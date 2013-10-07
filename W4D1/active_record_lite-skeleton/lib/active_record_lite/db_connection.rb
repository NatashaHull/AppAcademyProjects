require 'sqlite3'

class DBConnection
  def self.open(db_file_name)
    @db = SQLite3::Database.new(db_file_name)
    @db.results_as_hash = true
    @db.type_translation = true
    @db
  end

  def self.execute(*args)
    @db.execute(*args)
  end

  def self.last_insert_row_id
    @db.last_insert_row_id
  end

  private
  def initialize(db_file_name)
  end
end
