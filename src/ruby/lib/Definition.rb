class Definition
  
  attr_accessor :word, :dictionary, :summary, :full, :pos
  
  def initialize(options={})
    @dictionary = options[:dictionary]
    @word = options[:word]
    @summary = options[:summary]
    @full = options[:full]
    @pos = options[:pos]
  end
  
end