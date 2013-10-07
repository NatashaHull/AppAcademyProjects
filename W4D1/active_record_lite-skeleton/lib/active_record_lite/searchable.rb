require_relative './db_connection'

module Searchable
  def where(params)
  	#interpolates the keys into SQL
  	keys = params.keys.map do |key|
  		"#{key} = ?"
  	end

  	vals = params.values

  	results = DBConnection.execute(<<-SQL, vals)
  		SELECT *
  		FROM #{table_name}
  		WHERE #{keys.join(" AND ")}
  	SQL

  	parse_all(results)
  end
end