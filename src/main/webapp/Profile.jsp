<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.Address"%>
<%@ page import="com.tap.model.User"%>
<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.OrderTable"%>
<%
User user = (User) request.getAttribute("user");
Address defaultAddress = (Address) request.getAttribute("defaultAddress");
List<OrderTable> orders = (List<OrderTable>) request.getAttribute("orders");
if (user == null) {
	response.sendRedirect("LoginPage.html");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<meta charset="UTF-8">
<title>My Profile</title>

<style>
body {
	font-family: Poppins, sans-serif;
	background: #fff8f3;
}

html {
	margin: 0;
	padding: 0;
	height: 100%;
	overflow: hidden;
}

.navbar {
	background: white;
	height: 80px;
	padding: 0 30px;
	display: flex;
	align-items: center;
	gap: 25px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, .06);
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	z-index: 999;
}

.logo {
	font-size: 32px;
	font-weight: 700;
	color: #fc8019;
}

.location-box {
	display: flex;
	align-items: center;
	gap: 10px;
	padding: 10px 16px;
	border: 1px solid #e6e6e6;
	border-radius: 14px;
}




.location-text {
	display: flex;
	flex-direction: column;
}

.location-text small {
	font-size: 12px;
	color: #888;
}

.location-text span {
	font-weight: 600;
}

.search-box {
	flex: 1;
	position: relative;
}


.search-box input {
	width: 100%;
	height: 50px;
	border: 1px solid #e6e6e6;
	border-radius: 14px;
	padding-left: 45px;
	outline: none;
	font-size: 15px;
}


.search-icon {
	position: absolute;
	left: 15px;
	top: 50%;
	transform: translateY(-50%);
}

.nav-links {
	display: flex;
	list-style: none;
	gap: 30px;
}

.nav-links a {
	text-decoration: none;
	color: #222;
	font-weight: 500;
}

.nav-links a:hover {
	color: #fc8019;
}

.profile-link {
	text-decoration: none;
	color: #222;
	font-size: 18px;
	font-weight: 500;
}

.cart-link {
	text-decoration: none;
	font-size: 28px;
}

.profile-card {
	width: 600px;
	margin: 50px auto;
	background: white;
	padding: 30px;
	border-radius: 20px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, .1);
}

.profile-card h1 {
	color: #fc8019;
	margin-bottom: 20px;
}

.profile-row {
	margin: 15px 0;
	font-size: 18px;
}

.label {
	font-weight: 700;
}

.logout-btn {
	display: inline-block;
	margin-top: 20px;
	padding: 12px 20px;
	background: #ff4d4d;
	color: white;
	text-decoration: none;
	border-radius: 10px;
}

.orders-btn {
	display: inline-block;
	margin-top: 20px;
	margin-right: 10px;
	padding: 12px 20px;
	background: #fc8019;
	color: white;
	text-decoration: none;
	border-radius: 10px;
}

body {
	background: #fff8f3;
	margin: 0;
	font-family: 'Poppins', sans-serif;
}

.page {
	display: flex;
	height: 100vh;
	padding-top: 80px;
}

/* LEFT */
.sidebar {
	width: 290px;
	background: white;
	border-radius: 24px;
	padding: 25px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, .06);
	position: fixed;
	top: 100px;
	left: 20px;
	bottom: 20px;
	overflow: hidden;
}

.sidebar h1 {
	font-size: 32px;
	color: #222;
	margin-bottom: 10px;
}

.line {
	width: 55px;
	height: 5px;
	background: #fc8019;
	border-radius: 20px;
	margin-bottom: 20px;
}

.sidebar p {
	color: #777;
	line-height: 1.7;
	font-size: 14px;
	margin-bottom: 15px;
}

.menu-item {
	display: block;
	text-decoration: none;
	color: #222;
	padding: 10px 14px;
	border-radius: 18px;
	margin-bottom: 2px;
	font-size: 18px;
}

.menu-item:hover {
	background: #fff4ec;
	color: #fc8019;
	transform: translateX(4px);
}

.menu-item {
	display: block;
	text-decoration: none;
	color: #222;
	padding: 11px 15px;
	border-radius: 18px;
	margin-bottom: 6px;
	font-size: 17px;
	transition: .25s;
}

.active {
	background: #fff4ec;
	color: #fc8019;
	font-weight: 600;
}

.logout {
	margin-top: 30px;
	color: #ff4d4d;
}

/* RIGHT */
.content {
	flex: 1;
	margin-left: 340px;
	padding: 30px;
	height: calc(100vh - 80px);
	overflow-y: auto;
}

.user-card {
	background: white;
	border-radius: 24px;
	padding: 25px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	box-shadow: 0 4px 20px rgba(0, 0, 0, .06);
}

.user-left {
	display: flex;
	gap: 30px;
}

.avatar {
	width: 110px;
	height: 110px;
	border-radius: 50%;
	background: #fff3eb;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 55px;
	color: #fc8019;
}

.name-row {
	display: flex;
	align-items: center;
	gap: 15px;
}

.name-row h2 {
	font-size: 32px;
	margin: 0;
}

.badge {
	background: #fff3eb;
	color: #fc8019;
	padding: 8px 14px;
	border-radius: 20px;
	font-size: 14px;
	font-weight: 600;
}

.user-id {
	margin-top: 12px;
	font-size: 18px;
}

.info {
	margin-top: 15px;
	font-size: 18px;
	color: #555;
}

.edit-btn {
	display: inline-block;
	text-decoration: none;
	color: #222;
	border: 1px solid #eee;
	background: #fff;
	padding: 15px 25px;
	border-radius: 14px;
	font-size: 16px;
	transition: .25s;
}

.edit-btn:hover {
	background: #FC8019;
	color: #fff;
}

/* ORDERS */
.orders-section {
	margin-top: 12px;
	background: white;
	border-radius: 24px;
	padding: 20px;
	height: auto;
	box-shadow: 0 4px 20px rgba(0, 0, 0, .06);
}

.order-card {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 15px 20px;
	margin-top: 12px;
	border: 1px solid #eee;
	border-radius: 15px;
	background: #fffaf6;
}

.order-left h3 {
	margin: 0;
	font-size: 18px;
}

.order-left p {
	color: #fc8019;
	font-weight: 600;
	margin: 6px 0;
}

.order-left small {
	color: #777;
}

.status {
	background: #e8fff1;
	color: #2e7d32;
	padding: 8px 16px;
	border-radius: 20px;
	font-weight: 600;
}

.orders-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.orders-header a {
	text-decoration: none;
	color: #fc8019;
	font-weight: 600;
}

.empty-order {
	text-align: center;
	padding: 50px;
	color: #888;
}
</style>
</head>

<body>

	<nav class="navbar">

		<div class="logo">FoodHub</div>

		<div class="location-box">
			<span class="location-icon">📍</span>
			<div class="location-text">
				<small>Deliver to</small> <span>Vijayawada, 520001</span>
			</div>
		</div>

		<div class="search-box">

			<input type="text"
				placeholder="Search for restaurants, dishes, cuisines..."> <span
				class="search-icon">🔍</span>

		</div>

		<ul class="nav-links">
			<li><a href="callRestaurantServlet">Home</a></li>
			<li><a href="#">Restaurants</a></li>
			<li><a href="#">Offers</a></li>
		</ul>

		<a href="callProfileServlet" class="profile-link"> 👤 <%=user.getUserName()%>
		</a> <a href="CartPage.jsp" class="cart-link"> 🛒 </a>

	</nav>

	<div class="page">

		<!-- LEFT SIDEBAR -->

		<div class="sidebar">

			<h1>My Profile</h1>

			<div class="line"></div>

			<p>Manage your account, addresses and view your orders</p>

			<a href="callProfileServlet" class="menu-item active"> 👤 Profile
			</a> <a href="MyOrdersServlet" class="menu-item"> 🛍 My Orders </a> <a
				href="AddressServlet" class="menu-item"> 📍 Addresses </a> <a
				href="HelpSupport.jsp" class="menu-item"> 🎧 Help & Support </a> <a
				href="LogoutServlet" class="menu-item logout"> 🚪 Logout </a>

		</div>


		<!-- RIGHT CONTENT -->

		<div class="content">

			<!-- PROFILE CARD -->

			<div class="user-card">

				<div class="user-left">

					<div class="avatar">👤</div>

					<div class="user-details">

						<div class="name-row">
							<h2><%=user.getUserName()%></h2>

							<span class="badge"> FoodHub User </span>
						</div>

						<div class="user-id">
							User ID :
							<%=user.getUserID()%>
						</div>

						<hr>

						<div class="info">
							✉
							<%=user.getEmail()%>
						</div>

						<div class="info">

							📍

							<%
						if (defaultAddress != null) {
						%>

							<%=defaultAddress.getHouseNo()%>,
							<%=defaultAddress.getArea()%>,
							<%=defaultAddress.getCity()%>

							<%
							} else {
							%>

							No Default Address

							<%
							}
							%>

						</div>

					</div>

				</div>

				<a href="EditProfileServlet" class="edit-btn"> ✏ Edit Profile </a>

			</div>



			<!-- RECENT ORDERS CARD -->

			<div class="orders-section">

				<div class="orders-header">

					<h2>Recent Orders</h2>

					<a href="orders"> View All Orders → </a>

				</div>

				<%
				if (orders == null || orders.isEmpty()) {
				%>

				<div class="empty-order">No Orders Yet</div>

				<%
				} else {
				for (OrderTable order : orders) {
				%>

				<div class="order-card">

					<div class="order-left">

						<h3>
							Order #<%=order.getOrderID()%></h3>

						<p>
							₹
							<%=order.getToatalAmount()%>
						</p>

						<small> <%=order.getOrderDate()%>
						</small>

					</div>

					<div class="order-right">

						<span class="status"> <%=order.getStatus()%>
						</span>

					</div>

				</div>

				<%
				}
				}
				%>

			</div>


		</div>

	</div>

</body>

</body>
</html>