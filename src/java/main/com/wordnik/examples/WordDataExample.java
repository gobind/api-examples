package com.wordnik.examples;

import java.net.URLEncoder;
import java.util.Iterator;
import java.util.List;

import com.sun.jersey.api.client.GenericType;
import com.wordnik.examples.objects.Example;
import com.wordnik.examples.objects.Frequency;
import com.wordnik.examples.objects.FrequencyValue;
import com.wordnik.examples.objects.Word;

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
	
		WordDataExample t = new WordDataExample();
		try{
			t.initClient();
			t.fetchWord(args[1]);
			t.fetchExamples(args[1]);
			t.fetchFrequency(args[1]);
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
		System.out.println("found word " + word.getWord());
	}
	
	void fetchExamples(String wordstring) throws Exception {
		GenericType<List<Example>> genericType = new GenericType<List<Example>>() {}; 
		List<Example> examples = client.resource("http://api.wordnik.com/api/word.xml/" + URLEncoder.encode(wordstring, "utf8") + "/examples").header("api_key", API_KEY).get(genericType);
		
		for(Example example : examples){
			System.out.println("example: " + example.getDisplay());
		}
	}

	void fetchFrequency(String wordstring) throws Exception {
		Frequency frequencyData = client.resource("http://api.wordnik.com/api/word.xml/" + URLEncoder.encode(wordstring, "utf8") + "/frequency").header("api_key", API_KEY).get(Frequency.class);
		
		
		for(Iterator<FrequencyValue> x =frequencyData.getValues().iterator(); x.hasNext();){
			FrequencyValue frequency = x.next();
			System.out.println("Year: " + frequency.getYear() + ", frequency: " + frequency.getCount());
		}
	}
	
	static void usage(){
		System.out.println("usage: " + WordDataExample.class.getName() +" {api_key} {word}");
	}
}
