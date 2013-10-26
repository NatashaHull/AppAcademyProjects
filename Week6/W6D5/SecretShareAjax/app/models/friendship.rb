class Friendship < ActiveRecord::Base
  attr_accessible :friendee_id

  validate :not_friending_self
  validates :friendee_id, :friender_id, :presence => true
  validates_uniqueness_of :friendee_id, :scope => [:friender_id]

  belongs_to :friendee, :class_name => "User"
  belongs_to :friender, :class_name => "User"

  private
    def not_friending_self
      if friender_id == friendee_id
        errors[:friendee] << "You can't friend yourself!"
      end
    end
end
