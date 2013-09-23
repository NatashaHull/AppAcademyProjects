class Link < ActiveRecord::Base
  attr_accessible :title, :url, :user_id
  
  belongs_to :user, 
    :class_name => "User", 
    :foreign_key => :user_id, 
    :primary_key => :id
    
  has_many :comments, 
    :class_name => "Comment", 
    :foreign_key => :link_id,
    :primary_key => :id
    
  validates :title, :url, :presence => true
end
