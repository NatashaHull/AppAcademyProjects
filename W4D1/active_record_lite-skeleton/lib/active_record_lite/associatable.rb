require 'active_support/core_ext/object/try'
require 'active_support/inflector'
require_relative './db_connection.rb'

class AssocParams
  def other_class
  end

  def other_table
  end
end

class BelongsToAssocParams < AssocParams
  attr_reader :name, :primary_key, :foreign_key,
              :other_class, :other_table_name

  def initialize(name, params)
    @name = name.to_s
    @other_class_name =
      params[:class_name] || @name.camelcase
    @primary_key =
      params[:primary_key] || "id"
    @foreign_key =
      params[:foreign_key] || "#{name}_id"
    @other_class = @other_class_name
    @other_table_name = @other_class_name
    convert_to_s
  end

  def convert_to_s
    @other_class_name = @other_class_name.to_s
    @primary_key = @primary_key.to_s
    @foreign_key = @foreign_key.to_s
  end

  def type
    @other_class = @other_class.constantize
    @other_table_name = @other_class.table_name
  end
end

class HasManyAssocParams < AssocParams
  attr_reader :name, :primary_key, :foreign_key,
              :other_class, :other_table_name

  def initialize(name, params, self_class)
    @name = name.to_s
    @current_class_name = self_class.to_s.underscore
    @other_class_name =
      params[:class_name] || @name.singularize.camelcase
    @primary_key =
      params[:primary_key] || "id"
    @foreign_key =
      params[:foreign_key] || "#{@current_class_name}_id"
    @other_class = @other_class_name
    @other_table_name = @other_class_name
    convert_to_s
  end

  def convert_to_s
    @other_class_name = @other_class_name.to_s
    @primary_key = @primary_key.to_s
    @foreign_key = @foreign_key.to_s
  end

  def type
    @other_class = @other_class.constantize
    @other_table_name = @other_class.table_name
  end
end

module Associatable
  def assoc_params
  end

  def belongs_to(name, params = {})
    define_method(name) do
      assoc = BelongsToAssocParams.new(name, params)
      p assoc
      assoc.type
      p assoc

      parent = DBConnection.execute(<<-SQL)
        SELECT t1.*
        FROM #{assoc.other_table_name} AS t1
        INNER JOIN #{self.class.table_name} AS t2
          ON t1.#{assoc.primary_key} = t2.#{assoc.foreign_key}
      SQL

      assoc.other_class.parse_all(parent)[0]
    end
  end

  def has_many(name, params = {})
    define_method(name) do
      assoc = HasManyAssocParams.new(name, params, self.class)
      assoc.type

      children = DBConnection.execute(<<-SQL)
        SELECT t1.*
        FROM #{assoc.other_table_name} AS t1
        INNER JOIN #{self.class.table_name} AS t2
          ON t1.#{assoc.foreign_key} = t2.#{assoc.primary_key}
      SQL

      assoc.other_class.parse_all(children)
    end
  end

  def has_one_through(name, assoc1, assoc2)
  end
end
