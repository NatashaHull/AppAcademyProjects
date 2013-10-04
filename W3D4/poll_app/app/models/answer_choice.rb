class AnswerChoice < ActiveRecord::Base
  attr_accessible :text, :question_id

  validates_presence_of :text, :question_id

  belongs_to :question,
            :primary_key => :id,
            :foreign_key => :question_id,
            :class_name => 'Question'

  has_many :responses,
            :primary_key => :id,
            :foreign_key => :answer_choice_id,
            :class_name => 'Response'
end
