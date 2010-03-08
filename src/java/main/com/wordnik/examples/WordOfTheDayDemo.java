package com.wordnik.examples;

import com.wordnik.examples.objects.*;

/**
 * Sample code to fetch the most current word of the day
 * 
 * @author tony
 *
 */
public class WordOfTheDayDemo extends AbstractExample {
	public static void main(String[]args){
		if(args == null || args.length < 1){
			usage();
			return;
		}

		//	your api key
		API_KEY = args[0];
		
		WordOfTheDayDemo t = new WordOfTheDayDemo();
		try{
			t.initClient();
			t.wordOfTheDay();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	void wordOfTheDay() throws Exception {
		WordOfTheDay wotd = client.resource("http://api.wordnik.com/api/wordoftheday.xml").header("api_key", API_KEY).get(WordOfTheDay.class);
		
		System.out.println("word of the day is: " + wotd.getWordstring());
		for(WordOfTheDayDefinition def : wotd.getDefinition()){
			System.out.println("\tdefinition:" + def.getText());
		}
		
		for(WordOfTheDayExample example : wotd.getExample()){
			System.out.println("\texample:" + example.getText());
		}
	}

	static void usage(){
		System.out.println("usage: " + WordOfTheDayDemo.class.getName() +" {api_key}");
	}
}
