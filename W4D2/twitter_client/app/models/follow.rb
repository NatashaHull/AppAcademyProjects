class Follow < ActiveRecord::Base
  attr_accessible :twitter_followee_id, :twitter_follower_id
  validates_uniqueness_of :twitter_follower_id, scope: :twitter_followee_id

  belongs_to :follower,
              :primary_key => :twitter_user_id;
              :foreign_key => :twitter_follower_id.
              :class_name => 'User'

  belongs_to :followee,
              :primary_key => :twitter_user_id;
              :foreign_key => :twitter_followee_id.
              :class_name => 'User'
end
