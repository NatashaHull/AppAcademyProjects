class Cat < ActiveRecord::Base
  GENDERS = ["M", "F"]

  attr_accessible :name, :age, :birth_date, :color, :gender

  validates_presence_of :name, :age, :birth_date, :color, :gender, :owner_id
  validates :gender, :inclusion => GENDERS
  validates :age, :numericality => true

  belongs_to :owner,
              :class_name => "User"

  has_many :rentals,
           :class_name => "CatRental"
end