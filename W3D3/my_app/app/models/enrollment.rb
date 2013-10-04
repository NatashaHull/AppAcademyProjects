class Enrollment < ActiveRecord::Base
  attr_accessible :student_id, :course_id

  belongs_to(
  :user,
  :class_name => "User",
  :primary_key => :id,
  :foreign_key => :student_id
  )

  belongs_to(
  :course,
  :class_name => "Course",
  :primary_key => :id,
  :foreign_key => :course_id
  )

end
