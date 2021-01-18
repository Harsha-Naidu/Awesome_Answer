# This model was generated using following command👇🏻
# rails g model answer body:text question:references
# This Command generated 2 files one is this model the second is migration to create the answer table

class Answer < ApplicationRecord
 
  belongs_to :question

  # ASSOCIATION WITH USER MODEL
  belongs_to :user, optional: true

  # This is autmatically added to a model when we use references :question
  # it generates a validation something like this 👇🏻:
  # validates :question_id, presence: true # but this is hidden from us
  # validates :body, presence: true
  validates :body, presence: {message: " should be present."}

end
=begin

Method 1:
q = Question.find 10

a = Answer.new(body: 'My Awesome Answer')
a.question = q
a.save

Method 2:
a = q.answers.new(body: 'My Awesome Answer')
a.save

Method 3:
a = q.answers.create(body: 'My Awesome Answer')

Method 4:
a = Answer.create(body: 'My Awesome Answer', question: q)
Method 5:

a=Answer.create(body: "My Awesome Answer 5", question_id:q.id)

If you want to query for answers you can do:

q.answers # 👈🏻 will fetch all the questions whose question_id is 10

=end