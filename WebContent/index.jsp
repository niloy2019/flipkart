<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!-------------------------------------------         IMPORTING JAVA CLASSES          --------------------------------------------->    
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
	
	<style>
		.z:hover{
    			transform: scale(1.1);
		}
	</style>
	
<!----------------------------------------------------      JavaScript Code      --------------------------------------------->

	<script src="flipkart.js"></script>

<!----------------------------------------------------      BootStrap Code       --------------------------------------------->
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    
    
	    
	    
<body   style="background-color: rgb(241,243,246);">

<div id="b">


<!-------------------------------------              CODE TO FETCH THE CUSTMER                --------------------------------------->

<div>
	<%	
		//Fetching the Customer object from the Session		
		Customer c=(Customer)session.getAttribute("customer");
		
		//Printing the Object in Console	
		System.out.println(c);
		
		String s=null;
		
		//Checikng if customer Object is null or not		
		if(c!=null){
			//If not null, then Stroing the Customer First Name into String s
			System.out.println(c.getName());
			String j=c.getName();
			String[] k=j.split(" ");
			s=k[0];
		}

	%>

<!--------------------------------------------------             HEADER            --------------------------------------------------->
    

    <table  style="background-color:rgb(40,116, 240) ;">
        <tr>
            <td width="12.5%"></td>
			<!--------------------------          flipkart logo         ---------------------------->
            <td align="right"><a href="" class="header"><img src="images/logo.PNG"></a></td>


			<!-----------------------------------        Search Bar        ----------------------------->
			<form action="Search.jsp" >
				<!--------------------------          Search Input Box         ------------------------->
	            <td><input type="text" name="search" class="input" placeholder="   Search for products, brands and more"></td>
	
	
				<!--------------------------          Search Button         ---------------------------->
	            <td> <button type="submit" style="padding: 0px;border: 0px;"><img  src="images/search.PNG" class="search"></button> </td>
			</form>


			<!--------------------------          Login Button         ----------------------------->
            <!---------- Without Logged in -------->
            <%if(s==null){ %>
	            <td class="loginPadding " >	 <a id="openLogin"> <button type="submit" class="login" onclick="return openLogin()">
	            	Login
	          	</button> </a> </td>
			<%}else{ %>
            <!-- -------- Logged in ---------------->
	            <td class="loginPadding " >	
	            	<span style="color: white;font-weight: bold;font-size: 18px;"><%=s %></span>
	             </td>
	             <td width="4%"></td>
			<%} %>			

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



<!--------------------------------------------------             NAVBAR            --------------------------------------------------->

<div>
    <table  width="100%" style="background-color: white;">
        
        <tr>
 
        <!-------------------------------------------        ELECTRONICS SECTION       --------------------------------------------->
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



<!------------------------------------------------             IMAGE SLIDER            ------------------------------------------------>

<div class="content" style="">

    <div class="container" style="width: 100%;padding:10px;">
    
        <div id="myCarousel" class="carousel slide" data-ride="carousel">
          <!-- Indicators -->
          <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
            <li data-target="#myCarousel" data-slide-to="3"></li>
            <li data-target="#myCarousel" data-slide-to="4"></li>
          </ol>
      
          <!-- Wrapper for slides -->
          <div class="carousel-inner">
            <div class="item active">
				<a href="Categoery.jsp?from=1&&to=5">            
              		<img src="images/slider1.PNG" alt="Los Angeles" style="width:100%;">
              	</a>
            </div>
      
            <div class="item">
            	<a href="Categoery.jsp?from=51&&to=60">   
              		<img src="images/slider2.PNG" alt="Chicago" style="width:100%;">
              	</a>
            </div>
          

            <div class="item">
                <a href="Categoery.jsp?from=1&&to=5">   
                	<img src="images/slider5.PNG" alt="New york" style="width:100%;">
                </a>
            </div>

            <div class="item">
                <a href="Categoery.jsp?from=31&&to=50">   
                	<img src="images/slider6.PNG" alt="New york" style="width:100%;">
                </a>	
            </div>

            <div class="item">
                <a href="Categoery.jsp?from=31&&to=60">   
                	<img src="images/slider7.PNG" alt="New york" style="width:100%;">
                </a>	
            </div>  
            
          </div>

          
      
          <!-- Left and right controls -->
          <a class="left carousel-control" href="#myCarousel" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
            <span class="sr-only">Previous</span>
          </a>
          <a class="right carousel-control" href="#myCarousel" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
            <span class="sr-only">Next</span>
          </a>
        </div>
        
      </div>
      
      
      
<!---------------------------------------             AVAILIABLE PRODUCTS IN STORE            ----------------------------------------->

<!-----------      JAVA CODE TO FETCH THE PRODUCTS FROM DATABASE         --------------->	
	
	<%
		//Creating Object of ProductDetailsDaoImpl Class
		ProductDetailsDaoImpl p=new ProductDetailsDaoImpl();

		//Getting all the Product List from Database
    	List<ProductDetails> list=p.getAll();
		
		//Printing all the Products in the console		
		System.out.println(list);
		
		//USING FOR LOOP FETCHING 5 PRODUCT OBJECTS AND PRINTING ALL 5 AS A ROW ,REPEATING THIS PROCESS USING FOR LOOP
		//THIS WILL PRINT ALL THE PRODUCT DETAILS FROM DATABSE TO BROWSER
		for(int i=0;i<list.size();i++){
			
			//Fetching 5 Products Object
			ProductDetails s1=list.get(i);
			ProductDetails s2=list.get(++i);
			ProductDetails s3=list.get(++i);
			ProductDetails s4=list.get(++i);
			ProductDetails s5=list.get(++i);
			
			//Getting the Ids of  Five Objects
			int p1=s1.getId();
			int p2=s2.getId();
			int p3=s3.getId();
			int p4=s4.getId();
			int p5=s5.getId();
			
			//Calculaiong the Prevous Price for 5 Products
			int previousPrice1=p.getPreviousPrice(s1.getPrice(), s1.getOffer());
			int previousPrice2=p.getPreviousPrice(s2.getPrice(), s2.getOffer());
			int previousPrice3=p.getPreviousPrice(s3.getPrice(), s3.getOffer());
			int previousPrice4=p.getPreviousPrice(s4.getPrice(), s4.getOffer());
			int previousPrice5=p.getPreviousPrice(s5.getPrice(), s5.getOffer());
	    	
			//Printing the Details of the 5 Products in console
	    	System.out.println(s1);
	    	System.out.println(s2);
	    	System.out.println(s3);
	    	System.out.println(s4);
	    	System.out.println(s5);
	    
	%>   
	
<!-----------------------       HTML CODE FOR 1 ROW OF PRODUCTS          -------------------------------------->	


	<div id="navbar"  style="background-color: white;margin-top: 50px;padding-bottom: 30px;">
   
        <table border="0" width="100%" bgcolor="white">
			  
			  <!------------------------      CATEGOERY OF 5 THE PRODUCTS        ----------------------------->	
		       <tr>
		          	   <td colspan="5" ><h2 style="padding-left: 50px;"><%=s1.getCategory() %></h2><hr></td>
		       </tr>
		       
			  <!-------------------------         IMAGE OF THE 5 PRODUCTS        ----------------------------->	
		       <tr >
				       <th style="text-align: center;padding-bottom: 20px;"><a href="Product.jsp?id=<%=p1%>"><img src="images/<%= s1.getImagePath() %>" alt=""  style="height:150px;margin-bottom:20px;transition: 0.5s;" class="z"></a></th>
				       <th style="text-align: center;"><a href="Product.jsp?id=<%=p2%>"><img src="images/<%= s2.getImagePath() %>" alt=""  style="height:150px;margin-bottom:20px;transition: 0.5s;" class="z"></a></th>
				       <th style="text-align: center;"><a href="Product.jsp?id=<%=p3%>"><img src="images/<%= s3.getImagePath() %>" alt=""  style="height:150px;margin-bottom:20px;transition: 0.5s;" class="z"></a></th>
				       <th style="text-align: center;"><a href="Product.jsp?id=<%=p4%>"><img src="images/<%= s4.getImagePath() %>" alt=""  style="height:150px;margin-bottom:20px;transition: 0.5s;" class="z"></a></th>
				       <th style="text-align: center;"><a href="Product.jsp?id=<%=p5%>"><img src="images/<%= s5.getImagePath() %>" alt=""  style="height:150px;margin-bottom:20px;transition: 0.5s;" class="z"></a></th>
		       </tr>
		     
			  <!----------------------------         NAME OF THE 5 PRODUCTS        --------------------------->	
		       <tr>  
		       		<td style="width:20% ;text-align: center;font-size: 17px;padding-right: 20px;"> 
		       			<a onMouseOver="this.style.color='rgb(40,116,240)'" onMouseOut="this.style.color='black'"  style="text-decoration:none;color: black;" href="Product.jsp?id=<%=p1%>">  
		       				<%= s1.getName() %>
		       			</a>
		       		</td>
		       		
		       		<td style="width:20%;text-align: center;font-size: 17px;padding-right: 20px;"> 
		       			<a onMouseOver="this.style.color='rgb(40,116,240)'" onMouseOut="this.style.color='black'"  style="text-decoration:none;color: black;" href="Product.jsp?id=<%=p2%>">  
		       				<%= s2.getName() %>
		       			</a>
		       		</td>
		       		
		       		<td style="width:20%;text-align: center;font-size: 17px;padding-right: 20px;"> 
		       			<a onMouseOver="this.style.color='rgb(40,116,240)'" onMouseOut="this.style.color='black'"  style="text-decoration:none;color: black;" href="Product.jsp?id=<%=p3%>">  
		       				<%= s3.getName() %>
		       			</a>
		       		</td>
		       		
		       		<td style="width:20%;text-align: center;font-size: 17px;padding-right: 20px;"> 
		       			<a onMouseOver="this.style.color='rgb(40,116,240)'" onMouseOut="this.style.color='black'"  style="text-decoration:none;color: black;" href="Product.jsp?id=<%=p4%>">  
		       				<%= s4.getName() %>
		       			</a>
		       		</td>
		       		
		       		<td style="width:20%;text-align: center;font-size: 17px;padding-right: 20px;"> 
		       			<a onMouseOver="this.style.color='rgb(40,116,240)'" onMouseOut="this.style.color='black'"  style="text-decoration:none;color: black;" href="Product.jsp?id=<%=p5%>">  
		       				<%= s5.getName() %>
		       			</a>
		       		</td>
		       
		       </tr>
		       
		       
			  <!--------------------        STAR,RATING AND REVIEWS OF 5 PRODUCTS       ---------------------->	
		       <tr>
			            <td style="text-align: center;padding-bottom: 5px;padding-top: 10px;">
			            	<span style="background-color: green;color: white;border-radius: 3px;font-size: 12px;padding: 4px;"> <%= s1.getStarRating() %> &#9734;	</span>&nbsp;
		       				<span style="color: gray;font-weight: bold;padding: 10px;">(<%= s1.getRating() %>)</span>
			            </td>  
			            
			            <td style="text-align: center;">
			            	<span style="background-color: green;color: white;border-radius: 3px;font-size: 12px;padding: 4px;"> <%= s2.getStarRating() %> &#9734;	</span>&nbsp;
		       				<span style="color: gray;font-weight: bold;padding: 10px;">(<%= s2.getRating() %>)</span>
			            </td>  
			            
			            <td style="text-align: center;">
			            	<span style="background-color: green;color: white;border-radius: 3px;font-size: 12px;padding: 4px;"> <%= s3.getStarRating() %> &#9734;	</span>&nbsp;
		       				<span style="color: gray;font-weight: bold;padding: 10px;">(<%= s3.getRating() %>)</span>
			            </td>  
			            
			            <td style="text-align: center;">
			            	<span style="background-color: green;color: white;border-radius: 3px;font-size: 12px;padding: 4px;"> <%= s4.getStarRating() %> &#9734;	</span>&nbsp;
		       				<span style="color: gray;font-weight: bold;padding: 10px;">(<%= s4.getRating() %>)</span>
			            </td>  
			            
			            <td style="text-align: center;">
			            	<span style="background-color: green;color: white;border-radius: 3px;font-size: 12px;padding: 4px;"> <%= s5.getStarRating() %> &#9734;	</span>&nbsp;
		       				<span style="color: gray;font-weight: bold;padding: 10px;">(<%= s5.getRating() %>)</span>
			            </td>  

		       </tr>
		       

		       
			  <!-----------------         PRICE,OFFER AND PREVOUS PRICE OF 5 PRODUCS       ------------------->	
		       <tr>
			            <td style="text-align: center;">
			            	<span style="font-size: 16px;"><b> &#8377; <%=s1.getPrice() %> </b></span> &nbsp;
				    	    <span style="text-decoration: line-through;color: gray;">&#8377; <%=previousPrice1 %></span>&nbsp;
				    	    <span  style="color: green;font-size:12px; ;">	<%= s1.getOffer() %> % off   </span>
			            </td>
			            
			            <td style="text-align: center;">
			            	<span style="font-size: 16px;"><b> &#8377; <%=s2.getPrice() %> </b></span> &nbsp;
				    	    <span style="text-decoration: line-through;color: gray;">&#8377; <%=previousPrice2 %></span>&nbsp;
				    	    <span  style="color: green;font-size:12px; ;">	<%= s2.getOffer() %> % off   </span>
			            </td>
			            
			            <td style="text-align: center;">
			            	<span style="font-size: 16px;"><b> &#8377; <%=s3.getPrice() %> </b></span> &nbsp;
				    	    <span style="text-decoration: line-through;color: gray;">&#8377; <%=previousPrice3 %></span>&nbsp;
				    	    <span  style="color: green;font-size:12px; ;">	<%= s3.getOffer() %> % off   </span>
			            </td>
			            
			            <td style="text-align: center;">
			            	<span style="font-size: 16px;"><b> &#8377; <%=s4.getPrice() %> </b></span> &nbsp;
				    	    <span style="text-decoration: line-through;color: gray;">&#8377; <%=previousPrice4 %></span>&nbsp;
				    	    <span  style="color: green;font-size:12px; ;">	<%= s4.getOffer() %> % off   </span>
			            </td>
			            
			            <td style="text-align: center;">
			            	<span style="font-size: 16px;"><b> &#8377; <%=s5.getPrice() %> </b></span> &nbsp;
				    	    <span style="text-decoration: line-through;color: gray;">&#8377; <%=previousPrice5 %></span>&nbsp;
				    	    <span  style="color: green;font-size:12px; ;">	<%= s5.getOffer() %> % off   </span>
			            </td>
		       </tr>
		       
    </table>
   
   </div>
   

<%} %>





<!---------------          COVID-19 INFORMATION LINK        ----------------->

<div style="padding: 50px 0px 50px 0px">
		<a href="https://www.mohfw.gov.in/?otracker=hp_banner_1_COVID-19">
			<img alt="" src="images/GovtAdvisory.PNG">
		</a>
</div>







<!------------------------------------------------------           For Footer           --------------------------------------------->




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
</div>
</div>

  
				    



<!--------------------------------------------------            POPUP LOGIN              ---------------------------------------------->



<div style="display: none;border-radius: 10px;" class="Login" id="login" >

		<div class="col-sm-6 a" style="position: absolute; top :9%;left: 27%;justify-content: right; align-items: center;border-radius: 5px;background-image:url('images/login.PNG');background-repeat:no-repeat;height: 520px;width: 18%;"> </div>

		
		<div class="col-sm-6 container c" style=" height:518px;float:right;position: absolute;top :9%;left: 45.1%;justify-content: right;background-color:white;border-radius: 10px;align-items: center;width: 30%;padding-top: 50px;">
				<!-----     FORM FOR LOGIN  -------->	  
		        <form  action="Login">
		  
					     <!-----------        EMAIL/MOBILE INPUT        ---------------->	  
				          <div class="form-group">
				            <label style=" color: grey;font-size: 14px;">Enter Email/Mobile Number</label>
				            <input type="text" required="required"	class="form-control "  name="emailOrMobile" style="width: 350px;">
				          </div>
				  
				  
					     <!---------------       PASSWORD INPUT        ----------------->	  
				          <div class="form-group">
				            <label style=" color: grey;font-size: 14px;">Enter Password</label>
				            <input type="password" required="required" class="form-control f"  name="password" style="width: 350px;">
				          </div>
				  
				          <br><br>
				  
					     <!----------------        LOGIN BUTTON      -------------------->	  
				          <button type="submit" style="width: 350px;height: 48px;background-color: rgb(251, 100, 27);color: white;font-size: 18px;" >
				          	Login
				          </button>
		        </form>
		  
		        <br>

				<!-----------------        PRINTING "OR"       ----------------->	  
		        <p style="margin-left: 167px;font-size: 18px;color: grey;">     OR     </p> <br><br>


				<!------------     BUTTON TO OPEN SIGN UP FORM    ----------->	  
		        <a  onclick="return openSignup()" style="text-decoration: none;cursor: pointer;"> 
		        	<p style="margin-left: 30px;color:rgb(65, 132, 242);font-size: 18px;">New to Flipkart? Create an account</p>
		        </a>  
		
		
		</div>  
		
		<!------------     CLOSING BURRON FOR LOGIN POPUP    ----------->	  
		<div style="position: absolute;top: 6%;right:23%;font-size: 55px;color: #333;transform: rotate(45deg);cursor: pointer;">	
			<a onclick="return closeLogin()" style="text-decoration: none;color: black;">+</a>	
		</div>
		
</div>






<!------------------------------------------------------            SIGN UP         -------------------------------------------------->



<div style="display: none;" class="signip" id="signup">

		<div class="col-sm-6 b" style="position: absolute; top :9%;left: 27%;justify-content: right; align-items: center;border-radius: 5px;background-image:url('images/signup.PNG');background-repeat:no-repeat;height: 520px;width: 18%;"></div>

		
		<div class="col-sm-6 container c" style=" height:518px;float:right;position: absolute;top :9%;left: 45.1%;justify-content: right;background-color:white;border-radius: 10px;align-items: center;width: 30%;padding-top: 50px;padding-top: 5px;">
		  
		  		<br>
				<!------------     SIGN UP FORM    ----------->	  
			    <form action="AddCustomer">
			            
			            <div class="form-group">
			              <label>Name</label>
			              <input type="text" required="required" class="form-control "  name="name" style="width: 350px;">
			            </div>
			          
						<!---------------------        EMAIL       ------------------>	  
			            <div class="form-group">
			              <label>Email</label>
			              <input type="email" required="required" class="form-control " name="email" style="width: 350px;">
			            </div>
			
			
						<!---------------------        MOBILE       ------------------->	  
			            <div class="form-group">
			                <label>Mobile</label>
			                <input type="number" required="required" class="form-control " name="mobile" style="width: 350px;">
			            </div>

						<!-------------------        PASSWORD       ----------------->	  
			            <div class="form-group">
			              <label>Password</label>
			              <input type="password" required="required" class="form-control " name="password" style="width: 350px;">
			            </div>
						
						<br>
												          
						<!--------------        SUBMIT BUTTON       ------------------>	  
			            <button type="submit" style="width: 350px;height: 48px;background-color: rgb(251, 100, 27);color: white;font-size: 18px;">Submit</button>
	          
	          </form>
			  
			  <br>
			  
			 <!----------------        PRINTING "OR"      ----------------->	  
			 <p style="margin-left: 167px;font-size: 18px;color: grey;" >	  OR	</p>
		
			 <!---------        BUTTTON TO OPEN LOGIN FORM       ---------->	  
		     <button   onclick="return openLogin()" style="width: 350px;height: 48px;font-size: 18px;background-color: white;color: rgb(40,116,240);box-shadow: 10px 10px 8px #888888;">
		     	Existing User? Log in 
		     </button>
			
		</div>
		  
	    <!-------        BUTTON TO CLOSE SIGNUP POPUP      ----------->	  
		<div style="position: absolute;top: 6%;right:23%;font-size: 55px;color: #333;transform: rotate(45deg);cursor: pointer;">	
			<a onclick="return closeSignup()" style="text-decoration: none;">+</a>	
		</div>
		
</div>
	
</body>
</html>