require 'SecureRandom'
class ShortenedUrl < ActiveRecord::Base
  attr_accessible :long_url, :short_url, :submitter_id

  belongs_to(
  :submitter,
  :class_name => "User",
  :primary_key => :id,
  :foreign_key => :submitter_id
  )

  has_many(
  :visits,
  :class_name => "Visit",
  :primary_key => :id,
  :foreign_key => :url_id
  )

  has_many :visitors, :through => :visits, :source => :user, :uniq => true

  has_many(
  :taggings,
  :class_name => "Tagging",
  :primary_key => :id,
  :foreign_key => :url_id
  )

  has_many :tags, :through => :taggings, :source => :tag

  def self.create_for_user_and_long_url!(user, long_url)
    self.create!({long_url: long_url, short_url: self.random_code, submitter_id: user.id})
  end

  def self.random_code
    code = nil
    loop do
      code = SecureRandom.urlsafe_base64
      break unless self.pluck(:short_url).include? code
    end
    code
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    self.visits
    self.visits.where(:created_at => 10.minutes.ago..0.minutes.ago).count
  end

end
