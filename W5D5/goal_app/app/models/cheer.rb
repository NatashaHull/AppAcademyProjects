class Cheer < ActiveRecord::Base
  attr_accessible :goal_id
  validates :goal_id, :user_id, presence: true
  validates_uniqueness_of :user_id, :scope => [:goal_id]
  belongs_to :goal
  belongs_to :user
end
