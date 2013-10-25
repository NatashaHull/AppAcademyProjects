class Course < ActiveRecord::Base
  attr_accessible :name, :instructor_id

  belongs_to :students,
            :primary_key => :id,
            :foreign_key => :instructor_id,
            :class_name => "User"

  has_many :enrollments,
            :primary_key => :id,
            :foreign_key => :course_id,
            :class_name => 'Enrollment'

  has_many :enrolled_students, :through => :enrollments, :source => :student

  belongs_to :course,
            :primary_key => :id,
            :foreign_key => :prerequisite_id,
            :class_name => 'Course'

  has_one :prerequisite,
          :primary_key => :id,
          :foreign_key => :prerequisite_id,
          :class_name => 'Course'
end
