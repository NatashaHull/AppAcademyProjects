class Visit < ActiveRecord::Base
  attr_accessible :visitor_id, :url_id

  belongs_to(
  :user,
  :class_name => "User",
  :primary_key => :id,
  :foreign_key => :visitor_id
  )

  belongs_to(
  :shortened_url,
  :class_name => "ShortenedUrl",
  :primary_key => :id,
  :foreign_key => :url_id
  )

  def self.record_visit!(user, shortened_url)
    self.create!({visitor_id: user.id, url_id: shortened_url.id})
  end

end
