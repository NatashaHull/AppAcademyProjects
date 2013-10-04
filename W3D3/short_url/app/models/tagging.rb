class Tagging < ActiveRecord::Base
  attr_accessible :tag_id, :url_id

  def self.create_for_tag_and_url(tag, url)
    self.create!({tag_id: tag, url_id: url})
  end

  belongs_to(
  :tag,
  :class_name => "Tag",
  :primary_key => :id,
  :foreign_key => :tag_id
  )

  belongs_to(
  :shortened_url,
  :class_name => "ShortenedUrl",
  :primary_key => :id,
  :foreign_key => :url_id
  )



end
