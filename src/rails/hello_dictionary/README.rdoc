= Hello, Dictionary!

This is the example Rails app for the Wordnik API and the wordnik-ruby gem.  

Follow the instructions, and you'll have a working dictionary up and running in 15 minutes!
= Resources
Wordnik API Documentation: http://docs.wordnik.com/api/methods

Wordnik API Key Signup: http://api.wordnik.com/signup

Wordnik API Support: http://groups.google.com/group/wordnik-api

wordnik-ruby gem on github: http://github.com/wordnik/wordnik-ruby
= Tutorial

1. Create a new Rails app: 
    >> rails hello_dictionary

2. Install the wordnik-ruby gem (you may need to do this as sudo, depending on your setup):
    >> gem install wordnik-ruby

3. Edit two lines in hello_dictionary/config/environment.rb:
    3a. Add the wordnik-ruby gem (inside of the Rails::Initializer.run block):
    config.gem "wordnik-ruby"
    3b. Add your Wordnik API key at the end of the file (outside of the Rails::Initializer.run block). Don't have a key? Go here: http://api.wordnik.com/signup
    ENV['WORDNIK_API_KEY'] = "YOUR_API_KEY_GOES_HERE"

3. Add the "initialize_wordnik" function to hello_dictionary/app/controllers/application_controller.rb:

    class ApplicationController < ActionController::Base
      helper :all # include all helpers, all the time
      protect_from_forgery # See ActionController::RequestForgeryProtection for details

      def initialize_wordnik(options={})
        options.merge!({:api_key=>ENV['WORDNIK_API_KEY']})
        @wordnik = Wordnik.new(options)
        @wotd = @wordnik.word_of_the_day
      end
    end

4. Create a controller and add an 'index' action:
    >> script/generate controller wordnik

5. Edit the new controller (hello_dictionary/app/controllers/wordnik_controller.rb), like so:
    class WordnikController < ApplicationController

      def index
        # initialize_wordnik will set up the @wordnik object, which we can then use to call the wordnik api.
        # it also fetches the word of the day, @wotd
        # don't forget to specify your WORDNIK_API_KEY at the bottom of config/environment.rb!
        initialize_wordnik

        if (params[:word_search] || params[:commit]) # user has submitted the form or clicked a link
          if params[:commit]=="I'm Feeling Wordie"
            @word = @wordnik.random_word
          else
            @word = Word.find(params[:word_search])
          end
          @wordstring = @word.wordstring
          @definitions = @word.definitions
          @examples = @word.examples
          @phrases = @word.phrases
          @related = @word.related
        end
      end
    end

6. Create your app's layout (hello_dictionary/app/views/layouts/application.html.erb):
    <html>
      <head>
        <title>Hello, Dictionary!</title>
      </head>
      <body>
        <div>
          <h1>Hello, Dictionary!</h3>
          <h3>The Wordnik Word of the Day for <%= Time.now.strftime("%A, %B %d, %Y") %> is... <strong><%= link_to(@wotd['wordstring'], "/wordnik?word_search=#{@wotd['wordstring']}") %></strong>!
          </h3>
          <p>
            <% form_tag('/wordnik', :method=>'get') do -%>
              Look up a word: 
              <%= text_field_tag('word_search') %>
              <%= submit_tag('Search') %>
              <%= submit_tag("I'm Feeling Wordie") %>
            <% end %>
          </p>
        </div>
        <%= yield %>
        <hr />
        <div>
          <p>Hello Dictionary was built with the <%= link_to("Wordnik API", "http://wordnik.com/developers") %>.</p>
          <p><strong>Documentation</strong>: <%= link_to("http://docs.wordnik.com/api/methods", "http://docs.wordnik.com/api/methods") %></p>
          <p><strong>API Key Signup</strong>: <%= link_to("http://api.wordnik.com/signup/", "http://api.wordnik.com/signup/") %></p>
          <p><strong>Support</strong>: <%= link_to("http://groups.google.com/group/wordnik-api", "http://groups.google.com/group/wordnik-api") %></p>
        </div>
      </body>
    </html>

7. Create the template for the wordnik/index action (hello_dictionary/app/views/wordnik/index.html.erb):
    <% unless @word.nil? %>
      <hr />
      <div>
        <h2>Definitions of <em><%= @wordstring %></em></h2>
        <% if @definitions.blank? %>
          <em>Sorry, we couldn't find any definitions!</em>
        <% else %>
          <ul>
            <% @definitions.each do |definition| %>
              <% unless definition.text.blank? -%>
                <li><%= definition.text %></li>
              <% end %>
            <% end %>
          </ul>
          <%= link_to("more definitions", "http://wordnik.com/words/#{@wordstring}") %>
        <% end %>
      </div>

      <div>
        <h2>Examples of <em><%= @wordstring %></em></h2>
        <% if @examples.blank? %>
          <em>Sorry, we couldn't find any examples!</em>
        <% else %>
          <ul>
            <% @examples.each do |example| %>
              <% unless example.display.blank? -%>
                <li>
                  <%= example.display -%>
                  <% unless example.title.blank? %>
                    <br />
                    - <em><%= example.title %></em>
                  <% end %>
                </li>
              <% end %>
            <% end %>
          </ul>
          <%= link_to("more examples", "http://wordnik.com/words/#{@wordstring}") %>
        <% end %>
      </div>

      <div>
        <h2>Words related to <em><%= @wordstring %></em></h2>
        <% if @related.blank? %>
          <em>Sorry, we couldn't find any related words!</em>
        <% else %>
            <% @related.each do |relation_type, related_words| %>
              <% unless related_words.blank? -%>
                <h3><%= relation_type %></h3>
                <ul>
                  <!-- only display the first 5 related words in each category -->
                  <% related_words[0..4].each do |related_word| %>
                    <li><%= link_to(related_word.wordstring, "/wordnik?word_search=#{URI.escape(related_word.wordstring)}") -%></li>
                  <% end %>
                </ul>
              <% end %>
            <% end %>
          </ul>
          <%= link_to("more related words", "http://wordnik.com/words/#{@wordstring}") %>
        <% end %>
      </div>

      <div>
        <h2>Phrases containing <em><%= @wordstring %></em></h2>
        <% if @phrases.blank? %>
          <em>Sorry, we couldn't find any phrases!</em>
        <% else %>
          <ul>
            <% @phrases.each do |phrase| %>
              <% unless phrase['gram1'].blank? -%>
                <% complete_phrase = "#{phrase['gram1']} #{phrase['gram2']}" %>
                <li><%= link_to(complete_phrase, "/wordnik?word_search=#{URI.escape(complete_phrase)}") %></li>
              <% end %>
            <% end %>
          </ul>
          <%= link_to("more phrases", "http://wordnik.com/words/#{@wordstring}") %>
        <% end %>
      </div>
    <% end %>

7. Start your app's server:
    >> script/server

9. Navigate to http://localhost:3000/wordnik
    >> open http://localhost:3000/wordnik

10. Party!

= Resources
Wordnik API Documentation: http://docs.wordnik.com/api/methods

Wordnik API Key Signup: http://api.wordnik.com/signup

Wordnik API Support: http://groups.google.com/group/wordnik-api

wordnik-ruby gem on github: http://github.com/wordnik/wordnik-ruby
== Copyright

Copyright (c) 2010 Altay Guvench / Wordnik.com. See LICENSE for details.
