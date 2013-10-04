class Response < ActiveRecord::Base
  attr_accessible :user_id, :answer_choice_id

  validates_presence_of :user_id, :answer_choice_id

  validate :doesnt_respond_to_own_poll,
            :respondent_has_not_already_answered_question

  belongs_to :respondent,
              :primary_key => :id,
              :foreign_key => :user_id,
              :class_name => 'User'

  belongs_to :answer_choice,
              :primary_key => :id,
              :foreign_key => :answer_choice_id,
              :class_name => 'AnswerChoice'

  def respondent_has_not_already_answered_question
    previous_responses = existing_responses

    unless previous_responses.empty? ||
       (previous_responses.length == 1 &&
       previous_responses.first.id == self.id)
      errors.add(:user_id, "Respondant has already answered this question!")
    end
  end

  def doesnt_respond_to_own_poll
    author = User
        .joins(:authored_polls => {:questions => :answer_choices})
        .where("answer_choices.id = ?", answer_choice_id)
        .first

    if author.id == respondent.id
      errors.add(:user_id, "Respondant cannot vote in own poll!")
    end
  end

  private
    def existing_responses
      previous_responses = Response.find_by_sql(<<-SQL)
        SELECT responses.*
        FROM responses
          INNER JOIN answer_choices ON answer_choices.id = responses.answer_choice_id
        WHERE answer_choices.question_id = (SELECT question_id
                                            FROM answer_choices
                                            WHERE id = #{answer_choice_id})
        AND responses.user_id = #{user_id}
      SQL
    end
end