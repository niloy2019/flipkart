package com.abc.application;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.abc.daoImpl.CartDaoImpl;


//This Servlet will Decrease the Amount of Product present in the cart
@WebServlet("/DecreaseQuantity")
public class DecreaseQuantity extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Creating one object of cartDaoImpl
		CartDaoImpl cartDaoImpl = new CartDaoImpl();
		
		//Getting the Customer Object from session and then fetching customerId
		int customerId = Integer.parseInt(request.getParameter("customerId"));
	
		//Getting the Product Object from session and then fetching productId
		int productId = Integer.parseInt(request.getParameter("productId"));
		
		//Decreasing the Quantity of the Product in the Cart by calling decreaseQuantity()
		cartDaoImpl.decreaseQuantity(productId, customerId);
		
		//This is to identify that This Servlet is called from Payment.jsp Page or cart.jsp Page
		//load will hold the Page name from where this Servlet called
		//Sending the parameter "deliveryAddress=true" just to inform the page that user has already submit Delivery Address ,don't ask again
		String s = request.getParameter("load")+".jsp?deliveryAddress=true";
		
		
		//It will Redirect to the Same Page from where the Servlet is Called
		response.sendRedirect(s);

	}

}
