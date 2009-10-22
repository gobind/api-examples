require 'net/http'
require 'uri'
require 'hpricot'
require 'json'
require 'definition'
require 'example'

# Ruby wrapper to access Wordnik definitions API.
class Wordnik

# move to config file
API_BASE_URL = 'http://api.wordnik.com/api'
API_KEY = 'INTERNAL_ALPHA_TEST'

# add:
# - spelling suggestions (did you mean)
# - wotd
# - corpus frequency
# - autosuggest (like autocomplete on site)

  private
  
  # gets raw parsed json
  def self.get_raw_data(url)
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
    JSON.parse(res.body)
  end
  
  public

  # get an array of examples sentences for a word, as strings
  def self.examples(word)
    begin
      
      # TODO: send key via headers, not querystring
      url = URI.parse( "#{API_BASE_URL}/word.json/#{word}/examples?api_key=#{API_KEY}" )
      result = get_raw_data(url)
      raise 'Wordnik API error' if result.is_a?(Hash) && result.has_key?('Error')
      
      puts result.inspect
      
      examples = Array.new
      result.each do |e|
        puts 'creating an example, display is: ' + e['display'];
        examples << Example.new(  :display => e['display'],
                                  :rating => e['rating'],
                                  :url => e['url'],
                                  :title => e['title'] )
      end
      examples
    rescue Exception => e
      puts "Wordnik API error in examples: #{e}"
      nil
    end
  end

  # get an array of Definition objects for a word
  def self.definitions(word)
    begin
      
      # TODO: send key via headers, not querystring
      url = URI.parse( "#{API_BASE_URL}/word.json/#{word}/definitions?api_key=#{API_KEY}" )
      result = get_raw_data(url)
      raise 'Wordnik API error' if result.is_a?(Hash) && result.has_key?('Error')
      
      definitions = Array.new
      result.each do |d|
        definitions << Definition.new( :word => d['headword'],
                                       :dictionary => 'Century Dictionary',
                                       :summary => d['defTxtSummary'],
                                       :full => d['defTxtExtended'],
                                       :pos => d['pos'] )
      end
      definitions
    rescue Exception => e
      puts "Wordnik API error in definitions: #{e}"
      nil
    end
  end
end