class Entry < ActiveRecord::Base
  attr_accessible :guid, :link, :published_at, :title, :json, :feed_id

  belongs_to :feed

  def self.create_from_json!(entryData, feed)
    Entry.create!({
      guid: entryData.guid,
      link: entryData.link, 
      published_at: entryData.pubDate,
      title: entryData.title, 
      json: entryData,
      feed_id: feed.id
    })
  end
end
