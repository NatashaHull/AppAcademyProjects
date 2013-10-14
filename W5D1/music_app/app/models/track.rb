class Track < ActiveRecord::Base
  attr_accessible :name, :album_id, :track_type, :lyrics

  validates_presence_of :name, :album_id, :lyrics

  belongs_to :album, :dependent => :destroy
  
  has_many :notes
end
