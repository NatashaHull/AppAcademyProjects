class AddIndexToShortenedUrl < ActiveRecord::Migration
  def change
    add_index :shortened_urls, :short_url
  end
end
