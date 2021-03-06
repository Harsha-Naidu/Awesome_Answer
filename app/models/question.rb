class Question < ApplicationRecord
    after_initialize :set_defaults
    before_save :capitalize_title
    # validates :title, presence: true
    validates :title, presence: {message: 'must be provided'},uniqueness: true
    # validates :title, uniqueness: true

    # ASSOCIATION WITH ANSWER MODEL
    has_many :answers, dependent: :destroy # in case of delete


    # ASSOCIATION WITH USER MODEL
    belongs_to :user, optional: true

    validates :body , length:{minimum: 2, maximum: 200}
    validates :title, uniqueness: {scope: :body }
    validates :view_count, numericality: {greater_than_or_equal_to: 0}
    validate :no_monkey
    # .new

    # Exercise:
    # def self.search(query)
    #     where("title ILIKE ? OR body ILIKE ?", "%#{query}%", "%#{query}%")
    # end

    # Equivalent to:
    scope(:search, -> (query){ where("title ILIKE ? OR body ILIKE ?", "%#{query}%", "%#{query}%") })

    # def self.recent_ten
    #     order("created_at DESC").limit(10)
    # end
    # Converting above method into a lambda
    scope :recent_ten,lambda{order("created_at DESC").limit(10)}


    private
    
    def capitalize_title
        self.title.capitalize!
    end
    def set_defaults
        self.view_count ||= 0
    end
    def no_monkey
        if body&.downcase&.include?("monkey")
        # &. is the safe navigation operator. It's used
        # like the . operator to call methods on an object.
        # If the method doesn't exist for the object, 'nil'
        # will be returned instead of getting an error
            self.errors.add(:body, "must not have monkeys")
            # To make a record invalid. You must add a 
            # validation error using the 'errors' 'add' method
            # It's arguments (in order):
            # - A symbol for the invalid column
            # - An error message as a string
        end
    
    end
end

# LifeCycle of a Model is: Initialize > Validates> Save> Commits 

# A C T I V E    R E C O R D 
    # Fetch All Questions
    # questions = Question.all 👈 this will give us back the list of questions as an object
    # the object behaves like an array so you can call methods on it like (.each) and you
    # can also chain it with other methods to do other types of operations and queries

    # Creating a new question
    # To create a new question object in memory do:
    # q = Question.new
    # you can also pass in a hash to the new method as in:
    # q = Question.new({ title: 'To be or not to be', body: 'is that a question?', view_count: 0 })
    # or for short:
    # q = Question.new title: 'To be or not to be }, body: 'is that a question?', view_count: 0 

    # to save the above question into questions table:
    # q.save 👈 this will save that above question into the questions table (persist it)

    # Creating a record right away
    # you can create a record right away in the database using (.create) method as in:
    # Question.create({ title: 'My Question Title', body: 'My question body', view_count: 1 })

    # Fetching Records
    # .first
    # Question.first 👈 fetches the first record ordered by the id in an ascending order
    # The sql equivalent:
    # SELECT "questions".* FROM "questions" ORDER BY "questions"."id" ASC LIMIT 1;

    # .last
    # Question.last 👈 fetches the last record ordered by the id in an ascending order 
    # The sql equivalent:
    # SELECT "questions".* FROM "questions" ORDER BY "qeustions"."id" DESC LIMIT 1;

    # .find
    # Question.find(1) 👈 finding records by their primary key which is likely id

    # .find_by_x 👈 x is the column name
    # Question.find_by_title('My Last Question') 👈 this finds a question with title 
    # exactly "My Last Question"

    # .where
    # Question.where({ title: 'My Last Question', body: 'The body of the question' })

    # WILDCARD SEARCHING 
    # You can perform  wildcard searching with ActiveRecord using LIKE within "where" method
    # Question.where(['title LIKE ?', '%Last%'])
    # if you are using Postgres client, you can use ILIKE for case-insensitive searching:
    # Question.where(['title ILIKE ?', '%Last%'])
    # Note that in above queries we used a syntax that used '?' to insert variable into a SQL query.
    # this is important to avoid SQL injection if the variable component is actually a user input such
    # as search term.

    # .limit
    # Question.limit(10) 👈 this will give us back 10 first questions that are returned from the query

    # .order
    # Question.order(:created_at) 👈 this will order the fetched records by created_at. by default is ASC and 
    # if you want them in descending order do:
    # Question.order(created_at: :DESC)


    # Chaining
    # You can chain the where, limit, order, offset, and many others to compose
    # more sophisticated queries for example:
    # Question.where(['view_count > ?', 10]).where(['title ILIKE ?', 'a']).order(id: :DESC).limit(10).offset(10)
    # Note: offset will skip first 10 records from the above query
    # SQL equivalent:
    # SELECT "questions".* FROM "questions" WHERE (view_count > 10) AND (title ILIKE 'a') ORDER BY id DESC LIMIT 10 OFFSET 10
    # another example:
    # Question.where(['view_count < ?', 10]).where(['body ILIKE ?', '%question%']).order(id: :DESC).limit(1).offset(1)

    # UPDATE RECORDS
    # once you've selected one or more records, you have ability to update them
    # Many setting attributes:
    # q = Question.find 10
    # q.title = "Some new title"
    # q.save
    # q.view_count += 1
    # q.save

    # using .update_attributes or .update
    # q = Question.find 10
    # q.update({ title: 'Updated Title', body: 'Updated body' }) or
    # q.update_attribute(:title, 'Updated Title') or
    # q.update_attributes(title: 'Updated Title', body: 'Updated body')

    # DELETING RECORDS
    # using .destroy
    # q = Question.find 10
    # q.destroy

    # using .delete
    # q = Question.find 10
    # q.delete

    # using .delete skips executing callback methods after_destroy and before_destroy 
    # and also skips deleting or nullifying associated records in the :dependant option
    # with associtations. Generally, avoid using ".delete" in favor of ".destroy". there are
    # only few cases when you want to use ".delete"

    # Aggregate functions
    # .count
    # Question.count 👈 counts the number of records in questions model
    # SQL equivalent:
    # SELECT COUNT(*) FROM "questions";

    # .group
    # Question.select('avg(view_count)) as count').group('title')

    # CALLING RAW QUERIES
    # connection = ActiveRecord::Base.connection
    # result = connection.execute('SELECT * FROM questions WHERE id=1;')
    # result.first 👈 because the result is an array of hashes
