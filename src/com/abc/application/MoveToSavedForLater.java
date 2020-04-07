package com.abc.application;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.abc.daoImpl.CartDaoImpl;
import com.abc.daoImpl.SavedForLaterDaoImpl;
import com.abc.model.Cart;
import com.abc.model.Customer;
import com.abc.model.SavedForLater;

//This Servlet will Remove the Product(Selected by Customer) from cart and Add it to SavedForLater
@WebServlet("/MoveToSavedForLater")
public class MoveToSavedForLater extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Creating one Object of SavedForLaterDaoImpl
		SavedForLaterDaoImpl savedForLaterDaoImpl = new SavedForLaterDaoImpl();
		
		//Getting the customerId from Request url and converting it into Integer
		int customerId = Integer.parseInt(request.getParameter("customerId"));
		
		//Getting the productId from Request url and converting it into Integer
		int productId = Integer.parseInt(request.getParameter("productId"));
		
		//Creating one Object of CartDaoImpl
		CartDaoImpl cartDaoImpl = new CartDaoImpl();
		
		//Getting the Customer ID from Session
		List<SavedForLater> saList = savedForLaterDaoImpl.getAll(customerId);
				
		int count=0;

		//Getting the Cart Object with productId and and customerId
		Cart c = cartDaoImpl.getCartObject(productId, customerId);
		
		for (SavedForLater item : saList) {
			//Checking If the Product which Customer Trying to Add to SavedForLater, is already Present in SavedForLater or not
			//If present then Increasing the Quantity by 1
			if(item.getCustomerId()==customerId && item.getProductId()==productId) {
				
				//Increasing count so that control should not go to another if condition
				count++;
				
				//Getting the orderId of cart
				int orderId = item.getOrderId();
				
				//increasing the quantity by 1 in SavedForLater
				savedForLaterDaoImpl.updateQuantity(orderId,c.getQuantity());
				
				//Removing from Cart,sending 0 to indicate to not add the Product in SavedForLater beacsue it is already present
				savedForLaterDaoImpl.moveToSavedForLater(c,0);
				
				//Redirecting to cart.jsp
				response.sendRedirect("cart.jsp");
			}
		}

		
		//If the Product is not Present in SavedForLater,Then Adding the Product in he SavedForLater
		if(count==0) {
			
			//Removing the Product from cart and Adding it to SavedForLater
			//Sendint 1 to indicate that product is not Present in SavedForLater , So add the Product
			savedForLaterDaoImpl.moveToSavedForLater(c,1);
					
			//Redirecting it to cart.jsp
			response.sendRedirect("cart.jsp");
		}

		

	}
	

}
