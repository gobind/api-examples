require 'rubygems'
require 'httparty'
require 'json'
require 'word'
require 'definition'
require 'example'
require 'list'

# Ruby wrapper to access Wordnik definitions API. Has dependency on HTTParty gem.
# No exception handling or other niceties. Intended as an API demo, not meant for production use
class Wordnik
  include HTTParty
  base_uri 'http://api.wordnik.com/api'
  
  attr_accessor :api_key, :auth_token

  def authenticated?
    return !self.auth_token.blank?
  end

  def ensure_authentic
    raise("This method requires a valid auth_token!") unless self.authenticated?
  end

  @@client = nil
  def self.client
    return @@client
  end

  # this initializes the wordnik api client
  # options[:api_key] is REQUIRED 
  # if you want to access the "write" api calls (e.g. List creation/deletion), you need to also pass in options[:username] and options[:password] to authenticate
  # e.g. w = Wordnik.new({:username=>'my_username', :password=>'my_password', :api_key=>'my_api_key'})
  # this will set the @api_key, @auth_token, and @user_id variables
  def initialize(options={}) 
    raise("ERROR: missing api_key!") if options[:api_key].blank? 
    @api_key = options[:api_key]
    # pass in options[:username] and options[:password] if you want to authenticate this instance of the api client.
    # authenticating will allow you to perform all CRUD operations (e.g. List creation/deletion/etc)
    if options[:username] && options[:password]
      response = self.class.get("/account.json/authenticate/#{options[:username]}", {:query=>{:password=>options[:password]}, :headers => {'Content-Type'=>'application/json', 'api_key' => @api_key}} )
      if (response['type'] && response['type']=='error')
        puts("ERROR: #{response['message']}")
      elsif (response['userId'])
        puts('access GRANTED!')
        @auth_token = response['token']
        @user_id = response['userId']
      else
        puts("access DENIED! make sure you're passing a valid :username, :password, and :api_key to Wordnik.new")
      end
    end
    @@client = self # so we can do Wordnik.client
    return self
  end
  
  # this returns the api headers (including api_key and auth_token) for the wordnik api client
  def api_headers
    the_headers = {'Content-Type'=>'application/json', 'api_key' => @api_key}
    the_headers.merge!({'auth_token'=>@auth_token}) if authenticated?
    return the_headers
  end

  # get all the lists for the authenticated user
  def lists
    ensure_authentic
    list_data = Wordnik.get("/wordLists.json", {:headers=>self.api_headers})
    return list_data.map{|list| List.new(list) }
  end

  # create a list for the authenticated user
  def create_list(name, description)
    ensure_authentic
    return List.create(name, description)
  end

end
