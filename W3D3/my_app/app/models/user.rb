class User < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name
  has_many(
    :enrollments,
    :class_name => "Enrollment",
    :foreign_key => :student_id,
    :primary_key => :id
  )
  has_many :courses, :through => :enrollments, :source => :course

end
