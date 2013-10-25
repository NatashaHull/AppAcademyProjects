class Employee
  attr_reader :name, :salary
  attr_accessor :boss, :title

  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end

class Manager < Employee
  attr_reader :employees

  def initialize(name, title, salary, boss)
    @employees = []
    super(name, title, salary, boss)
  end

  def add_employee(employee)
    @employees << employee unless @employees.include?(employee)
    employee.boss = self
  end

  def bonus(multiplier)
    @employees.map(&:salary).inject(:+) * multiplier
  end
end