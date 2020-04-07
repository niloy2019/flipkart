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
  			      com.abc.daoImpl.SavedForLaterDaoImpl,
  			       java.time.LocalDate" %>
  			      
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


<!----------------------------------------------------          HEADER         ------------------------------------------------------->


<%
		session.setAttribute("load", "Cart");

		//Getting the Customer Object from Session
		Customer c=(Customer)session.getAttribute("customer");
		
%>
<div >
    
    <table  style="background-color:rgb(40,116, 240) ;">
        <tr>
            <td width="12.5%"></td>
			
			<!--------------------------          flipkart logo         ---------------------------->
            <td align="right"><a href="index.jsp" class="header"><img src="images/logo.PNG"></a></td>
			
			
			<!-----------------------------------        Search Bar        ----------------------------->
			<form action="Search.jsp" >
				<!--------------------------          Search Input Box         ------------------------->
	            <td><input type="text" name="search" class="input" placeholder="   Search for products, brands and more"></td>
	
	
				<!--------------------------          Search Button         ---------------------------->
	            <td> <button type="submit" style="padding: 0px;border: 0px;"><img  src="images/search.PNG" class="search"></button> </td>
			</form>

            <td style="width:23% "></td>

           	<%if(c!=null){ %>
	            <td class="dropdown"> 
						  <!---------------------------          More Button         ----------------------------->
		            	  <img src="images/more.PNG" alt="" class="morePadding">
						  
						  <div class="dropdown-content">
						 		 <!--------------------------          MyOrder Button         ----------------------------->
								 <a href="MyOrder.jsp" style="text-decoration: none;"> 	<p>My order</p> 	</a>

						 		 <!--------------------------          Log Out Button         ----------------------------->
								 <form action="LogOut">
								 	<button style="border: 0px;background-color: #f9f9f9;">  	Log Out 	</button>
								 </form>
						  </div>
				</td>
			<%}else{ %>
				<td style="width: 6%;"></td>
			<%} %>



            <td style="width:10% "></td>

        </tr>
    </table>

</div>

<!------------------------------------------      CODE TO FETCH CUSTOMER FROM THE SESSION      -------------------------------------->
   
   <%	
   		List<SavedForLater>  listSavedForLater=null;
  	    List<Cart> list =null;
   	
  	    if(c!=null){
		
		//Printing the Customer Details in Console
		System.out.println(c);
	%>
	
	
<!--------------------------------------       CODE TO FETCH ALL THE PRODUCTS OF THE CUSTOMER FROM DATABASE      -------------------------------->
	
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
		list=cd.getAll(customerId);
		
		//Creating one ArrayList of ProductDetails
		ArrayList<ProductDetails> pList=new ArrayList<ProductDetails>();
		
		String displayCart="none";
		
		//If No Products present in cart then displau "cart empty"
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
		
		//Geting the Day after 10 days from today
		LocalDate today = LocalDate.now(); 
		LocalDate afterTenDays = today.plusDays(10);
		
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
	
	



<!--------------------------------------------------          CART ( Devided in 4 Parts )        ------------------------------------->


    <!------------------------------------------------   1.   PRICE DETAILS OF ALL PRODUCTS        ---------------------------------->

	<div style="display:<%=displayCart %> ;background-color: white; float:right; width:425px; margin-top: 20px; margin-right: 50px;">
	
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
		</div>
		
	</div>
	
	
	
	
	 <!------------------------------------------------   2.    Products Present in Cart        --------------------------------------->
	
	
	<div style="display:<%=displayCart %> ;width:800px;background-color: white; margin-left: 50px;margin-top: 20px;float: inherit;">
		
				<p style="font-size: 18px; font-weight:bold;padding-top: 20px; margin-left: 20px; ">My Cart (<%=count %>)<img alt="" src="images/deliverTo.PNG" style="float: right;margin-right: 150px;"></p>	
				
			    <hr>
			     
				<table>	
			
				
			<!-------------     Using ForEach loop Printing all the Product Present in Cart        ----------->

			<% 	
				for (ProductDetails product : pList) { 
				
					//Getting the Product Id
			   		int productId=product.getId();
		
			   		//Calculation the Previous amount of the Product(Current Amount+Discount)
					int previousPrice=p.getPreviousPrice(product.getPrice(), product.getOffer());
			   		
			   		//Getting the Quantity of the Product
			   		Cart w=cd.getCartObject(product.getId(), customerId);
			   		
					int quantity=w.getQuantity();
			   		
			   		//Printing the Product Details in Console
			   		System.out.println(product);
			%>
			
							<tr>
								<!----------------     IMAGE OF PRODUCT      ------------------------>
							
								<td style="padding-right: 20px;padding-left: 20px;padding: 20px;text-align: center;">	
									 	<a style="text-decoration:none;" href="Product.jsp?id=<%= productId%>"><img alt="" src=" images/<%=product.getImagePath() %>" style="height: 125px;max-width: 200px; "></a>
									 <p></p> 
									 <a href="DecreaseQuantity?customerId=<%=customerId%>&productId=<%=productId%>&load=cart" style="text-decoration: none;"><img alt="" src="images/minus.PNG"> </a>    
									 <input style="width: 45px; text-align: center;" value="<%=quantity %>" type="text"> &nbsp;
									 <a href="IncreaseQuantity?customerId=<%=customerId%>&productId=<%=productId%>&load=cart" style="text-decoration: none;"><img alt="" src="images/plus.PNG"></a>    
								</td>
								
								<!---------------     DETAILS OF THE PRODUCT     -------------------->
					
								<td style="padding-left"> 
										
										<!-- PRODUCT NAME AND DELIVERY DATE -->
										<div style="width: 600px">
											<a onMouseOver="this.style.color='rgb(40,116,240)'" onMouseOut="this.style.color='black'"  style="text-decoration:none;color: black;" href="Product.jsp?id=<%= productId%>">
												<span style="padding-bottom: 10px ; font-size: 18px"  >  <%=  product.getName() %>  	   </span>
											</a>
											<span style="font-size: 13px; float: right;margin-right: 50px;"> Delivery by <%=afterTenDays %> |  &#8377;	40 </span>  
										</div>
	
										<!-- SELLER NAME OF THE PRODUCT AND REPLACEMENT-->
										<div>
									 		<span style=" color: grey;padding-top: 10px;" > 	Seller:  <%= product.getSeller() %>  		</span>
									 		<img alt="" src="images/fassured.PNG">
									 		<span style="color: grey;font-size: 12px;float: right;margin-right: 50px; ">		10 Days Replacement Policy	</span>
										</div>
	
										<!-- PRICE,PREVIOUS PRICE AND OFFER OF THE PRODUCT-->
								 		<font size="5" style="padding-bottom: 20px;"><b style="font-size: 18px;">  &#x20b9; 	<%= product.getPrice() %>		</b></font>
								 		<font color="grey" style="text-decoration: line-through;">   <%= previousPrice %>	</font> &nbsp;
								 		<font color="green">	<%=   product.getOffer()  %>	% off</font> <font color="green">2 offers available</font> 
								 		<img alt="" src="images/e.PNG">
	
										<!-- REMOVE AND SAVE FOR LATER BUTTON-->
								  		<p style="padding-top:40px ; font-size: 18px;">
								  			<a onMouseOver="this.style.color='rgb(40,116,240)'" onMouseOut="this.style.color='black'"  style="text-decoration:none;color: black;" href="MoveToSavedForLater?customerId=<%=customerId%>&productId=<%=productId%>"> SAVE FOR LATER </a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
								  		  	<a onMouseOver="this.style.color='rgb(40,116,240)'" onMouseOut="this.style.color='black'" style="color: black;text-decoration: none;" href="RemoveProductFromCart?customerId=<%=customerId%>&productId=<%=productId%>&load=cart"> REMOVE </a>    
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
					<a href="Payment.jsp">
						<button style="text-decoration:none;color: white;background-color:rgb(251,100,27) ;font-weight:bold;height: 50px;width: 200px;font-size: 15px; border: 0px;float: right; margin-right: 20px;">
							PLACE ORDER
						</button>
					</a>
				</div>
			
	</div>







 <!--------------------------------------------------   3.    SAVE FOR LATER        ---------------------------------------------------->
	
	
	<%
		//Creating Object of SavedForLaterDaoImpl Class
		SavedForLaterDaoImpl sf=new SavedForLaterDaoImpl();
		
		//Getting All the Cart Details of that Customer from Database  
		listSavedForLater=sf.getAll(customerId);
		
		String display="none";
		
		System.out.println(listSavedForLater.size());
		
		//Lofic for -> If No Product Present in the Saved For Later,then dont show it
		if(listSavedForLater.size()!=0){
			display="block";
		}
		
		int count2=listSavedForLater.size();
		
		//Creating one ArrayList of SavedForLater
		ArrayList<ProductDetails> productSaved=new ArrayList<ProductDetails>();
		
		//Adding all the Product Object to the List
		for (SavedForLater s : listSavedForLater) {
			//Getting Product Ids
			int i=s.getProductId();
			
			//Getting the Product Object with the help of Product Id
			ProductDetails p1=p.get(i);
			
			//Adding the Ids to a List
			productSaved.add(p1);
		}
	
	%>	
	
	<div style="width:800px;background-color: white; margin-left: 50px;margin-top: 20px;float: inherit;display: <%= display%>;">
		
				<p style="font-size: 18px; font-weight:bold;padding-top: 20px; margin-left: 20px; ">Saved For Later  (<%=count2 %>)<img alt="" src="images/deliverTo.PNG" style="float: right;margin-right: 150px;"></p>	
				
			     
				<table>	
			
				
			<!-------       Using ForEach loop Printing all the Product Present in SaveForLater        ------>

			<% 	
				for (ProductDetails product : productSaved) { 
				
					//Getting the Product Id
			   		int productId=product.getId();

					//Calculation the Previous amount of the Product(Current Amount+Discount)
					int previousPrice=p.getPreviousPrice(product.getPrice(), product.getOffer());
			   		
			   		//Getting the Quantity of the Product
			   		SavedForLater e=sf.getSavedForLater(productId, customerId);
			   		int quantity=0;
			   		if(e!=null){
			   			quantity= e.getQuantity();
			   		}
			   		
			   		//Printing the Product Details in Console
			   		System.out.println(product);
			%>				
								
								
								
							<!-- HR TAG TO DEVIDE ONE PRODUCT FROM ANOTHER WITH A LINE-->
							<tr>
								<td>    <hr>    </td>	 
								<td>	<hr>    </td>	 
							</tr>
			
			
							<tr>
								<!----------------     IMAGE OF PRODUCT      ------------------------>
							
								<td style="padding-right: 20px;padding-left: 20px;padding: 20px;text-align: center;">	
									 <a style="text-decoration:none;" href="Product.jsp?id=<%= productId%>"><img alt="" src=" images/<%=product.getImagePath() %>" style="height: 125px; max-width: 200px;"></a>
									 <p></p> 
									 <img alt="" src="images/minus.PNG"> 
									 <input style="width: 45px; text-align: center;" value="<%=quantity %>" type="text"> &nbsp;
									 <img alt="" src="images/plus.PNG">
								</td>
								
								<!---------------     DETAILS OF THE PRODUCT     -------------------->
					
								<td style="padding-left"> 
										
										<!-- PRODUCT NAME AND DELIVERY DATE -->
										<div style="width: 600px">
											<a onMouseOver="this.style.color='rgb(40,116,240)'" onMouseOut="this.style.color='black'"  style="text-decoration:none;color: black;" href="Product.jsp?id=<%= productId%>">
												<span style="padding-bottom: 10px ; font-size: 18px"  >  <%=  product.getName() %>  	   </span>
											</a>
											<span style="font-size: 13px; float: right;margin-right: 50px;"> Delivery by Mon Mar 16 |  &#8377;	40 </span>  
										</div>
	
										<!-- SELLER NAME OF THE PRODUCT AND REPLACEMENT-->
										<div>
									 		<span style=" color: grey;padding-top: 10px;" > 	Seller:  <%= product.getSeller() %>  		</span>
									 		<img alt="" src="images/fassured.PNG">
									 		<span style="color: grey;font-size: 12px;float: right;margin-right: 50px; ">		10 Days Replacement Policy	</span>
										</div>
	
										<!-- PRICE,PREVIOUS PRICE AND OFFER OF THE PRODUCT-->
								 		<font size="5" style="padding-bottom: 20px;"><b style="font-size: 18px;">  &#x20b9; 	<%= product.getPrice() %>		</b></font>
								 		<font color="grey" style="text-decoration: line-through;">   <%= previousPrice %>	</font> &nbsp;
								 		<font color="green">	<%=   product.getOffer()  %>	% off</font> <font color="green">2 offers available</font> 
								 		<img alt="" src="images/e.PNG">
	
										<!-- REMOVE AND SAVE FOR LATER BUTTON-->
								  		<p style="padding-top:40px ; font-size: 18px;">
								  			<a onMouseOver="this.style.color='rgb(40,116,240)'" onMouseOut="this.style.color='black'"  style="text-decoration:none;color: black;" href="MoveToCart?customerId=<%=customerId%>&productId=<%=productId%>"> MOVE TO CART </a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
								  		  	<a onMouseOver="this.style.color='rgb(40,116,240)'" onMouseOut="this.style.color='black'" style="color: black;text-decoration: none;" href="RemoveFromSaveForLater?customerId=<%=customerId%>&productId=<%=productId%>"> REMOVE </a>    
								  		</p>
							   </td>
	
	
   
							</tr>
							
							
						
	
				<% } %>
			
				</table>

	</div>



	<% } %>
	


 <!--------------------------------------------------   4.    EMPTY CART        ---------------------------------------------------->


<%	
	//Logic for -> If No Product Presen in cart as well as Saved for Later, Then it will show cart Empty 
	
	Object o1=list;
	Object o2=listSavedForLater;
	
	String j1="";
	String j2="";
	
	if(o1!=null && o2!=null){
		j1=o1.toString();
		j2=o2.toString();
	}

	if( (j1.equals("[]") && j2.equals("[]") ) || (o1==null && o2==null) ){
%>

<div style="margin: 50px;background-color: white;width: 1240px;height: 450px; box-shadow: 5px 10px 8px #888888;	">
	
	<p	style="text-align: center;">	<img alt="" src="images\cartEmpty.PNG"></p>
	<p	style="text-align: center;">	
		<a href="index.jsp"><button style="background-color: rgb(40,116, 240);color: white;border:0px;height:40px;width: 200px;border-radius: 5px;">Shop now</button></a>	
	</p>
	
</div>

<%} %>







<!------------------------------------------------------       For Footer       ----------------------------------------------------->
   
   
<div class="footer" style="padding-top: 30px;margin-top: 150px">

  <table border="0" width="100%" bgcolor= #172337 >
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