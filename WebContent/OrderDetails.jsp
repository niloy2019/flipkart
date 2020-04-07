<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <!------------------------------------------         IMPORTING JAVA CLASSES          --------------------------------------------->
    
    <%@ page import=" java.util.*,
	  				  java.io.*,
	  				  java.sql.*,
	  				  javax.servlet.*,
	  				    
	  				  com.abc.model.Customer,
	  				  com.abc.model.ProductDetails,
	  				  com.abc.model.Cart,
	  			      com.abc.model.MyOrders,
	  			      com.abc.model.SavedForLater,
	  				    
	  			      com.abc.daoImpl.CustomerDaoImpl,
	  			      com.abc.daoImpl.ProductDetailsDaoImpl,
	  			      com.abc.daoImpl.CartDaoImpl,
	  			      com.abc.daoImpl.MyOrdersDaoImpl,
	  			      com.abc.daoImpl.SavedForLaterDaoImpl" %>
	  			      
<!DOCTYPE html>
<html>
<head>

	<!----------------------------------------------------         CSS Code          --------------------------------------------->
   
     <link rel="stylesheet" href="index.css">
    
   <!----------------------------------------------------      BootStrap Code       --------------------------------------------->
   
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
     <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    
    
<meta charset="ISO-8859-1">
<title>flipkart</title>
</head>
<body style="background-color: rgb(241,243,246);">




<!------------------------------------------      CODE TO FETCH CUSTOMER FROM THE SESSION      -------------------------------------->
<%
	Customer c=(Customer)session.getAttribute("customer");
	
	//If Customer Object is null,it will Redirect to index.jsp Page
	if(c==null){
		response.sendRedirect("index.jsp");
	}
%>

<!----------------------------------------------------          HEADER         ------------------------------------------------------->

<div>
    
    <table  style="background-color:rgb(40,116, 240) ;">
        <tr>
            <td width="12.5%"></td>
			
			<!--------------------------          FLIPKART LOGO         ---------------------------->
            <td align="right"><a href="index.jsp" class="header"><img src="images/logo.PNG"></a></td>

			<!-----------------------------------        SEARCH BAR        ----------------------------->
			<form action="Search.jsp" >
				<!--------------------------          SEARCH INPUT BOX         ------------------------->
	            <td><input type="text" name="search" class="input" placeholder="   Search for products, brands and more"></td>
	
	
				<!--------------------------          SEARCH BUTTON        ---------------------------->
	            <td> <button type="submit" style="padding: 0px;border: 0px;"><img  src="images/search.PNG" class="search"></button> </td>
			</form>


            <td class="loginPadding " style="width: 11%">	 </td>

			
           	<%if(c!=null){ %>
	            <td class="dropdown"> 
						  <!---------------------------          MORE BUTTON         ----------------------------->
		            	  <img src="images/more.PNG" alt="" class="morePadding">

						  <div class="dropdown-content">
						  		
						  		 <!-------------------------          MYORDER BUTTON         ---------------------------->
								 <a href="MyOrder.jsp" style="text-decoration: none;"> 	<p>My order</p> 	</a>

						  		
						  		 <!--------------------------          LOGOUT BUTTON         ---------------------------->
								 <form action="LogOut">
								 	<button style="border: 0px;background-color: #f9f9f9;">  	Log Out 	</button>
								 </form>
						  </div>
				</td>
			<%}else{ %>
				<td style="width: 6%;"></td>
			<%} %>

			<!----------------------------          CART BUTTON         ---------------------------->
			<td > <a href="cart.jsp"><img src="images/cart2.PNG" alt="" class="cartPadding"></a> </td>
			
            <td class="last"></td>
        </tr>
    </table>

</div>




<img alt="" src="images/homeMyOrders.PNG" style="margin-left: 120px;margin-top: 10px;">


<!-------------------        JAVA CODE TO PRINT ORDER DETAILS AND DELIVERY ADDRESS DETAILS OF A PARTCULAR ORDER      ------------------>
   <%	
 		//Getting the Customer Object from Session
 		Customer customer=(Customer)session.getAttribute("customer");
		
   		//Getting the First Namr of the Customer
   		String name=customer.getName().split(" ")[0];
   		
   		//Fetching the customerId
        int customerId=customer.getId();
        
   		//Geting the orderid from the Request
        int orderId=Integer.parseInt(request.getParameter("orderId"));
		
   		//Creating Object of ProductDetailsDaoImpl
   		ProductDetailsDaoImpl p=new ProductDetailsDaoImpl();
   	
  	    if(customer!=null){

  	    	//Creating Object of MyOrdersDaoImpl
			MyOrdersDaoImpl m=new MyOrdersDaoImpl();
			
  	    	//Getting the Order Object with orderId and customerId
			MyOrders order=m.get(orderId, customerId);
			
  	    	//Getting the productId
			int id=order.getProductId();
	    	
  	    	//Getting the Product object with help of productId
			ProductDetails product=p.get(id);
	%>
	
	
<!---------------------------------------------         DELIVERY ADDRESS OF THE ORDER           -------------------------------------->
	
	
	<div style="background-color: white;margin-left: 120px;margin-right: 120px;margin-bottom: 20px;font-size: 16px;padding: 20px 0px 20px 40px">

		<p style="font-weight: bold;font-size: 20px;">Delivery Address</p>
		
		<!------------------          PERSON NAME         -------------------->
		<p style="font-weight: bold;font-size: 16px;"><%=order.getName() %></p>

		<!-----------------          ORDER ADDRESS         ------------------->
		<p><%=order.getAddress() %> </p>

		<!--------------------          PINCODE         ---------------------->
		<p><%=order.getCity() %>-<%=order.getPincode() %>, <%=order.getState() %> </p>

		<!-----------------          PHONE NUMBER         -------------------->
		<p style="font-weight: bold;font-size: 16px;">Phone number</p>
		<p> <%=order.getNumber() %>, <%=order.getAlternativePhone() %> </p>

	</div>	
	
	
<!---------------------------------------------------         ORDER DETAILS           ------------------------------------------------>
	
	
<div  style="background-color: white;margin-left: 120px;margin-right: 120px;height:160px;padding-top: 20px;margin-bottom: 20px;	">
		
			<!-----------          NAME AND NUMBER OF THE PERSON WHO HAS ORDERED      ----------->
			<span style="background-color: rgb(255,247,225);border-radius: 10px;margin-left: 10px;padding: 8px;">	<%=order.getName() %> (<%=order.getNumber() %>) shared this order with you.	</span>
		
			<table width="100%" style="margin-top: 20px">
			
				<tr width="100%">
					
					<!-----------------------         IMAGE OF THE PRODUCT        ----------------------->
					<td style="text-align: center;width: 13%;"> 
						<a href="Product.jsp?id=<%=product.getId()%>">
							<img alt="" src="images/<%=product.getImagePath() %>"  style="height: 80px;"> 
						</a>
					</td>
					

					<!-------------         NAME,COLOR AND SELLER OF THE PRODUCT        ----------------->
					<td style="width: 40%">
						<a onMouseOver="this.style.color='rgb(40,116,240)'" onMouseOut="this.style.color='black'"  style="text-decoration:none;color: black;" href="Product.jsp?id=<%= product.getId()%>">
							<p>	<%=product.getName() %>	</p>
						</a>
						<p style="color: gray;font-size:13px " >	Color : <%=product.getColor() %>	</p>
						<p style="color: gray;font-size:13px ">	Seller : <%=product.getSeller() %>	</p>
					</td>

					
					<!-----------------------         PRICE OF THE PRODUCT        ----------------------->
					<td style="width: 17%">  &#8377; <%=product.getPrice() %> </td>

					

					<!----------         DELIVERY DATE AND RETURN DATE OF THE PRODCUT        ------------>
					<td style="width: 30%">	
						<p> <img alt="" src="images/greendot.PNG"> Will be delivered on <%=order.getDeliverDate() %></p>
						<p> Return Policy Valid till <%=order.getReturnDate() %></p>
					</td>
					
				</tr>
			
			
			</table>
		
		</div>

<%} %>




<!--------------------------------------------------------         FOOTER         ----------------------------------------------------->


   
<div class="footer" style="padding-top: 30px;">
  <table border="0" width="100%" bgcolor= #172337>
      <tr>
         
          <td width="13.75%"><ul><li class="footerHead"><font color="grey">ABOUT</font></li></ul></td>
          <td width="13.75%"><ul><li class="footerHead"><font color="grey">HELP</font></li></ul></td>
          <td width="13.75%"><ul><li class="footerHead"><font color="grey">POLICY</font></li></ul></td>
          <td width="13.75%"><ul><li class="footerHead"><font color="grey">SOCIAL</font></li></ul></td>
          <td width="22.5% "><ul><li class="footerHead"><font color="grey">Mail Us:</font></li></ul></td>
          <td width="22.5% "><ul><li class="footerHead"><font color="grey">Registered Office Address:</font></li></ul></td>
      </tr>
      
      <tr>
         <td width="13.75%">
             <ul>
                 <a href="" class="h"><li > Contact Us</li></a><br>
                 <a href="" class="h"><li > About Us</li></a><br>
                 <a href="" class="h"><li > Careers</li></a><br>
                 <a href="" class="h"><li > Flipkart Stories</li></a><br>
                 <a href="" class="h"><li > Press</li></a><br>
             </ul>
         </td>

          
          <td width="13.75%">
             
             <ul>
                  <a href="" class="h"><li >Payments</li></a><br>
                  <a href="" class="h"><li >Shipping</li></a><br>
                  <a href="" class="h"><li >Cancellation & Returns</li></a><br>
                  <a href="" class="h"><li >FAQ</li></a><br>
                  <a href="" class="h"><li >Report Infringement</li></a><br>
             </ul>
              
          </td>
          
          
          
          <td width="13.75%">
                  <ul>
                       <a href="" class="h"><li >Return Policy</li></a><br>
                       <a href="" class="h"><li >Terms Of Use</li></a><br>
                       <a href="" class="h"><li >Security</li></a><br>
                       <a href="" class="h"><li >Privacy</li></a><br>
                       <a href="" class="h"><li >Sitemap</li></a><br>
                       <a href="" class="h"><li >EPR Compliance</li></a><br>
                  </ul>    
          </td>
          
          <td width="13.75%">
                  <ul>
                     <a href="" class="h"><li >Facebook</li></a><br>
                     <a href="" class="h"><li >Twitter</li></a><br>
                     <a href="" class="h"><li >YouTube</li></a><br>
                  </ul>
          </td>
          
          
           <td width="22.5%">
                  <ul>
                      <li class="m" >Flipkart Internet Private Limited,</li>
                      <li class="m">Buildings Alyssa, Begonia &</li>
                      <li class="m">Clove Embassy Tech Village,</li>
                      <li class="m">Outer Ring Road, Devarabeesanahalli Village,</li>
                      <li class="m">Bengaluru, 560103,</li>
                      <li class="m">Karnataka, India.</li>
                  </ul>
          </td>
          
          <td width="22.5%">
                 
                     <ul>
                         <li class="m">Flipkart Internet Private Limited,</li>
                         <li class="m">Buildings Alyssa, Begonia &</li>
                         <li class="m">Clove Embassy Tech Village,</li>
                         <li class="m">Outer Ring Road, Devarabeesanahalli Village,</li>
                         <li class="m">Bengaluru, 560103,</li>
                         <li class="m">Karnataka, India</li>
                         <li class="m">CIN : U51109KA2012PTC066107</li>
                         <li class="m">Telephone: <a href="" style="color: blue;">1800 208 9898</a></li>
                     </ul>
                     
              
          </td>
      </tr>
      
</table>

  <hr style="height: 0.01px;">
  
  <table  border="0" width="100%" bgcolor= #172337>
      <tr height="10%">
      <td  width="12.5%"><ul><li class="footerHead"><img src="images/footer1.svg" alt="">&nbsp;&nbsp;<a href="" class="h">Sell On Flipkart</a></li></ul></td>
      <td  width="12.5%"><ul><li class="footerHead"><img src="images/footer2.svg" alt="">&nbsp;  <a href="" class="h">Advertise</a></li></ul></td>
      <td  width="12.5%"><ul><li class="footerHead"><img src="images/footer3.svg" alt="">&nbsp;  <a href="" class="h">Gift Cards</a></li></ul></td>
      <td  width="12.5%"><ul><li class="footerHead"><img src="images/footer4.svg" alt="">&nbsp;  <a href="" class="h">Help Center</a></li></ul></td>
      <td  width="15%"  ><ul><li class="m">© 2007-2019 Flipkart.com.</li></ul></td>
      <td  width="35%"  ><ul><li class="m" style="border: none;"><img src="images/cards.PNG" alt="" style="width: 100%;"></li></ul></td>
      
      </tr>
      
  </table>
  </div>




</body>
</html>