require 'singleton'
require 'sqlite3'

class AAQuestionsDatabase < SQLite3::Database
  include Singleton
  def initialize
    #Gets the associated database
    #Note: recreate dabatase locally
    super("aaquestions.db")

    #Returns the values as an array of hashes
    self.results_as_hash = true

    #Returns the values as what they should be
    #(strings for varchar, integers for integers...)
    self.type_translation = true
  end
end

class AAQuestionsTable
  def save
    @id.nil? ? create : update
  end
end

require './questions.rb'
require './aaquestions_user.rb'
require './aaquestions_reply.rb'
load './aaquestions_tag.rb'