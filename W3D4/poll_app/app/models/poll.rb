class Poll < ActiveRecord::Base
  attr_accessible :title, :author_id

  validates_presence_of :title, :author_id

  belongs_to :author,
              :primary_key => :id,
              :foreign_key => :author_id,
              :class_name => 'User'

  has_many :questions,
            :primary_key => :id,
            :foreign_key => :poll_id,
            :class_name => 'Question'

  #Nested associations

  has_many :answer_choices,
            :through => :questions,
            :source => :answer_choices
end
