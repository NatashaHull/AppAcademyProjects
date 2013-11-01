class Star < ActiveRecord::Base
  attr_accessible :gist_id

  validates :gist_id, :user_id, :presence => true
  validates_uniqueness_of :gist_id, :scope => [:user_id]

  belongs_to :user

  belongs_to :gist


end
