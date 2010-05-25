package com.wordnik.examples;

import javax.ws.rs.core.Response;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.filter.LoggingFilter;
import com.wordnik.examples.objects.ApiTokenStatus;

public abstract class AbstractExample {
	Client client = null;
	static String API_KEY = null;

	protected void initClient() throws Exception {
		client = new Client();

		//	check to make sure this key is valid
		ClientResponse response = client.resource("https://api.wordnik.com/api/account.xml/apiTokenStatus/").header("api_key", API_KEY).get(ClientResponse.class);
		if(System.getProperty("WORDNIK_DEBUG") != null){
			//	add a logger filter to see all messages
			client.addFilter(new LoggingFilter());
		}

		if(Response.Status.OK.getStatusCode() != response.getStatus()){
			System.out.println("invalid response from the server, HTTP status code was " + response.getStatus());
			throw new Exception("failed to get api token status!  " + response.getEntity(String.class).toString());
		}
		ApiTokenStatus status = response.getEntity(ApiTokenStatus.class);
		if(status.getRemainingCalls()==0){
			System.out.println("this token has used up all it's available calls");
			throw new Exception ("bad token");
		}
	}
}
