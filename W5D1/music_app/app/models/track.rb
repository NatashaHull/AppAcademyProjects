class Track < ActiveRecord::Base
  attr_accessible :name, :album_id, :track_type, :lyrics

  validates :name, :album_id, :presence => true

  belongs_to :album
  
  has_many :notes, :dependent => :destroy
end
