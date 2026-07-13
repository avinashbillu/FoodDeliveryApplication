<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.*"%>
<%@ page import="com.tap.DAOImp.*"%>

<%
User user = (User) session.getAttribute("user");
if (user == null) {
	response.sendRedirect("LoginPage.html");
	return;
}

List<OrderTable> orders = (List<OrderTable>) request.getAttribute("orders");
OrderItemImp orderItemDAO = (OrderItemImp) request.getAttribute("orderItemDAO");
MenuImpl menuDAO = (MenuImpl) request.getAttribute("menuDAO");
RestaurantDAOImpl restaurantDAO = (RestaurantDAOImpl) request.getAttribute("restaurantDAO");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Orders</title>

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

html, body {
	height: 100%;
	background: #fff8f3;
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
	transition: .25s;
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

.main-container {
	display: flex;
	height: calc(100vh - 80px);
}

.sidebar {
	width: 290px;
	position: fixed;
	left: 20px;
	top: 100px;
	bottom: 20px;
	overflow: hidden;
	background: #fff;
	border-radius: 24px;
	padding: 25px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, .06);
}

.sidebar h1 {
	font-size: 32px;
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
	font-size: 14px;
	line-height: 1.7;
	margin-bottom: 15px;
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

.menu-item:hover {
	background: #fff4ec;
	color: #fc8019;
	transform: translateX(4px);
}

.menu-item.active {
	background: #fff4ec;
	color: #fc8019;
	font-weight: 600;
}

.logout {
	margin-top: 25px;
	color: #ff4d4d;
}

.page {
	display: flex;
	height: 100vh;
	padding-top: 80px;
}

.content {
	flex: 1;
	margin-left: 340px;
	padding: 30px;
	height: calc(100vh - 80px);
	overflow-y: auto;
}

.page-title {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
}

.page-title h1 {
	font-size: 25px;
	margin: 0;
}

.orders-wrapper {
	padding: 0;
}

/* ================= ORDER CARD ================= */
.order-card {
	width: 1250px;
	max-width: 100%;
	background: #fff;
	border-radius: 20px;
	padding: 18px 28px;
	margin-bottom: 22px;
	box-shadow: 0 5px 18px rgba(0, 0, 0, .08);
}

.order-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.restaurant {
	display: flex;
	gap: 18px;
}

.restaurant-image {
	width: 72px;
	height: 72px;
	object-fit: cover;
	border-radius: 14px;
}

.restaurant-details h2 {
	font-size: 22px;
	margin-bottom: 4px;
	font-weight: 700;
}

.restaurant-meta {
	color: #666;
	font-size: 15px;
	margin-top: 2px;
}

.status-badge {
	background: #FFF4E8;
	color: #FC8019;
	padding: 10px 22px;
	border-radius: 30px;
	font-weight: 600;
}

.divider {
	margin: 4px 0;
	border: none;
	border-top: 1px dashed #ddd;
}

.items-container {
	display: flex;
	flex-direction: column;
}

.item-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 8px 0;
	border-bottom: 1px solid #efefef;
}

.item-left {
	display: flex;
	align-items: center;
	gap: 7px;
	font-size: 15px;
}

.item-name {
	font-weight: 600;
}

.item-right {
	width: 120px;
	text-align: right;
	font-size: 16px;
	font-weight: 600;
}

.order-summary {
	margin-top: 10px;
}

.summary-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 5px 0;
	font-size: 16px;
}

.total-row {
	margin-top: 12px;
	padding-top: 12px;
	border-top: 2px solid #eee;
}

.total-price {
	color: #FC8019;
	font-size: 28px;
	font-weight: 700;
}

.action-buttons {
	margin-top: 12px;
	display: flex;
	gap: 12px;
}

.track-btn {
	background: #FC8019;
	color: white;
	padding: 11px 22px;
	border-radius: 10px;
	text-decoration: none;
	font-weight: 600;
}

.reorder-btn {
	border: 2px solid #FC8019;
	color: #FC8019;
	padding: 11px 22px;
	border-radius: 12px;
	text-decoration: none;
	font-weight: 600;
}

.empty-order {
	width: 900px;
	background: #fff;
	padding: 60px;
	border-radius: 22px;
	text-align: center;
	box-shadow: 0 8px 25px rgba(0, 0, 0, .08);
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
		</a> <a href="CartPage.jsp" class="cart-link">🛒</a>

	</nav>

	<div class="page">

		<div class="sidebar">

			<h1>My Profile</h1>

			<div class="line"></div>

			<p>Manage your account, addresses and view your orders</p>

			<a href="callProfileServlet" class="menu-item">👤 Profile</a> <a
				href="MyOrdersServlet" class="menu-item active">🛍 My Orders</a> <a
				href="AddressServlet" class="menu-item">📍 Addresses</a> <a
				href="HelpSupport.jsp" class="menu-item">🎧 Help & Support</a> <a
				href="LogoutServlet" class="menu-item logout">🚪 Logout</a>

		</div>

		<div class="content">

			<div class="page-title">
				<h1>My Orders</h1>
			</div>

			<div class="orders-wrapper">



				<%
				if (orders == null || orders.isEmpty()) {
				%>

				<div class="empty-order">

					<h2>No Orders Found</h2>

					<p>You haven't placed any orders yet.</p>

				</div>

				<%
				} else {

				for (OrderTable order : orders) {

					Restaurant restaurant = restaurantDAO.getRestaurant(order.getRestaurantID());

					List<OrderItem> items = orderItemDAO.getItemsByOrderId(order.getOrderID());
				%>

				<div class="order-card">

					<!-- HEADER -->

					<div class="order-header">

						<div class="restaurant">

							<img src="<%=restaurant.getImagePath()%>"
								class="restaurant-image">

							<div class="restaurant-details">

								<h2><%=restaurant.getName()%></h2>

								<div class="restaurant-meta">

									⭐
									<%=restaurant.getRating()%>

									•

									<%=restaurant.getCuisineTypes()%>

								</div>



							</div>

						</div>

						<div class="status-badge">

							<%=order.getStatus()%>

						</div>

					</div>



					<div class="items-container">

						<%
						for (OrderItem item : items) {

							Menu menu = menuDAO.getMenuItem(item.getMenuID());
						%>

						<div class="item-row">

							<div class="item-left">

								🍽 <span class="item-name"> <%=menu.getItemName()%>

								</span> ×

								<%=item.getQuantity()%>

							</div>

							<div class="item-right">

								₹
								<%=item.getItemTotal()%>

							</div>

						</div>

						<%
						}
						%>

					</div>





					<div class="order-summary">

						<div class="summary-row">
							<span>Payment Method</span> <strong><%=order.getPaymentMethod()%></strong>
						</div>

						<div class="summary-row">
							<span>Order ID</span> <strong>#<%=order.getOrderID()%></strong>
						</div>

						<div class="summary-row">
							<span>Status</span> <strong><%=order.getStatus()%></strong>
						</div>

						<div class="summary-row total-row">
							<span>Total Paid</span> <span class="total-price"> ₹ <%=String.format("%.2f", order.getToatalAmount())%>
							</span>
						</div>

					</div>

					<div class="action-buttons">

						<a href="TrackOrderServlet?orderId=<%=order.getOrderID()%>">
							<button class="track-btn">🚚 Track Order</button>
						</a> <a href="CartServlet?reorder=<%=order.getOrderID()%>"
							class="reorder-btn"> 🔄 Reorder </a>

					</div>

				</div>

				<%
				} // end for(order)
				} // end else
				%>
			</div>


			<style>

/* ---------------- HOVER EFFECTS ---------------- */
.order-card {
	transition: all .25s ease;
}

.order-card:hover {
	transform: translateY(-4px);
	box-shadow: 0 16px 40px rgba(0, 0, 0, .12);
}

.track-btn {
	transition: .25s;
}

.track-btn:hover {
	background: #e46f00;
}

.reorder-btn {
	transition: .25s;
}

.reorder-btn:hover {
	background: #fc8019;
	color: #fff;
}

/* ---------------- RESPONSIVE ---------------- */
@media ( max-width :1200px) {
	.content {
		margin-left: 0;
	}
	.order-card {
		width: 100%;
	}
}

@media ( max-width :992px) {
	.profile-page {
		flex-direction: column;
		margin-top: 90px;
	}
	.sidebar {
		position: relative;
		top: 0;
		width: 100%;
		height: auto;
	}
	.content {
		margin-left: 0;
	}
	.top {
		flex-direction: column;
		gap: 20px;
	}
	.restaurant-info {
		width: 100%;
	}
	.action-buttons {
		flex-direction: column;
	}
	.track-btn, .reorder-btn {
		width: 100%;
		text-align: center;
	}
}

@media ( max-width :768px) {
	.navbar {
		padding: 0 15px;
		gap: 15px;
		overflow-x: auto;
	}
	.logo {
		font-size: 26px;
	}
	.search-box {
		display: none;
	}
	.nav-links {
		gap: 15px;
	}
	.restaurant-img {
		width: 70px;
		height: 70px;
	}
	.restaurant-name {
		font-size: 20px;
	}
	.total-price {
		font-size: 24px;
	}
}

/* --------------- CUSTOM SCROLLBAR --------------- */
::-webkit-scrollbar {
	width: 10px;
}

::-webkit-scrollbar-thumb {
	background: #fc8019;
	border-radius: 20px;
}

::-webkit-scrollbar-track {
	background: #f7f7f7;
}
</style>

		</div>
		<!-- End Content -->

	</div>
	<!-- End Profile Page -->
</body>
</html>
