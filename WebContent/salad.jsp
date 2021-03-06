<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=utf-8" %>
 <%@page import="com.hajar.zaki.model.Customer, com.hajar.zaki.dao.SupplierDAO,  com.hajar.zaki.dao.CustomerDAO, com.hajar.zaki.model.Supplier "%>
<%@ page import=" java.io.UnsupportedEncodingException,com.hajar.zaki.dao.UserDAO, com.hajar.zaki.dao.UserDAOImpl,
 				  com.hajar.zaki.model.User , utils.*, java.sql.*, java.util.*,com.hajar.zaki.dao.ProductDAO, com.hajar.zaki.model.Product,
 				  com.hajar.zaki.db.DBConnect, com.hajar.zaki.model.ProductPicture, com.hajar.zaki.dao.PicturesDao,
				  com.hajar.zaki.dao.ProductCustomerDAO,com.hajar.zaki.model.ProductCustomer, 
				 com.hajar.zaki.dao.OrderDAO,  com.hajar.zaki.model.Order ,  java.io.*, java.util.Base64" %>
 				  
 				  
<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
<title>salad</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="Little Closet template">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="view/styles/bootstrap-4.1.2/bootstrap.min.css">
<link href="view/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="view/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="view/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="view/plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" type="text/css" href="view/styles/category.css">
<link rel="stylesheet" type="text/css" href="view/styles/category_responsive.css">
<link rel="stylesheet" type="text/css" href="view/styles/global.css">
<link href="https://fonts.googleapis.com/css?family=Alef&display=swap" rel="stylesheet">



<link rel="stylesheet"href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

  <link href="view/css/jquery-ui.css" rel="stylesheet">
  <script src="view/js/jquery-1.11.2.js"></script>
  <script src="view/js/jquery-ui.js"></script>
<style>
.btn {
  border: 0px solid black;
  background-color: white;
  color: black;
  padding: 6px 16px;
  font-size: 12px;
  cursor: pointer;
}


</style>
</head>
<body>

			 <%

				String userName = "";
				String password = "";
				String email = "";
				String jspName = "salad.jsp";
				/* Get below data from HttpSession. */
	
				Object userNameObj = session.getAttribute("userName");
				Object emailObj = session.getAttribute("email");
				boolean sup = false;
				User user = new User ();
				UserDAOImpl userdao = new UserDAOImpl();
				SupplierDAO supdao = new SupplierDAO();
				CustomerDAO customerdao = new CustomerDAO();
				ArrayList<Supplier> suppliers = supdao.getAllSuppliers();
				ArrayList<Customer> customers = (ArrayList<Customer>) customerdao.getAllOfObjects();
				ArrayList<Order> orders = new ArrayList<>();
				OrderDAO orderdao= new OrderDAO();


				if(userNameObj!=null){
					userName = (String)userNameObj;
				}
				
				if(emailObj!=null){
					email = (String)emailObj;
					orders= orderdao.getOrderdPerCustomer(email);


					for(Supplier s : suppliers){

						if(s.getUserMail().equals(email)){
							sup = true;
							System.out.print("include the supplier "+ suppliers.contains((email)) +"  test ");
							break;
						}
					}
						for(Customer cus : customers){
							if(cus.getUserMail().equals(email)){
								sup = false;
								break;
							}
						}
				}
			
			%>
			
<!-- Menu -->


<div class="menu">

	<!-- Search -->
	<div class="menu_search">
		<form action="#" id="menu_search_form" class="menu_search_form">
			<button class="menu_search_button"><img src="view/images/search.png" alt=""></button>
			<input type="text" class="search_input" placeholder="חפש משהו טעים" required="required">
		</form>
	</div>
	<!-- Navigation -->
	<div class="menu_nav">
		<ul>
		            <li ><a href="category.jsp?userName=<%=userName%>&email=<%=email%>">מנה ראשונה </a></li>
					<li><a href="mainCourse.jsp?userName=<%=userName%>&email=<%=email%>">מנה עיקרית</a></li>
					<li><a href="sweet.jsp?userName=<%=userName%>&email=<%=email%>">קינוח</a></li>
					<li class="active" ><a href="salad.jsp?userName=<%=userName%>&email=<%=email%>"  >סלט</a></li>
		</ul>
	</div>
	<!-- Contact Info -->
	<div class="menu_contact">
		<div class="menu_phone d-flex flex-row align-items-center justify-content-start">
		</div>
		<div class="menu_social">
			<ul class="menu_social_list d-flex flex-row align-items-start justify-content-start">
				<li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
				<li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
			</ul>
		</div>
	</div>
</div>

<div class="super_container">

	<!-- Header -->

	<header class="header">
		<div class="header_overlay"></div>
		<div class="header_content d-flex flex-row align-items-center justify-content-start">
			
			<div class="logo">
				 <form action="<%=request.getContextPath()%>LIServlet">
				 <a href="index.jsp">
					<div class="d-flex flex-row align-items-center justify-content-start">
						<div class=""><img src="view/images/logo5.png" alt="" height="80" width="130"></div>
					</div>
				</a></form>
			</div>
		<div class="header_right d-flex flex-row align-items-center justify-content-start ml-auto">

			<div class="hamburger"><i class="fa fa-bars" aria-hidden="true"></i></div>
			<nav class="main_nav">
				<ul class="d-flex flex-row align-items-start justify-content-start">
					
					<li ><a href="category.jsp?userName=<%=userName%>&email=<%=email%>">מנה ראשונה </a></li>
					<li><a href="mainCourse.jsp?userName=<%=userName%>&email=<%=email%>">מנה עיקרית</a></li>
					<li><a href="sweet.jsp?userName=<%=userName%>&email=<%=email%>">קינוח</a></li>
					<li class="active" ><a href="salad.jsp?userName=<%=userName%>&email=<%=email%>"  >סלט</a></li>
					
					</ul>
			</nav>

		</div>
		
		       <!-- Search -->
				<div class="header_search">
					<form action="#" id="header_search_form">
						<button class="header_search_button"><img src="view/images/search.png" alt=""></button>
						<input type="text" class="search_input" placeholder="חפש משהו טעים" required="required">
					</form>
				</div>
		       <!-- Phone -->
				<div class="header_phone d-flex flex-row align-items-center justify-content-start"></div>
				<!-- Cart -->
				 <% if(!userName.equals("")){
					 if(!sup){	 %>
					  <div  class="user">
				   <div class="user">
				    <a href="cart.jsp">
				     <div><img src="view/images/cart.svg" alt="https://www.flaticon.com/authors/freepik" >
				    <% if(orders.size() > 0){ %>
				    <div><%= orders.size()%></div>
				    <%} %></div></a>
					<div id="userName" style="color:black;"> </div>
					</div>
				  </div >
				 <% } } else { %>
				     <div class="cart">
				 <a href="login.jsp">
				    <div>
				     <img class="svg" src="view/images/cart.svg" alt="https://www.flaticon.com/authors/freepik">
				     </div></a></div>
				 <% }%>
				 
							<!-- User -->
				<c:if test="${empty userName}">
				
				<div id="userlogin" class="user">
				<div class="user"><a href="login.jsp">
				<div><img src="view/images/user.svg" alt="https://www.flaticon.com/authors/freepik" >
				</div></a>
				<div id="userName" style="color:black;"> 
						<%= userName  %> </div>
				</div>
				 
			  </div >
			  </c:if>
			 
				<c:if test="${not empty userName}">
			 <a href="chat.jsp?pageJsp=index" 
			 	class="btn btn-sm btn-outline-light text-dark  waves-effect" 
			 	 style="border: none; background-color: transparent;" >
					<span> <small><i class="far fa-comments" 
					                 style="font-size: 25px;border: none; background-color: transparent;"> צ'אט</i></small>
					</span>
		     </a>
			<%
			               String imageBase641="";
							  if( user != null && user.getImage() != null ){
								   imageBase641 = new String(Base64.getEncoder().encode(( user.getImage())));
									  if(imageBase641 !=null ){%>
										 <img src="data:image/jpeg;base64,<%=imageBase641%>"  style="border-radius:30%; border: none; height: 30px; width :30px;" />
									  <%}} else{%>
										<img  alt="" src="view/images/none.jpg" style="border-radius:30%; border: none; height: 30px; width :30px;"> 
										 <%}%>
			 <div class="dropdown">
			     <button type="button" class="btn dropdown-toggle" style="border: none; background-color: transparent;" data-toggle="dropdown">
			       	<%= userName  %> 
			  		  </button>
			    <div class="dropdown-menu">
			      <div >
				    <% if (sup){  
				    %>
				         <a  style="border: none; background-color: transparent;"
				          class="active btn btn-sm btn-outline-light text-dark  waves-effect"  
			              href="sellerProfile.jsp?email=<%= email%>"> פרופיל </a>
				    <%}else{%>    
				      <a   style="border: none; background-color: transparent;"
				          class="active btn btn-sm btn-outline-light text-dark  waves-effect"  
			              href="customerProfile.jsp?email=<%= email%>"> פרופיל </a>
				    <%}%>
			     </div>
			       <hr>
						<form action="<%=request.getContextPath()%>/LogoutServlet">
						  <button class="btn btn-sm btn-outline-light text-dark  waves-effect" id="userName" >
									 צא - سجل الخروج
						   </button >
						  </form>
					</div>
			    </div>
			  
 			</c:if>
 			</div>
	</header>
	
	<div class="super_container_inner">
		<div class="super_overlay"></div>

		<!-- Home -->

		<div class="home">
			<div class="home_container d-flex flex-column align-items-center justify-content-end">
				<div class="home_content text-center">
					<div class="home_title">סלט</div>
					<div class="breadcrumbs d-flex flex-column align-items-center justify-content-center">
					</div>
				</div>
			</div>
		</div>

		<!-- Products -->

		<div class="products">
			<div class="container">
				<div class="row products_bar_row">
					<div class="col">
					    <div class="products_bar d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-lg-start justify-content-center">
							<div class="products_bar_links">
								<ul class="d-flex flex-row align-items-start justify-content-start">
									<li class="active"><a href="#">מוצרים חדשים</a></li>
									<li><a href="#">הכל</a></li>
									<li><a href="#">הכי פפולרי</a></li>
									<li><a href="#">מוצרים במבצע</a></li>
								</ul>
							</div>
							<div class="products_bar_side d-flex flex-row align-items-center justify-content-start mr-lg-auto">
								<div class="products_dropdown product_dropdown_sorting">
									<div class="isotope_sorting_text"><span>מין תוצאה </span><i class="fa fa-caret-down" aria-hidden="true"></i></div>
									<ul>
										<li class="item_sorting_btn" data-isotope-option='{ "sortBy": "original-order" }'>רגיל</li>
										<li class="item_sorting_btn" data-isotope-option='{ "sortBy": "price" }'>לפי מחיר</li>
										<li class="item_sorting_btn" data-isotope-option='{ "sortBy": "name" }'>לפי שם</li>
									</ul>
								</div>
								<div class="product_view d-flex flex-row align-items-center justify-content-start">
									<div class="view_item active"><img src="view/images/view_1.png" alt=""></div>
									<div class="view_item"><img src="view/images/view_2.png" alt=""></div>
									<div class="view_item"><img src="view/images/view_3.png" alt=""></div>
								</div>
								<div class="products_dropdown text-right product_dropdown_filter">
									<div class="isotope_filter_text"><span>סינון </span><i class="fa fa-caret-down" aria-hidden="true"></i></div>
									<ul>
										<li class="item_filter_btn" data-filter="*">הכל</li>
										<li class="item_filter_btn" data-filter=".hot">פפולקי</li>
										<li class="item_filter_btn" data-filter=".new">חדש</li>
										<li class="item_filter_btn" data-filter=".sale">במבצע</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				<% if(email != null && sup){ %>
					<div class="row products_row ">
					
					<% 
					ProductDAO prodDao=new ProductDAO();
					ArrayList<Product> salads_sup = prodDao.getAllSalads_SUP(email);
					int valuesLength=salads_sup.size()-1;
				    InputStream sImage;
					int index_Prod=0;
				    for(index_Prod=0; index_Prod<=valuesLength;index_Prod++){
					  PicturesDao picDao= new PicturesDao();
					  ProductPicture prodPic = picDao.getPicturePerProductId(salads_sup.get(index_Prod).getProdID());
					  String imageBase64="";
					  if(prodPic != null && prodPic.getImg()!= null){
						  System.out.print("test into index img " + imageBase64);
						  imageBase64 = new String(Base64.getEncoder().encode((prodPic.getImg())));

					  }	
					  
				  %>
					  
					  <!-- Product -->
					<div class="col-xl-4 col-md-6">
						<div class="product">
							<div class="product_image">
							<% if(imageBase64 !=null ){%>
							  <img style="border-radius: 10%;height: 260px; width:500px" src="data:image/jpeg;base64,<%=imageBase64%>"  />
							  <% } %>
							</div>
							<div class="product_content">
								<div class="product_info d-flex flex-row align-items-start justify-content-start">
									<div>
										<div>
											<div class="product_name"><a href="product.jsp?value=<%=salads_sup.get(index_Prod).getProdID()%>">
											 <% 
										        out.println(salads_sup.get(index_Prod).getName() ); %> </a></div>
											<div class="product_category">המחיר / السعر  </div>
										</div>
									</div>
									<div class="ml-auto text-right">
										<!-- div class="rating_r rating_r_4 home_item_rating"><i></i><i></i><i></i><i></i><i></i></div-->
										<div class="product_price text-right">₪<%out.println(salads_sup.get(index_Prod).getPiece_price() ); %> </div>
									</div>
								</div>
								
							</div>
						</div>
					</div> 
					
				  <% }
				%>
				</div>
				<% }else{
					 if(email != null && !sup) { 
				%>
				<div class="row products_row ">
					
					 <% 
					ProductDAO prodDao=new ProductDAO();
					ArrayList<Product> salads= prodDao.getAllSalads();
					int valuesLength=salads.size()-1;
				    InputStream sImage;
					int index_Prod=0;
				    for(index_Prod=0; index_Prod<=valuesLength;index_Prod++){
					  PicturesDao picDao= new PicturesDao();
					  ProductPicture prodPic = picDao.getPicturePerProductId(salads.get(index_Prod).getProdID());
					  String imageBase64="";
					  if(prodPic != null && prodPic.getImg()!= null){
						  System.out.print("test into index img " + imageBase64);
						  imageBase64 = new String(Base64.getEncoder().encode((prodPic.getImg())));
						  System.out.print("test num 2 into index img " + imageBase64);
					  }	
				  %>
					  <!-- Product -->
					<div class="col-xl-4 col-md-6">
						<div class="product">
							<div class="product_image">
							<% if(imageBase64 !=null ){%>
							  <img style="border-radius: 10%;height: 260px; width:500px"  src="data:image/jpeg;base64,<%=imageBase64%>"  />
							  <% } %>
							</div>
							<div class="product_content">
								<div class="product_info d-flex flex-row align-items-start justify-content-start">
									<div>
										<div>
											<div class="product_name"><a href="product.jsp?value=<%=salads.get(index_Prod).getProdID()%>"> <% 
										     out.println(salads.get(index_Prod).getName() ); %> </a></div>
											<div class="product_category">המחיר / السعر  </div>
										</div>
									</div>
									<div class="ml-auto text-right">
										<!-- div class="rating_r rating_r_4 home_item_rating"><i></i><i></i><i></i><i></i><i></i></div-->
										<div class="product_price text-right">₪<%out.println(salads.get(index_Prod).getPiece_price() ); %> </div>
									</div>
								</div>
								<%  if( salads.get(index_Prod) != null){
								      ProductCustomerDAO pcdao = new ProductCustomerDAO(); 
									  ProductCustomer pc = new ProductCustomer(); 
									  pc = pcdao.getProductLike(salads.get(index_Prod).getProdID(),email);
									  if(pc != null && pc.getLike()==1){
								%>
								<div class="product_buttons">
									<div class="text-right d-flex flex-row align-items-start justify-content-start">
										<div class="product_button product_cart text-center d-flex flex-column align-items-center justify-content-center" >
										<div><div>
										 <a  href="product.jsp?value=<%=salads.get(index_Prod).getProdID() %>" style="font-size:32px;border:none; background-repeat:no-repeat;background: transparent; ">  
   														<img alt="" src="view/images/cart.svg"><br>
   										</a> 
										<br></div></div>
										</div>
										<div class="product_button product_fav text-center d-flex flex-column align-items-center justify-content-center">
											<div><div>
											<i class="fa fa-heart" style="font-size:36px;color:red"></i></div></div>
										</div>
									</div>
								</div>
								<%}else{%>
								<div class="product_buttons">
									<div class="text-right d-flex flex-row align-items-start justify-content-start">		
										<div class="product_button product_cart text-center d-flex flex-column align-items-center justify-content-center" >
										<div><div>
										<form action=""  method="post">
										<input type="hidden" value="<%= email %>" name="mailCus">
						                <input type="hidden" value="<%=  salads.get(index_Prod).getProdID()%>" name="prod_id">
										<input type="hidden" value=<%= jspName %> name="jspPage" >	
									    <a href="product.jsp?value=<%=salads.get(index_Prod).getProdID()%>"  
											         style="font-size:32px;border:none; background-repeat:no-repeat;background: transparent; ">  
   														<img alt="" src="view/images/cart.svg">
   											 </a></form>
										</div></div>
										</div>
										<div class="product_button product_fav text-center d-flex flex-column align-items-center justify-content-center">
											<div><div>
											      <form action="<%=request.getContextPath()%>/LikeProductServlet" method="post">
											        <input type="hidden" value="<%= email %>" name="mailCus">
						                            <input type="hidden" value="<%= salads.get(index_Prod).getProdID()%>" name="prodidLiked">
						                            <input type="hidden" value=<%= jspName %> name="jspPage" >											         
											         <button  type="submit" value="" 
											         style="font-size:32px;border:none; background-repeat:no-repeat;background: transparent; ">  
   														<img alt="" src="view/images/heart_2.svg">
   														 </button>											        
											      </form>	
											      <br>										      
											     </div></div>
										</div>
									</div>
								</div>
								 <% } } %>
							</div>
						</div>
					</div> 
			<%  } }else{ %>
			</div>
		
		 <div class="row products_row ">
					
					<% 
					ProductDAO prodDao=new ProductDAO();
					ArrayList<Product> salads= prodDao.getAllSalads();
					int valuesLength=salads.size();
				    InputStream sImage;
					int index_Prod=0;
				    for(index_Prod=0; index_Prod<valuesLength;index_Prod++){
					  PicturesDao picDao= new PicturesDao();
					  ProductPicture prodPic = picDao.getPicturePerProductId(salads.get(index_Prod).getProdID());
					  String imageBase64="";
					  if(prodPic != null && prodPic.getImg()!= null){
						  System.out.print("test into index img " + imageBase64);
						  imageBase64 = new String(Base64.getEncoder().encode((prodPic.getImg())));

					  }	
					  
				  %>
					  
					  <!-- Product -->
					<div class="col-xl-4 col-md-6">
						<div class="product">
							<div class="product_image">
							<% if(imageBase64 !=null ){%>
							  <img style="border-radius: 10%;height: 260px; width:500px" src="data:image/jpeg;base64,<%=imageBase64%>"  />
							  <% } %>
							</div>
							<div class="product_content">
								<div class="product_info d-flex flex-row align-items-start justify-content-start">
									<div>
										<div>
											<div class="product_name"><a href="product.jsp?value=<%=salads.get(index_Prod).getProdID()%>">
											 <% 
										        out.println(salads.get(index_Prod).getName() ); %> </a></div>
											<div class="product_category">המחיר / السعر  </div>
										</div>
									</div>
									<div class="ml-auto text-right">
										<!-- div class="rating_r rating_r_4 home_item_rating"><i></i><i></i><i></i><i></i><i></i></div-->
										<div class="product_price text-right">₪<%out.println(salads.get(index_Prod).getPiece_price() ); %> </div>
									</div>
								</div>
								<div class="product_buttons">
									<div class="text-right d-flex flex-row align-items-start justify-content-start">										
										
										<div class="product_button product_cart text-center d-flex flex-column align-items-center justify-content-center" >
										<div><div>
										<form action="login.jsp" >
											 <button  type="submit" value="" 
											         style="font-size:32px;border:none; background-repeat:no-repeat;background: transparent; ">  
   														<img alt="" src="view/images/cart.svg">
   											 </button>
											</form>
											<br>
										</div></div>
										</div>	
										<div class="product_button product_fav text-center d-flex flex-column align-items-center justify-content-center">
											<div><div>
											<form action="login.jsp" >
											 <button  type="submit" value="" 
											         style="font-size:32px;border:none; background-repeat:no-repeat;background: transparent; ">  
   														<img alt="" src="view/images/heart_2.svg">
   														 </button>
											</form>
											<br></div></div>
										</div>									
									</div>
								</div>
							</div>
							
						</div>
						
					</div> 
					
				  <% }%>
				 
				</div>
				 
				  <% } }%>
				</div>
			</div>

		<!-- Footer -->

		<footer class="footer">
			<div class="footer_content">
				<div class="container">
					<div class="row">

						<!-- About -->
						<div class="col-lg-4 footer_col">
							<div class="footer_about">
								<div class="footer_logo">
									 <form action="<%=request.getContextPath()%>LIServlet">
									 <a href="index.jsp">
										<div class="d-flex flex-row align-items-center justify-content-start">
											<div><img src="view/images/logo5.png" alt="" height="80" width="130"></div>
										</div>
									</a></form>
								</div>
								<div  dir="rtl" class="footer_about_text text-center"">
									<p>זאכי מעניקה לך מגוון רחב של מנות טעימות, אנחנו מאמינים כי כל אחד מגיע לו אוכל  ביתי חם, טעים ומעולה בכל מקום ובכל זמן</p>
									<p>בתיאבון, אלאא והאג'ר</p>
								</div>
							</div>
						</div>

						<!-- Footer Links -->
						<!-- Footer Links -->
						<div class="col-lg-4 footer_col">
							<div class="footer_menu">
								<div class="footer_title text-center">עזרה ושירותים</div>
								<ul class="footer_list text-center">
									<li>
										<a href="#"><div>שירות לקוחות<div class="footer_tag_1">אונלין</div></div></a>
									</li>
									<li>
										<a href="#"><div>מדיניות החזרה</div></a>
									</li>
									<li>
										<a href="#"><div>כמויות של מוצרים<div class="footer_tag_2">מומלץ</div></div></a>
									</li>
									<li>
										<a href="#"><div>תקנון האתר</div></a>
									</li>
									<li>
										<a href="#"><div>צור קשר</div></a>
									</li>
								</ul>
							</div>
						</div>
						

						<!-- Footer Contact -->
						<div dir="rtl" class="col-lg-4 footer_col">
							<div dir="rtl" class="footer_contact">
								
								<div dir="rtl" class="footer_social">
									<div dir="rtl" class="footer_title">רשתות חברתיות</div>
									<ul  class="footer_social_list d-flex flex-row align-items-start justify-content-start text-center">
										
										<li><a   href="#"><i class="fa fa-facebook " aria-hidden="true"></i></a></li>
										<li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div  dir="ltr" class="footer_bar text-center"">
				<div  class="container">
					<div class="row">
						<div class="col">
							<div class="footer_bar_content d-flex flex-md-row flex-column align-items-center justify-content-start">
								<div class="copyright order-md-1 order-2">Copyright &copy;
								<script>document.write(new Date().getFullYear());</script>
								 All rights reserved  <i class="fa fa-heart-o" aria-hidden="true"></i>
								  Alaa && Hajar </div>
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</footer>
	</div>

</div>
<script src="view/js/jquery-3.2.1.min.js"></script>
<script src="view/styles/bootstrap-4.1.2/popper.js"></script>
<script src="view/styles/bootstrap-4.1.2/bootstrap.min.js"></script>
<script src="view/plugins/greensock/TweenMax.min.js"></script>
<script src="view/plugins/greensock/TimelineMax.min.js"></script>
<script src="view/plugins/scrollmagic/ScrollMagic.min.js"></script>
<script src="view/plugins/greensock/animation.gsap.min.js"></script>
<script src="view/plugins/greensock/ScrollToPlugin.min.js"></script>
<script src="view/plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="view/plugins/easing/easing.js"></script>
<script src="view/plugins/progressbar/progressbar.min.js"></script>
<script src="view/plugins/parallax-js-master/parallax.min.js"></script>
<script src="view/plugins/Isotope/isotope.pkgd.min.js"></script>
<script src="view/plugins/Isotope/fitcolumns.js"></script>
<script src="view/js/category.js"></script>
</body>
</html>
	