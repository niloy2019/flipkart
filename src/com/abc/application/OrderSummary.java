package com.abc.application;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;

//This Servlet is used to close The OrderSummary Block in Payemnt.jsp Page and open the Payment Option
@WebServlet("/OrderSummary")
public class OrderSummary extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Redirecting to Payment.jsp Page
		//Sending the parameter "deliveryAddress=true" just to inform the page that user has already submit Delivery Address ,don't ask again
		//Sending the parameter "orderSummary=true" just to inform the page that user has already submit OrderSummary ,don't ask again
		response.sendRedirect("Payment.jsp?deliveryAddress=true&orderSummary=true");

	}

}
