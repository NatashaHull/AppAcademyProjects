class Album < ActiveRecord::Base
  attr_accessible :name, :band_id, :recording_type

  validates :name, :band_id, :presence => true

  belongs_to :band

  has_many :tracks, :dependent => :destroy
end
