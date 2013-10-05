class Tag < AAQuestionsTable
  #Find, Find_by..., All
  def self.all
    results = AAQuestionsDatabase.instance.execute("Select * FROM tags")
    results.map { |result| Tag.new(result) }
  end

  def self.find(id)
    tag = AAQuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM tags
      WHERE id = ?
    SQL
    Tag.new(tag.first)
  end

  def self.find_by_id(id)
    find(id)
  end


  def self.find_by_name(name)
    tag = AAQuestionsDatabase.instance.execute(<<-SQL, name)
      SELECT *
      FROM tags
      WHERE name = ?
    SQL
    Tag.new(tag.first)
  end

  def self.most_popular_questions(n)
    #Currently finds the most popular posts, groups them by their tag
    #and returns those posts and the associated tag
    AAQuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT t.name, q1.title
      FROM tags t
        INNER JOIN question_tags ON question_tags.tag_id = t.id
        INNER JOIN questions q1 ON question_tags.question_id = q1.id
      GROUP BY t.id, q1.id
      ORDER BY (SELECT COUNT(*)
                FROM question_likes ql
                WHERE ql.question_id = q1.id) DESC
      LIMIT ?
    SQL
  end

  attr_reader :id
  attr_accessor :name

  def initialize(options={})
    @id, @name =
      options.values_at('id', 'name')
  end

  private

    def create
      #Weeds out saved users
      raise "This user already exists" unless @id.nil? || !User.find_by_name(name).is_a?(Tag)

      AAQuestionsDatabase.instance.execute(<<-SQL, name)
        INSERT INTO
          tags (name)
        VALUES
          (?)
      SQL

      #Updates the id now that the user has been saved
      @id = AAQuestionsDatabase.instance.last_insert_row_id
    end

    def update
      AAQuestionsDatabase.instance.execute(<<-SQL, name, id)
        UPDATE tags
        SET name = ?
        WHERE id = ?
      SQL
    end
end