package com.abc.dao;

import java.util.List;

import com.abc.model.Cart;
import com.abc.model.SavedForLater;

public interface SavedForLaterDao {
	
//<-----------------       Method to Move from Cart to SavedForLater	       ----------------->
	
	//This Method will Delete the Product from Cart,And if (status==1) , It will add the Product to SavedForLater
	//														     else  , It will not add the Product to the SavedForLater
	 void moveToSavedForLater(Cart c,int status);
	 
//<-------------------        Method to Move from SavedForLater  to Cart	    ---------------->
	//This Method will Delete the Product from SavedForLater ,And if (status==1) , It will add the Product to Cart
	//														               else  , It will not add the Product to the Cart
	 void moveToCart(SavedForLater s,int status);

	 
//<------------------         Method to Get the List of Product in Cart	       ----------------->
	 List<SavedForLater> getAll(int customerId);

	 
//<-----      Method to Get the Quantity of a Product with the ProductID and CustomerID	  ------>
	 SavedForLater  getSavedForLater(int productId, int CustomerId);

	 
//<-----------------        Method to Remove Product from the SavedForLater	      -------------->
	 void removeProduct(int productId, int customerId);
	 
	 
//<-----------        Method to Update the Quantity of the Product in the Cart	    ------------>
	 void updateQuantity(int id,int quantityInCarts);

}
