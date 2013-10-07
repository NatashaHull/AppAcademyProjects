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
    @assoc_params
  end

  def belongs_to(name, params = {})
    assoc = BelongsToAssocParams.new(name, params)
    define_method(name) do
      assoc.type

      parent = DBConnection.execute(<<-SQL)
        SELECT t1.*
        FROM #{assoc.other_table_name} AS t1
          INNER JOIN #{self.class.table_name} AS t2
            ON t1.#{assoc.primary_key} = t2.#{assoc.foreign_key}
      SQL

      assoc.other_class.parse_all(parent)[0]
    end

    #Stores the association for future use
    @assoc_params = {} if @assoc_params.nil?
    @assoc_params[name] = assoc
  end

  def has_many(name, params = {})
    assoc = HasManyAssocParams.new(name, params, self)
    define_method(name) do
      assoc.type
      
      children = DBConnection.execute(<<-SQL)
        SELECT t1.*
        FROM #{assoc.other_table_name} AS t1
          INNER JOIN #{self.class.table_name} AS t2
            ON t1.#{assoc.foreign_key} = t2.#{assoc.primary_key}
      SQL

      assoc.other_class.parse_all(children)
    end
    
    #Stores the association for future use
    @assoc_params = {} if @assoc_params.nil?
    @assoc_params[name] = assoc
  end

  #Notice that this is a special case of has_many_through, ie #belongs_to => #belongs_to
  def has_one_through(name, assoc1, assoc2)
    define_method(name) do
      #Finds the necessary middle query info
      assoc_params = self.class.assoc_params
      first_params = assoc_params[assoc1]
      middle_class = first_params.other_class
      second_params = middle_class.assoc_params[assoc2]

      #Performs the query with this info
      grand_something = DBConnection.execute(<<-SQL)
        SELECT t1.*
        FROM #{second_params.other_table_name} AS t1
          INNER JOIN #{first_params.other_table_name} AS t2
            ON t1.#{second_params.primary_key} = t2.#{second_params.foreign_key}
          INNER JOIN #{self.class.table_name} AS t3
            ON t2.#{first_params.primary_key} = t3.#{first_params.foreign_key}
      SQL

      second_params.other_class.parse_all(grand_something)[0]
    end
  end

  def has_many_through(name, assoc1, assoc2)
    define_method(name) do
      #Setup
      #Finds the necessary middle query info
      assoc_params = self.class.assoc_params
      first_params = assoc_params[assoc1]
      
      #Formats the other_table_name and other_class they aren't formatted already
      first_params.type

      #Finishes params setup before join setup
      middle_class = first_params.other_class
      second_params = middle_class.assoc_params[assoc2]

      #Sets the first join to either return has_many or belongs_to data
      if second_params.class == HasManyAssocParams
        join1 = "t1.#{second_params.foreign_key} = t2.#{second_params.primary_key}"
      else
        join1 = "t1.#{second_params.primary_key} = t2.#{second_params.foreign_key}"
      end

      #Sets the second join to either return has_many or belongs_to data
      if second_params.class == HasManyAssocParams
        join2 = "t2.#{first_params.foreign_key} = t3.#{first_params.primary_key}"
      else
        join2 = "t2.#{first_params.primary_key} = t3.#{first_params.foreign_key}"
      end

      #Executes the query given the information above
      grand_something = DBConnection.execute(<<-SQL)
        SELECT t1.*
        FROM #{second_params.other_table_name} AS t1
          INNER JOIN #{first_params.other_table_name} AS t2
            ON #{join1}
          INNER JOIN #{self.class.table_name} AS t3
            ON #{join2}
      SQL

      second_params.other_class.parse_all(grand_something)
    end
  end
end
