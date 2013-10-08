require_relative './associatable'
require_relative './db_connection'
require_relative './mass_object'
require_relative './searchable'
require 'active_support/inflector'

class SQLObject < MassObject
  extend Searchable
  extend Associatable

  def self.set_table_name(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.underscore.pluralize
  end

  def self.all
    members = DBConnection.execute(<<-SQL)
      SELECT *
      FROM #{table_name}
    SQL

    parse_all(members)
  end

  def self.find(id)
    member = DBConnection.execute(<<-SQL, id)
      SELECT *
      FROM #{table_name}
      WHERE id = ?
    SQL

    parse_all(member)[0]
  end

  def save
    @id.nil? ? create : update
  end

  private

    def create
      raise "already saved!" unless self.id.nil?

      #This selects out all the keys and values that
      #are defined
      keys = self.class.attributes
      vals = attribute_values
      
      q_marks = (["?"] * vals.length).join(", ")

      #Inserts the new values into SQL
      DBConnection.execute(<<-SQL, vals)
        INSERT INTO
          #{self.class.table_name}(#{keys.join(', ')})
        VALUES
          #{q_marks}
      SQL

      @id = DBConnection.last_insert_row_id
    end

    def update
      #This selects out all the keys that and
      #interpolates them into sql
      updates = self.class.attributes.map do |attr_name|
        "#{attr_name} = ?" 
      end

      #Get the values for each key
      vals = attribute_values

      #Inserts the new values into SQL
      DBConnection.execute(<<-SQL, vals)
        UPDATE #{self.class.table_name}
        SET #{updates.join(", ")}
        WHERE id = #{@id}
      SQL
    end

    def attribute_values
      self.class.attributes.map do |attr_name|
        send(attr_name)
      end
    end
end
