class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :long_url
      t.string :short_url, :unique => true
      t.integer :submitter_id, :null => false

      t.timestamps
    end
  end
end
