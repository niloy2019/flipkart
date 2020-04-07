package com.abc.dao;

import java.util.List;

import com.abc.model.Cart;

public interface CartDao {

//-------------------------------------------        Method to Add one Product to Cart      ---------------------------------------------//
	 void addToCart(Cart c);
	 
//---------------------------------------        Method to Get the List of Product in Cart       ----------------------------------------//
	 List<Cart> getAll(int customerId);


//--------------------------------        Method to Update the Quantity of the Product in the Cart       --------------------------------//
	 void updateQuantity(int id,int quantityInSavedForLater);
	 
	 
//------------------------------       Method to Get the Cart Object with ProductID and CustomerID      ---------------------------------//
	 public Cart getCartObject(int productId, int CustomerId);

	 
//---------------------------       Method to Increase the Quantity of the Product by 1 in the Cart      --------------------------------//
	 void increaseQuantity(int productId, int customerId); 

	 
//---------------------------       Method to Decrease the Quantity of the Product by 1 in the Cart      --------------------------------//
	 void decreaseQuantity(int productId, int customerId); 

	 
//-------------------------------              Method to Remove Product from the Cart                    --------------------------------//
	 void removeProduct(int productId, int customerId);
	
}
