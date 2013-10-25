class User < ActiveRecord::Base
  attr_accessible :user_name

  validates :user_name, :presence => true, :uniqueness => true

  has_many :authored_polls,
            :primary_key => :id,
            :foreign_key => :author_id,
            :class_name => 'Poll'

  has_many :authored_responses,
            :primary_key => :id,
            :foreign_key => :user_id,
            :class_name => 'Response'

  #Nested associations

  has_many :authored_questions,
            :through => :authored_polls,
            :source => :questions

  has_many :authored_answer_choices,
            :through => :authored_questions,
            :source => :answer_choices
end
