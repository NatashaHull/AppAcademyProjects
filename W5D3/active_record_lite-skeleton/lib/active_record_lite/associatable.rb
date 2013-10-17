require 'active_support/core_ext/object/try'
require 'active_support/inflector'
require_relative './db_connection.rb'

class AssocParams
  attr_reader :name, :primary_key, :foreign_key

  def initialize(name, params)
    @name = name.to_s
    @other_class_name =
      params[:class_name] || @name.camelcase
    @primary_key =
      params[:primary_key] || "id"
    convert_to_s
  end

  def other_class
    @other_class_name.constantize
  end

  def other_table_name
    other_class.table_name
  end

  def convert_to_s
    @other_class_name = @other_class_name.to_s
    @primary_key = @primary_key.to_s
    @foreign_key = @foreign_key.to_s
  end
end

class BelongsToAssocParams < AssocParams
  def initialize(name, params)
    super(name, params)
    @other_class_name =
      params[:class_name] || @name.camelcase
    @foreign_key =
      params[:foreign_key] || "#{name}_id"
  end

  def type
    :belongs_to
  end
end

class HasManyAssocParams < AssocParams
  def initialize(name, params, self_class)
    super(name, params)
    @current_class_name = self_class.to_s.underscore
    @other_class_name =
      params[:class_name] || @name.singularize.camelcase
    @foreign_key =
      params[:foreign_key] || "#{@current_class_name}_id"
  end

  def type
    :has_many
  end
end

module Associatable
  def assoc_params
    @assoc_params ||= {}
    @assoc_params
  end

  def belongs_to(name, params = {})
    assoc = BelongsToAssocParams.new(name, params)
    assoc_params[name] = assoc
    
    define_method(name) do
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
    assoc = HasManyAssocParams.new(name, params, self)
    assoc_params[name] = assoc

    define_method(name) do
      children = DBConnection.execute(<<-SQL)
        SELECT t1.*
        FROM #{assoc.other_table_name} AS t1
          INNER JOIN #{self.class.table_name} AS t2
            ON t1.#{assoc.foreign_key} = t2.#{assoc.primary_key}
      SQL

      assoc.other_class.parse_all(children)
    end
  end

  #Notice that this is a special case of has_many_through,
  #ie #belongs_to => #belongs_to
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
      middle_class = first_params.other_class
      second_params = middle_class.assoc_params[assoc2]

      #Sets each join statement to either return has_many or belongs_to data
      join1 = self.class.generate_join_statement(second_params, 't1', 't2')
      join2 = self.class.generate_join_statement(first_params, 't2', 't3')

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


  def generate_join_statement(assoc_params,t1, t2)
    if assoc_params.class == HasManyAssocParams
      "#{t1}.#{assoc_params.foreign_key} = #{t2}.#{assoc_params.primary_key}"
    else
      "#{t1}.#{assoc_params.primary_key} = #{t2}.#{assoc_params.foreign_key}"
    end
  end
end
