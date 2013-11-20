Active Record Lite
==================
#Files
* [Mass Object](https://github.com/NatashaHull/AppAcademyProjects/blob/master/Week4/W4D1/active_record_lite-skeleton/lib/active_record_lite/mass_object.rb) - This file implements `attr_accessible`, automatically blacklisting all attributes and whitelisting those specified, as well as the `initialize` method used in ActiveRecord::Base.

* [SQL Object](https://github.com/NatashaHull/AppAcademyProjects/blob/master/Week4/W4D1/active_record_lite-skeleton/lib/active_record_lite/sql_object.rb) - This file implements most of the basic functions of ActiveRecord::Base objects, such as `find`, `all`, and `save`.

* [Searchable](https://github.com/NatashaHull/AppAcademyProjects/blob/master/Week4/W4D1/active_record_lite-skeleton/lib/active_record_lite/searchable.rb) - The `Searchable` module recreates the `where` function from ActiveRecord::Base.

* [Associatable](https://github.com/NatashaHull/AppAcademyProjects/blob/master/Week4/W4D1/active_record_lite-skeleton/lib/active_record_lite/associatable.rb) - This file creates `has_many` and belongs_to` object parameters that are then used to create a function, named after the association, that uses this data in its SQL query. I implemented basic forms of `has_many`, `belongs_to`, `has_one_through`, and, because it easily followed, `has_many_through`.
