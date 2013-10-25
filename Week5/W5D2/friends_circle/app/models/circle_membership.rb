class CircleMembership < ActiveRecord::Base
  attr_accessible :circle_id, :user_id

  validates :circle_id, :user_id, :presence => true
  validates_uniqueness_of :user_id, :scope => [:circle_id]

  belongs_to :circle
  belongs_to :user
end
