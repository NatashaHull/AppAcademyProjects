class Comment < ActiveRecord::Base
  attr_accessible :content, :link_id

  validates_presence_of :content, :link_id

  belongs_to :link
end
