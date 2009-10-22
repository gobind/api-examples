package com.wordnik.examples.objects;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class ApiTokenStatus {
	boolean valid;
	long expiresIn;
	long calls;
	long remainingCalls;
	long resetsIn;
	String token;

	public boolean isValid() {
		return valid;
	}

	public void setValid(boolean valid) {
		this.valid = valid;
	}

	public long getExpiresIn() {
		return expiresIn;
	}

	public void setExpiresIn(long expiresIn) {
		this.expiresIn = expiresIn;
	}

	public long getCalls() {
		return calls;
	}

	public void setCalls(long calls) {
		this.calls = calls;
	}

	public long getRemainingCalls() {
		return remainingCalls;
	}

	public void setRemainingCalls(long remainingCalls) {
		this.remainingCalls = remainingCalls;
	}

	public long getResetsIn() {
		return resetsIn;
	}

	public void setResetsIn(long resetsIn) {
		this.resetsIn = resetsIn;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}
}
