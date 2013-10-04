class Tag < ActiveRecord::Base
  TAGS = ["Science", "Sports", "News", "Music"]
   attr_accessible :topic
   validates :topic, :inclusion => {:in => TAGS}, :uniqueness => true

   has_many(
   :taggings,
   :class_name => "Tagging",
   :primary_key => :id,
   :foreign_key => :tag_id
   )

   has_many :urls, :through => :taggings, :source => :shortened_url



   def self.create_or_return_existing_tag(tag_str)
     object = Tag.find_by_topic(tag_str)
     if object.nil?
       Tag.create!({topic:tag_str})
     else
       object
     end
   end


   def most_visited_links(n = 5)
     ShortenedUrl.joins(:visits)
   end


   # def most_visited_links(n = 5)
   #   self.urls.sort_by {|url| url.num_uniques } [0..n-1]
   # end

   # def most_visited_links
   #   # tag --> urls.  Urls each have a # of visits.  Sort by how many visits they have
   #   id_safe = id.to_i
   #   ActiveRecord::Base.connection.execute(<<-SQL)
   #   SELECT * FROM shortened_urls WHERE id IN
   #   (SELECT visits.url_id
   #   FROM taggings
   #   JOIN visits ON taggings.url_id = visits.url_id
   #   WHERE tag_id = #{id_safe}
   #   GROUP BY visits.url_id
   #   ORDER BY COUNT(visitor_id) DESC)
   #   SQL
   # end

end
