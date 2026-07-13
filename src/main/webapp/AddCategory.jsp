<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Category</title>
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
	font-family: 'Poppins', sans-serif
}

body {
	background: #fff8f3
}

.wrapper {
	display: flex;
	height: 100vh
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
	padding: 35px
}

.card {
	background: #fff;
	padding: 35px;
	border-radius: 20px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, .06);
	max-width: 900px
}

.grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px
}

.full {
	grid-column: 1/3
}

label {
	display: block;
	font-weight: 600;
	margin-bottom: 8px
}

input, textarea, select {
	width: 100%;
	padding: 14px;
	border: 1px solid #ddd;
	border-radius: 12px
}

textarea {
	height: 120px;
	resize: none
}

.buttons {
	display: flex;
	gap: 15px;
	margin-top: 25px
}

.save {
	background: #fc8019;
	color: #fff;
	border: none;
	padding: 14px 28px;
	border-radius: 12px;
	cursor: pointer
}

.cancel {
	text-decoration: none;
	background: #ececec;
	color: #333;
	padding: 14px 28px;
	border-radius: 12px
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
			<h1>Add New Category</h1>
			<p style="margin: 10px 0 25px; color: #666;">Create a new
				category for your restaurant.</p>

			<div class="card">
				<form action="CategoryManagementServlet?action=add" method="post">
					<div class="grid">

						<div>
							<label>Category Name</label> <input type="text"
								name="categoryName" placeholder="e.g. Biryani, Pizza" required>
						</div>

						<div>
							<label>Status</label> <select name="active">
								<option value="true">Active</option>
								<option value="false">Inactive</option>
							</select>
						</div>

						<div class="full">
							<label>Description</label>
							<textarea name="description"
								placeholder="Enter category description..." required></textarea>
						</div>

						<div class="full">
							<label>Image Path</label> <input type="text" name="imagePath"
								placeholder="images/categories/biryani.jpg" required>
						</div>

					</div>

					<div class="buttons">
						<button class="save" type="submit">Save Category</button>
						<a class="cancel" href="OwnerCategoriesServlet">Cancel</a>
					</div>

				</form>
			</div>

		</div>
	</div>
</body>
</html>
