<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Restaurant - FoodHub Partner</title>
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
	background: #fff8f3;
	height: 100vh;
	overflow: hidden
}

.container {
	display: flex;
	height: 100vh;
	width:100%;
	overflow:hidden;
}

.left {
	width: 50%;
	padding: 30px 45px;
	position: relative;
	background: #fff8f3;
	overflow: hidden
}

.logo {
	font-size: 38px;
	font-weight: 700;
	color: #fc8019;
	margin-bottom: 30px
}

h1 {
	font-size: 58px;
	line-height: 1.05;
	color: #222;
	margin-bottom:14px;
    letter-spacing:-1px;
}

h1 span {
	color: #fc8019
}

.desc {
	width: 410px;
	color: #666;
	font-size: 17px;
	line-height: 1.65;
}

.cards {
	margin-top: 24px;
	width: 360px
}

.card {
	display: flex;
	align-items: center;
	gap: 16px;
	background: #fff;
	padding: 15px;
	border-radius: 18px;
	margin-bottom: 15px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, .06)
}

.icon {
	width: 52px;
	height: 52px;
	border-radius: 14px;
	background: #fff3ea;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 28px
}

.card h3 {
	font-size: 19px;
	color: #222
}

.card p {
	font-size: 14px;
	color: #777
}

.food {
	position: absolute;
	bottom: -10px;
	left: 68%;
	transform: translateX(-50%);
	width: 520px
}

.bg-icon{

    position:absolute;

    opacity:.10;

    font-size:60px;

    color:#fc8019;
}

.chef{

    top:40px;

    right:200px;
}

.leaf{

    top:330px;

    right:520px;
}

.cover{

    top:220px;

    right:40px;
}

.dot{

    width:15px;

    height:15px;

    border-radius:50%;

    position:absolute;

    background:#fc8019;

    opacity:.35;
}

.dot1{

    top:180px;

    right:150px;
}

.dot2{

    top:400px;

    right:50px;
}

.dot3{

    bottom:120px;

    right:300px;
}

.restaurant-image{

    position:absolute;

    bottom:10px;

    right:-55px;

    width:420px;

    opacity:.96;
}

.right {
	width: 50%;
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 28px;
	height:720px;
}

.form-card {
	width: 100%;
	max-width: 600px;
	background: #fff;
	padding: 30px;
	border-radius: 24px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, .07)
	
}

.form-card h2 {
	font-size: 35px;
	color: #222
}

.sub {
	font-size:16px;
    color:#666;
    margin:6px 0 22px;
}

.group {
	margin-bottom: 5px
}

label {
	 display:block;
    font-size:15px;
    font-weight:500;
    margin-bottom:5px;
}

input,select,textarea{
    width:100%;
    padding:13px 15px;
    border:1px solid #e5e5e5;
    border-radius:12px;
    font-size:15px;
    outline:none;
}

input:focus, select:focus, textarea:focus {
	border-color: #fc8019
}

textarea {
	height: 80px;
	resize: none
}

.row {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 14px
}

.btn{
    width:100%;
    height:52px;
    border:none;
    border-radius:14px;
    background:#fc8019;
    color:#fff;
    font-size:17px;
    font-weight:600;
    cursor:pointer;
    transition:.3s;
}

.btn:hover{
    background:#e86f07;
}

.note{
    margin-top:16px;
    text-align:center;
    font-size:15px;
    color:#666;
}

.note a{
    color:#fc8019;
    text-decoration:none;
    font-weight:600;
}
</style>
</head>
<body>
	<div class="container">
		<div class="left">
			<div class="logo">FoodHub Partner</div>
			<h1>
				Build Your<br>
				<span>Restaurant!</span>
			</h1>
			<p class="desc">Complete your restaurant profile and start
				receiving online orders through FoodHub.</p>

			<div class="cards">
				<div class="card">
					<div class="icon">🍽️</div>
					<div>
						<h3>Create Restaurant</h3>
						<p>Start selling online instantly.</p>
					</div>
				</div>
				<div class="card">
					<div class="icon">📦</div>
					<div>
						<h3>Receive Orders</h3>
						<p>Manage customer orders easily.</p>
					</div>
				</div>
				<div class="card">
					<div class="icon">💰</div>
					<div>
						<h3>Grow Revenue</h3>
						<p>Reach thousands of customers.</p>
					</div>
				</div>
			</div>
		<div class="bg-icon chef">👨‍🍳</div>

        <div class="bg-icon cover">🍽</div>

        <div class="bg-icon leaf">🥗</div>

        <div class="dot dot1"></div>

        <div class="dot dot2"></div>

        <div class="dot dot3"></div>
			<img src="images/banner6.png" class="restaurant-image">
		</div>

		<div class="right">
			<div class="form-card">
				<h2>Create Restaurant</h2>
				<p class="sub">Register your restaurant to continue.</p>

				<form action="CreateRestaurantServlet" method="post">

					<div class="group">
						<label>Restaurant Name</label> <input type="text" name="name"
							placeholder="Enter restaurant name" required>
					</div>

					<div class="row">
						<div class="group">
							<label>Cuisine Type</label> <input type="text" name="cuisineType"
								placeholder="Biryani, Chinese..." required>
						</div>

						<div class="group">
							<label>Delivery Time (Minutes)</label> <input type="number"
								name="deliveryTime" placeholder="30" required>
						</div>
					</div>

					<div class="group">
						<label>Restaurant Address</label>
						<textarea name="address" placeholder="Enter complete address"
							required></textarea>
					</div>

					<div class="group">
						<label>Restaurant Image Path</label> <input type="text"
							name="imagePath" placeholder="images/myrestaurant.jpg" required>
					</div>

					<div class="group">
						<label>Status</label> <select name="isActive">
							<option value="true">Open</option>
							<option value="false">Closed</option>
						</select>
					</div>

					<button class="btn" type="submit">Create Restaurant</button>

				</form>

				<div class="note">
					Already created? <a href="RestaurantOwnerLogin.html">Back to
						Login</a>
				</div>

			</div>
		</div>
	</div>
</body>
</html>
