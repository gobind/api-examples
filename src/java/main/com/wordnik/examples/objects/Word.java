package com.wordnik.examples.objects;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Word {
	long id;
	String word;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getWord() {
		return word;
	}

	public void setWord(String word) {
		this.word = word;
	}

	public String toString(){
		return word;
	}
}