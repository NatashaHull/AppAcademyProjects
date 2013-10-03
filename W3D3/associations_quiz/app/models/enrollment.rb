class Enrollment < ActiveRecord::Base
  attr_accessible :student_id, :course_id

  belongs_to :course,
            :primary_key => :id,
            :foreign_key => :course_id,
            :class_name => 'Course'

  belongs_to :student,
            :primary_key => :id,
            :foreign_key => :student_id,
            :class_name => 'User'
end
