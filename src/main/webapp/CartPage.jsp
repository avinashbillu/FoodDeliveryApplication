<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.Map"%>
<%@ page import="com.tap.model.Cart"%>
<%@ page import="com.tap.model.CartItem"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FoodHub Cart</title>

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
	background: white;
	height: 80px;
	padding: 0 40px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	box-shadow: 0 2px 12px rgba(0, 0, 0, .06);
}

.logo {
	font-size: 34px;
	font-weight: 700;
	color: #fc8019;
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

/* CART */
.cart-wrapper {
	padding: 30px 40px;
	display: grid;
	grid-template-columns: 2fr 1fr;
	gap: 25px;
}

.cart-title {
	font-size: 34px;
	font-weight: 700;
	color: #222;
	margin-bottom: 20px;
}

/* LEFT */
.cart-items {
	display: flex;
	flex-direction: column;
	gap: 12px;
}

.cart-item {
	background: white;
	border-radius: 20px;
	padding: 15px 18px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	box-shadow: 0 5px 15px rgba(0, 0, 0, .05);
	min-height: 110px;
}

.item-left {
	display: flex;
	align-items: center;
	gap: 25px;
}

.food-img {
	width: 90px;
	height: 90px;
	object-fit: cover;
	border-radius: 14px;
}

.item-info h3 {
	font-size: 18px;
	color: #222;
	margin-bottom: 5px;
}

.item-price {
	color: #fc8019;
	font-size: 18px;
	font-weight: 700;
}

.item-right {
	display: flex;
	align-items: center;
	gap: 15px;
}

/* QUANTITY */
.quantity-box {
	display: flex;
	align-items: center;
	gap: 10px;
}

.qty-btn {
	width: 32px;
	height: 32px;
	border: none;
	border-radius: 50%;
	background: #fc8019;
	color: white;
	font-size: 18px;
	cursor: pointer;
}

.qty {
	font-size: 16px;
	font-weight: 600;
}

/* REMOVE */
.remove-btn {
	margin-left: 15px;
	border: none;
	background: #ff4d4d;
	color: white;
	padding: 1px 12px;
	font-size: 14px;
	border-radius: 10px;
	cursor: pointer;
}

/* BILL */
.bill-card {
	background: white;
	border-radius: 24px;
	padding: 25px;
	height: fit-content;
	box-shadow: 0 5px 20px rgba(0, 0, 0, .06);
}

.bill-card h2 {
	margin-bottom: 20px;
}

.bill-row {
	display: flex;
	justify-content: space-between;
	margin-bottom: 15px;
	color: #444;
}

.total {
	border-top: 1px solid #eee;
	padding-top: 15px;
	margin-top: 15px;
	font-size: 22px;
	font-weight: 700;
}

.checkout-btn {
	width: 100%;
	margin-top: 20px;
	border: none;
	background: #fc8019;
	color: white;
	padding: 15px;
	border-radius: 14px;
	font-size: 18px;
	font-weight: 600;
	cursor: pointer;
}

.checkout-btn:hover {
	background: #e96f08;
}

/* EMPTY */
.empty-cart {
	background: white;
	padding: 50px;
	text-align: center;
	border-radius: 24px;
}

.empty-cart h2 {
	color: #555;
}

.shop-btn {
	margin-top: 20px;
	background: #fc8019;
	color: white;
	border: none;
	padding: 12px 25px;
	border-radius: 12px;
	cursor: pointer;
}

.add-more-container {
	margin-top: 25px;
	display: flex;
}

.add-more-btn {
	display: inline-flex;
	align-items: center;
	gap: 10px;
	text-decoration: none;
	background: linear-gradient(135deg, #fc8019, #ff9f43);
	color: white;
	padding: 14px 28px;
	border-radius: 14px;
	font-size: 16px;
	font-weight: 600;
	box-shadow: 0 8px 20px rgba(252, 128, 25, 0.25);
	transition: all .3s ease;
}

.add-more-btn:hover {
	transform: translateY(-3px);
	box-shadow: 0 12px 25px rgba(252, 128, 25, 0.35);
}

.add-more-btn::before {
	content: "+";
	font-size: 20px;
	font-weight: 700;
}
</style>
</head>

<body>

	<nav class="navbar">

		<div class="logo">FoodHub</div>

		<ul class="nav-links">
			<li><a href="callRestaurantServlet">Home</a></li>
			<li><a href="#">Offers</a></li>
			<li><a href="callProfileServlet">Profile</a></li>
		</ul>

	</nav>

	<%
	Cart cart = (Cart) session.getAttribute("cart");

	float subtotal = 0;
	float deliveryFee = 29;
	float platformFee = 5;
	%>

	<div class="cart-wrapper">

		<!-- LEFT -->

		<div>

			<h1 class="cart-title">Your Cart</h1>

			<%
			if (cart == null || cart.getItems().isEmpty()) {
			%>

			<div class="empty-cart">

				<h2>Your cart is empty 😔</h2>

				<br> <a href="callRestaurantServlet">
					<button class="shop-btn">Browse Restaurants</button>
				</a>

			</div>

			<%
			} else {
			%>

			<div class="cart-items">

				<%
				for (Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {

					CartItem item = entry.getValue();

					float itemTotal = item.getPrice() * item.getQuantity();

					subtotal += itemTotal;
				%>

				<div class="cart-item">

					<div class="item-left">

						<img src="<%=item.getImagePath()%>" class="food-img">

						<div class="item-info">

							<h3><%=item.getName()%></h3>

							<div class="item-price">
								₹<%=item.getPrice()%>
							</div>

						</div>

					</div>

					<div class="item-right">
						<%
						Integer restaurantId = (Integer) session.getAttribute("restaurantId");
						%>
						<div class="quantity-box">

							<!-- Decrease -->
							<form action="callCartServlet" method="post">

								<input type="hidden" name="menuId" value="<%=item.getMenuId()%>">

								<input type="hidden" name="restaurantId"
									value="<%=restaurantId%>">

								<%
								if (item.getQuantity() - 1 <= 0) {
								%>

								<input type="hidden" name="action" value="delete">

								<%
								} else {
								%>

								<input type="hidden" name="action" value="update"> <input
									type="hidden" name="quantity"
									value="<%=item.getQuantity() - 1%>">

								<%
								}
								%>

								<button class="qty-btn" type="submit">-</button>

							</form>


							<span class="qty"><%=item.getQuantity()%></span>


							<!-- Increase -->
							<form action="callCartServlet" method="post">

								<input type="hidden" name="menuId" value="<%=item.getMenuId()%>">

								<input type="hidden" name="restaurantId"
									value="<%=restaurantId%>"> <input type="hidden"
									name="action" value="update"> <input type="hidden"
									name="quantity" value="<%=item.getQuantity() + 1%>">

								<button class="qty-btn" type="submit">+</button>

							</form>


							<!-- Remove -->
							<form action="callCartServlet" method="post">

								<input type="hidden" name="action" value="delete"> <input
									type="hidden" name="menuId" value="<%=item.getMenuId()%>">

								<input type="hidden" name="restaurantId"
									value="<%=restaurantId%>">

								<button class="remove-btn" type="submit">Remove</button>

							</form>

						</div>

					</div>

				</div>

				<%
				}
				%>

			</div>

			<!-- Add More Items Button -->
			<%
			Integer restaurantId = (Integer) session.getAttribute("restaurantId");

			String restaurantName = (String) session.getAttribute("restaurantName");

			String cuisine = (String) session.getAttribute("cuisine");

			String rating = (String) session.getAttribute("rating");

			String deliveryTime = (String) session.getAttribute("deliveryTime");
			%>
			<div class="add-more-container">

				<a class="add-more-btn"
					href="menuServlet?restaurantID=<%=restaurantId%>
&restaurantName=<%=java.net.URLEncoder.encode(restaurantName, "UTF-8")%>
&rating=<%=rating%>
&deliveryTime=<%=deliveryTime%>
&cuisine=<%=java.net.URLEncoder.encode(cuisine, "UTF-8")%>">
					Add More Items </a>
			</div>

			<%
			}
			%>

		</div>

		<!-- RIGHT -->

		<%
		float total = subtotal + deliveryFee + platformFee;
		%>

		<div class="bill-card">

			<h2>Bill Details</h2>

			<div class="bill-row">
				<span>Item Total</span> <span>₹<%=subtotal%></span>
			</div>

			<div class="bill-row">
				<span>Delivery Fee</span> <span>₹<%=deliveryFee%></span>
			</div>

			<div class="bill-row">
				<span>Platform Fee</span> <span>₹<%=platformFee%></span>
			</div>

			<div class="bill-row total">
				<span>To Pay</span> <span>₹<%=total%></span>
			</div>

			<%
			if (cart == null || cart.getItems().isEmpty()) {
			%>

			<form action="callRestaurantServlet">
				<button type="submit" class="checkout-btn">Browse
					Restaurants</button>
			</form>

			<%
			} else {
			%>

			<form action="CheckoutServlet" method="get">
				<button type="submit" class="checkout-btn">Proceed To
					Checkout</button>
			</form>

			<%
			}
			%>

		</div>

	</div>

</body>
</html>