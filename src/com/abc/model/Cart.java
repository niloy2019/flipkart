package com.abc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "cart")
public class Cart {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int orderId;

	@Column(name = "product_id")
	private int productId;
	
	@Column(name = "customer_id")
	private int customerId;
	
	@Column(name = "quantity")
	private int quantity;
	
	@Override
	public String toString() {
		return "Cart [orderId=" + orderId + ", productId=" + productId + ", customerId=" + customerId + ", quantity="
				+ quantity + "]";
	}

	public Cart(int productId, int customerId, int quantity) {
		super();
		this.productId = productId;
		this.customerId = customerId;
		this.quantity = quantity;
	}

	public Cart() {
		super();
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	

}
