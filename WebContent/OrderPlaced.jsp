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


<!-------------------------          JAVA CODE FETCH CURRENT DATE AND CUSTOMER OBJECT         ---------------------------------------->
<%	
	//Fetching the Current Date of System
	LocalDate today = LocalDate.now(); 
	//Fetching The Date After 10 Days
	LocalDate afterTenDays = today.plusDays(10);
 
	String deliveryDate = today.toString();
	String returnDate = afterTenDays.toString();
	
	//Getting the Customer Object from Session
	Customer c=(Customer)session.getAttribute("customer");
	
	//If Customer Object is null,it will Redirect to index.jsp Page
		if(c==null){
		response.sendRedirect("index.jsp");
	}
	
%>

<!-----------------------------------------          ORDER SUCESSFULLY PLACED MASSEGE         ---------------------------------------->

<div style="background-color: white;width:600px;height: 550px;font-size: 20px;margin:50px 0px 0px 350px;padding: 20px 0px 0px 50px">
	
	 	<img alt="" src="images/orderPlaced.jpg" style="height: 70px;margin-left: 20px;" >
	 
	 <br><br>
	 <!-------------------------       CUSTOMER NAME        --------------------->
	 <span style="font-weight: bold;font-size: 20px;">Hi <%=c.getName() %>,</span>
	 <br><br><br>

   	 <span style="font-weight: bold;font-size: 20px;">Order Successfully placed.</span>
	 <br><br>

	 <!--------------------------       RETURN DATE        ---------------------->
	 <span>Your Order will be Delivered by <%=returnDate %>.</span>
	 <br><br>

	 We are Pleased to Confirm your  order no OD113237959885484000.
	 <br><br>

	 Thank you for  shopping with Flipkart!
	 <br><br>

	<a href="MyOrder.jsp">
	 <!------       VIEW ORDER BUTTON(Redirect to MyOrder.jsp PAGE        ------->
	 <button style="background-color:rgb(40,116, 240);border: 0px;width: 250px;height: 50px;color: white; font-weight: bold;border-radius: 3px;">
	 	View order
	 </button>
	</a>		

</div>




</body>
</html>