class Note < ActiveRecord::Base
  attr_accessible :body, :track_id

  validates_presence_of :body, :track_id, :user_id

  belongs_to :track
  belongs_to :user
end
