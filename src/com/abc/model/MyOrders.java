package com.abc.model;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "my_orders")
public class MyOrders {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;
	
	@Column(name = "customer_id")
	private int customerId;
	
	@Column(name = "product_id")
	private int productId;

	@Column(name = "deliver_date")
	private String deliverDate;

	@Column(name = "return_date")
	private String returnDate;
	
	@Column(name = "name")
	private String name;

	@Column(name = "number")
	private String number;

	@Column(name = "pincode")
	private String pincode;

	@Column(name = "locality")
	private String locality;
	
	@Column(name = "address")
	private String address;
	
	@Column(name = "city")
	private String city;
	
	@Column(name = "state")
	private String state;
	
	@Column(name = "landmark")
	private String landmark;
	
	@Column(name = "alternativePhone")
	private String alternativePhone;
	
	@Column(name = "address_type")
	private String addressType;
	
	@Override
	public String toString() {
		return "MyOrders [id=" + id + ", customerId=" + customerId + ", producId=" + productId + ", deliverDate="
				+ deliverDate + ", returnDate=" + returnDate + ", name=" + name + ", number=" + number + ", pincode="
				+ pincode + ", locality=" + locality + ", address=" + address + ", city=" + city + ", state=" + state
				+ ", landmark=" + landmark + ", alternativePhone=" + alternativePhone + ", addressType=" + addressType
				+ "]";
	}
	
	public MyOrders(int customerId, int productId, String deliverDate, String returnDate, String name, String number,
			String pincode, String locality, String address, String city, String state, String landmark,
			String alternativePhone, String addressType) {
		super();
		this.customerId = customerId;
		this.productId = productId;
		this.deliverDate = deliverDate;
		this.returnDate = returnDate;
		this.name = name;
		this.number = number;
		this.pincode = pincode;
		this.locality = locality;
		this.address = address;
		this.city = city;
		this.state = state;
		this.landmark = landmark;
		this.alternativePhone = alternativePhone;
		this.addressType = addressType;
	}

	public MyOrders() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getDeliverDate() {
		return deliverDate;
	}

	public void setDeliverDate(String deliverDate) {
		this.deliverDate = deliverDate;
	}

	public String getReturnDate() {
		return returnDate;
	}

	public void setReturnDate(String returnDate) {
		this.returnDate = returnDate;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getPincode() {
		return pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	public String getLocality() {
		return locality;
	}

	public void setLocality(String locality) {
		this.locality = locality;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getLandmark() {
		return landmark;
	}

	public void setLandmark(String landmark) {
		this.landmark = landmark;
	}

	public String getAlternativePhone() {
		return alternativePhone;
	}

	public void setAlternativePhone(String alternativePhone) {
		this.alternativePhone = alternativePhone;
	}

	public String getAddressType() {
		return addressType;
	}

	public void setAddressType(String addressType) {
		this.addressType = addressType;
	}
	
}
