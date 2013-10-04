initial_user = User.create!({:user_name => "Mr. First"})
second_user = User.create!({:user_name => "Number 2"})
third_user = User.create!({:user_name => "Ms. Third"})

cat_poll = Poll.create!({:title => "Cat poll", :author_id => initial_user.id})
dog_poll = Poll.create!({:title => "Dog poll", :author_id => second_user.id})

cat_question_one = Question.create!({:text => "Should we save the cats?", :poll_id => cat_poll.id})
cat_question_two = Question.create!({:text => "What color cat is best?", :poll_id => cat_poll.id})
cat_question_three = Question.create!({:text => "What does a cat mean to you?", :poll_id => cat_poll.id})

dog_question_one = Question.create!({:text => "Should we save the dogs?", :poll_id => dog_poll.id})
dog_question_two = Question.create!({:text => "What color dog is best?", :poll_id => dog_poll.id})
dog_question_three = Question.create!({:text => "What does a dog mean to you?", :poll_id => dog_poll.id})

#Cat question 1 responses
answer_one = AnswerChoice.create!({:question_id => cat_question_one.id, :text => "Yes"})
answer_two = AnswerChoice.create!({:question_id => cat_question_one.id, :text => "No"})

#Cat question 2 responses
answer_three = AnswerChoice.create!({:question_id => cat_question_two.id, :text => "Black"})
answer_four = AnswerChoice.create!({:question_id => cat_question_two.id, :text => "Orange"})
answer_five = AnswerChoice.create!({:question_id => cat_question_two.id, :text => "Brown"})

#Cat question 3 responses
answer_six = AnswerChoice.create!({:question_id => cat_question_three.id, :text => "Fluffy friend"})
answer_seven = AnswerChoice.create!({:question_id => cat_question_three.id, :text => "Vile critter"})

#Dog question 1 responses
answer_eight = AnswerChoice.create!({:question_id => dog_question_one.id, :text => "Yes"})
answer_nine = AnswerChoice.create!({:question_id => dog_question_one.id, :text => "No"})

#Dog question 2 responses
answer_ten = AnswerChoice.create!({:question_id => dog_question_two.id, :text => "Black"})
answer_eleven = AnswerChoice.create!({:question_id => dog_question_two.id, :text => "Orange"})
answer_twelve = AnswerChoice.create!({:question_id => dog_question_two.id, :text => "Brown"})

#Dog question 3 responses
answer_thirteen = AnswerChoice.create!({:question_id => dog_question_three.id, :text => "Man's best friend"})
answer_fourteen = AnswerChoice.create!({:question_id => dog_question_three.id, :text => "Vile critter"})

#Responses
#First user
Response.create!({:user_id => initial_user.id, :answer_choice_id => answer_eight.id})
Response.create!({:user_id => initial_user.id, :answer_choice_id => answer_ten.id})
Response.create!({:user_id => initial_user.id, :answer_choice_id => answer_thirteen.id})

#Second user
Response.create!({:user_id => second_user.id, :answer_choice_id => answer_one.id})
Response.create!({:user_id => second_user.id, :answer_choice_id => answer_three.id})
Response.create!({:user_id => second_user.id, :answer_choice_id => answer_seven.id})

#Third user
Response.create!({:user_id => third_user.id, :answer_choice_id => answer_two.id})
Response.create!({:user_id => third_user.id, :answer_choice_id => answer_three.id})
Response.create!({:user_id => third_user.id, :answer_choice_id => answer_six.id})
Response.create!({:user_id => third_user.id, :answer_choice_id => answer_nine.id})
Response.create!({:user_id => third_user.id, :answer_choice_id => answer_eleven.id})
Response.create!({:user_id => third_user.id, :answer_choice_id => answer_fourteen.id})