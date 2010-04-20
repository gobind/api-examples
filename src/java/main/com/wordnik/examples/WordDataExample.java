package com.wordnik.examples;

import java.net.URLEncoder;
import java.util.Iterator;
import java.util.List;

import com.sun.jersey.api.client.GenericType;
import com.wordnik.examples.objects.*;

/**
 * fetches a word and some properties on it
 * 
 * @author tony
 *
 */
public class WordDataExample extends AbstractExample {
	public static void main(String[]args){
		if(args == null || args.length < 2){
			usage();
			return;
		}

		//	your api key
		API_KEY = args[0];
		
		//	word to get data for
		String wordstring = args[1];
	
		WordDataExample t = new WordDataExample();
		try{
			t.initClient();
			t.fetchWord(wordstring);
			t.fetchExamples(wordstring);
			t.fetchFrequency(wordstring);
			t.fetchDefinitions(wordstring);
			t.fetchRelatedWords(wordstring);
			t.fetchPhrases(wordstring);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	/**
	 * fetches the word back from the API, returns a 404 if not found.
	 * 
	 * @param wordstring
	 * @throws Exception
	 */
	void fetchWord(String wordstring) throws Exception {
		Word word = client.resource("http://api.wordnik.com/api/word.xml/" + URLEncoder.encode(wordstring, "utf8")).header("api_key", API_KEY).get(Word.class);
		System.out.println("found word " + word.getWordstring());
	}

	/**
	 * fetches definitions for the specified word
	 * 
	 * @param wordstring
	 * @throws Exception
	 */
	void fetchDefinitions(String wordstring) throws Exception {
		GenericType<List<Definition>> genericType = new GenericType<List<Definition>>() {}; 
		List<Definition> definitions = client.resource("http://api.wordnik.com/api/word.xml/" + URLEncoder.encode(wordstring, "utf8") + "/definitions").header("api_key", API_KEY).get(genericType);
		
		for(Definition definition : definitions){
			System.out.println("definition: " + definition.getText());
		}
	}

	/**
	 * fetches frequency data for the specified word
	 * @param wordstring
	 * @throws Exception
	 */
	void fetchFrequency(String wordstring) throws Exception {
		FrequencySummary frequencyData = client.resource("http://api.wordnik.com/api/word.xml/" + URLEncoder.encode(wordstring, "utf8") + "/frequency").header("api_key", API_KEY).get(FrequencySummary.class);
		
		for(Iterator<FrequencyValue> x =frequencyData.getFrequency().iterator(); x.hasNext();){
			FrequencyValue frequency = x.next();
			System.out.println("Year: " + frequency.getYear() + ", frequency: " + frequency.getCount());
		}
	}
	
	/**
	 * fetches examples for the specified word
	 * 
	 * @param wordstring
	 * @throws Exception
	 */
	void fetchExamples(String wordstring) throws Exception {
		GenericType<List<Example>> genericType = new GenericType<List<Example>>() {}; 
		List<Example> examples = client.resource("http://api.wordnik.com/api/word.xml/" + URLEncoder.encode(wordstring, "utf8") + "/examples").header("api_key", API_KEY).get(genericType);
		
		for(Example example : examples){
			System.out.println("example (" + example.getProvider().getName() + "): " + example.getDisplay());
		}
	}
	
	/**
	 * fetches related words for the specified word
	 * 
	 * @param wordstring
	 * @throws Exception
	 */
	void fetchRelatedWords(String wordstring) throws Exception {
		GenericType<List<Related>> genericType = new GenericType<List<Related>>() {}; 
		List<Related> relatedWords = client.resource("http://api.wordnik.com/api/word.xml/" + URLEncoder.encode(wordstring, "utf8") + "/related").header("api_key", API_KEY).get(genericType);
		
		for(Related relatedWord : relatedWords){
			System.out.println("relationship: " + relatedWord.getRelType());
			for(String word : relatedWord.getWordstrings().getWordstring()){
				System.out.println("\t"+word);
			}
		}
	}
	
	void fetchPhrases(String wordstring) throws Exception {
		GenericType<List<Bigram>> genericType = new GenericType<List<Bigram>>() {}; 
		List<Bigram> phrases = client.resource("http://api.wordnik.com/api/word.xml/" + URLEncoder.encode(wordstring, "utf8") + "/phrases").header("api_key", API_KEY).get(genericType);
		
		for(Bigram phrase : phrases){
			System.out.println("phrase: " + phrase.getGram1() + " " + phrase.getGram2());
		}
	}
	
	static void usage(){
		System.out.println("usage: " + WordDataExample.class.getName() +" {api_key} {word}");
	}
}
