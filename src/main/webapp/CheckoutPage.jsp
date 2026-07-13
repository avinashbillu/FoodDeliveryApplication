<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.Address"%>
<%@ page import="com.tap.model.Cart"%>
<%@ page import="com.tap.model.CartItem"%>
<%@ page import="com.tap.model.User"%>
<%@ page import="java.util.*"%>


<%
User user = (User) session.getAttribute("user");
List<Address> addresses = (List<Address>) request.getAttribute("addresses");
Cart cart = (Cart) session.getAttribute("cart");

if (user == null) {
	response.sendRedirect("LoginPage.html");
	return;
}

float subtotal = 0;

if (cart != null) {
	for (CartItem item : cart.getItems().values()) {
		subtotal += item.getPrice() * item.getQuantity();
	}
}

float delivery = 39;
float platform = 5;
float gst = (subtotal * 5) / 100;
float total = subtotal + delivery + platform + gst;
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Checkout | FoodHub</title>

<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">


<style>
/*==========================
RESET
==========================*/
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Poppins', sans-serif;
}

html {
	scroll-behavior: smooth;
}

body {
	background: #fff8f3;
	color: #222;
	overflow-x: hidden;
	font-size: 14px;
}

/*==========================
NAVBAR
==========================*/
.navbar {
	background: #fff;
	height: 65px;
	padding: 0 25px;
	display: flex;
	align-items: center;
	gap: 25px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, .06);
	position: sticky;
	top: 0;
	z-index: 999;
}

.logo {
	font-size: 28px;
	font-weight: 700;
	color: #fc8019;
}

.location-box {
	display: flex;
	align-items: center;
	gap: 10px;
	padding: 8px 12px;
	border: 1px solid #ececec;
	border-radius: 14px;
}

.location-text {
	display: flex;
	flex-direction: column;
}

.location-text small {
	color: #888;
	font-size: 12px;
}

.location-text span {
	font-size: 15px;
	font-weight: 600;
}

.search-box {
	flex: 1;
	position: relative;
}

.search-box input {
	width: 100%;
	height: 42px;
	border: 1px solid #e8e8e8;
	border-radius: 14px;
	padding-left: 50px;
	padding-right: 18px;
	outline: none;
	font-size: 14px;
	transition: .3s;
}

.search-box input:focus {
	border-color: #fc8019;
	box-shadow: 0 0 0 4px rgba(252, 128, 25, .12);
}

.search-icon {
	position: absolute;
	left: 18px;
	top: 50%;
	transform: translateY(-50%);
	color: #888;
}

.nav-links {
	list-style: none;
	display: flex;
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
	font-weight: 600;
}

.cart-link {
	text-decoration: none;
	font-size: 28px;
}

/*==========================
LAYOUT
==========================*/
.checkout-container {
	width: 94%;
	margin: 15px auto;
	display: grid;
	grid-template-columns: 1.6fr 1fr;
	gap: 18px;
	align-items: start;
}

/*==========================
LEFT PANEL
==========================*/
.left-side {
	display: flex;
	flex-direction: column;
	gap: 15px;
}

/*==========================
COMMON CARD
==========================*/
.card {
	background: #fff;
	border-radius: 16px;
	padding: 28px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, .06);
	transition: .3s;
}

.card:hover {
	transform: translateY(-3px);
	box-shadow: 0 12px 28px rgba(0, 0, 0, .08);
}

.card h2 {
	font-size: 18px;
	margin-bottom: 15px;
	color: #222;
}

/*==========================
ADDRESS
==========================*/
.card-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 18px;
}

.change-btn {
	background: #fff3eb;
	color: #fc8019;
	border: none;
	padding: 8px 14px;
	font-size: 13px;
	border-radius: 12px;
	cursor: pointer;
	font-weight: 600;
	transition: .3s;
}

.change-btn:hover {
	background: #fc8019;
	color: #fff;
}

.address {
	display: flex;
	flex-direction: column;
	gap: 8px;
}

.address-card {
	display: flex;
	align-items: flex-start;
	gap: 10px;
	background: #fff;
	border: 1px solid #ececec;
	border-radius: 10px;
	padding: 10px 14px;
	cursor: pointer;
	transition: .25s;
}

.address-card:hover {
	border-color: #fc8019;
	box-shadow: 0 2px 8px rgba(0, 0, 0, .05);
}

.address-radio {
	margin-top: 24px;
	width: 16px;
	height: 16px;
	accent-color: #fc8019;
}

.address-details {
	flex: 1;
}

.address-top {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 4px;
}

.address-type, .default-badge {
	padding: 3px 8px;
	border-radius: 5px;
	font-size: 10px;
	font-weight: 700;
}

.address-type {
	background: #fff3eb;
	color: #fc8019;
}

.default-badge {
	background: #e9f8ef;
	color: #28a745;
}

.address-details h3 {
	font-size: 16px;
	margin: 4px 0;
	line-height: 1.1;
}

.address-details p {
	font-size: 13px;
	line-height: 18px;
	color: #666;
	margin: 0;
}

.phone {
	margin-top: 4px;
	font-size: 13px;
	color: #555;
	font-weight: 500;
}

.address-actions {
	margin-top: 8px;
	display: flex;
	justify-content: flex-end;
	gap: 14px;
}

.address-actions a {
	font-size: 12px;
	font-weight: 600;
	text-decoration: none;
	color: #fc8019;
}

.address-card:has(.address-radio:checked) {
	border: 2px solid #fc8019;
	background: #fffdfb;
}

/*==========================
TEXTAREA
==========================*/
textarea {
	width: 100%;
	height: 90px;
	resize: none;
	border: 1px solid #e7e7e7;
	border-radius: 16px;
	padding: 12px;
	font-size: 14px;
	outline: none;
	transition: .3s;
}

textarea:focus {
	border-color: #fc8019;
	box-shadow: 0 0 0 4px rgba(252, 128, 25, .12);
}

/*==========================
PAYMENT
==========================*/
.payment {
	display: flex;
	flex-direction: column;
	gap: 12px;
}

.payment label {
	display: flex;
	align-items: center;
	gap: 15px;
	padding: 12px;
	font-size: 14px;
	border: 1px solid #ececec;
	border-radius: 16px;
	cursor: pointer;
	transition: .3s;
}

.payment label:hover {
	border-color: #fc8019;
	background: #fff7f2;
}

.payment input {
	accent-color: #fc8019;
	width: 18px;
	height: 18px;
}

/*==========================
BILL
==========================*/
.bill-row {
	display: flex;
	justify-content: space-between;
	margin-bottom: 18px;
	font-size: 16px;
}

.total {
	margin-top: 18px;
	padding-top: 18px;
	border-top: 2px dashed #ececec;
	font-size: 22px;
	font-weight: 700;
}

/*=========================================
RIGHT SIDE
=========================================*/
.right-side {
	display: flex;
	flex-direction: column;
	gap: 15px;
}

/*=========================================
ORDER SUMMARY CARD
=========================================*/
.summary-card {
	background: #fff;
	border-radius: 16px;
	padding: 24px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, .06);
	transition: .3s;
}

.summary-card:hover {
	transform: translateY(-3px);
	box-shadow: 0 12px 28px rgba(0, 0, 0, .08);
}

.restaurant-top {
	display: flex;
	align-items: center;
	gap: 18px;
	margin-bottom: 20px;
}

.restaurant-img {
	width: 55px;
	height: 55px;
	border-radius: 18px;
	object-fit: cover;
	background: #fff4ec;
	padding: 8px;
}

.restaurant-top h2 {
	font-size: 18px;
	margin-bottom: 4px;
}

.restaurant-top p {
	color: #777;
	font-size: 13px;
}

.summary-card hr {
	border: none;
	border-top: 1px solid #ececec;
	margin: 18px 0;
}

/*=========================================
ITEMS
=========================================*/
.items-list {
	display: flex;
	flex-direction: column;
	gap: 18px;
}

.item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding-bottom: 12px;
	border-bottom: 1px dashed #ededed;
}

.item:last-child {
	border-bottom: none;
	padding-bottom: 0;
}

.item-left {
	display: flex;
	align-items: center;
	gap: 15px;
}

.food-image {
	width: 55px;
	height: 55px;
	object-fit: cover;
	border-radius: 16px;
}

.item-left h4 {
	font-size: 15px;
	margin-bottom: 5px;
}

.item-left p {
	color: #777;
	font-size: 13px;
}

.item-price {
	color: #fc8019;
	font-size: 16px;
	font-weight: 700;
}

/*=========================================
COUPON
=========================================*/
.coupon-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.coupon-row h3 {
	font-size: 20px;
	margin-bottom: 5px;
}

.coupon-row p {
	color: #777;
	font-size: 14px;
}

.apply-btn {
	border: none;
	background: #fc8019;
	color: white;
	padding: 10px 18px;
	border-radius: 12px;
	cursor: pointer;
	font-size: 15px;
	font-weight: 600;
	transition: .3s;
}

.apply-btn:hover {
	background: #e96d05;
	transform: scale(1.05);
}

/*=========================================
PRICE DETAILS
=========================================*/
.price-row {
	display: flex;
	justify-content: space-between;
	margin: 15px 0;
	font-size: 16px;
	color: #444;
}

.grand-total {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 18px;
	padding-top: 18px;
	border-top: 2px dashed #ececec;
	font-size: 23px;
	font-weight: 700;
	color: #111;
}

/*=========================================
PLACE ORDER
=========================================*/
.place-order-btn {
	width: 100%;
	height: 52px;
	border: none;
	border-radius: 14px;
	background: linear-gradient(135deg, #fc8019, #ff9f43);
	color: white;
	font-size: 17px;
	font-weight: 700;
	cursor: pointer;
	transition: .35s;
	box-shadow: 0 10px 24px rgba(252, 128, 25, .28);
}

.place-order-btn:hover {
	transform: translateY(-4px);
	box-shadow: 0 16px 34px rgba(252, 128, 25, .35);
}

.place-order-btn:active {
	transform: scale(.98);
}

form {
	display: flex;
	flex-direction: column;
	gap: 20px;
}

/*=========================================
SECURE PAYMENT
=========================================*/
.secure-box {
	background: white;
	border-radius: 18px;
	padding: 14px;
	font-size: 14px;
	text-align: center;
	color: #16a34a;
	font-weight: 600;
	box-shadow: 0 6px 18px rgba(0, 0, 0, .05);
}

/*=========================================
FOOTER
=========================================*/
.checkout-footer {
	margin-top: 18px;
	background: #1f1f1f;
	color: white;
	text-align: center;
	padding: 16px;
	font-size: 13px;
}

/*=========================================
SCROLLBAR
=========================================*/
::-webkit-scrollbar {
	width: 8px;
}

::-webkit-scrollbar-thumb {
	background: #fc8019;
	border-radius: 20px;
}

::-webkit-scrollbar-track {
	background: #f5f5f5;
}
/*=========================================
INPUTS & BUTTONS
=========================================*/
input, textarea, button {
	font-family: 'Poppins', sans-serif;
}

button {
	outline: none;
}

button:focus, input:focus, textarea:focus {
	outline: none;
}

/*=========================================
CARD ANIMATIONS
=========================================*/
.card, .summary-card {
	animation: fadeUp .5s ease;
	padding: 18px;
	border-radius: 18px;
}

@
keyframes fadeUp {from { opacity:0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}

/*=========================================
HOVER EFFECTS
=========================================*/
.item {
	transition: .3s;
}

.item:hover {
	transform: translateX(6px);
}

.payment label {
	transition: .3s;
}

.payment label:hover {
	transform: translateX(4px);
}

.bill-row, .price-row {
	margin: 10px 0;
	font-size: 14px;
	transition: .3s;
}

.bill-row:hover, .price-row:hover {
	color: #fc8019;
}

.restaurant-top {
	transition: .3s;
}

.restaurant-top:hover {
	transform: scale(1.02);
}

/*=========================================
BADGES
=========================================*/
.badge {
	display: inline-block;
	background: #fff4ec;
	color: #fc8019;
	padding: 6px 14px;
	border-radius: 20px;
	font-size: 13px;
	font-weight: 600;
}

/*=========================================
PLACE ORDER BUTTON EFFECT
=========================================*/
.place-order-btn {
	position: relative;
	overflow: hidden;
}

.place-order-btn::before {
	content: "";
	position: absolute;
	top: 0;
	left: -120%;
	width: 120%;
	height: 100%;
	background: rgba(255, 255, 255, .25);
	transform: skewX(-25deg);
	transition: .7s;
}

.place-order-btn:hover::before {
	left: 120%;
}

/*=========================================
SHADOW ENHANCEMENT
=========================================*/
.card:hover, .summary-card:hover {
	box-shadow: 0 18px 40px rgba(0, 0, 0, .10);
}

/*=========================================
RESPONSIVE
=========================================*/
@media ( max-width :1200px) {
	.checkout-container {
		grid-template-columns: 1fr;
	}
	.right-side {
		margin-top: 10px;
	}
}

@media ( max-width :992px) {
	.navbar {
		padding: 15px;
		flex-wrap: wrap;
		height: auto;
		gap: 15px;
	}
	.search-box {
		order: 3;
		width: 100%;
	}
	.location-box {
		display: none;
	}
	.nav-links {
		gap: 18px;
	}
}

@media ( max-width :768px) {
	.checkout-container {
		width: 96%;
		margin: 15px auto;
	}
	.card, .summary-card {
		padding: 18px;
		border-radius: 18px;
	}
	.restaurant-img {
		width: 60px;
		height: 60px;
	}
	.food-image {
		width: 58px;
		height: 58px;
	}
	.place-order-btn {
		height: 56px;
		font-size: 18px;
	}
	.price-row, .bill-row {
		font-size: 15px;
	}
	.grand-total {
		font-size: 20px;
	}
}

@media ( max-width :576px) {
	.nav-links {
		display: none;
	}
	.profile-link {
		font-size: 15px;
	}
	.cart-link {
		font-size: 24px;
	}
	.restaurant-top {
		flex-direction: column;
		align-items: flex-start;
	}
	.item {
		flex-direction: column;
		align-items: flex-start;
		gap: 12px;
	}
	.item-price {
		margin-left: 72px;
	}
	.coupon-row {
		flex-direction: column;
		align-items: flex-start;
		gap: 15px;
	}
	.apply-btn {
		width: 100%;
	}
}

/*=========================================
SUCCESS MESSAGE
=========================================*/
.success-box {
	margin-top: 20px;
	padding: 16px;
	background: #ecfff2;
	border: 1px solid #b7f0c4;
	border-radius: 16px;
	color: #1d8c4b;
	font-weight: 600;
	text-align: center;
}

/*=========================================
EMPTY CART
=========================================*/
.empty-cart {
	background: white;
	padding: 70px 30px;
	border-radius: 24px;
	text-align: center;
	box-shadow: 0 8px 25px rgba(0, 0, 0, .05);
}

.empty-cart h2 {
	margin-bottom: 15px;
	font-size: 30px;
}

.empty-cart p {
	color: #777;
	margin-bottom: 25px;
}

.shop-btn {
	background: #fc8019;
	color: white;
	border: none;
	padding: 14px 30px;
	border-radius: 14px;
	cursor: pointer;
	font-size: 16px;
	font-weight: 600;
	transition: .3s;
}

.shop-btn:hover {
	background: #e96d05;
	transform: translateY(-3px);
}

/*=========================================
SMOOTH TRANSITIONS
=========================================*/
* {
	transition: background .25s, color .25s, border .25s, box-shadow .25s;
}
</style>
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
</head>

<body>
	<nav class="navbar">

		<div class="logo">FoodHub</div>

		<div class="location-box">
			<span>📍</span>

			<div class="location-text">
				<small>Deliver To</small> <span><%=user.getAddress()%></span>
			</div>
		</div>

		<div class="search-box">
			<span class="search-icon">🔍</span> <input type="text"
				placeholder="Search for restaurants, dishes...">
		</div>

		<ul class="nav-links">
			<li><a href="callRestaurantServlet">Home</a></li>
			<li><a href="#">Restaurants</a></li>
		</ul>

		<a href="callProfileServlet" class="profile-link"> 👤 <%=user.getUserName()%>
		</a> <a href="CartPage.jsp" class="cart-link"> 🛒 </a>

	</nav>
	<div class="checkout-container">
		<div class="left-side">
			<div class="card">

				<div class="card-header">

					<h2>📍 Delivery Address</h2>

					<button class="change-btn">Change</button>

				</div>

				<div class="address">

					<%
					if (addresses != null && !addresses.isEmpty()) {

						for (Address address : addresses) {
					%>

					<label class="address-card"> <input type="radio"
						class="address-radio" name="addressRadio"
						value="<%=address.getAddressID()%>"
						<%=address.getIsDefault() ? "checked" : ""%>
						onchange="selectAddress(this)">

						<div class="address-details">

							<div class="address-top">

								<span class="address-type"> <%=address.getAddressType().toUpperCase()%>
								</span>

								<%
								if (address.getIsDefault()) {
								%>

								<span class="default-badge"> DEFAULT </span>

								<%
								}
								%>

							</div>

							<h3><%=address.getFullName()%></h3>

							<p>

								<%=address.getHouseNo()%>,
								<%=address.getArea()%>,
								<%=address.getCity()%>,
								<%=address.getState()%>
								-
								<%=address.getPincode()%>

							</p>

							<div class="phone">

								📞
								<%=address.getPhone()%>

							</div>

							<div class="address-actions">

								<a href="#">✏ Edit</a> <a href="#">🗑 Remove</a>

							</div>

						</div>

					</label>

					<%
					}
					}
					%>

				</div>

			</div>
			<div class="card">

				<h2>Delivery Instructions</h2>

				<textarea placeholder="Add cooking instructions..."></textarea>

			</div>
			<!-- Price Details -->
			<div class="card">

				<h2>Bill Details</h2>

				<div class="bill-row">

					<span>Item Total</span> <span>₹ <%=subtotal%></span>

				</div>

				<div class="bill-row">

					<span>GST</span> <span>₹ <%=gst%></span>

				</div>

				<div class="bill-row">

					<span>Delivery Fee</span> <span>₹ <%=delivery%></span>

				</div>

				<div class="bill-row">

					<span>Platform Fee</span> <span>₹ <%=platform%></span>

				</div>

				<div class="grand-total">

					<span>To Pay</span> <span>₹ <%=total%></span>

				</div>

			</div>
		</div>
		<!-- ================= RIGHT SIDE ================= -->

		<div class="right-side">

			<!-- Restaurant Card -->

			<div class="summary-card">

				<div class="restaurant-top">

					<img src="images/Logo.png" class="restaurant-img">

					<div>

						<h2>FoodHub Order</h2>

						<p>Fresh & Delicious Food</p>

					</div>

				</div>

				<hr>

				<!-- Cart Items -->

				<div class="items-list">

					<%
					if (cart != null) {
						for (CartItem item : cart.getItems().values()) {
					%>

					<div class="item">

						<div class="item-left">

							<img src="<%=item.getImagePath()%>" class="food-image">

							<div>

								<h4><%=item.getName()%></h4>

								<p>
									Qty :
									<%=item.getQuantity()%></p>

							</div>

						</div>

						<div class="item-price">

							₹
							<%=item.getPrice() * item.getQuantity()%>

						</div>

					</div>

					<%
					}
					}
					%>

				</div>

			</div>



			<!-- Coupon -->

			<div class="summary-card">

				<div class="coupon-row">

					<div>

						<h3>🎁 Apply Coupon</h3>

						<p>Save more on this order</p>

					</div>

					<button class="apply-btn">Apply</button>

				</div>

			</div>

			<!-- Place Order -->

			<form id="checkoutForm" action="placeOrderServlet" method="post">
				<input type="hidden" name="addressID" id="selectedAddress">

				<input type="hidden" name="razorpayPaymentId" id="razorpayPaymentId">

				<input type="hidden" name="razorpayOrderId" id="razorpayOrderId">

				<input type="hidden" name="razorpaySignature" id="razorpaySignature">
				<div class="card">

					<h2>Select Payment</h2>

					<div class="payment">

						<label> <input type="radio" name="payment" value="Cash"
							checked> 💵 Cash On Delivery

						</label> <label> <input type="radio" name="payment"
							value="Razorpay"> 💳 Pay Online

						</label>

					</div>

				</div>

				<div class="btn">
					<button type="button" id="placeOrderBtn" class="place-order-btn">

						Place Order • ₹
						<%=total%>

					</button>
				</div>

			</form>



			<div class="secure-box">🔒 Safe & Secure Payments</div>

		</div>

	</div>

	<!-- Footer -->

	<footer class="checkout-footer">

		<p>© 2026 FoodHub | Fast Delivery • Secure Payment • Delicious
			Food</p>

	</footer>
	<script>
		function selectAddress(radio) {

			document.getElementById("selectedAddress").value = radio.value;

		}

		window.onload = function() {

			const checked = document
					.querySelector('input[name="addressRadio"]:checked');

			if (checked) {

				document.getElementById("selectedAddress").value = checked.value;

			}

		}
	</script>
	<script >
	const placeOrderBtn =
		document.getElementById("placeOrderBtn");

		const checkoutForm =
		document.getElementById("checkoutForm");
		placeOrderBtn.addEventListener("click",function(){
			const paymentMethod =
				document.querySelector(
				'input[name="payment"]:checked'
				).value;
			const addressId =
				document.getElementById("selectedAddress").value;
			if(addressId===""){

			    alert("Please select a delivery address.");

			    return;

			}
			if(paymentMethod==="Cash"){
				placeOrderBtn.disabled=true;
				checkoutForm.submit();
			}
			else{
				 openRazorpay();
			}
		});
		function openRazorpay(){
			var options = {
					key:"rzp_test_TCUsTW2C16cyoP"	,
					amount:<%= (int)(total * 100) %>,
					currency:"INR",
					name:"FoodHub",
					description:"Food Order Payment",
					prefill:{

					    name:"<%=user.getUserName()%>",

					    email:"<%=user.getEmail()%>",

					   

					},
					image:"images/Logo.png",
					theme:{

					    color:"#FC8019"

					},
					modal:{

					    ondismiss:function(){

					    	alert("Payment was cancelled.");

					    }

					},
					handler:function(response){

						document.getElementById("razorpayPaymentId").value
						=
						response.razorpay_payment_id;

						document.getElementById("razorpayOrderId").value
						=
						response.razorpay_order_id;

						document.getElementById("razorpaySignature").value
						=
						response.razorpay_signature;
						placeOrderBtn.disabled=true;
						checkoutForm.submit();

						}
			};
			var rzp=new Razorpay(options);
			rzp.on("payment.failed",function(response){
				placeOrderBtn.disabled=false;
				alert(
						"Payment Failed!\n\n"
						+
						response.error.description
						+
						"\n\nPlease try again."
						);

			});
			rzp.open();

			return false;
			
		}
		
	</script>
</body>

</html>