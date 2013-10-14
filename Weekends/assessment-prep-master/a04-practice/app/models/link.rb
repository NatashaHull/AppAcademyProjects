class Link < ActiveRecord::Base
  attr_accessible :title, :url

  validates_presence_of :title, :url, :user_id

  belongs_to :user
  has_many :comments
end
