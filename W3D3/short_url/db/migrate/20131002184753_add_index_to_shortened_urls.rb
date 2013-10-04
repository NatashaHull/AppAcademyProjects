class AddIndexToShortenedUrls < ActiveRecord::Migration
  def change
      add_index :shortened_urls, [:submitter_id,:short_url], :unique => true
  end
end
