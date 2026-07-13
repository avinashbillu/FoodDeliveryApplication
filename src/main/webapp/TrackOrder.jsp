<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.tap.model.*"%>
<%@ page import="com.tap.model.OrderTable"%>
<%
OrderTable order = (OrderTable) request.getAttribute("order");
Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
Map<Integer,Menu> menuMap = (Map<Integer,Menu>) request.getAttribute("menuMap");
List<OrderItem> items = (List<OrderItem>) request.getAttribute("items");

String status = (order != null && order.getStatus() != null) ? order.getStatus() : "Pending";

String eta = "20 - 25 mins";
String partnerName = "Will be assigned soon";
String partnerPhone = "";
String restaurantPhone = "+91 98765 43210";

/*
	Timeline mapping (5 steps, matches the design):
	1 = Order Confirmed
	2 = Preparing Your Food
	3 = Picked Up
	4 = On The Way
	5 = Delivered
*/
int current = 1;
if (status.equalsIgnoreCase("Pending"))
	current = 1;
else if (status.equalsIgnoreCase("Confirmed"))
	current = 1;
else if (status.equalsIgnoreCase("Preparing"))
	current = 2;
else if (status.equalsIgnoreCase("Picked Up"))
	current = 3;
else if (status.equalsIgnoreCase("On The Way"))
	current = 4;
else if (status.equalsIgnoreCase("Delivered"))
	current = 5;

String username = (String) session.getAttribute("username");
if (username == null) username = "Guest";

int cartCount = 0;
Object cartCountObj = session.getAttribute("cartCount");
if (cartCountObj != null) cartCount = (Integer) cartCountObj;
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Track Order | FoodHub</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
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

/* =========================
        NAVBAR (matches Address page)
========================= */
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
	text-decoration: none;
}

.location-box {
	display: flex;
	align-items: center;
	gap: 10px;
	padding: 10px 16px;
	border: 1px solid #e6e6e6;
	border-radius: 14px;
	white-space: nowrap;
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
	transition: .25s;
}

.nav-links a:hover {
	color: #fc8019;
}

.profile-link {
	text-decoration: none;
	color: #222;
	font-size: 18px;
	font-weight: 500;
	position: relative;
}

.cart-link {
	text-decoration: none;
	font-size: 28px;
	position: relative;
}

.cart-badge {
	position: absolute;
	top: -6px;
	right: -12px;
	background: #fc8019;
	color: #fff;
	font-size: 11px;
	font-weight: 700;
	border-radius: 50%;
	width: 18px;
	height: 18px;
	display: flex;
	align-items: center;
	justify-content: center;
}

/* =========================
      PAGE LAYOUT (matches Address page)
========================= */
.page {
	display: flex;
	height: 100vh;
	padding-top: 80px;
}

/* =========================
        SIDEBAR (matches Address page)
========================= */
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

.active {
	background: #fff4ec;
	color: #fc8019;
	font-weight: 600;
}

.logout {
	margin-top: 25px;
	color: #ff4d4d;
}

/* =========================
       MAIN CONTENT (scrolls independently, like Address page's .content)
========================= */
.main {
	flex: 1;
	margin-left: 340px;
	padding: 30px;
	height: calc(100vh - 80px);
	overflow-y: auto;
	display: flex;
	flex-direction: column;
	gap: 18px;
}

.main::-webkit-scrollbar {
	width: 8px;
}

.main::-webkit-scrollbar-thumb {
	background: #fc8019;
	border-radius: 20px;
}

.main::-webkit-scrollbar-track {
	background: #f3f3f3;
}

.back-btn {
	text-decoration: none;
	color: #fc8019;
	font-weight: 600;
	font-size: 14px;
}

.title-row {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
}

.title-row h1 {
	font-size: 38px;
	font-weight: 700;
}

.order-id {
	color: #888;
	margin-top: 4px;
	font-size: 15px;
}

.help-btn {
	background: #fff;
	border: 1px solid #eee;
	border-radius: 30px;
	padding: 12px 20px;
	font-weight: 600;
	color: #222;
	text-decoration: none;
	white-space: nowrap;
	box-shadow: 0 4px 12px rgba(0, 0, 0, .05);
}

/* ---------- Two column grid: order card + status card ---------- */
.track-grid {
	display: grid;
	grid-template-columns: 1.15fr 1fr;
	gap: 24px;
	align-items: start;
}

.card {
	background: #fff;
	border-radius: 22px;
	padding: 28px;
	box-shadow: 0 8px 28px rgba(0, 0, 0, .06);
}

/* ---- Order details card ---- */
.restaurant-row {
	display: flex;
	gap: 18px;
	align-items: center;
}

.restaurant-row img {
	width: 78px;
	height: 78px;
	object-fit: cover;
	border-radius: 16px;
}

.restaurant-row h2 {
	font-size: 20px;
	font-weight: 700;
}

.restaurant-row .rating {
	color: #666;
	font-size: 14px;
	margin-top: 4px;
}

.restaurant-row .view-link {
	color: #fc8019;
	font-weight: 600;
	font-size: 13px;
	text-decoration: none;
	display: inline-block;
	margin-top: 4px;
}

hr.divider {
	border: none;
	border-top: 1px solid #eee;
	margin: 20px 0;
}

.detail-row {
	display: flex;
	gap: 14px;
	align-items: flex-start;
	margin-bottom: 16px;
}

.detail-row:last-child {
	margin-bottom: 0;
}

.detail-row .dicon {
	font-size: 17px;
	width: 22px;
}

.detail-row .dlabel {
	font-size: 13px;
	color: #888;
}

.detail-row .dvalue {
	font-weight: 600;
	font-size: 15px;
	margin-top: 2px;
}

.detail-row.address .dvalue {
	font-weight: 400;
	color: #555;
	line-height: 1.6;
}

.section-heading {
	font-size: 15px;
	font-weight: 700;
	margin-bottom: 14px;
	color: #222;
}

.item-row {
	display: flex;
	justify-content: space-between;
	padding: 9px 0;
	font-size: 14px;
	color: #333;
}

.item-row .qty {
	color: #888;
	margin-left: 6px;
}

.total-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 14px;
	padding-top: 16px;
	border-top: 2px solid #eee;
	font-size: 15px;
	font-weight: 600;
}

.total-row .amount {
	font-size: 26px;
	font-weight: 700;
	color: #fc8019;
}

/* ---- Status timeline card ---- */
.timeline {
	position: relative;
	margin-left: 20px;
	margin-top: 6px;
}

.timeline:before {
	content: "";
	position: absolute;
	left: 18px;
	top: 10px;
	bottom: 10px;
	width: 3px;
	background: #e5e7eb;
	border-radius: 10px;
}

.step {
	display: flex;
	gap: 20px;
	position: relative;
	margin-bottom: 30px;
}

.step:last-child {
	margin-bottom: 0;
}

.step .icon {
	width: 40px;
	height: 40px;
	min-width: 40px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 17px;
	z-index: 2;
	background: #fff;
	border: 2px solid #d1d5db;
	color: #999;
}

.step.completed .icon {
	background: #22c55e;
	border-color: #22c55e;
	color: #fff;
}

.step.active .icon {
	background: #fc8019;
	border-color: #fc8019;
	color: #fff;
	animation: pulse 1.5s infinite;
}

.step .content h3 {
	font-size: 17px;
	font-weight: 700;
	color: #999;
	margin-bottom: 4px;
}

.step.completed .content h3 {
	color: #16a34a;
}

.step.active .content h3 {
	color: #fc8019;
}

.step .content p {
	color: #777;
	font-size: 13.5px;
	line-height: 1.5;
}

.step .content .time {
	margin-top: 5px;
	color: #aaa;
	font-size: 12px;
}

@keyframes pulse {
	0% { box-shadow: 0 0 0 0 rgba(252, 128, 25, .5); }
	70% { box-shadow: 0 0 0 12px rgba(252, 128, 25, 0); }
	100% { box-shadow: 0 0 0 0 rgba(252, 128, 25, 0); }
}

/* ---------- Bottom delivery info strip ---------- */
.delivery-strip {
	background: #fff3eb;
	border-radius: 20px;
	padding: 24px 28px;
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 20px;
}

.strip-item {
	display: flex;
	align-items: center;
	gap: 14px;
}

.strip-item .sicon {
	font-size: 22px;
	color: #fc8019;
}

.strip-item .slabel {
	font-size: 13px;
	color: #888;
}

.strip-item .svalue {
	font-weight: 700;
	font-size: 15px;
	color: #222;
	margin-top: 2px;
}

.strip-item a.svalue {
	text-decoration: none;
	color: #fc8019;
}

/* ---------- Responsive (matches Address page breakpoints) ---------- */
@media (max-width: 1200px) {
	.main {
		margin-left: 0;
	}
	.sidebar {
		position: relative;
		top: 0;
		left: 0;
		width: 100%;
		margin-bottom: 20px;
	}
	.page {
		flex-direction: column;
		height: auto;
	}
	html, body {
		overflow: auto;
	}
	.main {
		height: auto;
		overflow: visible;
	}
	.track-grid {
		grid-template-columns: 1fr;
	}
	.delivery-strip {
		grid-template-columns: 1fr;
	}
}

@media (max-width: 768px) {
	.navbar {
		overflow-x: auto;
		gap: 15px;
		padding: 0 15px;
	}
	.logo {
		font-size: 25px;
	}
	.location-box {
		display: none;
	}
	.search-box {
		display: none;
	}
	.nav-links {
		gap: 15px;
	}
}
</style>
</head>
<body>

	<!-- NAVBAR -->
	<nav class="navbar">
		<a href="callRestaurantServlet" class="logo">FoodHub</a>

		<div class="location-box">
			<span>📍</span>
			<div class="location-text">
				<small>Deliver to</small> <span>Vijayawada, 520001</span>
			</div>
		</div>

		<div class="search-box">
			<input type="text" placeholder="Search for restaurants, dishes, cuisines...">
			<span class="search-icon">🔍</span>
		</div>

		<ul class="nav-links">
			<li><a href="callRestaurantServlet">Home</a></li>
			<li><a href="#">Restaurants</a></li>
			<li><a href="#">Offers</a></li>
		</ul>

		<a href="callProfileServlet" class="profile-link">👤 <%=username%></a>
		<a href="CartPage.jsp" class="cart-link">🛒
			<% if (cartCount > 0) { %>
				<span class="cart-badge"><%=cartCount%></span>
			<% } %>
		</a>
	</nav>

	<!-- PAGE -->
	<div class="page">

		<!-- SIDEBAR -->
		<div class="sidebar">
			<h1>My Profile</h1>
			<div class="line"></div>
			<p>Manage your account, addresses and view your orders</p>

			<a href="callProfileServlet" class="menu-item">👤 Profile</a>
			<a href="MyOrdersServlet" class="menu-item active">🛍 My Orders</a>
			<a href="AddressServlet" class="menu-item">📍 Addresses</a>
			<a href="HelpSupport.jsp" class="menu-item">🎧 Help &amp; Support</a>
			<a href="LogoutServlet" class="menu-item logout">🚪 Logout</a>
		</div>

		<!-- MAIN CONTENT: Track Order / Order Status (unchanged) -->
		<main class="main">

			<a href="MyOrdersServlet" class="back-btn">← Back to My Orders</a>

			<div class="title-row">
				<div>
					<h1>Track Order</h1>
					<div class="order-id">Order ID: #<%=order != null ? order.getOrderID() : ""%></div>
				</div>
				<a href="#" class="help-btn">🎧 Need help?</a>
			</div>

			<div class="track-grid">

				<!-- Order details card -->
				<section class="card">

					<div class="restaurant-row">
						<img
							src="<%=restaurant != null ? restaurant.getImagePath() : "images/noimage.png"%>"
							alt="Restaurant">
						<div>
							<h2><%=restaurant != null ? restaurant.getName() : ""%></h2>
							<div class="rating">
								⭐ <%=restaurant != null ? restaurant.getRating() : ""%>
								&nbsp;•&nbsp;
								<%=restaurant != null ? restaurant.getCuisineTypes() : ""%>
							</div>
							<a class="view-link" href="#">View Restaurant &rsaquo;</a>
						</div>
					</div>

					<hr class="divider">

					<div class="detail-row">
						<span class="dicon">🗓️</span>
						<div>
							<div class="dlabel">Order Placed On</div>
							<div class="dvalue"><%=order != null ? order.getOrderDate() : ""%></div>
						</div>
					</div>

					<div class="detail-row">
						<span class="dicon">💳</span>
						<div>
							<div class="dlabel">Payment Method</div>
							<div class="dvalue"><%=order != null ? order.getPaymentMethod() : ""%></div>
						</div>
					</div>

					<div class="detail-row address">
						<span class="dicon">📍</span>
						<div>
							<div class="dlabel">Delivery Address</div>
							<div class="dvalue">
								<%
								Address address = (Address) request.getAttribute("address");
								if (address != null) {
								%>
									<%=address.getAddressID()%>
								<%
								} else {
								%>
									Address ID: <%=order != null ? order.getAddressID() : ""%>
								<%
								}
								%>
							</div>
						</div>
					</div>

					<hr class="divider">

					<div class="section-heading">Order Items (<%=items != null ? items.size() : 0%>)</div>
					<div class="items">
						<%
						if (items != null) {
							for (OrderItem item : items) {
								Menu menu = (menuMap != null) ? menuMap.get(item.getMenuID()) : null;
						%>
						<div class="item-row">
							<span><%=menu != null ? menu.getItemName() : "Item"%>
								<span class="qty">Qty <%=item.getQuantity()%></span>
							</span>
							<span>₹<%=item.getItemTotal()%></span>
						</div>
						<%
							}
						}
						%>
					</div>

					<div class="total-row">
						<span>Total Amount</span>
						<span class="amount">₹<%=order != null ? order.getToatalAmount() : "0"%></span>
					</div>

				</section>

				<!-- Order status timeline card -->
				<section class="card">
					<div class="section-heading" style="font-size: 20px; margin-bottom: 22px;">Order Status</div>

					<div class="timeline">

						<div class="step <%=current > 1 ? "completed" : (current == 1 ? "active" : "")%>">
							<div class="icon">✓</div>
							<div class="content">
								<h3>Order Confirmed</h3>
								<p>We have received your order.</p>
								<div class="time"><%=order != null ? order.getOrderDate() : ""%></div>
							</div>
						</div>

						<div class="step <%=current > 2 ? "completed" : (current == 2 ? "active" : "")%>">
							<div class="icon">🍳</div>
							<div class="content">
								<h3>Preparing Your Food</h3>
								<p>Restaurant is preparing your food.</p>
							</div>
						</div>

						<div class="step <%=current > 3 ? "completed" : (current == 3 ? "active" : "")%>">
							<div class="icon">🛵</div>
							<div class="content">
								<h3>Picked Up</h3>
								<p>Your order has been picked up by the delivery partner.</p>
							</div>
						</div>

						<div class="step <%=current > 4 ? "completed" : (current == 4 ? "active" : "")%>">
							<div class="icon">🛵</div>
							<div class="content">
								<h3>On The Way</h3>
								<p>Your order is on the way to you.</p>
							</div>
						</div>

						<div class="step <%=current == 5 ? "completed" : ""%>">
							<div class="icon">🏠</div>
							<div class="content">
								<h3>Delivered</h3>
								<p>Your order has been delivered.</p>
							</div>
						</div>

					</div>
				</section>

			</div>

			<!-- Delivery info strip -->
			<div class="delivery-strip">

				<div class="strip-item">
					<span class="sicon">⏱️</span>
					<div>
						<div class="slabel">Estimated Delivery</div>
						<div class="svalue"><%=eta%></div>
					</div>
				</div>

				<div class="strip-item">
					<span class="sicon">🛵</span>
					<div>
						<div class="slabel">Delivery Partner</div>
						<%
						if (partnerPhone != null && !partnerPhone.isEmpty()) {
						%>
							<a class="svalue" href="tel:<%=partnerPhone.replaceAll("[^0-9+]", "")%>"><%=partnerName%></a>
						<%
						} else {
						%>
							<div class="svalue"><%=partnerName%></div>
						<%
						}
						%>
					</div>
				</div>

				<div class="strip-item">
					<span class="sicon">📞</span>
					<div>
						<div class="slabel">Contact Restaurant</div>
						<a class="svalue" href="tel:<%=restaurantPhone.replaceAll("[^0-9+]", "")%>"><%=restaurantPhone%></a>
					</div>
				</div>

			</div>

		</main>
		<!-- main -->

	</div>
	<!-- page -->

</body>
</html>
