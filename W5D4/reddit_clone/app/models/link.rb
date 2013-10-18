class Link < ActiveRecord::Base
  attr_accessible :title, :description, :url, :sub_ids

  validates_presence_of :author_id, :title, :url

  belongs_to :author, :class_name => 'User'
  has_many :link_subs
  has_many :comments

  has_many :subs, :through => :link_subs, :source => :sub

  def comments_by_parent_id
    link_comments = self.comments
    comments_hash = {}
    parentless_comments = []
    link_comments.each do |comment|
      if !!comment.parent_id
        comments_hash[comment.parent_id] ||= []
        comments_hash[comment.parent_id] << comment
      else
        parentless_comments << comment
        comments_hash[comment.id] = []
      end
    end

    #Gives us an array of comments and the hash of their children
    #The point is only to query the database twice instead of 3 times
    [parentless_comments, comments_hash]
  end
end
