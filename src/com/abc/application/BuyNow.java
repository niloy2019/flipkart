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


//This Servlet will Add the Product to the cart and Redirect to the Payment Page
@WebServlet("/BuyNow")
public class BuyNow extends HttpServlet {
	
	
	
	// This Servlet is for BuyNow option, When user Click BuyNow button to a Product, Then This Servlet will be called
	// This Servlet will add the Product to the cart and Redirect to Payemnt.jsp page
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		HttpSession session = request.getSession();
		
		//Getting the Sesson Object
				
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
				
		
		//Creating one Cart Object
		Cart c = new Cart(product.getId(),customer.getId(),1);
					
		//Inserting Object in Database
		cartDaoImpl.addToCart(c);
		
		//To Identify in payment.jsp page that user clicked buyNow from product.jsp and not from cart.jsp
		session.setAttribute("cart", c);
		
		response.sendRedirect("Payment.jsp");
				
	}

}
