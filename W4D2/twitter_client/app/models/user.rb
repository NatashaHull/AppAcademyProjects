require 'addressable/uri'

class User < ActiveRecord::Base
  attr_accessible :screen_name, :twitter_user_id
  validates_presence_of :screen_name, :twitter_user_id
  validates_uniqueness_of :twitter_user_id

  has_many :statuses,
            :primary_key => :twitter_user_id,
            :foreign_key => :twitter_user_id,
            :class_name => 'Status'

  has_many :inbound_follows,
            :primary_key => :twitter_user_id,
            :foreign_key => :twitter_follower_id,
            :class_name => 'Follow'

  has_many :outbound_follows,
            :primary_key => :twitter_user_id,
            :foreign_key => :twitter_followee_id,
            :class_name => 'Follow'

  has_many :followers, :through => :inbound_follows, :source => :follower

  has_many :followed_users, :through => :outbound_follows, :source => :followee

  def self.fetch_by_screen_name(screen_name)
    request = Addressable::URI.new(
      :scheme => "https",
      :host => "api.twitter.com",
      :path => "1.1/users/lookup.json",
      :query_values => { :screen_name => "#{screen_name}" }
    ).to_s
    twitter_params = TwitterSession.get(request)
    twitter_user_id = parse_twitter_params(twitter_params)
    User.create!(:screen_name => screen_name, :twitter_user_id => twitter_user_id)
  end

  def self.parse_twitter_params(twitter_params)
    JSON.parse(twitter_params).first["id"]
  end

  def self.fetch_by_ids(ids)
    existing_users = find_all_by_twitter_user_id(ids)
    existing_ids = existing_users.map {|user| user.twitter_user_id }
    p twitter_api_lookup_ids = ids - existing_ids
    if twitter_api_lookup_ids.empty?
      return existing_users
    else
      p request = Addressable::URI.new(
        :scheme => "https",
        :host => "api.twitter.com",
        :path => "1.1/users/lookup.json",
        :query_values => { :user_id => "#{twitter_api_lookup_ids.join(",")}" }
      ).to_s
      twitter_params = TwitterSession.get(request)
      twitter_users_json = JSON.parse(twitter_params)
      twitter_users = twitter_users_json.map do |twitter_user|
        User.new(
          :screen_name => twitter_user['screen_name'],
          :twitter_user_id => twitter_user['id']
        )
      end

      twitter_users + existing_users
    end
  end

  def sync_statuses
    all_statuses = Status.fetch_statuses_for_user(self)
    all_statuses.each {|status| status.save! unless status.persisted? }
  end

  def fetch_followers
    #follower_ids = something_url_request
    User.fetch_by_ids(follower_ids)
  end

  def sync_followers
    all_followers = fetch_followers
    all_followers.each { |follower| follower.save! unless follower.persisted? }
  end
end
