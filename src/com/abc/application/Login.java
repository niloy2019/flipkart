package com.abc.application;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;

import com.abc.daoImpl.CustomerDaoImpl;
import com.abc.model.Customer;

//This Servlet is for Login
@WebServlet("/Login")
public class Login extends HttpServlet {


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Getting the Email or Mobile (Entered by the Customer) from Request
		String emailOrMobile = request.getParameter("emailOrMobile");

		//Getting the Password (Entered by the Customer) from Request
		String password = request.getParameter("password");
		
		//Printing the information entered by the Customer in console
		System.out.println(emailOrMobile);
		System.out.println(password);
		
		//Getting Session Object
		HttpSession session = request.getSession();
		
		session.setAttribute("name", null);
		
		//Creating one object of CustomerDaoImpl
		CustomerDaoImpl c = new CustomerDaoImpl();
		
		//Getting the List of All Customers from Database
		List<Customer> customers = c.getAll();

		
		//Validating the information Entered by the Customer with the Data from the Database, If it Matches then we will Login the Customer 
		for (Customer customer : customers) {
			
			if(  (	  customer.getEmail().equals(emailOrMobile) 
			  	   || customer.getMobile().equals(emailOrMobile) ) 
			  && customer.getPassword().equals(password) ) {
				
				//Setting the customer Object to a session atribute named "customer"
				session.setAttribute("customer", customer);

			}
			
		}
		
		//Redirecting to index.jsp Page
		response.sendRedirect("index.jsp");
		
	}

	
}
