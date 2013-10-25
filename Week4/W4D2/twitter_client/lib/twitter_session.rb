require 'singleton'
require 'launchy'
require 'oauth'
require 'yaml'

class TwitterSession
  include Singleton

  attr_reader :access_token

  CONSUMER_KEY = "MTOdtSdCjT2G2xlgP0WLQ"
  CONSUMER_SECRET = "DJvgOI6zrCUpiaw0mRU4QInfIB7Og4YUdNrZYEydFLw"
  CONSUMER = OAuth::Consumer.new(
    CONSUMER_KEY, CONSUMER_SECRET, :site => "https://twitter.com")

  def initialize
    @access_token = read_or_request_access_token
  end

  def self.get(*args)
    self.instance.access_token.get(*args).body
  end

  def self.post(*args)
    self.instance.access_token.post(*args)
  end

  protected
  def read_or_request_access_token
    if File.exist?('token_file.txt')
      File.open('token_file.txt') { |f| YAML.load(f) }
    else
      access_token = request_access_token
      File.open('token_file.txt', "w") { |f| YAML.dump(access_token, f) }

      access_token
    end
  end

  def request_access_token
    #gets the request token associated with the consumer key
    request_token = CONSUMER.get_request_token #This is an OAuth method
    authorize_url = request_token.authorize_url #uses the :site above to generate an authorization url
    puts "Go to this URL: #{authorize_url}"
    Launchy.open(authorize_url)

    #After the user give us authorization via OAuth, they come back here
    #and we take in their verifier to get their access token for future
    #get and push requests
    puts "Login, and type your verification code in"
    oauth_verifier = gets.chomp

    #takes the access token and verfies it with twitter
    access_token = request_token.get_access_token(
      :oauth_verifier => oauth_verifier
    )
  end
end