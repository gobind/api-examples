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
