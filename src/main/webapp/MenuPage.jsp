<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List,com.tap.model.Menu"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FoodHub Menu</title>

<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Poppins', sans-serif;
}

body {
	background: #f8f8f8;
}

/* Navbar */
.navbar {
	background: white;
	padding: 18px 70px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	box-shadow: 0 2px 15px rgba(0, 0, 0, .08);
}

.logo {
	color: #fc8019;
	font-size: 34px;
	font-weight: 700;
}

.nav-links {
	display: flex;
	gap: 30px;
	list-style: none;
}

.nav-links a {
	text-decoration: none;
	color: #333;
	font-weight: 500;
}

.nav-links a:hover {
	color: #fc8019;
}

/* Restaurant Info */
.restaurant-info {
	margin: 25px 40px;
	background: white;
	padding: 30px;
	border-radius: 20px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, .08);
}

.restaurant-info h1 {
	font-size: 32px;
	color: #222;
}

.restaurant-info p {
	color: #777;
	margin-top: 8px;
}

.meta {
	display: flex;
	gap: 20px;
	margin-top: 15px;
}

.rating {
	background: #16a34a;
	color: white;
	padding: 6px 12px;
	border-radius: 15px;
	font-size: 14px;
}

.section-title {
	margin: 25px 40px;
	font-size: 26px;
	color: #222;
}

/* Menu Grid */
.menu-container {
	padding: 0 40px 40px;
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
	gap: 25px;
}

.menu-card {
	background: white;
	border-radius: 20px;
	overflow: hidden;
	box-shadow: 0 5px 15px rgba(0, 0, 0, .08);
	transition: .3s;
}

.menu-card:hover {
	transform: translateY(-8px);
	box-shadow: 0 15px 30px rgba(0, 0, 0, .15);
}

.menu-card img {
	width: 100%;
	height: 220px;
	object-fit: cover;
}

.menu-content {
	padding: 18px;
}

.menu-content h3 {
	font-size: 20px;
	color: #222;
}

.description {
	color: #777;
	font-size: 14px;
	margin-top: 8px;
	line-height: 1.5;
}

.bottom {
	margin-top: 15px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.price {
	font-size: 22px;
	font-weight: 700;
	color: #fc8019;
}

.add-btn {
	background: #fc8019;
	color: white;
	border: none;
	padding: 10px 18px;
	border-radius: 10px;
	cursor: pointer;
	font-weight: 600;
}

.add-btn:hover {
	background: #e56f0d;
}
</style>
</head>

<body>

	<nav class="navbar">

		<div class="logo">FoodHub</div>

		<ul class="nav-links">
			<li><a href="callRestaurantServlet">Home</a></li>
			<li><a href="callCartServlet">Cart</a></li>
			<li><a href="callProfileServlet">Profile</a></li>
		</ul>

	</nav>
	<%
	List<Menu> allMenuItems = (List<Menu>) request.getAttribute("allMenuItems");
	%>
	<%
	String restaurantName = (String) request.getAttribute("restaurantName");
	String cuisine = (String) request.getAttribute("cuisine");
	String rating = (String) request.getAttribute("rating");
	String deliveryTime = (String) request.getAttribute("deliveryTime");
	%>
	<div class="restaurant-info">

		<h1><%=restaurantName%></h1>

		<p><%=cuisine%></p>

		<div class="meta">
			<span class="rating">★ <%=rating%></span> <span><%=deliveryTime%>
				mins</span> <span>₹400 for two</span>
		</div>

	</div>

	<h2 class="section-title">Recommended Items</h2>

	<div class="menu-container">
		<%
		for (Menu menuItems : allMenuItems) {
		%>

		<div class="menu-card">

			<img src="<%=menuItems.getImagePath()%>">

			<div class="menu-content">

				<h3><%=menuItems.getItemName()%></h3>

				<p class="description">
					<%=menuItems.getDescription()%>
				</p>

				<div class="bottom">
					<span class="price"><%=menuItems.getPrice()%></span>
					<form action="callCartServlet">
						<input type="hidden" name="menuId" value="<%= menuItems.getMenuID() %>">
						<input type="hidden" name="restaurantId" value="<%= menuItems.getRestaurantID() %>">
						<input type="hidden" name="quantity" value="1">
						<input type="hidden" name="action" value="add">
						<button class="add-btn">Add +</button>
					</form>
					
				</div>

			</div>


		</div>

		<%
		}
		%>

	</div>

</body>
</html>