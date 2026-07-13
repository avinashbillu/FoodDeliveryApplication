<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String ownerName = (String) request.getAttribute("ownerName");
String restaurantName = (String) request.getAttribute("restaurantName");
if (ownerName == null)
	ownerName = "Restaurant Owner";
if (restaurantName == null)
	restaurantName = "My Restaurant";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<link
	href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css"
	rel="stylesheet">
<meta charset="UTF-8">
<title>FoodHub Owner Dashboard</title>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet">
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Poppins, sans-serif
}

body {
	background: #fff8f3;
	color: #1f2937;
	overflow: hidden
}

.wrapper {
	display: flex;
	min-height: 100vh;
	overflow: hidden;
}

.sidebar {
	position: fixed;
	top: 0;
	left: 0;
	width: 270px;
	height: 100vh;
	background: #ffffff;
	border-right: 1px solid #f2f2f2;
	padding: 28px 18px;
	display: flex;
	flex-direction: column;
	box-shadow: 8px 0 24px rgba(0, 0, 0, .05);
	z-index: 999;
}

.brand {
	margin-bottom: 28px;
}

.logo {
	font-size: 28px;
	font-weight: 700;
	color: #fc8019;
	display: flex;
	align-items: center;
	gap: 8px;
	margin-bottom: 1px;
}

.logo span {
	font-size: 28px;
}

.role {
	margin-top: 3px;
	color: #777;
	font-size: 17px;
	font-weight: 500;
}

.menu {
	display: flex;
	flex-direction: column;
}

.menu a {
	height: 20px;
	display: flex;
	align-items: center;
	gap: 16px;
	padding: 14px 16px;
	margin-bottom: 10px;
	border-radius: 14px;
	color: #384255;
	text-decoration: none;
	font-size: 18px;
	font-weight: 500;
	transition: .25s;
	display: flex;
}

.menu a:hover {
	background: #fff4ec;
	color: #fc8019;
}

.menu a.active {
	background: #fff4ec;
	color: #fc8019;
	font-weight: 600;
}

.icon {
	width: 24px;
	text-align: center;
	font-size: 20px;
}

.badge {
	margin-left: auto;
	background: #ffe5d3;
	color: #ff6b00;
	padding: 3px 10px;
	border-radius: 20px;
	font-size: 13px;
	font-weight: 600;
}

.upgrade-card {
	background: #fff4ec;
	border-radius: 18px;
	padding: 18px;
	position: relative;
}

.upgrade-card h3 {
	font-size: 22px;
	margin-bottom: 8px;
}

.upgrade-card p {
	color: #666;
	line-height: 1.6;
	font-size: 15px;
	margin-bottom: 18px;
}

.upgrade-card button {
	border: none;
	background: #fc8019;
	color: #fff;
	padding: 10px 20px;
	border-radius: 10px;
	cursor: pointer;
	font-size: 15px;
	font-weight: 600;
}

.upgrade-card button:hover {
	background: #e96d00;
}

.rocket {
	position: absolute;
	right: 16px;
	bottom: 14px;
	font-size: 56px;
	opacity: .9;
}

.main {
	margin-left: 270px;
	width: calc(100% - 270px);
	height: 100vh;
	overflow-y: auto;
	overflow-x: hidden;
	padding: 28px;
}

.topbar {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	margin-bottom: 30px
}

.topbar h1 {
	font-size: 34px;
	line-height: 1.1;
}

.topbar p {
	font-size: 15px;
	color: #666;
}

.small-title {
	font-size: 24px;
	color: #666;
}

.welcome h1 {
	font-size: 26px;
	font-weight: 700;
	margin: 8px 0;
	color: #1f2937;
}

.welcome p {
	font-size: 18px;
	color: #777;
}

.notification {
	position: relative;
	font-size: 24px;
	cursor: pointer;
}

.notification span {
	position: absolute;
	top: -8px;
	right: -8px;
	width: 20px;
	height: 20px;
	background: #ff4d4f;
	color: white;
	border-radius: 50%;
	font-size: 11px;
	display: flex;
	justify-content: center;
	align-items: center;
}

.date-box {
	padding: 12px 20px;
	background: white;
	border-radius: 14px;
	font-size: 15px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, .06);
}

.profile {
	display: flex;
	align-items: center;
	gap: 12px
}

.profile .avatar {
	width: 58px;
	height: 58px;
	border-radius: 50%;
	background: #fff3ea;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 24px
}

.profile-area {
	display: flex;
	align-items: center;
	gap: 20px;
}

.profile h4 {
	font-size: 18px;
	margin-bottom: 4px;
	margin-right: 20px;
}

.profile p {
	font-size: 14px;
	color: #777;
}

.stats {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 16px;
	margin-bottom: 20px
}

.stat-card, .panel {
	background: #fff;
	border-radius: 16px;
	padding: 18px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, .05)
}

.stat-icon {
	width: 46px;
	height: 46px;
	border-radius: 50%;
	background: #fff3ea;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 20px;
	margin-bottom: 10px
}

.stat-top {
	display: flex;
	gap: 18px;
	align-items: center;
}

.stat-value {
	font-size: 28px;
	font-weight: 700
}

.stat-growth {
	color: #18a34a;
	font-weight: 600
}

.stat-card div:first-of-type {
	font-size: 16px;
}

.icon {
	width: 64px;
	height: 64px;
	border-radius: 50%;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 30px;
	font-weight: 700;
}

.orange {
	background: #fff0e6;
	color: #ff6b00;
}

.green {
	background: #ebfff0;
	color: #18a34a;
}

.purple {
	background: #f2efff;
	color: #7158e2;
}

.yellow {
	background: #fff8e7;
	color: #ffb400;
}

.stat-card span {
	font-size: 16px;
	color: #777;
}

.stat-card h2 {
	font-size: 20px;
	margin: 6px 0;
	font-weight: 500;
}

.stat-card small {
	color: #17a34a;
	font-size: 15px;
	font-weight: 400;
}

.content {
	display: grid;
	grid-template-columns: 2fr 1fr;
	gap: 16px
}

.chart {
	height: 270px;
	background: linear-gradient(#fff, #fff7f1);
	border: 1px solid #eee;
	border-radius: 16px;
	position: relative;
	overflow: hidden
}

.panel h2 {
	font-size: 22px;
	margin-bottom: 16px;
}

.chart svg {
	position: absolute;
	inset: 0;
	width: 100%;
	height: 100%
}

.progress {
	height: 8px;
	background: #eee;
	border-radius: 20px;
	margin: 8px 0 15px
}

.progress div {
	height: 100%;
	background: #fc8019;
	border-radius: 20px
}

.review {
	background: #fff8f3;
	border-radius: 14px;
	padding: 12px;
	margin-top: 10px
}

.orders {
	margin-top: 18px
}

.orders table {
	width: 100%;
	border-collapse: collapse;
	background: #fff;
	border-radius: 18px;
	overflow: hidden
}

.orders th, .orders td {
	padding: 13px 16px;
	border-bottom: 1px solid #f0f0f0;
	text-align: left;
	font-size: 14px;
	'
}

.orders th {
	background: #fff4ec
}

.status {
	padding: 5px 10px;
	border-radius: 20px;
	background: #e9fbef;
	color: #149f4a;
	font-size: 12px
}

.main::-webkit-scrollbar {
	width: 8px;
}

.main::-webkit-scrollbar-thumb {
	background: #fc8019;
	border-radius: 10px;
}

.main::-webkit-scrollbar-track {
	background: #f6f6f6;
}
</style>
</head>
<body>
	<div class="wrapper">
		<aside class="sidebar">

			<div class="brand">

				<div class="logo">
					FoodHub <span>👨‍🍳</span>
				</div>

				<div class="role">Restaurant Owner</div>

			</div>

			<nav class="menu">

				<a class="active" href="#"> <i class="ri-home-5-line"></i> <span>Dashboard</span></a>
				<a href="OwnerOrdersServlet"> <i class="ri-file-list-3-line"></i> <span>Orders</span></a> 
					<a href="OwnerMenuServlet"> <i class="ri-restaurant-line"></i> <span>Menu</span></a> 
					<a href="CategoryManagementServlet">
					<i class="ri-layout-grid-line"></i> <span>Categories</span>
				</a> <a href="OwnerCustomersServlet"> <i class="ri-group-line"></i> <span>Customers</span></a>
				<a href="#"> <i class="ri-money-rupee-circle-line"></i> <span>Earnings</span></a>
				<a href="#"> <i class="ri-bar-chart-line"></i> <span>Reports</span></a>
				<a href="#"> <i class="ri-megaphone-line"></i> <span>Marketing</span></a>
				<a href="#"> <i class="ri-star-line"></i> <span>Reviews</span></a> <a
					href="#"> <i class="ri-settings-3-line"></i> <span>Settings</span></a>

			</nav>

			<div class="upgrade-card">

				<h3>Grow your business</h3>

				<p>Increase your visibility and get more orders.</p>

				<button>Upgrade Now</button>

				<div class="rocket">🚀</div>

			</div>

		</aside>

		<main class="main">
			<div class="topbar">

				<div class="welcome">

					<span class="small-title">Welcome back,</span>

					<h1>Restaurant Owner 👋</h1>

					<p>Here's what's happening with your restaurant today.</p>

				</div>

				<div class="profile-area">

					<div class="notification">

						🔔 <span>5</span>

					</div>

					<div class="date-box">📅&nbsp;&nbsp;May 22 – May 28, 2024</div>

					<div class="profile">

						<div class="avatar">👨‍🍳</div>

						<div>

							<h4><%=ownerName%></h4>

							<p><%=restaurantName%></p>

						</div>

					</div>

				</div>

			</div>

			<!-- STATISTICS -->

			<div class="stats">

				<div class="stat-card">

					<div class="stat-top">

						<div class="icon orange">📦</div>

						<div>

							<span>Total Orders</span>

							<h2>128</h2>

							<small>↑ 18.6% from last week</small>

						</div>

					</div>

				</div>



				<div class="stat-card">

					<div class="stat-top">

						<div class="icon green">₹</div>

						<div>

							<span>Total Earnings</span>

							<h2>₹25,430</h2>

							<small>↑ 22.4% from last week</small>

						</div>

					</div>

				</div>



				<div class="stat-card">

					<div class="stat-top">

						<div class="icon purple">👥</div>

						<div>

							<span>Active Customers</span>

							<h2>96</h2>

							<small>↑15.3% from last week</small>

						</div>

					</div>

				</div>



				<div class="stat-card">

					<div class="stat-top">

						<div class="icon yellow">📈</div>

						<div>

							<span>Avg. Order Value</span>

							<h2>₹198</h2>

							<small>↑8.7% from last week</small>

						</div>

					</div>

				</div>
			</div>
			<div class="content">
				<div class="panel">
					<h2>📈 Earnings Overview</h2>
					<div class="chart">
						<svg viewBox="0 0 700 280">
							<polyline fill="none" stroke="#fc8019" stroke-width="4"
								points="20,220 90,180 160,190 230,130 300,145 370,90 440,110 510,70 580,90 650,45" /></svg>
					</div>
				</div>
				<div class="panel">
					<h2>Restaurant Performance</h2>
					<b>Order Completion</b>
					<div class="progress">
						<div style="width: 94%"></div>
					</div>
					<b>Customer Satisfaction</b>
					<div class="progress">
						<div style="width: 96%"></div>
					</div>
					<b>Food Quality</b>
					<div class="progress">
						<div style="width: 92%"></div>
					</div>
					<div class="review">
						<b>★★★★★ Excellent Taste!</b><br>Food was delicious and
						arrived hot.
					</div>
					<div class="review">
						<b>★★★★☆ Fast Delivery</b><br>Quick delivery and great
						packaging.
					</div>
				</div>
			</div>

			<div class="orders">
				<table>
					<thead>
						<tr>
							<th>Customer</th>
							<th>Order</th>
							<th>Items</th>
							<th>Amount</th>
							<th>Status</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Avinash</td>
							<td>#FH1024</td>
							<td>3</td>
							<td>₹560</td>
							<td><span class="status">Preparing</span></td>
						</tr>
						<tr>
							<td>Rahul</td>
							<td>#FH1023</td>
							<td>2</td>
							<td>₹430</td>
							<td><span class="status">Delivered</span></td>
						</tr>
						<tr>
							<td>Surya</td>
							<td>#FH1022</td>
							<td>5</td>
							<td>₹880</td>
							<td><span class="status">Pending</span></td>
						</tr>
					</tbody>
				</table>
			</div>
		</main>
	</div>
</body>
</html>
