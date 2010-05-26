class List
  
  # a List looks like this:
  # {"userName"=>"api-test", "name"=>"blerg", "updatedAt"=>"2010-05-25T02:55:04.892+0000", "numberWordsInList"=>0, "id"=>25488, "userId"=>1049237, "type"=>"PUBLIC", "createdAt"=>"2010-05-25T02:55:04.892+0000", "description"=>"blarg", "permalinkId"=>"blerg"}

  attr_accessor :id, :type, :user_name, :user_id, :name, :description, :permalink_id, :word_count, :updated_at, :created_at

  def initialize(options={})
    @id = options['id']
    @type = options['type']
    @user_name = options['userName']
    @user_id = options['userId']
    @name = options['name']
    @description = options['description']
    @permalink_id = options['permalinkId']
    @word_count = options['numberWordsInList']
    @updated_at = options['updatedAt']
    @created_at = options['createdAt']
  end

  # this is used for making api calls
  def client
    return Wordnik.client
  end
  
  # create a new list.  you must give it a name.  description is optional.
  def self.create(name, description=nil)
    Wordnik.client.ensure_authentic
    body = {'name'=>name, 'description'=>description, :type=>'PUBLIC' }
    response = Wordnik.post("/wordLists.json", {:body=>body.to_json, :headers=>Wordnik.client.api_headers} )
    if (response['permalinkId']) # list successfully created
      the_list = List.new(response)
      return the_list
    else
      puts('ERROR! list was not created.')
    end
  end

  # destroy this list completely
  def destroy
    self.client.ensure_authentic
    response = Wordnik.delete("/wordList.json/#{self.permalink_id}", {:headers=>self.client.api_headers})
    return response
  end

  # get all the words in this list
  def words
    response = Wordnik.get("/wordList.json/#{self.permalink_id}/words", {:headers=>self.client.api_headers})
    return response
  end

  # add the given word to this list
  def add_word(wordstring)
    self.client.ensure_authentic
    body = [{'wordstring'=>wordstring}]
    response = Wordnik.post("/wordList.json/#{self.permalink_id}/words", {:body=>body.to_json, :headers=>self.client.api_headers})
    @word_count += 1
    return self.words
  end

  # remove the given word from this list
  def remove_word(wordstring)
    self.client.ensure_authentic
    body = [{'wordstring'=>wordstring}]
    response = Wordnik.post("/wordList.json/#{self.permalink_id}/deleteWords", {:body=>body.to_json, :headers=>self.client.api_headers})
    @word_count -= 1
    return self.words
  end

end
