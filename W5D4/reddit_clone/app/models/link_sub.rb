class LinkSub < ActiveRecord::Base
  attr_accessible :sub_id, :link_id

  validates :sub_id, :link_id, :presence => true

  belongs_to :sub
  belongs_to :link
end
