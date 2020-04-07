package com.abc.application;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.abc.daoImpl.CartDaoImpl;
import com.abc.model.Cart;
import com.abc.model.Customer;
import com.abc.model.ProductDetails;

//This Servlet is used to Add the product to the cart of a particular Customer
@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet {
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Getting the Sesson Object
		HttpSession session = request.getSession();
		
		int count=0;
		
		//Getting the PRODUCT Object from Session
		ProductDetails product = (ProductDetails)session.getAttribute("product");
		
		//Getting the CUSTOMER Object from Session
		Customer customer= (Customer)session.getAttribute("customer");
		
		System.out.println("Product : "+product);
		System.out.println("Customer : "+customer);
		
		
		//Creating Object of CartDaoImplt Class
		CartDaoImpl cartDaoImpl = new CartDaoImpl();
		
		//Getting the Customer ID from Session
		int customerId = customer.getId();
		
		//Getting the List of all Products present in cart
		List<Cart> cart = cartDaoImpl.getAll(customerId);
		
		
		for (Cart item : cart) {
			//Checking If the Product which Customer Trying to Add to Cart, is already Present in cart or not
			//If present then Increasing the Quantity by 1
			if(item.getCustomerId()==customer.getId() && item.getProductId()==product.getId()) {
				count++;
				int orderId = item.getOrderId();
				cartDaoImpl.updateQuantity(orderId,0);
				response.sendRedirect("cart.jsp");
			}
			
		}

		//If the Product is not Present in Cart,Then Adding the Product in he Cart
		if(count==0) {
			//Creating one Cart Object
			Cart c = new Cart(product.getId(),customer.getId(),1);
			
			//Inserting Object in Database
			cartDaoImpl.addToCart(c);
			
			response.sendRedirect("cart.jsp");
		}
		
		
	}

}
