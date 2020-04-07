package com.abc.daoImpl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;

import com.abc.dao.ProductDetailsDao;
import com.abc.model.Cart;
import com.abc.model.Customer;
import com.abc.model.MyOrders;
import com.abc.model.ProductDetails;

public class ProductDetailsDaoImpl implements ProductDetailsDao{

	
//---------------------------------------          Method to add Product in DataBase          ------------------------------------------>
		@Override
		public void insert(ProductDetails product) {
			
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
				
				session.save(product);
				
				transaction.commit();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				factory.close();
				session.close();
				
			}
		}

		
		
		
		
//-------------------------------------          Method to Fetch the Product Details from DataBase          -------------------------->

		@Override
		public ProductDetails get(int id) {
			
			//Creating Session Factory
			SessionFactory factory = new  Configuration()
					.configure()
					.addAnnotatedClass(Customer.class)
					.addAnnotatedClass(ProductDetails.class)
					.addAnnotatedClass(Cart.class)
					.addAnnotatedClass(MyOrders.class)
					.buildSessionFactory();

			Session session = factory.openSession();
			
			ProductDetails product=null;
			
			try {
				
				Transaction transaction = session.beginTransaction();
				
				//Write Your Code Here
				product = session.get(ProductDetails.class, id);
				
				transaction.commit();
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				
				factory.close();
				session.close();
			}
			
			return product;
			
		}
		
		
		
//-------------------------------------         Method to Fetch ALL the Product Details from DataBase          -------------------------->

		@Override
		public List<ProductDetails> getAll() {
			
			//Creating Session Factory
			SessionFactory factory = new  	Configuration()
											.configure("hibernate.cfg.xml")
											.addAnnotatedClass(Customer.class)
											.addAnnotatedClass(ProductDetails.class)
											.addAnnotatedClass(Cart.class)
											.addAnnotatedClass(MyOrders.class)
											.buildSessionFactory();

			

			Session session = factory.openSession();
		
			List<ProductDetails> list=null;

			try {

				Transaction transaction = session.beginTransaction();

		       //Write Your Code Here
				Query q = session.createQuery("FROM  ProductDetails p");
				
				list = q.list();
				
				for (ProductDetails productDetails : list) {
					System.out.println(productDetails);
				}
				
				transaction.commit();

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				factory.close();
				session.close();
			}
			
			return list;
	
		}
		
		
//-------------------------------------         Method to Calculate Previous Price by Current Price          -------------------------->
		@Override
		public int getPreviousPrice(String cuurentPrice,int offer) {
	    	
			String n = cuurentPrice.replace(",", "");
	    	int price=Integer.parseInt(n); 
	    	int previousPrice= ( price*100 ) / (100-offer)+1;
	    	return previousPrice;
	
		}
		
		
//-------------------------------------         Converting the Price from String fromat to Integer format          -------------------------->

		@Override
		public int getPrice(String cuurentPrice) {
			
			String n = cuurentPrice.replace(",", "");
			int price=Integer.parseInt(n); 
			return price;
			
		}
		

}
