class Follow < ActiveRecord::Base
  attr_accessible :followed_id, :followee_id

  validates_presence_of :followed_id, :followee_id
  validates_uniqueness_of :followed_id, :scope => :followee_id

  belongs_to :follower,
  			 :class_name => 'User'

  belongs_to :followee,
  			 :class_name => 'User'
end
