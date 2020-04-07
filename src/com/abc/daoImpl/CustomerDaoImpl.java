package com.abc.daoImpl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.abc.dao.CustomerDao;
import com.abc.model.Cart;
import com.abc.model.Customer;
import com.abc.model.MyOrders;
import com.abc.model.ProductDetails;

public class CustomerDaoImpl implements CustomerDao{


//--------------------------------        Method to Add one Customer to DataBase        -----------------------------------------------//
	
	@Override
	public void addCustomer(Customer c) {
		
		//Creating Session Factory
		 SessionFactory factory = new  Configuration()
										.configure()
										.addAnnotatedClass(Customer.class)
										.addAnnotatedClass(ProductDetails.class)
										.addAnnotatedClass(Cart.class)
										.addAnnotatedClass(MyOrders.class)
										.buildSessionFactory();

		 
		Session session = factory.openSession();

		
		try {
			Transaction transaction = session.beginTransaction();
			
			
			session.save(c);
			
			transaction.commit();
			
			System.out.print("One Customer Added in Databse :    "+c);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
			factory.close();
		}
	}

	
	
	
//-----------------------------------    Method to Fetch the Customer Details from DataBase    -------------------------------------//

	@Override
	public Customer get(int id) {

		//Creating Session Factory
		 SessionFactory factory = new  Configuration()
										.configure()
										.addAnnotatedClass(Customer.class)
										.addAnnotatedClass(ProductDetails.class)
										.addAnnotatedClass(Cart.class)
										.addAnnotatedClass(MyOrders.class)
										.buildSessionFactory();
		
		Session session = factory.openSession();
		
		Customer customer=null;;
		
		try {
			
			Transaction transaction = session.beginTransaction();
			
			//Write Your Code Here
			customer = session.get(Customer.class, id);
			
			
			transaction.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
			factory.close();
			session.close();
		}
		
		return customer;
		
	}
	
	
	
	
	
	
//--------------------------------------    Method to Get all the Customer from DataBase    ------------------------------------------//

	@Override
	public List<Customer> getAll() {
		
		//Creating Session Factory
		SessionFactory factory = new Configuration().configure().addAnnotatedClass(Customer.class)
				.addAnnotatedClass(ProductDetails.class).addAnnotatedClass(Cart.class).addAnnotatedClass(MyOrders.class)
				.buildSessionFactory();

		Session session = factory.openSession();
		
		List<Customer> resultList=null;
		
		try {

			Transaction transaction = session.beginTransaction();
			
			resultList = session.createQuery("from Customer",Customer.class).getResultList();
			
			for (Customer customer : resultList) {
				System.out.println(customer);
			}

			transaction.commit();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			factory.close();
			session.close();
		}
		
		return resultList;
		
	}
	

}
