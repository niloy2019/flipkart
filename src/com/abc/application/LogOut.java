package com.abc.application;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LogOut")
public class LogOut extends HttpServlet {
		
	//This Servlet is used to Logout the Customer
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Getiing the Session Object
		HttpSession session = request.getSession();
		
		//Setting the value of "customer" atribute to null in the Session
		session.setAttribute("customer", null);
		
		//Redirecting the index.jsp
		response.sendRedirect("index.jsp");

	}

}
