package com.abc.dao;

import java.util.List;

import com.abc.model.Customer;


public interface CustomerDao {
	
//------------------------------          Method to Add one Customer to DataBase            -------------------------------------------//
	 void addCustomer(Customer c);

	 
//------------------------------    Method to Fetch the Customer Details from DataBase      -------------------------------------------//
	 Customer get(int id);

	 
//------------------------------        Method to Get all the Customer from DataBase        -------------------------------------------//
	 List<Customer> getAll();
	 
}
