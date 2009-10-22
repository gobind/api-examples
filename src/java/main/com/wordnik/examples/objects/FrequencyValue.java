package com.wordnik.examples.objects;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class FrequencyValue {
	int year;
	long count;

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public long getCount() {
		return count;
	}

	public void setCount(long count) {
		this.count = count;
	}
}
