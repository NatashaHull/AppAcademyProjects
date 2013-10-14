class Album < ActiveRecord::Base
  attr_accessible :name, :band_id, :recording_type

  validates :name, :band_id, :presence => true

  belongs_to :band, :dependent => :destroy

  has_many :tracks
end
