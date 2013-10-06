class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :article
  # attr_accessible :title, :body
end
