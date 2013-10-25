class Question < ActiveRecord::Base
  attr_accessible :text, :poll_id

  validates_presence_of :text, :poll_id

  belongs_to :poll,
              :primary_key => :id,
              :foreign_key => :poll_id,
              :class_name => 'Poll'

  has_many :answer_choices,
            :primary_key => :id,
            :foreign_key => :question_id,
            :class_name => 'AnswerChoice'

  #Nested associations

  has_many :responses,
            :through => :answer_choices,
            :source => :responses

  def results
    answers = answer_choices.includes(:responses)

    answer_choices_counts = {}

    answers.each do |answer_choice|
      answer_choices_counts[answer_choice.text] = answer_choice.responses.length
    end

    answer_choices_counts
  end

  def results_for_voted_on_choices
    answers = answer_choices
                     .select("answer_choices.text, COUNT(*) AS response_counts")
                     .joins(:responses)
                     .group("answer_choices.id")

    answer_choices_counts = {}

    answers.each do |answer_choice|
      answer_choices_counts[answer_choice.text] = answer_choice.response_counts
    end

    answer_choices_counts
  end
end