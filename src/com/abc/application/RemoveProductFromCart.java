package com.abc.application;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.abc.daoImpl.CartDaoImpl;

//This Servlet is used Remove the Product from Cart
@WebServlet("/RemoveProductFromCart")
public class RemoveProductFromCart extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Creating one Object of CartDaoImpl
		CartDaoImpl cartDaoImpl = new CartDaoImpl();
		
		//Getting th customerId from Request url
		int customerId = Integer.parseInt(request.getParameter("customerId"));

		//Getting th productId from Request url
		int productId = Integer.parseInt(request.getParameter("productId"));
		
		//Removung the Product from SavedForLater
		cartDaoImpl.removeProduct(productId, customerId);
		
		
		//Fetching the load atribute from session to know where should it Redirect
		String s = request.getParameter("load")+".jsp?deliveryAddress=true";
		
		//Redirecting to the page from where is is called
		response.sendRedirect(s);
		
	}

}
