package com.abc.daoImpl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;

import com.abc.dao.SavedForLaterDao;
import com.abc.model.Cart;
import com.abc.model.Customer;
import com.abc.model.MyOrders;
import com.abc.model.ProductDetails;
import com.abc.model.SavedForLater;

public class SavedForLaterDaoImpl implements SavedForLaterDao{
	
	
	
	
	//----------------------------      Method to Move the Product from Cart to SavedForLater      -----------------------------------//

	//This Method will Delete the Product from Cart,And if (status==1) , It will add the Product to SavedForLater
	//														     else  , It will not add the Product to the SavedForLater
	@Override
	public void moveToSavedForLater(Cart c,int status) {
		
				SessionFactory factory = new  Configuration()
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
					
					//Write Your Code Here
					
					//Creating SavedForLater Object
					SavedForLater s = new SavedForLater(c.getProductId(), c.getCustomerId(), c.getQuantity());
					
					//Removing the  Product from cart
					session.remove(c);
					
					if(status==1) {
						//Adding the Product to SavedForLater
						session.save(s);
					}
					
					transaction.commit();
					
					System.out.print("One Product Moved from Cart to Saved For Later:    "+s);
					
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					factory.close();
					session.close();
				}
				
		
	}
	
	
	
	
	//------------------------------        Method to Move he Product from SavedForLater  to Cart        -------------------------------//

	//This Method will Delete the Product from SavedForLater ,And if (status==1) , It will add the Product to Cart
	//														               else  , It will not add the Product to the Cart
		@Override
		public void moveToCart(SavedForLater s,int status) {
					
			SessionFactory factory = new  Configuration()
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
				
				//Write Your Code Here
				
				//Creating Cart Object
				Cart c = new Cart(s.getProductId(), s.getCustomerId(), s.getQuantity());
				
				//Removing the  Product from SavedForLater
				session.remove(s);
				
				if(status==1) {
					//Adding the Product to cart
					session.save(c);
				}
				
				transaction.commit();
				
				System.out.print("One Product Moved from Saved For Later to Cart :    "+c);
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				factory.close();
				session.close();
			}
			
			
		}

		
	//------------------------------        Method to Get the List of Product in Cart        ------------------------------------//
		
		@Override
		public List<SavedForLater> getAll(int customerId) {
					
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
					
					List list=null;
					
					try {

						Transaction transaction = session.beginTransaction();

						Query q = session.createQuery("FROM SavedForLater s WHERE s.customerId="+customerId);
						
						list = q.list();
						
						System.out.println("List of All the Prodcucts Present in the SavedForLater : ");
						
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
		
	//--------------------       Method to Get the Quantity of a Product with the ProductID and CustomerID      -----------------------//

		@Override
		public SavedForLater  getSavedForLater(int productId,int CustomerId) {
			
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
			
			SavedForLater s=null;
			
			try {
				
				Transaction transaction = session.beginTransaction();

				Query q = session.createQuery("FROM SavedForLater s WHERE s.customerId="+CustomerId+" AND s.productId="+productId);
				
				
				List list = q.list();
				
				s = (SavedForLater)list.get(0);
				
				transaction.commit();

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				factory.close();
				session.close();
			}

			return s;
		}


		

	//------------------------------------------       Method to Remove Product from the SavedForLater        -------------------------------------//

	@Override
	public void removeProduct(int productId, int customerId) {
		
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

			
			Query q = session.createQuery("FROM SavedForLater s WHERE s.customerId="+customerId+" AND s.productId="+productId);
			
			List list = q.list();
			
			SavedForLater s = (SavedForLater)list.get(0);
			
			session.delete(s);

			transaction.commit();


		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			factory.close();
			session.close();
		}
		
		
	}
	
	
	
	
//------------------------------        Method to Update the Quantity of the Product in the Cart      -------------------------------//
	
		@Override
		public void updateQuantity(int id,int quantityInCarts) {
			
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
				SavedForLater s = session.get(SavedForLater.class, id);
				
				//Updating the Quantity by 1 with the Setters
				s.setQuantity(s.getQuantity()+quantityInCarts);
				//Saving the Updated Product
				session.save(s);

				transaction.commit();

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				factory.close();
				session.close();
			}
			
		}



}
