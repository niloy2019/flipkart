package com.abc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "product_details")
public class ProductDetails {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;
	
	@Column(name = "category")
	private String category;

	@Column(name = "name")
	private String name;

	@Column(name = "brand_name")
	private String brandName;

	@Column(name = "image_path")
	private String imagePath;
	
	@Column(name = "price")
	private String price;
	
	@Column(name = "offer")
	private int offer;
	
	@Column(name = "seller_name")
	private String seller;
	
	@Column(name = "color")
	private String color;
	
	@Column(name = "star_rating")
	private String starRating;
	
	@Column(name = "rating")
	private String rating;
	
	@Column(name = "reviews")
	private String reviews;
	
	@Column(name = "description1")
	private String description1;
	
	@Column(name = "description2")
	private String description2;
	
	@Column(name = "description3")
	private String description3;
	
	@Column(name = "description4")
	private String description4;
	
	@Column(name = "description5")
	private String description5;

	@Override
	public String toString() {
		return "ProductDetails [id=" + id + ", category=" + category + ", name=" + name + ", brandName=" + brandName
				+ ", imagePath=" + imagePath + ", price=" + price + ", offer=" + offer + ", seller=" + seller
				+ ", color=" + color + ", starRating=" + starRating + ", rating=" + rating + ", reviews=" + reviews
				+ ", description1=" + description1 + ", description2=" + description2 + ", description3=" + description3
				+ ", description4=" + description4 + ", description5=" + description5 + "]";
	}
	
	public ProductDetails(String category, String name, String brandName, String imagePath, String price, int offer,
			String seller, String color, String starRating, String rating, String reviews, String description1,
			String description2, String description3, String description4, String description5) {
		super();
		this.category = category;
		this.name = name;
		this.brandName = brandName;
		this.imagePath = imagePath;
		this.price = price;
		this.offer = offer;
		this.seller = seller;
		this.color = color;
		this.starRating = starRating;
		this.rating = rating;
		this.reviews = reviews;
		this.description1 = description1;
		this.description2 = description2;
		this.description3 = description3;
		this.description4 = description4;
		this.description5 = description5;
	}

	public ProductDetails() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getStarRating() {
		return starRating;
	}

	public void setStarRating(String starRating) {
		this.starRating = starRating;
	}

	public String getRating() {
		return rating;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public String getReviews() {
		return reviews;
	}

	public void setReviews(String reviews) {
		this.reviews = reviews;
	}

	public String getDescription1() {
		return description1;
	}

	public void setDescription1(String description1) {
		this.description1 = description1;
	}

	public String getDescription2() {
		return description2;
	}

	public void setDescription2(String description2) {
		this.description2 = description2;
	}

	public String getDescription3() {
		return description3;
	}

	public void setDescription3(String description3) {
		this.description3 = description3;
	}

	public String getDescription4() {
		return description4;
	}

	public void setDescription4(String description4) {
		this.description4 = description4;
	}

	public String getDescription5() {
		return description5;
	}

	public void setDescription5(String description5) {
		this.description5 = description5;
	}

	public String getSeller() {
		return seller;
	}

	public void setSeller(String seller) {
		this.seller = seller;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public int getOffer() {
		return offer;
	}

	public void setOffer(int offer) {
		this.offer = offer;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	
}
