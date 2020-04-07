package com.abc.dao;

import java.util.List;

import com.abc.model.MyOrders;


public interface MyOrdersDao {
	
//<---------------           Method to Place a order           ------------------->//
	 void insert(MyOrders o);
	 
	 
//<------     Method to get Order Details of On Order with order_id 	 --------->//
	 MyOrders get(int orderId,int CustomerId);

	 
//<---------    Method get Details of All the Orders from DataBase	 ------------->//
	 List<MyOrders> getAll(int customerId);
	 

}
