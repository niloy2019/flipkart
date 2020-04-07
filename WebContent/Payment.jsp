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
     
     	
   <!----------------------------------------------------      JavaScript Code      --------------------------------------------->

	<script src="flipkart.js"></script>

     
    
    
	<meta charset="ISO-8859-1">
	<title>flipkart</title>
</head>


<body style="background-color: rgb(241,243,246);">



<!----------------------------------------------------          HEADER         ------------------------------------------------------->

<div >
    
    <table  style="background-color:rgb(40,116, 240) ;">
        <tr>
            <td width="12.5%"></td>
			
			<!--------------------------          flipkart logo         ---------------------------->
            <td align="right"><a href="index.jsp" class="header"><img src="images/logo.PNG"></a></td>
            
            <td width="80.5%"></td>

        </tr>
    </table>

</div>



<!------------------------------------------------        BILLING AND ADDRESS PAGE ( 5 PARTS )       --------------------------------->
	

		
<!------------------------------------------------   1.   PRICE DETAILS OF ALL PRODUCTS        ---------------------------------->

							
		   <!------------------         CODE TO FETCH CUSTOMER FROM THE SESSION         ---------------------->
		   
		   <%	
				//Getting the Customer Object from Session
				Customer c=(Customer)session.getAttribute("customer");
		   		
			   //If Customer Object is null,it will Redirect to index.jsp Page
	   		   
		   
		   		List<SavedForLater>  listSavedForLater=null;
		  	    
		   		List<Cart> list =null;
		   		
		   		if(c==null){
					response.sendRedirect("index.jsp");
				}else{
				
					//Printing the Customer Details in Console
					System.out.println(c);
					
					session.setAttribute("load", "Payment");
			%>
			
		   <!-------        CODE TO FETCH ALL THE PRODUCTS OF THE CUSTOMER FROM DATABASE          ------------->

			<% 
				//Getting the Session Object
				HttpSession session2=request.getSession();
				
				//Creating Object of CartDaoImpl Class
				CartDaoImpl cd=new CartDaoImpl();
				
				//Creating Object of ProductDetailsDaoImpl Class
				ProductDetailsDaoImpl p = new ProductDetailsDaoImpl();
				
				//Getting the CUSTOMER ID  
				int customerId=c.getId();
				
				//Getting All the Cart Details of that Customer from Database  
				//Object l=session.getAttribute("buyNowId");
				
				
				//Creating one ArrayList of ProductDetails
				ArrayList<ProductDetails> pList=new ArrayList<ProductDetails>();
				
				String displayCart="none";
				
				Cart cart=null;
				
				//Getting cart from Session
				Object m=session.getAttribute("cart");
				
				//FOR ADD TO CART
				if(m!=null){
					list=new ArrayList<Cart>();
				
					cart=(Cart)m;
					
					list.add(cart);
				}
				//FOR BUY NOW
				else{
					list=cd.getAll(customerId);
				}

				
				//If Nothing is Present ,then dont display Order Summary
				if(list.size()!=0){
					displayCart="block";
				}
					
				//From the cart Object Fetching th Product Ids, And with the Help of Product IDs fetching the Product Objects
				//Lastly Adding the product objects in the list	
				for (Cart x : list) {
					//Getting Product Ids
					int i=x.getProductId();
						
					//Getting the Product Object with the help of Product Id
					ProductDetails p1=p.get(i);
						
					//Adding the Ids to a List
					pList.add(p1);
				}
				
				
				//Total Price
				int TotalPrice=0;
				//Price without offer
				int EstimatedPrice=0;
				//Count of all Products
				int count=0;
				
				//Iterating the list of Product Objects using ForEach Loop
				for(ProductDetails k: pList){
					
					//Getting the Cart Object with help with customerId and productId
					Cart w=cd.getCartObject(k.getId(), customerId);
					
					//Getting the quantity of the Product in the Cart
					int quantity=w.getQuantity();
					
					//Calculating the Total Amount of all Products Present in the cart
					TotalPrice= TotalPrice+ p.getPrice(k.getPrice())*quantity;
					
					//Counting the Total Products present in the cart
					count=count+quantity;
					
					//Calculatng the Amount without Offer Applied
					EstimatedPrice= EstimatedPrice+ p.getPreviousPrice(k.getPrice(), k.getOffer())*quantity;
					
				}
				
				//Calculating Delivery Fee
				int deliveryCharge=40*count;
				
				//Calculating PAYABLE AMOUNT(Total Amount + Delivery Fees )
				int PayableAmount=TotalPrice+deliveryCharge;
				
				//Calculating the Discount(Amoutn without offer-Payable Amount)
				int savedAmount=EstimatedPrice-TotalPrice;
				
			%>
			
		
			<div style="display:<%=displayCart %> ;background-color: white; float:right; width:425px; margin-top: 20px; margin-right: 10px;">
			
				<p style="font-size: 18px; color: grey;margin-top: 20px; margin-left: 20px; margin-bottom: 0px; padding-bottom: 0px">PRICE DETAILS</p>
			
				<hr>
		
				<table width="100%" style="margin-left: 25px">
					
					<!------------------------    TOTAL PRICE    ------------------------->
					<tr>
						<td style="font-size: 17px;width: 50%;">Price ( <%=count %> items)</td>
						<td style="font-size: 17px;width: 50%;float: right;"> 	&#8377;	<%= TotalPrice %>	</td>
					</tr>
					
					<!------------------------   DELIVERY FEE    ------------------------->
					<tr>
						<td style="font-size: 17px;padding-top: 35px;width: 50%;">Delivery Fee</td>
						<td style="font-size: 17px;padding-top: 35px;width: 50%;float: right;">&#8377;	<%= deliveryCharge	%>	</td>
					</tr>
					
					<!--------------------   HR TAG TO DEVIDE    ------------------------->
					<tr width="100%">
						<td> <hr> </td>
						<td> <hr> </td>
					</tr>
					
					<!------   TOTAL PAYABLE AMOUNT = TOTAL AMOUNT +  DELIVERY FEE ------->
					<tr>
						<td style="font-size: 17px;font-weight: bold;width: 50%;">   Total Payable   </td>
						<td style="font-size: 17px;float: right;width: 50%;font-weight: bold;">&#8377;	<%= PayableAmount %></td>
					</tr>
				</table>
				<hr>
				
				<!-------------   AMOUNT BE SAVED IN THE ORDER  --------------------->
				<p style="font-size: 17px;font-weight: bold;color:green;padding-left: 30px;"> You will save &#8377;	<%=savedAmount %> on this order </p>
					
				<!------------------------   RETURN POLICY  ------------------------->
				<div style="background-color: rgb(241,243,246);">
					<img alt="" src="images/Safe.PNG">
				<!------------------------    SUPER COIN    ------------------------->
				</div>
				<div style="background-color: rgb(241,243,246);">
					<img alt="" src="images/supercoin.PNG">
				</div>
				
			</div>
			
			
			

<!---------------------------------------------------       2.   LOGIN        -------------------------------------------------------->
			
		<% 
			session.setAttribute("load", "Payment");
			//Getting customer Object From the Session
			Customer customer=(Customer)session.getAttribute("customer"); 
		%>
	
		<div style="background-color: white;color: rgb(146,135,135);padding: 20px 10px 10px 30px;font-size: 17px;font-weight: bold;margin-left: 40px;width: 850px;margin-top: 20px;box-shadow: 1px 1px 1px 1px #888888;">

				<!----------------------------------       LOGIN       -------------------------------->
				<p>		<span style="background-color:rgb(240,240,240);color:blue;margin-right: 10px; padding: 3px 6px 4px 6px;">1</span>			LOGIN	
						<img alt="" src="images/right.PNG">	
				</p>
				
				<!-------------------       CUSTOMER NAME AND CUSTOMER NUMBER       ------------------->
				<p style="color: black;margin-left: 30px;"> 	
					<span style="font-weight: bold;margin-right: 20px;"> <%=customer.getName() %> </span> 
					<span style="font-weight: 200;"> <%=customer.getMobile() %> </span>
				</p>
		</div>
	
	
	
	
<!----------------------------------------------      3.    DELIVERY ADDRESS            ----------------------------------------------->
		
		<%	
			//Logic for -  by Default Delivery Address Form will be Visible
			String backgroundColor ="rgb(40,116, 240)";	
			String color ="white";
			String img="";

			String z=request.getParameter("deliveryAddress");
			
			//LOGIC FOR- After Submitting the Delvery Adrees Form The Form will be closed and Order Summary Will open
			if(z!=null){
				backgroundColor="white";
				color="rgb(146,135,135)";
				img="images/right.PNG";
			}
		%>
		
		<!----------------------------        DELIVERY ADDRESS    ----------------------------->
		<div  style="background-color: white;color: <%=color %>;padding: 0px 0px 0px 0px;font-size: 17px;font-weight: bold;box-shadow: 1px 1px 1px 1px #888888;margin-left: 40px;width: 850px;margin-top: 20px;">
	
				<p id="addressBar" onclick="return openAddress()" style="background-color:<%=backgroundColor %> ;padding: 15px;cursor: pointer; ">	
					<span id="number" style="background-color: rgb(240,240,240); padding: 3px 6px 4px 6px;color: blue;margin-right: 10px;margin-left: 20px;">
					  2 
					 </span>	
				    	 DELIVERY ADDRESS	
					<img alt="" src="<%=img%>">	
				</p>
		</div>
		
		<%	
			if(z==null){
		%>
		
		<div id="address" style="margin-left: 40px;width: 850px;background-color: rgb(245,250,255);padding:0px 0px 20px 60px; ">
		
			<br>
			
			<!-------------------------------       ADDRESS FORM       ---------------------------->
			<form  action="PlaceOrder">
			
						<!-----------------------------------       NAME       --------------------------------->
						<input name="name" type="text" required="required" placeholder="Name" style="height: 50px;width: 250px;">
					
						<!---------------------------------       NUMBER       -------------------------------->
						<input name="number" type="number" required="required" placeholder="10-digit mobile number" style="height: 50px;width: 250px;">
						
						<br><br>
						
						<!---------------------------------       PINCODE       ------------------------------->
						<input name="pincode" type="number" required="required" placeholder="Pincode" style="height: 50px;width: 250px;">
						
						<!---------------------------------       LOCALITY       ------------------------------>
						<input name="locality" type="text" required="required" placeholder="Locality" style="height: 50px;width: 250px;">
						<br><br>
						
						<!---------------------------------       ADDRESS       ------------------------------->
						<input name="address" type="text" required="required" placeholder="Address(Area and Street)" style="height: 100px;width: 505px;">
						
						<br><br>
						
						<!------------------------------       CITY/DIST/TOW       ---------------------------->
						<input name="city" type="text" required="required" placeholder="City/District/Town" style="height: 50px;width: 250px;">
						
						<!----------------------------------       STATE       -------------------------------->
						<input name="state" type="text"  required="required" placeholder="State" style="height: 50px;width: 250px;">
						
						<br><br>
						
						<!--------------------------------       LANDMARK       ------------------------------->
						<input name="landmark" type="text"    placeholder="Landmark (Optional)" style="height: 50px;width: 250px;">
						
						<!----------------------------       ALTERNATIVE PHONE       -------------------------->
						<input name="alternativePhone" type="number"  placeholder="Alternate Phone (Optional)" style="height: 50px;width: 250px;">
						
						<br><br>
						
						<div>
							<!--------------------------       ADDRESS TYPE(HOME/WORK)       ---------------------->
							<label style="color: gray;font-size: 13px;">Address Type</label> <br>			
							<input name="addressType" required="required" type="radio" name="addressType" value="Home">	<span style="margin-right: 40px;">Home (All day delivery)</span>		
							<input name="addressType" required="required" type="radio" name="addressType" value="Work">	<span> Work (Delivery between 10 AM - 5PM)</span>	
						</div>
		
					
						<div style="margin-top: 40px;">
							<!-----------------------       SAVE AND DELIVER HERE BUTTON      --------------------->
							<button  type="submit"   style="background-color: rgb(251,100, 27);border: 0px;width: 250px;height: 50px;color: white; font-weight: bold;border-radius: 3px;"> SAVE AND DELIVER HERE </button>
							<!------------------------------       CANCEL BUTTON       ---------------------------->
							<button    style="background-color: transparent;border: 0px;width: 250px;height: 50px;color: rgb(40,116, 240);font-weight: bold;">CANCEL</button>
						</div>
		
					</form> 
		
		</div>
		
		<% } %>
		
	
<!----------------------------------------------     4.     ORDER SUMMARY            -------------------------------------------------->

			<%	
			
				//Logic for-By Defult Order Sumaary wont be visible
				String backgroundColor2="white";
				String color2="rgb(146,135,135)";
				String img2="";
				displayCart="none";
				String o2=request.getParameter("orderSummary");
				
				//Logic for-After Submitting Delivery Adresss Order Summary will be visible
				if(z!=null && o2==null){
					backgroundColor2 ="rgb(40,116, 240)";	
					color2 ="white";
					displayCart="block";
				}
				
				//Logic For- After Pressing the Continue Button, Order Summary will not be closed and Payment Option Form will Open 
				if(o2!=null){
					img2="images/right.PNG";
					displayCart="none";
				}
				
			
			%>
			
			<!----------------------------------       ORDER SUMMARY       -------------------------------->
			<div  style="background-color: <%=backgroundColor2 %> ;color:<%=color2 %>;padding: 0px 0px 0px 0px;font-size: 17px;font-weight: bold;box-shadow: 1px 1px 1px 1px #888888;margin-left: 40px;width: 850px;margin-top: 20px;">
			
					<p style="padding: 15px;cursor: pointer; ">	
						
						<span  style="background-color: rgb(240,240,240); padding: 3px 6px 4px 6px;color: blue;margin-right: 10px;margin-left: 20px;">
						  3 
						 </span>	
					    	ORDER SUMMARY	
						<img alt="" src="<%=img2 %>">	
					</p>
			</div>
			
			
			 <!------------------------------------------------   2.    Products Present in Cart        --------------------------------------->
			
			
			<div style="display:<%=displayCart %> ;width:850px;background-color: white; margin-left: 40px;margin-top: 0px;float: inherit;">
				
				<table>	
					
						
					<!-------------     Using ForEach loop Printing all the Product Present in Cart        ----------->
		
					<% 	
						for (ProductDetails product : pList) { 
						
							//Getting the Product Id
					   		int productId=product.getId();
				
					   		//Calculation the Previous amount of the Product(Current Amount+Discount)
							int previousPrice=p.getPreviousPrice(product.getPrice(), product.getOffer());
					   		
					   		//Getting the Quantity of the Product
					   		int quantity=0;
					   		
					   		if(cart!=null){
					   			quantity=cart.getQuantity();	
					   		}else{
						   		Cart w=cd.getCartObject(product.getId(), customerId);
								quantity=w.getQuantity();
					   		}
					   		
					   		
					   		//Printing the Product Details in Console
					   		System.out.println(product);
					%>
					
									<tr>
										<!----------------     IMAGE OF PRODUCT      ------------------------>
									
										<td style="padding-right: 20px;padding-left: 20px;padding: 20px;text-align: center;">	
											 	<a style="text-decoration:none;" href="Product.jsp?id=<%= productId%>"><img alt="" src=" images/<%=product.getImagePath() %>" style="height: 125px;max-width: 200px; "></a>
											 <p></p> 
											 <a href="DecreaseQuantity?customerId=<%=customerId%>&productId=<%=productId%>&load=Payment" style="text-decoration: none;"><img alt="" src="images/minus.PNG"> </a>    
											 <input style="width: 45px; text-align: center;" value="<%=quantity %>" type="text"> &nbsp;
											 <a href="IncreaseQuantity?customerId=<%=customerId%>&productId=<%=productId%>&load=Payment" style="text-decoration: none;"><img alt="" src="images/plus.PNG"></a>    
										</td>
										
										<!---------------     DETAILS OF THE PRODUCT     -------------------->
							
										<td style="padding-left"> 
												
												<!-- PRODUCT NAME AND DELIVERY DATE -->
												<div style="width: 600px">
													<a onMouseOver="this.style.color='rgb(40,116,240)'" onMouseOut="this.style.color='black'"  style="text-decoration:none;color: black;" href="Product.jsp?id=<%= productId%>">
														<span style="padding-bottom: 10px ; font-size: 18px"  >  <%=  product.getName() %>  	   </span>
													</a>
													<span style="font-size: 13px; float: right;"> Delivery by Mon Mar 16 |  &#8377;	40 </span>  
												</div>
			
												<!-- SELLER NAME OF THE PRODUCT AND REPLACEMENT-->
												<div>
											 		<span style=" color: grey;padding-top: 10px;" > 	Seller:  <%= product.getSeller() %>  		</span>
											 		<img alt="" src="images/fassured.PNG">
											 		<span style="color: grey;font-size: 12px;float: right; ">		10 Days Replacement Policy	</span>
												</div>
			
												<!-- PRICE,PREVIOUS PRICE AND OFFER OF THE PRODUCT-->
										 		<font size="5" style="padding-bottom: 20px;"><b style="font-size: 18px;">  &#x20b9; 	<%= product.getPrice() %>		</b></font>
										 		<font color="grey" style="text-decoration: line-through;">   <%= previousPrice %>	</font> &nbsp;
										 		<font color="green">	<%=   product.getOffer()  %>	% off</font> <font color="green">2 offers available</font> 
										 		<img alt="" src="images/e.PNG">
			
												<!-- REMOVE AND SAVE FOR LATER BUTTON-->
										  		<p style="padding-top:40px ; font-size: 18px;">
										  		  	<a onMouseOver="this.style.color='rgb(40,116,240)'" onMouseOut="this.style.color='black'" style="color: black;text-decoration: none;" href="RemoveProductFromCart?customerId=<%=customerId%>&productId=<%=productId%>&load=Payment"> REMOVE </a>    
										  		</p>
									   </td>
			
			
		   
									</tr>
									
									
									<!-- HR TAG TO DEVIDE ONE PRODUCT FROM ANOTHER WITH A LINE-->
									<tr>
										<td>    <hr>    </td>	 
										<td>	<hr>    </td>	 
									</tr>
			
						<% } %>
					
						</table>
						<br>
						
						<!---------     PLACE ORDER BUTTON     --------------->
						
						<div style="width:800px;background-color: white;height: 80px;">
							<a href="OrderSummary">
								<button style="text-decoration:none;color: white;background-color:rgb(251,100,27) ;font-weight:bold;height: 50px;width: 200px;font-size: 15px; border: 0px;float: right; margin-right: 20px;">
									CONTINUE
								</button>
							</a>
						</div>
					
			</div>
		
		
		

		
		
<!--------------------------------------------------     5.     PAYMENT            ---------------------------------------------------->
		<%	
			//Logic for - By Default Payment Option Won't be Visible
			String backgroundColor3="white";
			String color3="rgb(146,135,135)";
			String img3="";
			
			//logic for - After Submmitting the Delivery Address and order Summary Form, Payment Option will be visible
			if(z!=null && o2!=null){
				backgroundColor3 ="rgb(40,116, 240)";	
				color3 ="white";
			}
	
		%>
	
		<!-----------------------------       PAYMENT OPTIONS       --------------------------->
		<div style="background-color: <%=backgroundColor3 %>;color: <%=color3 %>;padding: 10px;font-size: 17px;font-weight: bold;box-shadow: 1px 1px 1px 1px #888888;margin-left: 40px;width: 850px;margin-top: 20px;">
				<p>		 
					<span style="background-color: rgb(240,240,240); padding: 3px 6px 4px 6px;color: blue;margin-right: 10px;margin-left: 20px;">
						4
					</span>		
					PAYMENT OPTIONS		
					<img alt="" src="<%=img3 %>>">
				</p>
		</div>
	
	
	<% if(z!=null && o2!=null){ %>
	
	<div id="payment"	style="background-color: white;margin-left: 40px;width: 850px;padding: 20px; ">
		
		<!---------------------------       PAYMENT OPTION FORM       ------------------------->
		<form action="RemoveFromCartAfterOrder">
		
			<!---------------------------------       PHONEPE       ------------------------------->
			<input type="radio" name="paymentType" required="required" style="margin-right: 10px;"> <img alt="" src="images/PhonePe.PNG">	<span> Credit/ Debit / ATM Card   </span>
			<hr>

			<!--------------------------------       BHIM UPI       ------------------------------->
			<input type="radio" name="paymentType" required="required" style="margin-right: 10px;">	<span> PhonePe / BHIM UPI         </span>
			<hr>

			<!-------------------------------       NET BANKING       ----------------------------->
			<input type="radio" name="paymentType" required="required" style="margin-right: 10px;">	<span> Net Banking                </span>
			<hr>

			<!-----------------------------       CASH ON DELIVERY       -------------------------->
			<input type="radio" name="paymentType" required="required" style="margin-right: 10px;">	<span> Cash on Delivery           </span>
			<br><br><br>
		
			<!------------------------------       PAYABLE AMOUNT       --------------------------->
			<button  type="submit" style="background-color: rgb(255,81,0);color: white;height: 50px;width: 200px;border: 0px;font-weight: bold;font-size: 17px;border-radius: 3px;"> 
					PAY &#8377;<%=PayableAmount %>
			</button>
	
		</form>
		
	</div>
	
	<% } %>

	
<%} %>
	

<div style="margin-bottom :100px;"></div>

</body>
</html>
