class Student

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = []
  end

  def name
    @first_name + " " + @last_name
  end

  def courses
    [].tap do |name|
      @courses.each { |course| name << course.course_name }
    end
  end

  def enroll(course)
    @courses << course unless @courses.include?(course)
  end

  def course_load
    course_load_hash = Hash.new(0)
    @courses.each do |course|
      course_load_hash[course.department] += course.num_credits
    end
    course_load_hash
  end
end

class Course
  attr_reader :course_name, :department, :num_credits

  def initialize(course_name, department, num_credits)
    @course_name = course_name
    @department = department
    @num_credits = num_credits
    @enrolled_students = []
  end

  def students
    [].tap do |name|
      @enrolled_students.each { |student| name << student.name }
    end
  end

  def add_student(student)
    @enrolled_students << student unless @enrolled_students.include?(student)
  end
end

#Adding students and courses
first_student = Student.new("Ben", "Hass")
second_student = Student.new("Natasha", "Hull")
first_course = Course.new("Web Development", "Computer Science", 9)
second_course = Course.new("Music Theory", "Music", 3)
third_course = Course.new("Artificial Intelligence", "Computer Science", 4)

#Enrolling students in courses
first_student.enroll(first_course)
first_student.enroll(third_course)
second_student.enroll(second_course)
second_student.enroll(third_course)

#Adding students to course attendees
first_course.add_student(first_student)
second_course.add_student(second_student)
third_course.add_student(first_student)
third_course.add_student(second_student)


#Testing whether or not a student can enroll twice
first_student.enroll(first_course)
first_course.add_student(first_student)

puts first_student.name
puts second_student.name
p first_student.courses
p second_student.courses
p first_course.students
p second_course.students
p third_course.students

p first_student.course_load
p second_student.course_load