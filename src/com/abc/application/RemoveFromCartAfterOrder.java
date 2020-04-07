package com.abc.application;

import java.io.IOException;
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
import com.abc.model.ProductDetails;




//This Servlet is used to Remove the Product from Cart after Successfully placing the Order
@WebServlet("/RemoveFromCartAfterOrder")
public class RemoveFromCartAfterOrder extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Getting the Session Object
		HttpSession session = request.getSession();

		//Getting the Customer Object from Session
		Customer customer=(Customer)session.getAttribute("customer");
		
		//Getting the Product Object from Session
		ProductDetails product = (ProductDetails)session.getAttribute("product");
		
		//Creating one Object of myOrdersDaoImpl
	    MyOrdersDaoImpl myOrdersDaoImpl = new MyOrdersDaoImpl();
   		
	    //Creating one Object of cartDaoImpl
	    CartDaoImpl cartDaoImpl = new CartDaoImpl();
   		
   		List<Cart> cart=null;
		
   		//Fetching cart atribute from session
   		//cart will only be initialized If User clicked "BuyNow"
		Cart c2=(Cart)session.getAttribute("cart");
		
		
		//If User click BuyNow Option in Product.jsp Page, then after placing the Order, We will delete only that Product from cart(Remaing all the Products in the Cart will be as it is)
		//We will get to know wheather User clicked "BuyNow" or "placeOrder" with the help of c2
		//We are adding Products to the list here,later it will be deleted
		if(c2!=null) {
			cart=new ArrayList<Cart>();
			cart.add(c2);
		}
		//If User add Multiples product to the cart, and then clicks "Place Order", then it will delete all the Products that customer have added to the Cart
		else {
			cart = cartDaoImpl.getAll(customer.getId());
		}
		
		
		//ALl the Product Present in the List will be Deleted
		for (Cart c : cart) {
			cartDaoImpl.removeProduct(c.getProductId(), c.getCustomerId());
		}
		
		//Cart will be initilized as "null" after Removing the Rroducts
		session.setAttribute("cart", null);

		//Redirecting to OrderPlaced.jsp
		response.sendRedirect("OrderPlaced.jsp");
		
	}

}


