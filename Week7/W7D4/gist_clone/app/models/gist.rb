class Gist < ActiveRecord::Base
  attr_accessible :title

  validates_presence_of :title, :user_id

  belongs_to :user

  has_many :stars, :dependent => :destroy

  has_many :starrers, :through => :stars, :source => :user

  def as_json(options={})
    current_user_id = options.delete(:user_id)
    json = super(options)
    json[:star] = self.stars.where(:user_id => current_user_id)
    json
  end
end