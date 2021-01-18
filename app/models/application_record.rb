class ApplicationRecord < ActiveRecord::Base
  # Models are inherited from this Application Controller calss and this Application Controller class is inherited from ActiveRecord Library
  # The Methods inherited from Acitve Records are used to generate SQL queries that make changes to DB
  self.abstract_class = true
end
