package com.wordnik.examples;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.ws.rs.core.MediaType;

import com.wordnik.examples.objects.AuthenticationToken;
import com.wordnik.examples.objects.WordList;
import com.wordnik.examples.objects.WordListType;
import com.wordnik.examples.objects.StringValue;
import com.wordnik.examples.objects.WordListWord;

public class WordListExample extends AbstractExample {
	private static String USER_NAME = null;
	private static String PASSWORD = null;
	private static AuthenticationToken TOKEN = null;

	public static void main(String ... args){
		if(args == null || args.length < 4){
			usage();
			return;
		}

		//	your api key
		API_KEY = args[0];

		//	your username
		USER_NAME = args[1];
		
		//	your password
		PASSWORD = args[2];
		
		//	list name
		String listName = args[3];
		
		//	comma-separated words
		String words = args[4];

		WordListExample t = new WordListExample();
		try{
			t.initClient();
			t.authenticate(USER_NAME, PASSWORD);
			t.createWordList(listName, words);
			t.getAllWordLists();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	/**
	 * authenticates the user with the supplied credentials
	 * 
	 * @param username
	 * @param password
	 * @throws Exception
	 */
	void authenticate(String username, String password) throws Exception {
		TOKEN = client.resource("https://api.wordnik.com/api/account.xml/authenticate/" + URLEncoder.encode(username, "utf8")).header("api_key", API_KEY).post(AuthenticationToken.class, password);
		System.out.println("authenticated user " + username);
	}

	/**
	 * returns all word lists for the authenticated user
	 * 
	 * @throws Exception
	 */
	void getAllWordLists() throws Exception {
		WordList[] lists = client.resource("https://api.wordnik.com/api/wordLists.xml").header("api_key", API_KEY).header("auth_token", TOKEN.getToken()).get(WordList[].class);
		if(lists != null){
			for(WordList list : lists){
				System.out.println("got list id " + list.getPermalinkId());
			}
		}
	}
	
	/**
	 * creates a word list and adds words to it.  Will split the wordsToAdd by commas to add multiple words.
	 * 
	 * @param listName
	 * @param wordsToAdd
	 * @return
	 * @throws Exception
	 */
	String createWordList(String listName, String wordsToAdd) throws Exception {
		WordList list = new WordList();
		list.setName(listName);
		list.setDescription("my list named " + listName);
		list.setType(WordListType.PRIVATE);

		//	create the list
		list = client.resource("https://api.wordnik.com/api/wordLists.xml").type(MediaType.APPLICATION_XML).header("api_key", API_KEY).header("auth_token", TOKEN.getToken()).post(WordList.class, list);
		System.out.println("created list " + listName + " with permalink " + list.getPermalinkId());

		//	add some words
		List<StringValue> words = new ArrayList<StringValue>();
		if(wordsToAdd.indexOf(',') > 0){
			StringTokenizer tk = new StringTokenizer(wordsToAdd, ",");
			while(tk.hasMoreElements()){
				StringValue str = new StringValue();
				str.setWordstring(tk.nextToken().trim());
				words.add(str);
			}
		}
		else{
			StringValue str = new StringValue();
			str.setWordstring(wordsToAdd);
			words.add(str);
		}
		
		//	add a word which we'll remove later
		StringValue str = new StringValue();
		str.setWordstring("yuck");
		words.add(str);

		client.resource("https://api.wordnik.com/api/wordList.xml/" + URLEncoder.encode(list.getPermalinkId(), "utf8") + "/words").type(MediaType.APPLICATION_XML).header("api_key", API_KEY).header("auth_token", TOKEN.getToken()).post(words.toArray(new StringValue[words.size()]));
		System.out.println("added " + words.size() + " word(s)");

		//	get all the words in the list we just created
		WordListWord[] wordsInList = client.resource("https://api.wordnik.com/api/wordList.xml/" + URLEncoder.encode(list.getPermalinkId(), "utf8") + "/words").type(MediaType.APPLICATION_XML).header("api_key", API_KEY).header("auth_token", TOKEN.getToken()).get(WordListWord[].class);
		System.out.println("found " + wordsInList.length + " words in list");

		//	remove the word "yuck" from the list
        client.resource("https://api.wordnik.com/api/wordList.xml/" + list.getPermalinkId() + "/deleteWords").header("api_key", API_KEY).header("auth_token", TOKEN.getToken()).post(new StringValue[]{str});
        
        //	uncomment to delete the list you just created
//        client.resource("https://api.wordnik.com/api/wordList.xml/" + list.getPermalinkId()).header("api_key", API_KEY).header("auth_token", TOKEN.getToken()).delete();
        
		return list.getPermalinkId();
	}

	static void usage(){
		System.out.println("usage: " + WordListExample.class.getName() +" {api_key} {username} {password} {list name} {words-to-add}");
	}
}
