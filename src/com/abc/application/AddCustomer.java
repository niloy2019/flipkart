package com.abc.application;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.abc.daoImpl.CustomerDaoImpl;
import com.abc.model.Customer;

//This Servlet is used to Add the Customer to the Database
@WebServlet("/AddCustomer")
public class AddCustomer extends HttpServlet {


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		//Getting the Values from HttpRequest
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String mobile = request.getParameter("mobile");
		String password = request.getParameter("password");
		
		
		//Creating object of CustomerDaoImpl Class
		CustomerDaoImpl c = new CustomerDaoImpl();
		
		
		//Creating object of Customer Class with the User given Values
		Customer customer = new Customer(name, email, mobile, password);
		
		
		//Adding the Customer into the Database by calling addCustomer() with help of Hibernate 
		c.addCustomer(customer);
		
		
		System.out.println("Customer Added Successfully !!!!!");
		
		
		//Loading the Home Page after Successfully adding the Customer in Database 
		response.sendRedirect("index.jsp");
		
	}

}
