class Goal < ActiveRecord::Base
  attr_accessible :name, :body, :private_goal
  validates :name, :body, presence: true

  belongs_to :user
  has_many :cheers
end
