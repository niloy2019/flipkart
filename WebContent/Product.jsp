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
  				    
  			      com.abc.daoImpl.CustomerDaoImpl,
  			      com.abc.daoImpl.ProductDetailsDaoImpl,
  			      com.abc.daoImpl.CartDaoImpl,
  			      com.abc.daoImpl.MyOrdersDaoImpl " %>
  			      
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>flipkart</title>
</head>

	<!----------------------------------------------------         CSS Code          --------------------------------------------->
   
     <link rel="stylesheet" href="index.css">
    
   <!----------------------------------------------------      BootStrap Code       --------------------------------------------->
   
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
     <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    
<body style="background-color: rgb(241,243,246);">

<div>


<!---------------------------------------------   CODE TO FETCH THE PRODUCT FROM DATABASE  ---------------------------------------------->
   
   <%	
   		//Getting the Product Id from the Request Parameter
   		String id=request.getParameter("id");
  	    int productId =0;

   		if(id!=null){
			 productId = Integer.parseInt(id);
			 session.setAttribute("id", productId);
   		}else{
   			 Object o=session.getAttribute("id");
   			 String j=o.toString();
   			 productId=Integer.parseInt(j);
   		}

   		//Creating Object of ProductDetailsDaoImpl Class
		ProductDetailsDaoImpl p=new ProductDetailsDaoImpl();
		
   		//Getting the Product Object with the ID
		ProductDetails product = p.get(productId);

   		//Saving the Product Object in Session
		session.setAttribute("product", product);
		
   		//Calculation the Previous amount of the Product(Current Amount+Discount)
		int previousPrice=p.getPreviousPrice(product.getPrice(), product.getOffer());
		
   		//Calculation the EMI of the Product for 12 months)
		int emi=p.getPrice(product.getPrice())/12;
		
   		//Printing the Product Details in Console
   		System.out.println(product);
   				
   		session.setAttribute("buyNowStatus", true);
   				
   %>
   
<!---------------------------------------------   CODE TO FETCH CUSTOMER FROM THE SESSION  ---------------------------------------------->
   
   <%	
		//Getting the Customer Object from Session
		Customer c=(Customer)session.getAttribute("customer");
	    
		//Printing the Customer Details in Console
		System.out.println(c);
		
		String s=null;
		
		//Getting PrintWriter Object
		PrintWriter o=response.getWriter();
		
		if(c==null){
			//If customer object is null,then it will show the key as "Login" 
			System.out.println("Login");
			s="Login";
		}else{
			//Else it will show the Customer Name Instead of Key
			System.out.println(c.getName());
			String j=c.getName();
			String[] k=j.split(" ");
			s=k[0];
		}
		
	%>
	
<!------------------------------------------------------------   HEADER   ----------------------------------------------------------->


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


			<!--------------------------          Login Button         ----------------------------->
            <td class="loginPadding" style="width: 13%;"></td>


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

			<!----------------------------          Cart Button         ------------------------------>
            <td > <a href="cart.jsp"><img src="images/cart2.PNG" alt="" class="cartPadding"></a> </td>

            <td class="last"></td>
       </tr>
    </table>


</div>



<!------------------------------------------------------------   code for Navbar   ----------------------------------------------------------->


<div>
    <table  width="100%" style="background-color: white;">
        
        <!-------------------------------------------        ELECTRONICS SECTION       --------------------------------------------->
        <tr>
            <td class="td" width="15%"> 
            	<a href="Categoery.jsp?from=1&&to=25"  onMouseOver="this.style.color='rgb(40,116,240)'" onMouseOut="this.style.color='black'"  style="text-decoration:none;color: black;">
            		<div class="dropdown">
            			Electronics 
            			<img src="images/navicon.PNG" alt="" >
            		   
            		    <div class="dropdown-content">
								<p> <a href="Categoery.jsp?from=1&&to=5" style="text-decoration: none;"> 	Mobile 	 </a></p>
								<p> <a href="Categoery.jsp?from=6&&to=10" style="text-decoration: none;"> 	Laptop 	 </a></p>
								<p> <a href="Categoery.jsp?from=11&&to=15" style="text-decoration: none;"> 	Watch 	 </a></p>
								<p> <a href="Categoery.jsp?from=16&&to=20" style="text-decoration: none;"> 	Earphone </a><p>
								<p> <a href="Categoery.jsp?from=21&&to=25" style="text-decoration: none;"> 	 Camera  </a><p>
				 		</div>
            	
            		</div>
            	</a>
            </td>
            

        <!---------------------------------------        TV & APPLIANCES SECTION       --------------------------------------------->
            <td class="td" width="12%">
	            <a href="Categoery.jsp?from=26&&to=30"  onMouseOver="this.style.color='rgb(40,116,240)'" onMouseOut="this.style.color='black'"  style="text-decoration:none;color: black;">
    		        <div class="dropdown">
    		        	TVs & Appliances 
    		        	<img src="images/navicon.PNG" alt="">
    		        	 <div class="dropdown-content">
								<p> <a href="Categoery.jsp?from=26&&to=30" style="text-decoration: none;"> 	Television 	 </a></p>
				 		</div>
    		     </a>
    		</td>
            
        <!-----------------------------------------------------        MEN       ---------------------------------------------------->
            <td class="td" width="10%">
            	<a href="Categoery.jsp?from=31&&to=40"  onMouseOver="this.style.color='rgb(40,116,240)'" onMouseOut="this.style.color='black'"  style="text-decoration:none;color: black;">
            		<div class="dropdown">
            			Men 
            			<img src="images/navicon.PNG" alt="">
            			
            			<div class="dropdown-content">
            					<!----------------------------------------       SHIRTS      ---------------------------------->
								<p> <a href="Categoery.jsp?from=31&&to=35" style="text-decoration: none;"> 	Shirts 	 </a></p>
            					
            					<!-------------------------------------       ETHNIC WEAR      -------------------------------->
								<p> <a href="Categoery.jsp?from=36&&to=40" style="text-decoration: none;"> 	Ethnic Wear  </a><p>
				 		</div>
           		 	</div>
           		 </a>
            </td>
        <!----------------------------------------------------        WOMEN       --------------------------------------------------->
            <td class="td" width="10%">
            	<a href="Categoery.jsp?from=41&&to=50"  onMouseOver="this.style.color='rgb(40,116,240)'" onMouseOut="this.style.color='black'"  style="text-decoration:none;color: black;">
          			 <div class="dropdown">
          			 	Women 
          			 	<img src="images/navicon.PNG" alt="">
          			 	<div class="dropdown-content">
            					<!----------------------------------------       SAREES      ---------------------------------->
								<p> <a href="Categoery.jsp?from=41&&to=45" style="text-decoration: none;"> 	Sarees 	 </a></p>
            					
            					<!---------------------------------------       CHUDRIDAR      -------------------------------->
								<p> <a href="Categoery.jsp?from=46&&to=50" style="text-decoration: none;"> 	Churidar  </a><p>
				 		</div>
					 </div>
          		</a>
          	</td>

        <!----------------------------------------------------        KIDS       ---------------------------------------------------->
            <td class="td" width="">
	            <a href="Categoery.jsp?from=51&&to=60"  onMouseOver="this.style.color='rgb(40,116,240)'" onMouseOut="this.style.color='black'"  style="text-decoration:none;color: black;">
            		<div class="dropdown">
            			Baby & Kids 
            			<img src="images/navicon.PNG" alt="">
            			<div class="dropdown-content">
            					<!--------------------------------------       BOYS WEAR      --------------------------------->
								<p> <a href="Categoery.jsp?from=56&&to=60" style="text-decoration: none;"> 	Boys Wear 	 </a></p>

            					<!---------------------------------------       GIRLS WEAR      ------------------------------->
								<p> <a href="Categoery.jsp?from=51&&to=55" style="text-decoration: none;">  Girls Wear	 </a></p>
				 		</div>
           	    	</div>
           	    </a>
           	</td>
            
        <!----------------------------------------------        HOME & FURNITURE       ---------------------------------------------->
            <td class="td" width="">
            	<a href="Categoery.jsp?from=61&&to=70"  onMouseOver="this.style.color='rgb(40,116,240)'" onMouseOut="this.style.color='black'"  style="text-decoration:none;color: black;">
            		<div class="dropdown">
            			Home & Furniture
            			<img src="images/navicon.PNG" alt="">
            			<div class="dropdown-content">
            					<!--------------------------------------       FURNITURE      --------------------------------->
								<p> <a href="Categoery.jsp?from=61&&to=65" style="text-decoration: none;"> 	Furniture 	     </a></p>
            				
            					<!-------------------------------------       FLOWER SEEDS      ------------------------------->
								<p> <a href="Categoery.jsp?from=66&&to=70" style="text-decoration: none;"> 	Flower Seeds 	 </a></p>
				 		</div>
           			</div>
            	</a>
            </td>
            
        <!--------------------------------------------        SPORTS,BOOKS AND MORE       ------------------------------------------->
            <td class="td" width="">
            	<a href="Categoery.jsp?from=71&&to=80"  onMouseOver="this.style.color='rgb(40,116,240)'" onMouseOut="this.style.color='black'"  style="text-decoration:none;color: black;">
            		<div class="dropdown">
            			Sports,Books & More 
            			<img src="images/navicon.PNG" alt="">
            			<div class="dropdown-content">
            					<!----------------------------------------       BOOKS      ----------------------------------->
								<p> <a href="Categoery.jsp?from=71&&to=75" style="text-decoration: none;"> 	Books </a><p>
            					
            					<!----------------------------------------       SPORTS      ---------------------------------->
								<p> <a href="Categoery.jsp?from=76&&to=80" style="text-decoration: none;"> 	Sports  </a><p>
				 		</div>
            		</div>
            	</a>
            </td>
            
        <!----------------------------------------------------        OFFERS       -------------------------------------------------->
            <td class="td" width="15%">
            	<a href="Categoery.jsp?from=31&&to=60"  onMouseOver="this.style.color='rgb(40,116,240)'" onMouseOut="this.style.color='black'"  style="text-decoration:none;color: black;">
            					<!----------------------------------------       OFFERS      ---------------------------------->
            						Offer Zone 
            	</a>
            </td>
        
        </tr>
    </table>

</div>

<!------------------------------------------------------------   FOR THIS PAGE  ----------------------------------------------------------->
  
    <table border="0" width="100%" style="background-color: white;border-top: 1px solid gray;">
    
		<tr>        
		     <td width="36%" style="text-align: center;">	
		            	
	        		<!-------------------------      PRODUCT IMAGE FETCHING FROM DATABASE      -------------------->
	        		
		            	<img src="images/<%= product.getImagePath() %>" style="height: 400px;max-width: 500px;">	<br>
		            	
		            	<br>
		            	<br>
		        
		        
		            <%if(c!=null){ %>	
	        	
	        		<!-----------------------------     ADD TO CART BUTTON     ------------------------------------>
							<a href="AddToCart">
				            	<button  type="submit"	style="margin-left: 20px;margin-right:7px;border-radius:3px;background-color: rgb(255,159,0);border:0px;color: white;width: 225px;height: 55px;font-size: 16px;font-weight: bold;">
				            		<img alt="" src="images/addToCart.PNG">ADD TO CART
				            	</button>
			            	</a>
	        		<!------------------------------------    BUY NOW BUTTON     ---------------------------------->
							<a href="BuyNow">
				            	<button type="submit" style="background-color: rgb(251,100,27);border-radius:3px;border:0px;color: white;width: 225px;height: 55px;font-size: 16px;font-weight: bold;">
				            		<img alt="" src="images/buyNow.PNG">BUY NOW
				            	</button>
			            	</a>
		            	<br><br><br><br><br><br><br><br>
		            	
		            <%} %>	
		   	</td>


	
	        <td width="50%">	
	        
	        	<div style="margin-left: 70px;">	
	        		
	        		<!-----------------------------     BRAND NAME (FROM DATABASE)     ---------------------------->
	        		
	        			<p style="color: gray;font-size: 15px;font-weight: bold;margin-top: 20px;"> <%= 	product.getBrandName()		%> </p>
			        
	        		<!---------------------------    PRODUCT NAME (FROM DATABASE)    ------------------------------>
			        
			        	<p style="font-size: 18px;"><%=		product.getName()	 %><p>
			        
	        		<!------------------         STAR RATING,RAVIEW,RATING (FROM DATABASE)         ---------------->
			        
				        <span style="background-color: rgb(56,142,60);color: white;border-radius: 3px;font-size: 12px;padding: 5px;"> <%= product.getStarRating() %> &#9734;	</span>&nbsp; 
				       	<span style="font-size: 17px;color: gray;font-weight: "> 	<%=  product.getRating() %>	 ratings and 	<%= product.getReviews() %> reviews</span>
				       	<img alt="" src="images/fassured.PNG">
			        
	        		<!----------------------------      SPECIAL RATING (FROM DATABASE)     ------------------------>
			        	
			        	<p style="color: green;font-size: 15px;"> Special price ends in less than 21h:06m:49s </p>

	        		<!------------------  PRICE,PREVIOUS PRICE AND OFFER DISCOUNT (FROM DATABASE)  ---------------->
				      
				        <font size="5"><b> &#8377;<%=		product.getPrice()		%></b></font> &nbsp;
				        <font color="grey" style="text-decoration: line-through;"><%=	previousPrice	%></font>&nbsp;
				        <font color="green" size="3">	<%=		product.getOffer()		%>	 % off</font>&nbsp;
				        <img alt="" src="images/exclamatary.PNG">
			       
			        	<br><br>
			        
	        		<!-------------------------     AVAILIABLE OFFERS (HARDCODED)     ----------------------------->
				        
				        <p style="font-weight: bold;font-size: 18px;">Available offers</p>
				        <p>
					        <img alt="" src="images/bankOfferSymbol.PNG">
					        <b>Bank Offer</b> 
					        5% Unlimited Cashback on Flipkart Axis Bank Credit Card
					        <b style="color: rgb(40,116,240);">T&C</b>
					    </p>    
				        
				        <p>
					        <img alt="" src="images/bankOfferSymbol.PNG">
					        <b>Bank Offer</b>
					        Flat &#8377;50/- Cashback as Flipkart gift voucher for first-time Transactions
					        <b style="color: rgb(40,116,240);">T&C</b>
					    </p>    
				        
				        <p>
					        <img alt="" src="images/bankOfferSymbol.PNG">
					        <b>Bank Offer</b> 
					        Extra 5% off* with Axis Bank Buzz Credit Card
					        <b style="color: rgb(40,116,240);">T&C</b>
					    </p>    
				        
				        <p>
					        <img alt="" src="images/bankOfferSymbol.PNG">
					        <b>Bank Offer</b> 
					        Get extra 5% off (price inclusive of discount)
					        <b style="color: rgb(40,116,240);">T&C</b>
					    </p>    
				        

	        		<!--------------------------     PRODUCT DETAILS (FROM DATABASE)     ------------------------->
	        		
						  <hr>
				          <h3 style="margin-right: 50px;font-weight: bold;">Product Details</h3>
						  <hr>
				          
				          <ul style="font-size:18px;">
				            <li style="padding: 10px;">		<%=  product.getDescription1()  %>		</li> 
				            <li style="padding: 10px;">		<%=  product.getDescription2()  %>		</li> 
				            <li style="padding: 10px;">		<%=  product.getDescription3()  %>		</li> 
				            <li style="padding: 10px;">		<%=  product.getDescription4()  %>		</li> 
				            <li style="padding: 10px;">		<%=  product.getDescription5()  %>		</li> 
				          </ul>

				          
	        		<!---------------------     PAYMENT OPTIONS (FETCHING EMI FROM DATABSE)     ------------------->

						  <hr>
					          <h3 style="font-size:17px;font-weight:bold;color: gray;">Easy Payment Options</h3>
						  <hr>
				          
				          <ul>
	    			            <li>No cost EMI starting from &#8377;	<%= emi  %>	/month</li>
				                <li>Cash on Delivery</li>
				                <li>Net banking & Credit/ Debit/ ATM card</li>
				                <br>    
				          </ul>
			          

			 	</div> 
	        </td>

	
	        <td width=15%> </td>
	        
	     </tr>
	        
    </table>
    
    <br>
    
	<!--------------------------     RETURN POLICY IMAGE (HARDCODED)     -------------------------->
	
    <img alt="" src="images/policy.PNG" style="width: 100%;">
    <br>
    
    
    
    
    
    
<!--------------------------------------------------------       FOR FOOTER     --------------------------------------------------------->

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