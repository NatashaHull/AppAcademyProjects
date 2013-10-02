class Question < AAQuestionsTable
  def self.all
    results = AAQuestionsDatabase.instance.execute("Select * FROM questions")
    results.map { |result| Question.new(result) }
  end

  def self.find(id)
    question = AAQuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM questions
      WHERE id = ?
    SQL
    Question.new(question.first)
  end

  def self.find_by_id(id)
    find(id)
  end

  def self.find_by_author_id(id)
    results = AAQuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM questions
      WHERE user_id = ?
    SQL
    results.map { |result| Question.new(result) }
  end

  def self.most_followed(n)
    QuestionFollower::most_followed_questions(n)
  end

  attr_reader :id, :title, :body, :user, :user_id

  def initialize(options={})
    @id, @title, @body, @user_id =
      options.values_at('id', 'title', 'body', 'user_id')
    @user = User.find(@user_id)
  end

  def author
    @user
  end

  def replies
    Reply::find_by_question_id(id)
  end

  def followers
    QuestionFollower::followers_for_question_id(id)
  end

  def likers
    QuestionLike::likers_for_question_id(id)
  end

  def num_likes
    QuestionLike::num_likers_for_question_id(id)
  end

  def most_liked(n)
    QuestionLike::most_liked_questions(n)
  end

  private

    def create
      #Weeds out saved questions
      raise "This question already exists" unless @id.nil?

      AAQuestionsDatabase.instance.execute(<<-SQL, title, body, user_id)
        INSERT INTO
          questions (title, body, user_id)
        VALUES
          (?, ?, ?)
      SQL

      #Updates the id now that the question has been saved in the database
      @id = AAQuestionsDatabase.instance.last_insert_row_id
    end

    def update
      AAQuestionsDatabase.instance.execute(<<-SQL, title, body, user_id, id)
        UPDATE questions
        SET title = ?,
            body = ?,
            user_id = ?
        WHERE id = ?
      SQL
    end
end

class QuestionFollower
  def self.all
    results = AAQuestionsDatabase.instance.execute("Select * FROM question_followers")
    results.map { |result| QuestionFollower.new(result) }
  end

  def self.find(id)
    question_follower = AAQuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM question_followers
      WHERE id = ?
    SQL
    QuestionFollower.new(question_follower.first)
  end

  def self.find_by_id(id)
    find(id)
  end

  def self.followers_for_question_id(id)
    results = AAQuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT u.id, u.fname, u.lname
      FROM question_followers
        INNER JOIN questions q ON question_followers.question_id = q.id
        INNER JOIN users u ON question_followers.user_id = u.id
      WHERE q.id = ?
    SQL
    results.map { |result| User.new(result) }
  end

  def self.followed_questions_for_user_id(id)
    results = AAQuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT q.id, q.title, q.body, q.user_id
      FROM question_followers
        INNER JOIN questions q ON question_followers.question_id = q.id
        INNER JOIN users u ON question_followers.user_id = u.id
      WHERE u.id = ?
    SQL
    results.map { |result| Question.new(result) }
  end

  def self.most_followed_questions(n)
    #Handles cases where n = 0
    return [] if n == 0

    #Handles cases when it is asking for more questions
    #than exist in the database.
    if Question.all.count < n
      raise ArgumentError, "There are not this many questions"
    end

    #Handles every other case
    followed_questions = AAQuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT q.id, q.title, q.body, q.user_id
      FROM question_followers qf
        INNER JOIN questions q ON qf.question_id = q.id
        INNER JOIN users u ON qf.user_id = u.id
      GROUP BY q.id
      ORDER BY MAX(qf.user_id)
      LIMIT ?
    SQL
    followed_questions.map { |result| Question.new(result) }
  end

  attr_reader :id, :question, :user, :question_id, :user_id

  def initialize(options={})
    @id, @user_id, @question_id =
      options.values_at('id', 'user_id', 'question_id')
    @question = Question.find(@question_id)
    @user = User.find(@user_id)
  end
end

class QuestionLike
  def self.all
    results = AAQuestionsDatabase.instance.execute("Select * FROM question_likes")
    results.map { |result| QuestionLike.new(result) }
  end

  def self.find(id)
    question_liker = AAQuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM question_likes
      WHERE id = ?
    SQL
    QuestionLike.new(question_liker.first)
  end

  def self.find_by_id(id)
    find(id)
  end

  def self.likers_for_question_id(id)
    results = AAQuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT u.id, u.fname, u.lname
      FROM question_likes
        INNER JOIN questions q ON question_likes.question_id = q.id
        INNER JOIN users u ON question_likes.user_id = u.id
      WHERE q.id = ?
    SQL
    results.map { |result| User.new(result) }
  end

  def self.liked_questions_for_user_id(id)
    results = AAQuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT q.id, q.title, q.body, q.user_id
      FROM question_likes
        INNER JOIN questions q ON question_likes.question_id = q.id
        INNER JOIN users u ON question_likes.user_id = u.id
      WHERE u.id = ?
    SQL
    results.map { |result| Question.new(result) }
  end

  def self.num_likes_for_question_id(id)
    AAQuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT COUNT(*)
      FROM question_likes ql
        INNER JOIN users u ON ql.user_id = u.id
      WHERE ql.question_id = ?
    SQL
  end

  def self.most_liked_questions(n)
    #Handles cases where n = 0
    return [] if n == 0

    #Handles cases when it is asking for more questions
    #than exist in the database.
    if Question.all.count < n
      raise ArgumentError, "There are not this many questions"
    end

    #Handles every other case
    liked_questions = AAQuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT q.id, q.title, q.body, q.user_id
      FROM question_likes ql
        INNER JOIN questions q ON ql.question_id = q.id
        INNER JOIN users u ON ql.user_id = u.id
      GROUP BY q.id
      ORDER BY MAX(ql.user_id)
      LIMIT ?
    SQL
    liked_questions.map { |result| Question.new(result) }
  end

  attr_reader :id, :question, :user, :question_id, :user_id

  def initialize(options={})
    @id, @user_id, @question_id =
      options.values_at('id', 'user_id', 'question_id')
    @question = Question.find(@question_id)
    @user = User.find(@user_id)
  end
end