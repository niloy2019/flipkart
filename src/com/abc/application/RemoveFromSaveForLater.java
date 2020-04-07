package com.abc.application;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.abc.daoImpl.CartDaoImpl;
import com.abc.daoImpl.SavedForLaterDaoImpl;
import com.abc.model.Cart;

//This Servlet is used Remove the Product from SavedForLater
@WebServlet("/RemoveFromSaveForLater")
public class RemoveFromSaveForLater extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Creating Object of SavedForLaterDaoImplt
		SavedForLaterDaoImpl savedForLaterDaoImpl = new SavedForLaterDaoImpl();
		
		//Getting th customerId from Request url
		int customerId = Integer.parseInt(request.getParameter("customerId"));
		
		//Getting the productId from Request url
		int productId = Integer.parseInt(request.getParameter("productId"));
		
		//Removung the Product from SavedForLater
		savedForLaterDaoImpl.removeProduct(productId, customerId);
		
		//Redirecting to cart.jsp Page
		response.sendRedirect("cart.jsp");

	
	
	}

}
