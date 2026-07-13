<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.tap.model.Restaurant"%>
<%@ page import="com.tap.model.Cart"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>FoodHub</title>

<link rel="stylesheet" href="RestaurantCSS.css">

<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">

</head>

<body>

	<nav class="navbar">

		<div class="logo">FoodHub</div>

		<div class="location-box">
			<span class="location-icon">📍</span>
			<div class="location-text">
				<small>Deliver to</small> <span>Vijayawada, 520001</span>
			</div>
			<span class="arrow">⌄</span>
		</div>

		<div class="search-box">

			<form action="SearchServlet" method="get">

				<input type="text" name="keyword"
					placeholder="Search for restaurants, dishes, cuisines..."
					autocomplete="off" required>

				<button class="search-btn" type="submit">🔍</button>

			</form>

		</div>
		<%
		String username = (String) session.getAttribute("username");
		%>
		<ul class="nav-links">
			<li><a href="#" class="active">Home</a></li>
			<li><a href="#">Restaurants</a></li>
			<li><a href="#">Offers</a></li>

			<%
			if (username == null) {
			%>

			<li><a href="LoginPage.html">Login</a></li>
		</ul>

		<button class="signup-btn">
			<a href="RegistrationPage.html" class="signup-btn1">Sign Up</a>
		</button>

		<%
		} else {
		%>

		</ul>

		<a href="callProfileServlet" class="profile-box"> 👤 <%=username%>
		</a>

		<%
		}
		%>

		<%
		int cartCount = 0;
		if (session.getAttribute("cart") != null) {
			Cart cart = (Cart) session.getAttribute("cart");
			cartCount = cart.getItems().size();
		}
		%>
		<a href="CartPage.jsp" class="cart-link"> <span class="cart-icon">
				🛒 <span class="cart-count"><%=cartCount%></span>
		</span>
		</a>

	</nav>
	<div class="page-container">
		<section class="hero">


			<div class="hero-left">

				<h1>
					Good Food,<br> <span>Great Mood!</span>
				</h1>

				<p>Order from the best restaurants near you and enjoy your
					favorites.</p>

				<div class="hero-buttons">

					<button class="order-btn">Order Now →</button>

					<button class="offer-btn">🎁 View Offers</button>

				</div>

			</div>

			<div class="hero-center">

				<img src="images/banner6.png">

			</div>


			<div class="hero-right">

				<div class="info-card">
					<h4>🛵 Fast Delivery</h4>
					<p>At Your Doorstep</p>
				</div>

				<div class="info-card">
					<h4>⏰ 20 min</h4>
					<p>Average Delivery Time</p>
				</div>

				<div class="info-card">
					<h4>🏷 Great Offers</h4>
					<p>On Every Order</p>
				</div>

			</div>

		</section>

		<div class="categories-wrapper">
			<div class="categories">

				<div class="cat">
					🥗 <span>Pure Veg</span>
				</div>
				<div class="cat">
					🍗 <span>Non Veg</span>
				</div>
				<div class="cat">
					🍽️ <span>North Indian</span>
				</div>
				<div class="cat">
					🍛 <span>South Indian</span>
				</div>
				<div class="cat">
					🍰 <span>Dessert</span>
				</div>
				<div class="cat">
					🍛 <span>Biryani</span>
				</div>
				<div class="cat">
					🍜 <span>Chinese</span>
				</div>
				<div class="cat">
					🍨 <span>Ice Cream</span>
				</div>
				<div class="cat">
					🎂 <span>Cake</span>
				</div>
				<div class="cat">
					🍔 <span>Burger</span>
				</div>
				<div class="cat">
					🍕 <span>Pizza</span>
				</div>
				<div class="cat">
					🌯 <span>Rolls</span>
				</div>

			</div>
		</div>


		<%
		List<Restaurant> allrestaurant = (List<Restaurant>) request.getAttribute("allrestaurant");
		%>
		<div class="restaurant-wrapper">
			<div class="restaurant-header">

				<%
				String keyword = (String) request.getAttribute("searchKeyword");
				%>

				<h2 class="section-title">

					<%
					if (keyword == null) {
					%>

					Top Restaurants Near You

					<%
					} else {
					%>

					Search Results for "<%=keyword%>"

					<%
					}
					%>

				</h2>

				<div class="restaurant-filters">
					<button>Sort By ▼</button>
					<button>Fastest Delivery</button>
					<button>Rating 4+</button>
				</div>

			</div>


			<div class="restaurant-container">
				<%
				if (allrestaurant == null || allrestaurant.isEmpty()) {
				%>

				<div class="no-result">

					<h2>No Restaurants Found</h2>

					<p>Try searching another restaurant or dish.</p>

				</div>

				<%
				} else {
				%>
				<%
				for (Restaurant restaurant : allrestaurant) {
				%>

				<a
					href="menuServlet?restaurantID=<%=restaurant.getRestaurantID()%>
&restaurantName=<%=java.net.URLEncoder.encode(restaurant.getName(), "UTF-8")%>
&rating=<%=restaurant.getRating()%>
&deliveryTime=<%=restaurant.getDeliveryTime()%>
&cuisine=<%=java.net.URLEncoder.encode(restaurant.getCuisineTypes(), "UTF-8")%>">
					<div class="card">

						<div class="image-box">

							<img src="<%=restaurant.getImagePath()%>">

							<div class="time-badge">
								🕒
								<%=restaurant.getDeliveryTime()%>
								min
							</div>

							<div class="heart">❤</div>

							<div class="offer">40% OFF</div>

						</div>

						<div class="card-content">

							<div class="top">

								<div class="restaurant-name">
									<%=restaurant.getName()%>
								</div>

								<div class="rating">
									★
									<%=restaurant.getRating()%>
								</div>

							</div>

							<div class="cuisine">
								<%=restaurant.getCuisineTypes()%>
							</div>

							<div class="details">

								<span> <%=restaurant.getDeliveryTime()%> mins
								</span> <span> ₹400 for two </span>

							</div>

							<div class="location">
								📍
								<%=restaurant.getAddress()%>
							</div>

						</div>

					</div>
				</a>

				<%
				}
				%>
				<%
				}
				%>
			</div>
		</div>
		<section class="download-app">

			<div class="download-left">

				<h2>Get the FoodHub App for a Better Experience</h2>

			</div>

			<div class="download-right">

				<img src="images/google-play.jpg"> <img
					src="images/app-store.jpg">

			</div>

		</section>
		<footer class="footer">

			<div class="footer-container">

				<div class="footer-brand">

					<h2>FoodHub</h2>

					<p>© 2026 FoodHub Ltd.</p>

				</div>

				<div class="footer-column">

					<h3>Company</h3>

					<a href="#">About Us</a> <a href="#">Careers</a> <a href="#">Blog</a>

					<a href="#">FoodHub One</a>

				</div>

				<div class="footer-column">

					<h3>Contact</h3>

					<a href="#">Help Center</a> <a href="#">Partner With Us</a> <a
						href="#">Delivery Partner</a> <a href="#">Support</a>

				</div>

				<div class="footer-column">

					<h3>Available In</h3>

					<a>Vijayawada</a> <a>Hyderabad</a> <a>Bangalore</a> <a>Chennai</a>

				</div>

				<div class="footer-column">

					<h3>Follow Us</h3>

					<div class="social">

						<span><img src="images/instagram.svg"></span> <span><img src="images/twitter.svg"></span> <span><img src="images/facebook.svg"></span> <span><img src="images/youtube.svg"></span>

					</div>

				</div>

			</div>

		</footer>
	</div>
</body>
</html>