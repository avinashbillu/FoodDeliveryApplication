<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.tap.model.Category"%>
<%
List<Category> categories = (List<Category>) request.getAttribute("categories");
if (categories == null)
	categories = new ArrayList<>();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Owner Categories</title>
<link
	href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css"
	rel="stylesheet">
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

body {
	background: #fff8f3
}

.wrapper {
	display: flex
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
	padding: 35px;
	width: calc(100% - 270px)
}

.top {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 25px
}

.add {
	background: #fc8019;
	color: #fff;
	padding: 12px 18px;
	border-radius: 10px;
	text-decoration: none
}

.grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
	gap: 20px
}

.card {
	background: #fff;
	border-radius: 18px;
	overflow: hidden;
	box-shadow: 0 8px 20px rgba(0, 0, 0, .08)
}

img {
	width: 100%;
	height: 180px;
	object-fit: cover
}

.content {
	padding: 18px
}

.actions {
	display: flex;
	gap: 8px;
	margin-top: 15px
}

.actions a {
	flex: 1;
	text-align: center;
	padding: 10px;
	border-radius: 8px;
	text-decoration: none;
	font-size: 13px
}

.edit {
	background: #fff4e8;
	color: #fc8019
}

.delete {
	background: #ffe9e9;
	color: #d22
}

.toggle {
	background: #eef3ff;
	color: #245
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

				<a href="ownerDashboardServlet"> <i class="ri-home-5-line"></i>
					<span>Dashboard</span></a> <a href="OwnerOrdersServlet"> <i
					class="ri-file-list-3-line"></i> <span>Orders</span></a> <a  href="OwnerMenuServlet">
					<i class="ri-restaurant-line"></i> <span>Menu</span>
				</a> <a class="active" href="CategoryManagementServlet"> <i class="ri-layout-grid-line"></i> <span>Categories</span>
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
		<div class="main">
			<div class="top">
				<h1>Category Management</h1>
				<a class="add" href="CategoryManagementServlet?action=addPage">+
					Add Category</a>
			</div>
			<div class="grid">
				<%
				for (Category c : categories) {
				%>
				<div class="card">
					<img src="<%=c.getImagePath()%>">
					<div class="content">
						<h3><%=c.getCategoryName()%></h3>
						<p><%=c.getDescription()%></p>
						<div class="actions">
							<a class="edit"
								href="CategoryManagementServlet?action=edit&categoryId=<%=c.getCategoryID()%>">Edit</a>
							<a class="delete"
								href="CategoryManagementServlet?action=delete&categoryId=<%=c.getCategoryID()%>"
								onclick="return confirm('Delete?')">Delete</a> <a class="toggle"
								href="CategoryManagementServlet?action=toggle&categoryId=<%=c.getCategoryID()%>"><%=c.getIsActive() ? "Disable" : "Enable"%></a>
						</div>
					</div>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</div>
</body>
</html>
