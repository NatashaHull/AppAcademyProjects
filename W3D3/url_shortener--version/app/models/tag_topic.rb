class TagTopic < ActiveRecord::Base
  attr_accessible :tag_name

  has_many :taggings,
            :primary_key => :id,
            :foreign_key => :tag_id,
            :class_name => "Tagging"

  has_many :tagged_urls, :through => :taggings, :source => :tagged_url

  def most_popular_links(n)
    tagged_urls = self.tagged_urls.group("long_url").count
    tagged_urls.sort_by { |name,tag_count| [-tag_count,name] }.take(n)
  end
end
