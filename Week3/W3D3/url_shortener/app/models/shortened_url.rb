class ShortenedUrl < ActiveRecord::Base
  attr_accessible :short_url, :long_url, :submitter_id

  validates :short_url, :uniqueness => true, :presence => true
  validates :submitter_id, :presence => true
  validates :long_url, length: { maximum: 255 }
  validate :user_not_a_spammer

  belongs_to :submitter,
            :primary_key => :id,
            :foreign_key => :submitter_id,
            :class_name => "User"

  has_many :visits,
           :primary_key => :id,
           :foreign_key => :shortened_url_id,
           :class_name => "Visit"

  has_many :taggings,
           :primary_key => :id,
           :foreign_key => :shortened_url_id,
           :class_name => "Tagging"

  has_many :visitors, :through => :visits, :source => :visitor, :uniq => true

  has_many :tags, :through => :taggings, :source => :tag

  def user_not_a_spammer
    range = ((Time.now - 2.minutes)..Time.now)
    submits_in_last_minute = ShortenedUrl.where(:submitter_id => submitter_id, :created_at => range)

    if submits_in_last_minute.count > 5
      errors[:spammer] << "User is a spammer"
    end
  end

  def self.random_code
    random_string = SecureRandom::urlsafe_base64
    if ShortenedUrl.find_by_short_url(random_string)
      random_code
    else
      random_string
    end
  end

  def self.create_for_user_long_url!(user, long_url)
    create!({:submitter_id => user.id, :long_url => long_url, :short_url => random_code })
  end

  def num_clicks
    self.visits.length
  end

  def num_uniques
    #The .uniq is not necessary because of the
    #':uniq => true' above, but is left in for clarity
    self.visitors.uniq.length
  end

  def num_recent(visits_arr=self.visits)
    visits_arr.select { |visit| (Time.now - visit.created_at).to_i <= 10.minutes }.length
  end

  def num_recent_uniques
    non_unique_user_ids = []
    visits_arr = self.visits.select do |visit|
      if non_unique_user_ids.include?(visit.visitor)
        false
      else
        non_unique_user_ids << visit.visitor
      end
    end
    num_recent(visits_arr)
  end
end
