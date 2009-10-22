package com.wordnik.examples.objects;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name="frequencySummary")
public class Frequency {
	List<FrequencyValue> values = new ArrayList<FrequencyValue>();

	@XmlElement(name="frequency")
	public List<FrequencyValue> getValues() {
		return values;
	}

	public void setValues(List<FrequencyValue> values) {
		this.values = values;
	}
}