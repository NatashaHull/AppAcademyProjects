class Friend < ActiveRecord::Base
  attr_accessible :friender_id, :friended_id

  validates :friender_id, :friended_id, :presence => true
  validates_uniqueness_of :friender_id, :scope => [:friended_id]

  belongs_to :friended_user,
             :foreign_key => :friended_id,
             :class_name => "User"

  belongs_to :friender,
             :class_name => "User"
end
