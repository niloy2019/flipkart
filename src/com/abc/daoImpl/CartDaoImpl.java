package com.abc.daoImpl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;

import com.abc.dao.CartDao;
import com.abc.model.Cart;
import com.abc.model.Customer;
import com.abc.model.MyOrders;
import com.abc.model.ProductDetails;
import com.abc.model.SavedForLater;

public class CartDaoImpl implements CartDao {
	
	
//------------------------------        Method to Add one Product to Cart        -------------------------------------------------------//

	@Override
	public void addToCart(Cart c) {
				
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
		
					//Write Your Code Here
					
					session.save(c);
		
					transaction.commit();
					
					System.out.print("One Product Added to Cart :    "+c);
		
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					factory.close();
					session.close();
				}
		
	}

	
	
	
	
	
//------------------------------        Method to Get the List of Product in Cart        ------------------------------------//
	
	@Override
	public List<Cart> getAll(int customerId) {
				
		//Creating Session Factory
				SessionFactory factory = new Configuration()
											.configure()
											.addAnnotatedClass(Customer.class)
											.addAnnotatedClass(ProductDetails.class)
											.addAnnotatedClass(Cart.class)
											.addAnnotatedClass(MyOrders.class)
											.buildSessionFactory();

				
				Session session = factory.openSession();
				
				List list=null;
				
				try {

					Transaction transaction = session.beginTransaction();

					//resultList = session.createQuery("from Cart",Cart.class).getResultList();
					
					Query q = session.createQuery("FROM Cart c WHERE c.customerId="+customerId);
					
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
	
	
	
	
	
//------------------------------        Method to Update the Quantity of the Product in the Cart      -------------------------------//
	
	@Override
	public void updateQuantity(int id,int quantityInSavedForLater) {
		
		//Creating Session Factory
		SessionFactory factory = new Configuration()
									.configure()
									.addAnnotatedClass(Customer.class)
									.addAnnotatedClass(ProductDetails.class)
									.addAnnotatedClass(Cart.class)
									.addAnnotatedClass(MyOrders.class)
									.addAnnotatedClass(SavedForLater.class)
									.buildSessionFactory();

		
		Session session = factory.openSession();
		
		try {

			Transaction transaction = session.beginTransaction();
			
			//Getting the Cart Object with the ID
			Cart c = session.get(Cart.class, id);
			
			//Updating the Quantity by 1 with the Setters
			if(quantityInSavedForLater!=0) {
				c.setQuantity(c.getQuantity()+quantityInSavedForLater);
			}else {
				c.setQuantity(c.getQuantity()+1);
			}
			//Saving the Updated Product
			session.save(c);

			transaction.commit();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			factory.close();
			session.close();
		}
		
	}

	
	
	
	
//-----------------------------       Method to Get the Cart Object with ProductID and CustomerID      --------------------------------//

	@Override
	public Cart getCartObject(int productId,int CustomerId) {
		
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
		
		Cart c=null;
		
		try {
			
			Transaction transaction = session.beginTransaction();

			
			Query q = session.createQuery("FROM Cart c WHERE c.customerId="+CustomerId+" AND c.productId="+productId);
			
			List list = q.list();
			
			c = (Cart)list.get(0);
//			quantity = c.getQuantity();
			
			transaction.commit();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			factory.close();
			session.close();
		}

		return c;
	}


	
	
	
//-------------------------       Method to Increase the Quantity of the Product by 1 in the Cart        ------------------------------//

@Override
public void increaseQuantity(int productId, int customerId) {
	
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
			
			try {
				
				Transaction transaction = session.beginTransaction();

				
				Query q = session.createQuery("FROM Cart c WHERE c.customerId="+customerId+" AND c.productId="+productId);
				
				List list = q.list();
				
				Cart c = (Cart)list.get(0);
				
				c.setQuantity(c.getQuantity()+1);
				
				transaction.commit();
				
				System.out.println("Quantity Increased by 1");

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				factory.close();
				session.close();
			}

}





//-------------------------       Method to Decrease the Quantity of the Product by 1 in the Cart        ------------------------------//

@Override
public void decreaseQuantity(int productId, int customerId) {
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
	
	try {
		
		Transaction transaction = session.beginTransaction();

		
		Query q = session.createQuery("FROM Cart c WHERE c.customerId="+customerId+" AND c.productId="+productId);
		
		List list = q.list();
		
		Cart c = (Cart)list.get(0);
		
		if(c.getQuantity()>1) {
			c.setQuantity(c.getQuantity()-1);
			System.out.println("Quantity Decreased by 1");
		}else {
			System.out.println("Cannot Decrease Quantity less than 1");
		}

		transaction.commit();


	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		factory.close();
		session.close();
	}

	
}






//------------------------------------------       Method to Remove Product from the Cart        -------------------------------------//

@Override
public void removeProduct(int productId, int customerId) {
	
	//Creating Session Factory
	SessionFactory factory = new Configuration()
								.configure()
								.addAnnotatedClass(Customer.class)
								.addAnnotatedClass(ProductDetails.class)
								.addAnnotatedClass(Cart.class)
								.addAnnotatedClass(MyOrders.class)
								.buildSessionFactory();

	
	Session session = factory.openSession();
	
	try {
		
		Transaction transaction = session.beginTransaction();

		
		Query q = session.createQuery("FROM Cart c WHERE c.customerId="+customerId+" AND c.productId="+productId);
		
		List list = q.list();
		
		Cart c = (Cart)list.get(0);
		
		session.delete(c);

		transaction.commit();


	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		factory.close();
		session.close();
	}
	
	
	
	
	
	
}



	
	
	
	
	
	
	
	

}
