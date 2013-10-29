class Photo < ActiveRecord::Base
  attr_accessible :owner_id, :title, :url
  validates :owner_id, :title, :url, presence: true

  belongs_to :owner, class_name: "User"
  has_many :taggings, class_name: "PhotoTagging"
  has_many :tagged_users, through: :taggings, source: :user
end
