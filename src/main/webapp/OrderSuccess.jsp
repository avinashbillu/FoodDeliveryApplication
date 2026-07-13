<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Integer orderId = (Integer) session.getAttribute("orderId");
if (orderId == null) {
	orderId = 0;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Placed Successfully</title>

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
	background: #fff8f3;
}

/* NAVBAR */
.navbar {
	height: 70px;
	background: white;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 0 45px;
	box-shadow: 0 3px 12px rgba(0, 0, 0, .08);
}

.logo {
	font-size: 32px;
	font-weight: 700;
	color: #fc8019;
}

.nav-links {
	display: flex;
	list-style: none;
	gap: 35px;
}

.nav-links a {
	text-decoration: none;
	color: #222;
	font-weight: 500;
}

.nav-links a:hover {
	color: #fc8019;
}

/* SUCCESS CARD */
.container {
	height: calc(100vh - 70px);
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 30px;
}

.card {
	width: 620px;
	background: white;
	border-radius: 28px;
	padding: 50px;
	text-align: center;
	box-shadow: 0 10px 35px rgba(0, 0, 0, .08);
}

.success-icon {
	width: 120px;
	height: 120px;
	background: #e9fff0;
	border-radius: 50%;
	display: flex;
	justify-content: center;
	align-items: center;
	margin: auto;
	font-size: 70px;
	margin-bottom: 25px;
}

.card h1 {
	font-size: 36px;
	color: #222;
	margin-bottom: 12px;
}

.subtitle {
	color: #777;
	font-size: 18px;
	margin-bottom: 30px;
}

.order-box {
	background: #fff5ef;
	padding: 18px;
	border-radius: 18px;
	margin-bottom: 30px;
}

.order-box h2 {
	color: #fc8019;
	font-size: 18px;
	margin-bottom: 8px;
}

.order-id {
	font-size: 28px;
	font-weight: 700;
	color: #222;
}

.message {
	font-size: 16px;
	color: #666;
	line-height: 28px;
	margin-bottom: 35px;
}

.buttons {
	display: flex;
	justify-content: center;
	gap: 20px;
}

.home-btn {
	text-decoration: none;
	padding: 15px 35px;
	background: #fc8019;
	color: white;
	border-radius: 14px;
	font-weight: 600;
	transition: .3s;
}

.home-btn:hover {
	background: #eb6d06;
}

.order-btn {
	text-decoration: none;
	padding: 15px 35px;
	border: 2px solid #fc8019;
	color: #fc8019;
	border-radius: 14px;
	font-weight: 600;
	transition: .3s;
}

.order-btn:hover {
	background: #fc8019;
	color: white;
}

.footer {
	margin-top: 35px;
	font-size: 14px;
	color: #999;
}
</style>

</head>

<body>

	<nav class="navbar">

		<div class="logo">FoodHub</div>

		<ul class="nav-links">

			<li><a href="callRestaurantServlet">Home</a></li>

			<li><a href="callProfileServlet">Profile</a></li>

			<li><a href="CartPage.jsp">Cart</a></li>

		</ul>

	</nav>

	<div class="container">

		<div class="card">

			<div class="success-icon">✅</div>

			<h1>Order Placed Successfully!</h1>

			<p class="subtitle">Thank you for ordering with FoodHub.</p>

			<div class="order-box">

				<h2>Your Order ID</h2>

				<div class="order-id">
					#<%=orderId%>
				</div>

			</div>

			<div class="message">

				Your delicious food is now being prepared by the restaurant.<br>

				You can track your order status anytime from <b>My Orders</b>.

			</div>

			<div class="buttons">

				<a href="callRestaurantServlet" class="home-btn"> 🏠 Continue
					Ordering </a> <a href="MyOrdersServlet" class="order-btn"> 📦 My Orders </a>

			</div>

			<div class="footer">

				Estimated Delivery Time : <b>25 - 35 Minutes</b>

			</div>

		</div>

	</div>

</body>
</html>