package com.abc.daoImpl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;

import com.abc.dao.MyOrdersDao;
import com.abc.model.Cart;
import com.abc.model.Customer;
import com.abc.model.MyOrders;
import com.abc.model.ProductDetails;

public class MyOrdersDaoImpl implements MyOrdersDao {

//<---------------------------------------          Method to Place a order           ------------------------------------------>	
	
	@Override
	public void insert(MyOrders o) {
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
			
			session.save(o);
			
			transaction.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			factory.close();
			session.close();
			
		}

	}

	
	
	
//<-----------------------          Method to get Order Details of On Order with order_id           ------------------------------------>	

	@Override
	public MyOrders get(int orderId,int CustomerId) {
				//Creating Session Factory
				SessionFactory factory = new Configuration()
											.configure()
											.addAnnotatedClass(Customer.class)
											.addAnnotatedClass(ProductDetails.class)
											.addAnnotatedClass(Cart.class)
											.addAnnotatedClass(MyOrders.class)
											.buildSessionFactory();

				
				Session session = factory.openSession();
				
				int quantity=0;
				
				MyOrders o=null;
				
				try {
					
					Transaction transaction = session.beginTransaction();

					
					Query q = session.createQuery("FROM MyOrders o WHERE o.customerId="+CustomerId+" AND o.id="+orderId);
					
					List list = q.list();
					
					o = (MyOrders)list.get(0);
					
					transaction.commit();

				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					factory.close();
					session.close();
				}

				return o;
			}

	
	
	
//<----------------------------------      Method get Details of All the Orders from DataBase      -------------------------------------->	
	
	@Override
	public List<MyOrders> getAll(int customerId) {
		
		
				//Creating Session Factory
				
		SessionFactory factory = new Configuration()
											.configure()
											.addAnnotatedClass(Customer.class)
											.addAnnotatedClass(ProductDetails.class)
											.addAnnotatedClass(Cart.class)
											.addAnnotatedClass(MyOrders.class)
											.buildSessionFactory();

				
				Session session = factory.openSession();
				
				List<MyOrders> list=null;
				
				try {

					Transaction transaction = session.beginTransaction();

					//resultList = session.createQuery("from Cart",Cart.class).getResultList();
					
					Query q = session.createQuery("FROM MyOrders o WHERE o.customerId="+customerId);
					
					list = q.list();
					
					System.out.println("List of All the Prodcucts Present in the Cart : ");
					
					for (Object c : list) {
						System.out.println(c);
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


}
