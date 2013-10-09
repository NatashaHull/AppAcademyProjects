class Status < ActiveRecord::Base
  attr_accessible :twitter_status_id, :body, :twitter_user_id

  validates_presence_of :twitter_status_id, :body, :twitter_user_id
  validates_uniqueness_of :twitter_status_id

  belongs_to :user,
            :primary_key => :twitter_user_id,
            :foreign_key => :twitter_user_id,
            :class_name => 'User'

  def self.fetch_statuses_for_user(user)
    request = Addressable::URI.new(
      :scheme => "https",
      :host => "api.twitter.com",
      :path => "1.1/statuses/user_timeline.json",
      :query_values => { :user_id => user.twitter_user_id }
    ).to_s
    twitter_params = TwitterSession.get(request)
    parsed = parse_twitter_params(twitter_params)
    parsed.map do |status|
      status_obj = Status.find_by_twitter_status_id(status["id"])
      if status_obj
        status_obj
      else
        Status.new({:twitter_status_id => status["id"],
                              :body => status["text"],
                              :twitter_user_id => user.twitter_user_id})
      end
    end
  end

  def self.parse_twitter_params(twitter_params)
    JSON.parse(twitter_params)
  end
end
