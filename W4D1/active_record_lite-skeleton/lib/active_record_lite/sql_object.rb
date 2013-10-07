require_relative './associatable'
require_relative './db_connection'
require_relative './mass_object'
require_relative './searchable'

class SQLObject < MassObject
  def self.set_table_name(table_name)
  end

  def self.table_name
  end

  def self.all
  end

  def self.find(id)
  end

  def create
  end

  def update
  end

  def save
  end

  def attribute_values
  end
end
