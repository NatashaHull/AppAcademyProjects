class Course < ActiveRecord::Base
   attr_accessible :name, :instructor, :prereq_id

   has_many(
   :enrollments,
   :class_name => "Enrollment",
   :primary_key => :id,
   :foreign_key => :course_id
   )

   has_many :users, :through => :enrollments, :source => :user

end
