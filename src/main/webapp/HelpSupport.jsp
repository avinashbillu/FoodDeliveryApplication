<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.User"%>
<%
User user = (User) session.getAttribute("user");
if (user == null) {
	response.sendRedirect("LoginPage.html");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Help & Support - FoodHub</title>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Poppins, sans-serif
}

html, body {
	height: 100%;
	overflow: hidden;
	background: #FFF8F3
}

a{
    text-decoration:none;
}

.navbar {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	height: 80px;
	background: #fff;
	display: flex;
	align-items: center;
	gap: 25px;
	padding: 0 30px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, .06);
	z-index: 1000
}

.logo {
	font-size: 32px;
	font-weight: 700;
	color: #FC8019
}

.location-box {
	display: flex;
	align-items: center;
	gap: 10px;
	padding: 10px 16px;
	border: 1px solid #e6e6e6;
	border-radius: 14px
}

.location-text {
	display: flex;
	flex-direction: column
}

.location-text small {
	font-size: 12px;
	color: #888
}

.location-text span {
	font-weight: 600
}

.search-box {
	flex: 1;
	position: relative
}

.search-box input {
	width: 100%;
	height: 50px;
	border: 1px solid #e6e6e6;
	border-radius: 14px;
	padding-left: 45px;
	outline: none
}

.search-icon {
	position: absolute;
	left: 15px;
	top: 50%;
	transform: translateY(-50%)
}

.nav-links {
	display: flex;
	list-style: none;
	gap: 30px
}

.nav-links a {
	text-decoration: none;
	color: #222;
	font-weight: 500
}

.nav-links a:hover {
	color: #fc8019;
}

.profile-link {
	text-decoration: none;
	color: #222;
	font-size: 18px;
	font-weight: 500
}

.cart-link {
	text-decoration: none;
	font-size: 28px
}

.main-container {
	display: flex;
	margin-top: 80px;
	height: calc(100vh - 80px)
}

.sidebar {
	position: fixed;
	top: 100px;
	left: 20px;
	bottom: 20px;
	width: 290px;
	background: #fff;
	border-radius: 24px;
	padding: 25px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, .06)
}

.sidebar h1 {
	font-size: 32px;
	margin-bottom: 10px
}

.line {
	width: 55px;
	height: 5px;
	background: #FC8019;
	border-radius: 20px;
	margin-bottom: 20px
}

.sidebar p {
	color: #777;
	line-height: 1.7;
	font-size: 14px;
	margin-bottom: 15px
}

.menu-item {
	display: block;
	text-decoration: none;
	color: #222;
	padding: 10px 14px;
	border-radius: 18px;
	font-size: 18px;
	margin-bottom: 4px
}

.menu-item:hover, .active {
	background: #FFF4EC;
	color: #FC8019;
	font-weight: 600
}

.logout {
	margin-top: 30px;
	color: #ff4d4d
}

.content {
	margin-left: 340px;
	flex: 1;
	overflow-y: auto;
	padding: 30px
}

.page-title {
	font-size: 34px;
	font-weight: 700;
	margin-bottom: 25px
}

/* ===== HERO ===== */
.hero-card {
	background: #fff;
	border-radius: 24px;
	padding: 35px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	box-shadow: 0 6px 20px rgba(0, 0, 0, .08);
	margin-bottom: 30px;
}

.hero-left h2 {
	font-size: 34px;
	margin: 15px 0;
	color: #222;
}

.hero-left p {
	color: #666;
	font-size: 16px;
	line-height: 1.8;
	max-width: 650px;
}

.hero-badge {
	background: #FFF3E7;
	color: #FC8019;
	padding: 8px 16px;
	border-radius: 25px;
	font-weight: 600;
}

.support-circle {
	width: 160px;
	height: 160px;
	border-radius: 50%;
	background: #FFF4EC;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 72px;
}

/* ===== SUPPORT GRID ===== */
.support-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 22px;
}

.support-card {
	background: #fff;
	border-radius: 20px;
	padding: 30px;
	box-shadow: 0 5px 16px rgba(0, 0, 0, .08);
	transition: .25s;
	cursor: pointer;
}

.support-card:hover {
	transform: translateY(-6px);
	box-shadow: 0 14px 28px rgba(0, 0, 0, .12);
}

.support-card .icon {
	width: 70px;
	height: 70px;
	border-radius: 18px;
	background: #FFF4EC;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 34px;
	margin-bottom: 18px;
}

.support-card h3 {
	margin-bottom: 10px;
	color: #222;
}

.support-card p {
	color: #777;
	line-height: 1.7;
}

.section-title {
	margin: 35px 0 20px;
	font-size: 30px;
	color: #222;
}

.faq-item {
	background: #fff;
	border-radius: 18px;
	margin-bottom: 15px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, .08);
	overflow: hidden;
}

.faq-question {
	width: 100%;
	padding: 22px;
	font-size: 18px;
	font-weight: 600;
	cursor: pointer;
	color: #222;
	background: #fff;
	display: block;
}

.faq-question span {
	font-size: 24px;
	color: #FC8019;
}

.faq-answer {
	padding: 18px 22px 22px;
	color: #666;
	line-height: 1.8;
}

details summary {
	list-style: none;
	cursor: pointer;
}

details summary::-webkit-details-marker {
	display: none;
}

details[open] .faq-question {
	color: #FC8019;
}

details {
	transition: .3s;
}

.support-bottom {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 25px;
	margin-top: 35px;
}

.contact-card, .hours-card {
	background: #fff;
	border-radius: 22px;
	padding: 30px;
	box-shadow: 0 5px 16px rgba(0, 0, 0, .08);
}

.contact-card h2, .hours-card h2 {
	margin-bottom: 20px;
	color: #222;
}

.contact-card p {
	margin: 15px 0;
	color: #666;
}

.chat-btn{
    display:inline-block;
    margin-top:20px;
    padding:14px 30px;
    background:#FC8019;
    color:#fff;
    border-radius:14px;
    text-decoration:none;
    font-size:16px;
    font-weight:600;
    cursor:pointer;
}

.hour-row {
	display: flex;
	justify-content: space-between;
	margin: 15px 0;
}

.support-status {
	margin-top: 25px;
	padding: 15px;
	background: #EAFBF0;
	border-radius: 14px;
	font-weight: 600;
	color: #1B8E42;
}

/* Floating Chat */
.floating-chat {
	position: fixed;
	right: 30px;
	bottom: 30px;
	background: #FC8019;
	color: #fff;
	padding: 16px 24px;
	border-radius: 50px;
	box-shadow: 0 10px 30px rgba(252, 128, 25, .35);
	font-weight: 600;
	cursor: pointer;
	z-index: 999;
	transition: .25s;
}

.floating-chat:hover {
	transform: translateY(-4px);
	background: #e56f00;
}
</style>
</head>
<body>
	<nav class="navbar">
		<div class="logo">FoodHub</div>
		<div class="location-box">
			<span>📍</span>
			<div class="location-text">
				<small>Deliver to</small><span>Vijayawada, 520001</span>
			</div>
		</div>
		<div class="search-box">
			<input type="text"
				placeholder="Search for restaurants, dishes, cuisines..."><span
				class="search-icon">🔍</span>
		</div>
		<ul class="nav-links">
			<li><a href="callRestaurantServlet">Home</a></li>
			<li><a href="#">Restaurants</a></li>
			<li><a href="#">Offers</a></li>
		</ul>
		<a href="callProfileServlet" class="profile-link">👤 <%=user.getUserName()%></a>
		<a href="CartPage.jsp" class="cart-link">🛒</a>
	</nav>
	<div class="main-container">
		<div class="sidebar">
			<h1>My Profile</h1>
			<div class="line"></div>
			<p>Manage your account, addresses and view your orders</p>
			<a href="callProfileServlet" class="menu-item">👤 Profile</a> <a
				href="MyOrdersServlet" class="menu-item">🛍 My Orders</a> <a
				href="AddressServlet" class="menu-item">📍 Addresses</a> <a
				href="HelpSupport.jsp" class="menu-item active">🎧 Help &
				Support</a> <a href="LogoutServlet" class="menu-item logout">🚪
				Logout</a>
		</div>
		<div class="content">
			<h1 class="page-title">Help & Support</h1>


			<div class="hero-card">

				<div class="hero-left">

					<span class="hero-badge">24 × 7 Customer Support</span>

					<h2>How can we help you today?</h2>

					<p>We're here to make your FoodHub experience smooth. Browse
						common issues below or contact our support team.</p>

				</div>

				<div class="hero-right">

					<div class="support-circle">🎧</div>

				</div>

			</div>


			<div class="support-grid">

				<div class="support-card">
					<div class="icon">📦</div>
					<h3>Order Issues</h3>
					<p>Track orders, missing items, cancellations and delays.</p>
				</div>

				<div class="support-card">
					<div class="icon">💳</div>
					<h3>Payment Problems</h3>
					<p>Card failures, UPI issues and payment verification.</p>
				</div>

				<div class="support-card">
					<div class="icon">💰</div>
					<h3>Refund Status</h3>
					<p>View refund progress and estimated completion time.</p>
				</div>

				<div class="support-card">
					<div class="icon">👤</div>
					<h3>Account & Login</h3>
					<p>Profile, password and account recovery assistance.</p>
				</div>

				<div class="support-card">
					<div class="icon">🛵</div>
					<h3>Delivery Partner</h3>
					<p>Delivery updates and rider communication support.</p>
				</div>

				<div class="support-card">
					<div class="icon">🍽</div>
					<h3>Restaurant Support</h3>
					<p>Restaurant availability, menu and order concerns.</p>
				</div>

			</div>


			<div class="faq-section">

				<h2 class="section-title">Frequently Asked Questions</h2>

				<details class="faq-item">

					<summary class="faq-question"> Where is my order? </summary>

					<div class="faq-answer">

						You can track your order in real time from the <b>My Orders</b>
						page.

					</div>

				</details>

				<details class="faq-item">

					<summary class="faq-question"> How do I cancel an order?

					</summary>

					<div class="faq-answer">Orders can be cancelled before the
						restaurant starts preparing them.</div>

				</details>

				<details class="faq-item">

					<summary class="faq-question"> When will I receive my
						refund? </summary>

					<div class="faq-answer">Refunds are usually processed within
						3–7 business days depending on your payment method.</div>

				</details>

				<details class="faq-item">

					<summary class="faq-question"> How can I update my
						address? </summary>

					<div class="faq-answer">

						Visit the <b>Addresses</b> page from your profile to add, edit or
						delete addresses.

					</div>

				</details>

			</div>

			<div class="support-bottom">

				<div class="contact-card">

					<h2>Contact Support</h2>

					<p>📞 +91 98765 43210</p>

					<p>✉ support@foodhub.com</p>

					<p>💬 Live chat available 24×7</p>

					<button class="chat-btn">Chat With Us</button>

				</div>

				<div class="hours-card">

					<h2>Business Hours</h2>

					<div class="hour-row">
						<span>Monday - Friday</span><strong>8 AM - 11 PM</strong>
					</div>
					<div class="hour-row">
						<span>Saturday</span><strong>8 AM - 12 AM</strong>
					</div>
					<div class="hour-row">
						<span>Sunday</span><strong>9 AM - 11 PM</strong>
					</div>

					<div class="support-status">🟢 Support Team Online</div>

				</div>

			</div>



			<style>

/* Responsive */
@media ( max-width :1200px) {
	.support-grid {
		grid-template-columns: repeat(2, 1fr);
	}
	.support-bottom {
		grid-template-columns: 1fr;
	}
}

@media ( max-width :900px) {
	.sidebar {
		position: relative;
		left: 0;
		top: 0;
		bottom: auto;
		width: 100%;
		margin: 20px;
	}
	.main-container {
		display: block;
	}
	.content {
		margin-left: 0;
		padding: 20px;
		height: auto;
	}
	.hero-card {
		flex-direction: column;
		text-align: center;
		gap: 25px;
	}
}

@media ( max-width :768px) {
	.navbar {
		overflow-x: auto;
		gap: 15px;
		padding: 0 15px;
	}
	.search-box {
		display: none;
	}
	.location-box {
		display: none;
	}
	.nav-links {
		gap: 18px;
	}
	.support-grid {
		grid-template-columns: 1fr;
	}
	.support-circle {
		width: 120px;
		height: 120px;
		font-size: 56px;
	}
	.hero-left h2 {
		font-size: 28px;
	}
	.popup, .contact-card, .hours-card {
		width: 100%;
	}
	.floating-chat {
		left: 20px;
		right: 20px;
		bottom: 20px;
		text-align: center;
	}
}
</style>

			<a href="mailto:support@foodhub.com" class="floating-chat"> 💬
				Chat With Us </a>

		</div>
		<!-- End Content -->

	</div>
	<!-- End Main Container -->

</body>
</html>
