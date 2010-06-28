Hello, Dictionary!
==================

This is the example Django app for the Wordnik API and the wordnik Python package.  

Follow the instructions, and you'll have a working dictionary up and running in 15 minutes!
Resources
=========
Wordnik API Documentation: http://docs.wordnik.com/api/methods

Wordnik API Key Signup: http://api.wordnik.com/signup

Wordnik API Support: http://groups.google.com/group/wordnik-api

wordnik-python package on github: http://github.com/wordnik/wordnik-python
Tutorial
========

Install the wordnik Python package:
    wget http://pypi.python.org/packages/source/w/wordnik/wordnik-0.2.tar.gz#md5=b553e4df2ea4524d8621ae62565f175b
    tar zxvf wordnik-0.2.tar.gz
    cd wordnik-0.2
    python setup.py install

Create a new Django project: 
    django-admin.py startproject wordnikapi

Create the hello_dictionary app: 
    python manage.py startapp hello_dictionary

Edit TEMPLATE_DIRS in settings.py:
    import os.path
    TEMPLATE_DIRS = ( os.path.join(os.path.dirname(__file__), 'templates'), )

Edit INSTALLED_APPS in settings.py:
    INSTALLED_APPS = (
        'wordnikapi.hello_dictionary',
        'wordnik'
    )

Edit urlpatterns in urls.py:
    urlpatterns = patterns('',
        # Example:
        # (r'^wordnikapi/', include('wordnikapi.foo.urls')),
        (r'^$', 'wordnikapi.hello_dictionary.views.index'),
        (r'^wordnik/', 'wordnikapi.hello_dictionary.views.index')
    )

Edit hello_dictionary/views.py:
    from django.shortcuts import render_to_response
    import wordnik
    from datetime import datetime

    def index(request):
      wordnik_client = wordnik.Wordnik(api_key="85b993ddaabe04346e0090d379b02d18ad04bda75d4e0ecca")
      wotd = wordnik_client.word_of_the_day()

      template_data = { 
        'wotd': wotd['wordstring'], 
        'date': datetime.now() 
      }

      if ((len(request.GET.get('word_search',''))>0) or (len(request.GET.get('commit',''))>0)): # user has submitted form or clicked link
        if (request.GET.get('commit')=="I'm Feeling Wordie"):
          word = wordnik_client.random_word()
        else:
          word = wordnik_client.word(request.GET.get('word_search'))

        wordstring = word.get('wordstring', '')
        related_data = wordnik_client.related(wordstring)
        related = {}
        for r in related_data:
          related[r.get('relType')] = r.get('wordstrings')[0:4]

        phrases_data = wordnik_client.phrases(wordstring)
        phrases = [("%s %s" % (p.get('gram1'), p.get('gram2'))) for p in phrases_data]

        template_data.update({
          'wordstring': wordstring,
          'definitions': wordnik_client.definitions(wordstring),
          'examples': wordnik_client.examples(wordstring),
          'phrases': phrases,
          'related': related
        })

      return render_to_response('index.html', template_data)

Create the wordnikapi/templates directory, and edit templates/index.html:
    <html>
      <head>
        <title>Hello, Dictionary!</title>
      </head>
      <body>
        <div>
          <h1>Hello, Dictionary!</h3>
          <h3>The Wordnik Word of the Day for {{date|date:"l M d, Y"}} is... <strong><a href="/wordnik?word_search={{wotd|urlencode}}">{{wotd}}</a></strong>!
          </h3>
          <p>
            <form method='get' action='/wordnik'>
              Look up a word: 
              <input type='text' name='word_search' />
              <input type='submit' name='commit' value='Search' />
              <input type='submit' name='commit' value="I'm Feeling Wordie" />
            </form>
          </p>
        </div>
    {% if wordstring %}
      <hr />
      <div>
        <h2>Definitions of <em>{{wordstring}}</em></h2>
        {% if not definitions %}
          <em>Sorry, we couldn't find any definitions!</em>
        {% else %}
          <ul>
            {% for definition in definitions %}
              {% if definition.text %}
                <li>{{definition.text}}</li>
              {% endif %}
            {% endfor %}
          </ul>
          <a href="http://wordnik.com/words/{{wordstring}}">more definitions</a>
        {% endif %}
      </div>

      <div>
        <h2>Examples of <em>{{wordstring}}</em></h2>
        {% if not examples %}
          <em>Sorry, we couldn't find any examples!</em>
        {% else %}
          <ul>
            {% for example in examples %}
              {% if example.display %}
                <li>
                  {{example.display}}
                  {% if example.title %} 
                    <br />
                    - <em>{{example.title}}</em>
                  {% endif %}
                </li>
              {% endif %}
            {% endfor %}
          </ul>
          <a href="http://wordnik.com/words/{{wordstring}}">more examples</a>
        {% endif %}
      </div>

      <div>
        <h2>Words related to <em>{{wordstring}}</em></h2>
        {% if not related %}
          <em>Sorry, we couldn't find any related words!</em>
        {% else %}
          {% for rel_type, rel_words in related.items %}
            {% if rel_words %}
              <h3>{{rel_type}}</h3>
              <ul>
                <!-- only display the first 5 related words in each category -->
                {% for r in rel_words %}
                  <li><a href="/wordnik?word_search={{r|urlencode}}">{{r}}</a></li>
                {% endfor %}
              </ul>
            {% endif %}
          {% endfor %}
          <a href="http://wordnik.com/words/{{wordstring|urlencode}}">more examples</a>
        {% endif %}
      </div>

      <div>
        <h2>Phrases containing <em>{{wordstring}}</em></h2>
        {% if not phrases %}
          <em>Sorry, we couldn't find any phrases!</em>
        {% else %}
          <ul>
            {% for phrase in phrases %}
              <li><a href="/wordnik?word_search={{phrase|urlencode}}">{{phrase}}</a></li>
            {% endfor %}
          </ul>
          <a href="http://wordnik.com/words/{{wordstring|urlencode}}">more phrases</a>
        {% endif %}
      </div>
    {% endif %}
        <hr />
        <div>
          <p>Hello Dictionary was built with the <a href="http://wordnik.com/developers">Wordnik API</a>.</p>
          <p><strong>Documentation</strong>: <a href="http://docs.wordnik.com/api/methods">http://docs.wordnik.com/api/methods</a></p>
          <p><strong>API Key Signup</strong>: <a href="http://api.wordnik.com/signup/">http://api.wordnik.com/signup</a></p>
          <p><strong>Support</strong>: <a href="http://groups.google.com/group/wordnik-api">http://groups.google.com/group/wordnik-api</a></p>
        </div>
      </body>
    </html>

Start the Django server:
    python manage.py runserver

Check out your work:
    open http://localhost:8000/

Hello, Dictionary!

Resources
=========
Wordnik API Documentation: http://docs.wordnik.com/api/methods

Wordnik API Key Signup: http://api.wordnik.com/signup

Wordnik API Support: http://groups.google.com/group/wordnik-api

wordnik-python on github: http://github.com/wordnik/wordnik-python
Copyright
=========

Copyright (c) 2010 Altay Guvench / Wordnik.com. See LICENSE for details.
