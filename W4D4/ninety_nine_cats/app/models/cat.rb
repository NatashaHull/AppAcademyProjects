class Cat < ActiveRecord::Base
  attr_accessible :name, :age, :birth_date, :color, :gender

  validates_presence_of :name, :age, :birth_date, :color, :gender
  validate :real_gender#, :age_corresponds_to_birthdate
  validates :age, :numericality => true

  has_many :rentals,
            :class_name => "CatRental"

  private

    def real_gender
      unless self.gender == "M" || self.gender == "F"
        errors[:gender] << "The cat's gender must either be male or female"
      end
    end
end