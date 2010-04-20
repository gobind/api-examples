package com.wordnik.examples.objects;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for bigram complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="bigram">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="mi" type="{http://www.w3.org/2001/XMLSchema}double"/>
 *         &lt;element name="wlmi" type="{http://www.w3.org/2001/XMLSchema}double"/>
 *         &lt;element name="gram1" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="gram2" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "bigram", propOrder = {
    "mi",
    "wlmi",
    "gram1",
    "gram2"
})
public class Bigram {

    protected double mi;
    protected double wlmi;
    protected String gram1;
    protected String gram2;

    /**
     * Gets the value of the mi property.
     * 
     */
    public double getMi() {
        return mi;
    }

    /**
     * Sets the value of the mi property.
     * 
     */
    public void setMi(double value) {
        this.mi = value;
    }

    /**
     * Gets the value of the wlmi property.
     * 
     */
    public double getWlmi() {
        return wlmi;
    }

    /**
     * Sets the value of the wlmi property.
     * 
     */
    public void setWlmi(double value) {
        this.wlmi = value;
    }

    /**
     * Gets the value of the gram1 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getGram1() {
        return gram1;
    }

    /**
     * Sets the value of the gram1 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setGram1(String value) {
        this.gram1 = value;
    }

    /**
     * Gets the value of the gram2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getGram2() {
        return gram2;
    }

    /**
     * Sets the value of the gram2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setGram2(String value) {
        this.gram2 = value;
    }

}
