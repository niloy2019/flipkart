package com.abc.dao;

import java.util.List;

import com.abc.model.ProductDetails;

public interface ProductDetailsDao {

//<-----------------     Method to add Product in DataBase	 ----------------->
	 void insert(ProductDetails o);
	 
//<-----------     Method to Fetch the Product Details from DataBas	 --------->
	 ProductDetails get(int id);
	 
//<--------     Method to Fetch ALL the Product Details from DataBase	 ----->
	 List<ProductDetails> getAll();
	 
	 
//<---------     Method to Calculate Previous Price by Current Price	 ----->
	 public int getPreviousPrice(String cuurentPrice,int offer);
	 
	 
//<------------     Method to Calculate Price by Current Price	 ------------->
	 public int getPrice(String cuurentPrice) ;
	
	 
	 
}
