class User < AAQuestionsTable
  #Find, Find_by..., All
  def self.all
    results = AAQuestionsDatabase.instance.execute("Select * FROM users")
    results.map { |result| User.new(result) }
  end

  def self.find(id)
    user = AAQuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM users
      WHERE id = ?
    SQL
    User.new(user.first)
  end

  def self.find_by_id(id)
    find(id)
  end


  def self.find_by_name(fname, lname)
    user = AAQuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT *
      FROM users
      WHERE fname = ?
        AND lname = ?
    SQL
    User.new(user.first)
  end

  attr_reader :id
  attr_accessor :fname, :lname

  def initialize(options={})
    @id, @fname, @lname =
      options.values_at('id', 'fname', 'lname')
  end

  def authored_questions
    Question::find_by_author_id(id)
  end

  def authored_replies
    Reply::find_by_author_id(id)
  end

  def followed_questions
    QuestionFollower::followed_questions_for_user_id(id)
  end

  def liked_questions
    QuestionLike::liked_questions_for_user_id(id)
  end

  def average_karma
    average = AAQuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT COUNT(*) / COUNT(DISTINCT q.id)
      FROM question_likes ql
        INNER JOIN questions q ON ql.question_id = q.id
      WHERE q.user_id = ?
    SQL
    average.first.values[0]
  end

  private

    def create
      #Weeds out saved users
      raise "This user already exists" unless @id.nil? || !User.find_by_name(fname, lname).is_a?(User)

      AAQuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        INSERT INTO
          users (fname, lname)
        VALUES
          (?, ?)
      SQL

      #Updates the id now that the user has been saved
      @id = AAQuestionsDatabase.instance.last_insert_row_id
    end

    def update
      AAQuestionsDatabase.instance.execute(<<-SQL, fname, lname, id)
        UPDATE users
        SET fname = ?,
            lname = ?
        WHERE id = ?
      SQL
    end
end