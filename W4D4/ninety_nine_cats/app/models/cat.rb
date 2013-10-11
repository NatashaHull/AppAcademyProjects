class Cat < ActiveRecord::Base
  GENDERS = ["M", "F"]

  attr_accessible :name, :age, :birth_date, :color, :gender

  validates_presence_of :name, :age, :birth_date, :color, :gender
  validates :gender, :inclusion => GENDERS
  validates :age, :numericality => true

  has_many :rentals,
           :class_name => "CatRental"
end