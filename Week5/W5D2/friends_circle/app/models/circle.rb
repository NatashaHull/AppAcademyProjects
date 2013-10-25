class Circle < ActiveRecord::Base
  attr_accessible :name, :user_id

  validates :name, :user_id, :presence => true
  validates_uniqueness_of :name, :scope => [:user_id]

  belongs_to :user
  has_many :memberships,
           :class_name => "CircleMembership"

  has_many :members, :through => :memberships, :source => :user
end
