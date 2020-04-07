package com.abc.application;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.abc.daoImpl.CartDaoImpl;
import com.abc.daoImpl.SavedForLaterDaoImpl;
import com.abc.model.Cart;
import com.abc.model.SavedForLater;


//This Servlet will Remove the Product(Selected by Customer) from cart and Add it to SavedForLater
@WebServlet("/MoveToCart")
public class MoveToCart extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Creating one Object of SavedForLaterDaoImpl
		SavedForLaterDaoImpl savedForLaterDaoImpl = new SavedForLaterDaoImpl();
		
		//Creating one Object of CartDaoImpl
		CartDaoImpl cartDaoImpl = new CartDaoImpl();
		
		//Getting the customerId from Request url and converting it into Integer
		int customerId = Integer.parseInt(request.getParameter("customerId"));

		//Getting the productId from Request url and converting it into Integer
		int productId = Integer.parseInt(request.getParameter("productId"));
		
		//Getting the SavedForLater Object with productId and and customerId
		SavedForLater s = savedForLaterDaoImpl.getSavedForLater(productId, customerId);
		
		
		//Getting the Customer ID from Session
		List<Cart> cart = cartDaoImpl.getAll(customerId);
				
		int count=0;
				
		for (Cart item : cart) {
			//Checking If the Product which Customer Trying to Add to Cart, is already Present in cart or not
			//If present then Increasing the Quantity by 1
			if(item.getCustomerId()==customerId && item.getProductId()==productId) {
				
				//Increasing count so that control should not go to another if condition
				count++;
				
				//Getting the orderId of cart
				int orderId = item.getOrderId();
				
				//increasing the quantity by 1 in cart
				cartDaoImpl.updateQuantity(orderId,s.getQuantity());
				
				//Removing from SavedForLater,sending 0 to indicate to not add the Product in cart beacsue it is already present
				savedForLaterDaoImpl.moveToCart(s,0);
				
				//Redirecting to cart.jsp
				response.sendRedirect("cart.jsp");
			}
				
		}

		
		//If the Product is not Present in Cart,Then Adding the Product in he Cart
		if(count==0) {

			//Removing the Product from SavedForLater and Adding it to cart
			//Sendint 1 to indicate that product is not Present in Cart , So add the Product
			savedForLaterDaoImpl.moveToCart(s,1);
					
			//Redirecting it to cart.jsp
			response.sendRedirect("cart.jsp");
		}

	}

}
