class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  def initialize_wordnik(options={})
    options.merge!({:api_key=>ENV['WORDNIK_API_KEY']})
    @wordnik = Wordnik.new(options)
    @wotd = @wordnik.word_of_the_day
  end
end
