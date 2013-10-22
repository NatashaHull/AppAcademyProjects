Array.prototype.myIncludes = function(val) {
  for(var i = 0; i < this.length; i++) {
    if(this[i] === val) {
      return true;
    }
  };
  return false;
}

function Student(fname, lname) {
  this.fname = fname;
  this.lname = lname;
  this.courses = [];
  this.courseLoad = {};
}

Student.prototype.name = function() {
  return this.fname + " " + this.lname;
}

Student.prototype.enroll = function(course) {
  if(!this.courses.myIncludes(course)) {
    this.courses.push(course);
    if (this.courseLoad[course.dept] == undefined){
      this.courseLoad[course.dept] = course.numCredits;
    } else {
      this.courseLoad[course.dept] += course.numCredits;
    }
  }
  if(!course.enrolledStudents.myIncludes(this)) {
    course.addStudent(this);
  }
}

function Course(name, dept, numCredits) {
  this.name = name;
  this.dept = dept;
  this.numCredits = num_credits;
  this.students = [];
}

Course.prototype.addStudent = function(student) {
  if(!this.enrolledStudents.myIncludes(student)) {
    this.students.push(student);
  }
  if(!student.courses.myIncludes(this)) {
    student.enroll(this);
  }
}
