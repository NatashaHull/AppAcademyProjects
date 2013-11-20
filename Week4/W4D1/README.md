Active Record Lite
==================
#Mass Object
This file implements `attr_accessible`, automatically blacklisting all attributes and whitelisting those specified, as well as the `initialize` method used in ActiveRecord::Base.

#SQL Object
This file implements most of the basic functions of ActiveRecord::Base objects, such as `find`, `all`, and `save.

#Searchable
The `Searchable` module recreates the `where` function from ActiveRecord::Base.

#Associatable
This file creates `has_many` and belongs_to` object parameters that are then used to create a function, named after the association, that uses this data in its SQL query. I implemented basic forms of `has_many`, `belongs_to`, `has_one_through`, and, because it easily followed, `has_many_through`.
