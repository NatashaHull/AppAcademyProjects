class Reply < AAQuestionsTable
  def self.all
    results = AAQuestionsDatabase.instance.execute("Select * FROM replies")
    results.map { |result| Reply.new(result) }
  end

  def self.find(id)
    reply = AAQuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM replies
      WHERE id = ?
    SQL
    Reply.new(reply.first)
  end

  def self.find_by_id(id)
    find(id)
  end

  def self.find_by_question_id(id)
    results = AAQuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM replies
      WHERE question_id = ?
    SQL
    results.map { |result| Reply.new(result) }
  end

  def self.find_by_author_id(id)
    results = AAQuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM replies
      WHERE user_id = ?
    SQL
    results.map { |result| Reply.new(result) }
  end

  def self.find_by_parent_reply(id)
    results = AAQuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM replies
      WHERE reply_id = ?
    SQL
    results.map { |result| Reply.new(result) }
  end

  attr_reader :id, :user, :question, :reply, :user_id, :question_id, :reply_id
  attr_accessor :body

  def initialize(options={})
    @id, @body, @user_id, @question_id =
      options.values_at('id', 'body', 'user_id', 'question_id')
    @question = Question.find(@question_id)
    @user = User.find(@user_id)
    @reply_id = options['reply_id']
    if @reply_id
      @parent_reply = Reply.find(@reply_id)
    else
      @parent_reply = nil
    end
  end

  def author
    @user
  end

  def child_replies
    find_by_parent_reply(@id)
  end

  private

    def create
      #Weeds out saved replies
      raise "This reply already exists" unless @id.nil?

      AAQuestionsDatabase.instance.execute(<<-SQL, body, question_id, user_id, reply_id)
        INSERT INTO
          users (body, question_id, user_id, reply_id)
        VALUES
          (?, ?, ?, ?)
      SQL

      #Updates the id now that the reply has been saved
      @id = AAQuestionsDatabase.instance.last_insert_row_id
    end

    def update
      AAQuestionsDatabase.instance.execute(<<-SQL, body, question_id, user_id, reply_id, id)
        UPDATE users
           SET body = ?,
               question_id = ?,
               user_id = ?,
               reply_id = ?
         WHERE id = ?
      SQL
    end
end