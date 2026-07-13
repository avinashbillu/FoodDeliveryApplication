<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.User"%>
<%@ page import="com.tap.model.Address"%>

<%
User user = (User) session.getAttribute("user");

if (user == null) {
	response.sendRedirect("LoginPage.html");
	return;
}

List<Address> addresses = (List<Address>) request.getAttribute("addresses");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>My Addresses</title>

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

html, body {
	height: 100%;
	background: #fff8f3;
	overflow: hidden;
}

/* =========================
        NAVBAR
========================= */
.navbar {
	background: white;
	height: 80px;
	padding: 0 30px;
	display: flex;
	align-items: center;
	gap: 25px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, .06);
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	z-index: 999;
}

.logo {
	font-size: 32px;
	font-weight: 700;
	color: #fc8019;
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
	font-size: 15px;
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
	transition: .25s;
}

.nav-links a:hover {
	color: #fc8019;
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

/* =========================
      PAGE LAYOUT
========================= */
.page {
	display: flex;
	height: 100vh;
	padding-top: 80px;
}

/* =========================
        SIDEBAR
========================= */
.sidebar {
	width: 290px;
	background: white;
	border-radius: 24px;
	padding: 25px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, .06);
	position: fixed;
	top: 100px;
	left: 20px;
	bottom: 20px;
	overflow: hidden;
}

.sidebar h1 {
	font-size: 32px;
	color: #222;
	margin-bottom: 10px;
}

.line {
	width: 55px;
	height: 5px;
	background: #fc8019;
	border-radius: 20px;
	margin-bottom: 20px;
}

.sidebar p {
	color: #777;
	line-height: 1.7;
	font-size: 14px;
	margin-bottom: 15px;
}

.menu-item {
	display: block;
	text-decoration: none;
	color: #222;
	padding: 11px 15px;
	border-radius: 18px;
	margin-bottom: 6px;
	font-size: 17px;
	transition: .25s;
}

.menu-item:hover {
	background: #fff4ec;
	color: #fc8019;
	transform: translateX(4px);
}

.active {
	background: #fff4ec;
	color: #fc8019;
	font-weight: 600;
}

.logout {
	margin-top: 25px;
	color: #ff4d4d;
}

/* =========================
       CONTENT
========================= */
.content {
	flex: 1;
	margin-left: 340px;
	padding: 30px;
	height: calc(100vh - 80px);
	overflow-y: auto;
}

.content-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
}

.content-header h1 {
	font-size: 34px;
	color: #222;
}

.add-btn {
	background: #fc8019;
	color: white;
	padding: 14px 28px;
	border-radius: 14px;
	text-decoration: none;
	font-weight: 600;
	transition: .25s;
}

.add-btn:hover {
	background: #e56f08;
}

/* Scrollbar */
.content::-webkit-scrollbar {
	width: 8px;
}

.content::-webkit-scrollbar-thumb {
	background: #fc8019;
	border-radius: 20px;
}

.content::-webkit-scrollbar-track {
	background: #f3f3f3;
}

/* ===========================
      ADDRESS CARD
===========================*/
.address-card {
	background: #fff;
	border-radius: 22px;
	padding: 24px;
	margin-bottom: 22px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	box-shadow: 0 5px 18px rgba(0, 0, 0, .08);
	transition: .25s;
}

.address-card:hover {
	transform: translateY(-4px);
	box-shadow: 0 14px 35px rgba(0, 0, 0, .12);
}

.address-left {
	display: flex;
	gap: 20px;
	align-items: flex-start;
}

.address-icon {
	width: 70px;
	height: 70px;
	border-radius: 50%;
	background: #FFF4EC;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 34px;
}

.address-details {
	max-width: 600px;
}

.title-row {
	display: flex;
	align-items: center;
	gap: 12px;
	margin-bottom: 8px;
}

.title-row h3 {
	font-size: 22px;
	color: #222;
}

.default-badge {
	background: #e8fff1;
	color: #1f8a3b;
	padding: 5px 12px;
	border-radius: 30px;
	font-size: 13px;
	font-weight: 600;
}

.customer-name {
	font-size: 18px;
	font-weight: 600;
	margin-bottom: 8px;
}

.full-address {
	color: #666;
	line-height: 1.7;
	font-size: 15px;
}

.mobile {
	margin-top: 12px;
	font-weight: 500;
}

.address-actions {
	display: flex;
	flex-direction: column;
	gap: 12px;
	min-width: 170px;
}

.address-actions a, .address-actions button {
	border: none;
	text-decoration: none;
	padding: 12px;
	border-radius: 12px;
	font-size: 15px;
	font-weight: 600;
	cursor: pointer;
	text-align: center;
}

.default-btn {
	background: #FFF4EC;
	color: #FC8019;
}

.edit-btn {
	background: #FC8019;
	color: #fff;
}

.delete-btn {
	background: #ffe9e9;
	color: #ff3b30;
}

.empty-address {
	background: #fff;
	border-radius: 22px;
	padding: 70px;
	text-align: center;
	box-shadow: 0 4px 20px rgba(0, 0, 0, .08);
}

.empty-address h2 {
	margin-top: 20px;
	margin-bottom: 12px;
}

.empty-address p {
	color: #777;
	margin-bottom: 30px;
}

.add-address-btn {
	background: #FC8019;
	color: #fff;
	border: none;
	padding: 15px 35px;
	border-radius: 15px;
	font-size: 17px;
	cursor: pointer;
}

/* ===============================
        POPUP
================================ */
.popup-overlay {
	position: fixed;
	inset: 0;
	background: rgba(0, 0, 0, .45);
	display: none;
	z-index: 1000;
}

.popup {
	position: fixed;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%) scale(.9);
	width: 700px;
	background: #fff;
	border-radius: 20px;
	padding: 25px;
	display: none;
	z-index: 1001;
	transition: .25s;
}

.popup.show {
	display: block;
	transform: translate(-50%, -50%) scale(1);
}

.popup-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.popup-header h2 {
	color: #FC8019;
}

.popup-header span {
	cursor: pointer;
	font-size: 28px;
}

.form-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 15px;
}

.form-grid input {
	padding: 14px;
	border: 1px solid #ddd;
	border-radius: 12px;
	font-size: 15px;
}

.popup select {
	width: 100%;
	margin-top: 15px;
	padding: 14px;
	border-radius: 12px;
	border: 1px solid #ddd;
}

.default-check {
	display: block;
	margin-top: 18px;
}

.popup-buttons {
	display: flex;
	justify-content: flex-end;
	gap: 15px;
	margin-top: 25px;
}

.cancel-btn {
	background: #eee;
	border: none;
	padding: 12px 25px;
	border-radius: 12px;
	cursor: pointer;
}

.save-btn {
	background: #FC8019;
	color: #fff;
	border: none;
	padding: 12px 25px;
	border-radius: 12px;
	cursor: pointer;
}
</style>

</head>

<body>

	<!-- NAVBAR -->

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

		<a href="callProfileServlet" class="profile-link"> 👤 <%=user.getUserName()%>

		</a> <a href="CartPage.jsp" class="cart-link"> 🛒 </a>

	</nav>

	<!-- PAGE -->

	<div class="page">

		<!-- SIDEBAR -->

		<div class="sidebar">

			<h1>My Profile</h1>

			<div class="line"></div>

			<p>Manage your account, addresses and view your orders</p>

			<a href="callProfileServlet" class="menu-item"> 👤 Profile </a> <a
				href="MyOrdersServlet" class="menu-item"> 🛍 My Orders </a> <a
				href="AddressServlet" class="menu-item active"> 📍 Addresses </a>  <a href="HelpSupport.jsp"
				class="menu-item"> 🎧 Help & Support </a> <a href="LogoutServlet"
				class="menu-item logout"> 🚪 Logout </a>

		</div>

		<!-- CONTENT -->

		<div class="content">

			<div class="content-header">

				<h1>Saved Addresses</h1>

				<a href="javascript:void(0)" class="add-btn"
					onclick="openAddPopup()"> + Add New Address </a>

			</div>

			<!-- Part 2 starts here -->
			<%
			if (addresses == null || addresses.isEmpty()) {
			%>

			<div class="empty-address">

				<img src="images/location.png" width="130">

				<h2>No Saved Addresses</h2>

				<p>Save an address for faster checkout.</p>

				<button class="add-address-btn" onclick="openAddAddress()">

					+ Add New Address</button>

			</div>

			<%
			} else {

			for (Address address : addresses) {
			%>

			<div class="address-card">

				<!-- LEFT -->

				<div class="address-left">

					<div class="address-icon">

						<%
						if (address.getAddressType().equalsIgnoreCase("Home")) {
						%>

						🏠

						<%
						} else if (address.getAddressType().equalsIgnoreCase("Work")) {
						%>

						💼

						<%
						} else {
						%>

						📍

						<%
						}
						%>

					</div>

					<div class="address-details">

						<div class="title-row">

							<h3>

								<%=address.getAddressType()%>

							</h3>

							<%
							if (address.getIsDefault()) {
							%>

							<span class="default-badge"> Default </span>

							<%
							}
							%>

						</div>

						<div class="customer-name">

							<%=address.getFullName()%>

						</div>

						<div class="full-address">

							<%=address.getHouseNo()%>,

							<%=address.getArea()%>,

							<%=address.getLandmark()%>,

							<%=address.getCity()%>,

							<%=address.getState()%>

							-

							<%=address.getPincode()%>

						</div>

						<div class="mobile">

							📞

							<%=address.getPhone()%>

						</div>

					</div>

				</div>

				<!-- RIGHT -->

				<div class="address-actions">

					<%
					if (!address.getIsDefault()) {
					%>

					<a
						href="AddressServlet?action=default&id=<%=address.getAddressID()%>"
						class="default-btn"> Make Default </a>

					<%
					}
					%>

					<button class="edit-btn"
						onclick="editAddress(

            '<%=address.getAddressID()%>',

            '<%=address.getAddressType()%>',

            '<%=address.getFullName()%>',

            '<%=address.getPhone()%>',

            '<%=address.getHouseNo()%>',

            '<%=address.getArea()%>',

            '<%=address.getLandmark()%>',

            '<%=address.getCity()%>',

            '<%=address.getState()%>',

            '<%=address.getPincode()%>',

            '<%=address.getIsDefault()%>'

            )">

						✏ Edit</button>

					<a
						href="AddressServlet?action=delete&id=<%=address.getAddressID()%>"
						class="delete-btn"
						onclick="return confirm('Delete this address?')"> 🗑 Delete </a>

				</div>

			</div>

			<%
			}
			}
			%>
			<!-- ===========================
        POPUP BACKDROP
=========================== -->

			<div class="popup-overlay" id="popupOverlay"></div>

			<!-- ===========================
        ADD ADDRESS POPUP
=========================== -->

			<div class="popup" id="addPopup">

				<div class="popup-header">

					<h2>Add New Address</h2>

					<span onclick="closePopup()">&times;</span>

				</div>

				<form action="AddressServlet" method="post">

					<input type="hidden" name="action" value="add">

					<div class="form-grid">

						<input type="text" name="fullName" placeholder="Full Name"
							required> <input type="text" name="phone"
							placeholder="Mobile Number" required> <input type="text"
							name="houseNo" placeholder="House / Flat No." required> <input
							type="text" name="area" placeholder="Area / Street" required>

						<input type="text" name="landmark" placeholder="Landmark">

						<input type="text" name="city" placeholder="City" required>

						<input type="text" name="state" placeholder="State" required>

						<input type="text" name="pincode" placeholder="Pincode" required>

					</div>

					<select name="addressType">

						<option>Home</option>

						<option>Work</option>

						<option>Other</option>

					</select> <label class="default-check"> <input type="checkbox"
						name="isDefault"> Make this my default address

					</label>

					<div class="popup-buttons">

						<button type="button" class="cancel-btn" onclick="closePopup()">

							Cancel</button>

						<button type="submit" class="save-btn">Save Address</button>

					</div>

				</form>

			</div>

			<!-- ===========================
        EDIT ADDRESS POPUP
=========================== -->

			<div class="popup" id="editPopup">

				<div class="popup-header">

					<h2>Edit Address</h2>

					<span onclick="closeEditPopup()">&times;</span>

				</div>

				<form action="AddressServlet" method="post">

					<input type="hidden" name="action" value="update"> <input
						type="hidden" id="editAddressID" name="addressId">

					<div class="form-grid">

						<input id="editFullName" type="text" name="fullName" required>

						<input id="editPhone" type="text" name="phone" required> <input
							id="editHouseNo" type="text" name="houseNo" required> <input
							id="editArea" type="text" name="area" required> <input
							id="editLandmark" type="text" name="landmark"> <input
							id="editCity" type="text" name="city" required> <input
							id="editState" type="text" name="state" required> <input
							id="editPincode" type="text" name="pincode" required>

					</div>

					<select id="editType" name="addressType">

						<option>Home</option>

						<option>Work</option>

						<option>Other</option>

					</select> <label class="default-check"> <input id="editDefault"
						type="checkbox" name="isDefault"> Make this my default
						address

					</label>

					<div class="popup-buttons">

						<button type="button" class="cancel-btn"
							onclick="closeEditPopup()">Cancel</button>

						<button type="submit" class="save-btn">Update Address</button>

					</div>

				</form>

			</div>
			<script>
				// ==========================
				// ADD POPUP
				// ==========================

				function openAddPopup() {

					document.getElementById("popupOverlay").style.display = "block";
					document.getElementById("addPopup").classList.add("show");

				}

				function closePopup() {

					document.getElementById("popupOverlay").style.display = "none";
					document.getElementById("addPopup").classList
							.remove("show");

				}

				// ==========================
				// EDIT POPUP
				// ==========================

				function editAddress(id, type, name, phone, house, area,
						landmark, city, state, pincode, isDefault) {

					document.getElementById("popupOverlay").style.display = "block";

					document.getElementById("editPopup").classList.add("show");

					document.getElementById("editAddressID").value = id;
					document.getElementById("editType").value = type;
					document.getElementById("editFullName").value = name;
					document.getElementById("editPhone").value = phone;
					document.getElementById("editHouseNo").value = house;
					document.getElementById("editArea").value = area;
					document.getElementById("editLandmark").value = landmark;
					document.getElementById("editCity").value = city;
					document.getElementById("editState").value = state;
					document.getElementById("editPincode").value = pincode;

					document.getElementById("editDefault").checked = (isDefault == "true");

				}

				function closeEditPopup() {

					document.getElementById("popupOverlay").style.display = "none";

					document.getElementById("editPopup").classList
							.remove("show");

				}

				// ==========================
				// DELETE CONFIRMATION
				// ==========================

				function deleteAddress(id) {

					if (confirm("Are you sure you want to delete this address?")) {

						window.location = "AddressServlet?action=delete&id="
								+ id;

					}

				}

				// Close popup when clicking overlay

				document.getElementById("popupOverlay").addEventListener(
						"click", function() {

							closePopup();

							closeEditPopup();

						});
			</script>

			<style>

/* =====================================
        RESPONSIVE
===================================== */
@media ( max-width :1200px) {
	.content {
		margin-left: 0;
	}
	.sidebar {
		position: relative;
		top: 0;
		left: 0;
		width: 100%;
		margin-bottom: 20px;
	}
	.page {
		flex-direction: column;
	}
	.address-card {
		flex-direction: column;
		align-items: flex-start;
	}
	.address-actions {
		width: 100%;
		margin-top: 20px;
		flex-direction: row;
		flex-wrap: wrap;
	}
	.popup {
		width: 95%;
	}
}

@media ( max-width :768px) {
	.navbar {
		overflow-x: auto;
		gap: 15px;
		padding: 0 15px;
	}
	.logo {
		font-size: 25px;
	}
	.location-box {
		display: none;
	}
	.search-box {
		display: none;
	}
	.nav-links {
		gap: 15px;
	}
	.form-grid {
		grid-template-columns: 1fr;
	}
	.content-header {
		flex-direction: column;
		gap: 20px;
		align-items: flex-start;
	}
	.address-card {
		padding: 18px;
	}
	.address-left {
		flex-direction: column;
	}
	.address-details {
		width: 100%;
	}
	.address-actions {
		flex-direction: column;
	}
	.address-actions a, .address-actions button {
		width: 100%;
	}
}
</style>

		</div>
		<!-- content -->

	</div>
	<!-- page -->

</body>
</html>