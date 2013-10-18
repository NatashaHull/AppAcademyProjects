class Comment < ActiveRecord::Base
  attr_accessible :link_id, :parent_id, :content

  validates :link_id, :content, :author_id, :presence => true

  belongs_to :author, :class_name => "User"
  belongs_to :link

  belongs_to(
    :parent,
    :class_name => "Comment",
    :foreign_key => :parent_id
  )

  has_many(
    :children,
    :class_name => "Comment",
    :foreign_key => :parent_id
  )

end
