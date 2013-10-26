class SecretTagging < ActiveRecord::Base
  attr_accessible :tag_id, :secret_id
  validates :tag_id, :secret_id, :presence => true
  validates_uniqueness_of :tag_id, :scope => [:secret_id]

  belongs_to :secret
  belongs_to :tag
end
