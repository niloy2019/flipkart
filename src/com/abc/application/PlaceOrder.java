package com.abc.application;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.abc.daoImpl.CartDaoImpl;
import com.abc.daoImpl.MyOrdersDaoImpl;
import com.abc.model.Cart;
import com.abc.model.Customer;
import com.abc.model.MyOrders;

//This Servlet is used to Place an Order by adding the Products to the MyOrders Table
@WebServlet("/PlaceOrder")
public class PlaceOrder extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Getting the Session Objectt
		HttpSession session = request.getSession();
		
		//Fetching the Customer Object from Session
		Customer customer = (Customer)session.getAttribute("customer");
		
		//Getting the customerId from Customer Object
		int customerId=customer.getId();
		
		
		//Fetching all the parameters from Request url, that user have given in DeliveryAddress form
		String name = request.getParameter("name");
		String number = request.getParameter("number");
		String pincode = request.getParameter("pincode");
		String locality = request.getParameter("locality");
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String landmark = request.getParameter("landmark");
		String alternativePhone = request.getParameter("alternativePhone");
		String addressType = request.getParameter("addressType");
		
		//Getting the Current Date
		LocalDate today = LocalDate.now(); 
	    
		//Getting the Date after 10 Days
		LocalDate afterTenDays = today.plusDays(10);
	     
		//Coverting the DataType of Date from "LocalDate" to String
	    String deliveryDate = today.toString();
	    String returnDate = afterTenDays.toString();
	     
	    //Creating one Object of myOrdersDaoImpl
	    MyOrdersDaoImpl myOrdersDaoImpl = new MyOrdersDaoImpl();
   		
	    //Creating one Object of CartDaoImpl
	    CartDaoImpl cartDaoImpl = new CartDaoImpl();
   		
	    //Creating One List of type Cart
   		List<Cart> cart=null;
		
   		
		Cart c2=(Cart)session.getAttribute("cart");
		
		//If User click BuyNow Option in Product.jsp Page, then after placing the Order, We will add only that Product into List<Cart> and later list will be added to MyOrder Table(Remaining all the Products in the Cart will be as it is)
		//We will get to know wheather User clicked "BuyNow" or "placeOrder" with the help of c2
		//We are adding Products to the list here,later it will be deleted
		if(c2!=null) {
			cart=new ArrayList<Cart>();
			cart.add(c2);
		}
		//If User add Multiples product to the cart, and then clicks "Place Order", then it will add all the list of Products that customer have added to the Cart
		else {
			cart = cartDaoImpl.getAll(customerId);
		}
		
		
		
		//All the List that have Added to the list,will be Added to MyOrders
		for (Cart c : cart) {
			int productId = c.getProductId();
			
			//Creating on Object of Myorders with all the Details 
			MyOrders o = new MyOrders(customerId, productId, deliveryDate, returnDate, name, number, pincode, locality, address, city, state, landmark, alternativePhone, addressType);
		
			//Adding the Object to MyOrder Database 
			myOrdersDaoImpl.insert(o);
		}
		
		
		//Redirecting to Payment.jsp Page
		//Sending the parameter "deliveryAddress=true" just to inform the page that user has already submit Delivery Address ,don't ask again
		response.sendRedirect("Payment.jsp?deliveryAddress=true");
	
	}
	

}
