<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.User"%>

<%
User user = (User) request.getAttribute("user");
if (user == null) {
	user = (User) session.getAttribute("user");
}
if (user == null) {
	response.sendRedirect("LoginPage.html");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile</title>

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
	background: #FFF8F3;
	overflow: hidden;
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
	z-index: 999;
}

.logo {
	font-size: 32px;
	font-weight: 700;
	color: #FC8019;
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

.page {
	display: flex;
	height: 100vh;
	padding-top: 80px;
}

.sidebar {
	width: 290px;
	background: #fff;
	border-radius: 24px;
	padding: 25px;
	position: fixed;
	left: 20px;
	top: 100px;
	bottom: 20px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, .06);
}

.sidebar h1 {
	font-size: 32px;
	margin-bottom: 10px;
}

.line {
	width: 55px;
	height: 5px;
	background: #FC8019;
	border-radius: 20px;
	margin-bottom: 20px;
}

.sidebar p {
	font-size: 14px;
	color: #777;
	line-height: 1.7;
	margin-bottom: 18px;
}

.menu-item {
	display: block;
	text-decoration: none;
	color: #222;
	padding: 12px 15px;
	border-radius: 18px;
	margin-bottom: 6px;
	transition: .25s;
}

.menu-item:hover, .active {
	background: #FFF4EC;
	color: #FC8019;
	font-weight: 600;
}

.logout {
	margin-top: 30px;
	color: #ff4d4d;
}

.content {
	flex: 1;
	margin-left: 340px;
	padding: 35px;
	height: calc(100vh - 80px);
	overflow-y: auto;
}

.page-title {
	font-size: 46px;
	font-weight: 700;
	margin-bottom: 25px;
}

.form-card {
	background: #fff;
	border-radius: 24px;
	padding: 35px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, .06);
}
</style>
</head>
<body>

	<nav class="navbar">

		<div class="logo">FoodHub</div>

		<div class="location-box">
			<span>📍</span>
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

		<a href="callProfileServlet" class="profile-link">👤 <%=user.getUserName()%></a>
		<a href="CartPage.jsp" class="cart-link">🛒</a>

	</nav>

	<div class="page">

		<div class="sidebar">

			<h1>My Profile</h1>

			<div class="line"></div>

			<p>Manage your account, addresses and view your orders</p>

			<a href="callProfileServlet" class="menu-item">👤 Profile</a> <a
				href="MyOrdersServlet" class="menu-item">🛍 My Orders</a> <a
				href="AddressServlet" class="menu-item">📍 Addresses</a> <a
				href="HelpSupport.jsp" class="menu-item">🎧 Help & Support</a> <a
				href="LogoutServlet" class="menu-item logout">🚪 Logout</a>

		</div>

		<div class="content">

			<h1 class="page-title">Edit Profile</h1>

			<div class="form-card">

				<!-- Part 2 starts here -->

				<form action="EditProfileServlet" method="post">

					<div style="display: flex; gap: 40px; align-items: flex-start;">

						<!-- Avatar -->
						<div style="text-align: center; width: 220px;">

							<div
								style="width: 160px; height: 160px; margin: auto; border-radius: 50%; background: #FFF4EC; display: flex; align-items: center; justify-content: center; font-size: 80px;">
								👤</div>

							<h2 style="margin-top: 18px;"><%=user.getUserName()%></h2>
							<p style="color: #777;">FoodHub Customer</p>

						</div>

						<!-- Form Fields -->

						<div style="flex: 1;">

							<div
								style="display: grid; grid-template-columns: 1fr 1fr; gap: 25px;">

								<div>
									<label style="font-weight: 600;">User ID</label><br> <br>
									<input type="text" value="<%=user.getUserID()%>" readonly
										style="width: 100%; height: 52px; padding: 0 15px; border: 1px solid #ddd; border-radius: 12px; background: #f8f8f8;">
								</div>

								<div>
									<label style="font-weight: 600;">Username</label><br> <br>
									<input type="text" name="username"
										value="<%=user.getUserName()%>" required minlength="3"
										maxlength="30"
										style="width: 100%; height: 52px; padding: 0 15px; border: 1px solid #ddd; border-radius: 12px;">
								</div>

								<div>
									<label style="font-weight: 600;">Email Address</label><br>
									<br> <input type="email" name="email"
										value="<%=user.getEmail()%>" required
										style="width: 100%; height: 52px; padding: 0 15px; border: 1px solid #ddd; border-radius: 12px;">
								</div>

								<div>
									<label style="font-weight: 600;">Phone Number</label><br>
									<br> <input type="tel" name="phone"
										placeholder="9876543210" pattern="[0-9]{10}" maxlength="10"
										style="width: 100%; height: 52px; padding: 0 15px; border: 1px solid #ddd; border-radius: 12px;">
									<small style="color: #888;">(Add phone column in users
										table if not available)</small>
								</div>

							</div>

							<div style="margin-top: 28px;">

								<label style="font-weight: 600;">Default Delivery
									Address</label><br> <br>

								<textarea name="address" rows="5" required
									style="width: 100%; padding: 15px; border: 1px solid #ddd; border-radius: 12px; resize: none;"><%=user.getAddress()%></textarea>

								<small style="color: #888;"> If you are using the
									Address module, replace this value with the user's default
									address. </small>

							</div>

						</div>

					</div>

					<!-- Part 3 Starts Here -->

					<div
						style="margin-top: 35px; display: flex; justify-content: flex-end; gap: 18px;">

						<a href="callProfileServlet"
							style="text-decoration: none; padding: 14px 30px; border: 2px solid #d9d9d9; border-radius: 12px; color: #444; font-weight: 600; transition: .25s;">
							Cancel </a>

						<button type="submit"
							style="border: none; background: #FC8019; color: #fff; padding: 14px 32px; border-radius: 12px; font-size: 16px; font-weight: 600; cursor: pointer; transition: .25s;">
							💾 Save Changes</button>

					</div>

					<%
					String success = (String) request.getAttribute("success");
					String error = (String) request.getAttribute("error");

					if (success != null) {
					%>

					<div
						style="margin-top: 25px; padding: 16px; background: #EAFBF0; color: #1B8E42; border-radius: 12px; font-weight: 600;">
						✅
						<%=success%>
					</div>
					<%
					session.removeAttribute("success");
					%>
					<%
					}

					if (error != null) {
					%>

					<div
						style="margin-top: 25px; padding: 16px; background: #FFECEC; color: #D32F2F; border-radius: 12px; font-weight: 600;">
						❌
						<%=error%>
					</div>

					<%
					}
					%>

				</form>



				<!-- Part 4 Starts Here -->

				<style>

/* =========================
   RESPONSIVE DESIGN
========================= */
@media ( max-width :1200px) {
	.content {
		margin-left: 320px;
		padding: 25px;
	}
	.form-card {
		padding: 25px;
	}
}

@media ( max-width :992px) {
	body {
		overflow: auto;
	}
	.page {
		display: block;
		padding-top: 80px;
	}
	.sidebar {
		position: relative;
		width: calc(100% - 40px);
		left: 20px;
		top: 20px;
		bottom: auto;
		margin-bottom: 20px;
	}
	.content {
		margin-left: 0;
		height: auto;
		overflow: visible;
		padding: 20px;
	}
	.navbar {
		gap: 15px;
		overflow-x: auto;
	}
}

@media ( max-width :768px) {
	.search-box {
		display: none;
	}
	.location-box {
		display: none;
	}
	.nav-links {
		gap: 15px;
	}
	.page-title {
		font-size: 34px;
	}
	.form-card {
		padding: 20px;
	}
	form>div:first-child {
		flex-direction: column !important;
	}
}

@media ( max-width :576px) {
	.navbar {
		padding: 0 15px;
	}
	.logo {
		font-size: 26px;
	}
	.profile-link {
		font-size: 16px;
	}
	input, textarea {
		font-size: 15px;
	}
	button, a {
		font-size: 15px;
	}
}
</style>

			</div>
			<!-- End Form Card -->

		</div>
		<!-- End Content -->

	</div>
	<!-- End Page -->

</body>
</html>
