class Track < ActiveRecord::Base
  attr_accessible :name

  validates :name, :album_id, :presence => true

  belongs_to :album
  has_many :notes
end
