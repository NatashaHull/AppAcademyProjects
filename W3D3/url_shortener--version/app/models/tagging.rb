class Tagging < ActiveRecord::Base
  attr_accessible :tag_id, :shortened_url_id

  validates :tag_id, :shortened_url_id, :presence => true

  belongs_to :tag,
             :primary_key => :id,
             :foreign_key => :tag_id,
             :class_name => "TagTopic"

  belongs_to :tagged_url,
             :primary_key => :id,
             :foreign_key => :shortened_url_id,
             :class_name => "ShortenedUrl"
end
