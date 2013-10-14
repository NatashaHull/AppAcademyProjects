class Album < ActiveRecord::Base
  attr_accessible :name

  validates :name, :band_id, :presence => true

  belongs_to :band

  has_many :tracks
end
