<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.Menu"%>

<%
Menu menu = (Menu) request.getAttribute("menu");

if (menu == null) {
	response.sendRedirect("OwnerMenuServlet");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Edit Menu Item</title>

<link
	href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css"
	rel="stylesheet">

<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    background:#fff8f3;
}

.wrapper{
    display:flex;
    min-height:100vh;
}

/* ================= SIDEBAR ================= */

.sidebar{
    position:fixed;
    top:0;
    left:0;
    width:270px;
    height:100vh;
    background:#ffffff;
    border-right:1px solid #f2f2f2;
    padding:28px 18px;
    display:flex;
    flex-direction:column;
    box-shadow:8px 0 24px rgba(0,0,0,.05);
    z-index:999;
}

.brand{
    margin-bottom:28px;
}

.logo{
    font-size:28px;
    font-weight:700;
    color:#fc8019;
    display:flex;
    align-items:center;
    gap:8px;
    margin-bottom:4px;
}

.role{
    color:#777;
    font-size:16px;
    font-weight:500;
}

.menu{
    display:flex;
    flex-direction:column;
    margin-top:8px;
}

.menu a{
    display:flex;
    align-items:center;
    gap:14px;
    padding:14px 16px;
    margin-bottom:10px;
    border-radius:14px;
    color:#384255;
    text-decoration:none;
    font-size:16px;
    font-weight:500;
    transition:.25s;
}

.menu a:hover{
    background:#fff4ec;
    color:#fc8019;
}

.menu a.active{
    background:#fff4ec;
    color:#fc8019;
    font-weight:600;
}

.menu i{
    font-size:20px;
}

/* ================= UPGRADE CARD ================= */

.upgrade-card{
    margin-top:auto;
    background:#fff4ec;
    border-radius:18px;
    padding:18px;
    position:relative;
}

.upgrade-card h3{
    font-size:20px;
    margin-bottom:8px;
}

.upgrade-card p{
    color:#666;
    font-size:14px;
    line-height:1.6;
    margin-bottom:18px;
}

.upgrade-card button{
    border:none;
    background:#fc8019;
    color:#fff;
    padding:10px 20px;
    border-radius:10px;
    cursor:pointer;
    font-weight:600;
}

.upgrade-card button:hover{
    background:#ea7007;
}

.rocket{
    position:absolute;
    right:16px;
    bottom:14px;
    font-size:54px;
}

/* ================= MAIN ================= */

.main{
    margin-left:270px;
    width:calc(100% - 270px);
    padding:40px;
}

.main h1{
    font-size:34px;
    color:#222;
}

.main p{
    color:#666;
}

/* ================= CARD ================= */

.card{
    margin-top:25px;
    background:#fff;
    border-radius:22px;
    padding:35px;
    max-width:920px;
    box-shadow:0 10px 30px rgba(0,0,0,.06);
}

/* ================= FORM ================= */

.grid{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:22px;
}

.full{
    grid-column:1/3;
}

label{
    display:block;
    margin-bottom:8px;
    font-weight:600;
    color:#333;
}

input,
textarea,
select{
    width:100%;
    padding:14px 16px;
    border:1px solid #ddd;
    border-radius:12px;
    font-size:15px;
    outline:none;
    transition:.3s;
}

input:focus,
textarea:focus,
select:focus{
    border-color:#fc8019;
    box-shadow:0 0 0 3px rgba(252,128,25,.12);
}

textarea{
    resize:none;
    height:130px;
}

/* ================= BUTTONS ================= */

.buttons{
    margin-top:30px;
    display:flex;
    gap:16px;
}

.save{
    border:none;
    background:#fc8019;
    color:white;
    padding:14px 28px;
    border-radius:12px;
    cursor:pointer;
    font-size:15px;
    font-weight:600;
    transition:.3s;
}

.save:hover{
    background:#ea7007;
}

.cancel{
    text-decoration:none;
    background:#ececec;
    color:#333;
    padding:14px 28px;
    border-radius:12px;
    font-weight:600;
    transition:.3s;
}

.cancel:hover{
    background:#dcdcdc;
}

/* ================= RESPONSIVE ================= */

@media(max-width:900px){

    .grid{
        grid-template-columns:1fr;
    }

    .full{
        grid-column:1;
    }

    .sidebar{
        display:none;
    }

    .main{
        margin-left:0;
        width:100%;
        padding:25px;
    }

    .card{
        padding:25px;
    }
}
</style>

</head>

<body>

	<div class="wrapper">

		<!-- ================= Sidebar ================= -->

		<aside class="sidebar">

			<div class="brand">

				<div class="logo">
					FoodHub <span>👨‍🍳</span>
				</div>

				<div class="role">Restaurant Owner</div>

			</div>

			<nav class="menu">

				<a href="ownerDashboardServlet"> <i class="ri-home-5-line"></i>
					<span>Dashboard</span>
				</a> <a href="OwnerOrdersServlet"> <i class="ri-file-list-3-line"></i> <span>Orders</span>
				</a> <a class="active" href="OwnerMenuServlet"> <i
					class="ri-restaurant-line"></i> <span>Menu</span>
				</a> <a href="CategoryManagementServlet"> <i class="ri-layout-grid-line"></i> <span>Categories</span>
				</a> <a href="#"> <i class="ri-group-line"></i> <span>Customers</span>
				</a> <a href="#"> <i class="ri-money-rupee-circle-line"></i> <span>Earnings</span>
				</a> <a href="#"> <i class="ri-bar-chart-line"></i> <span>Reports</span>
				</a> <a href="#"> <i class="ri-megaphone-line"></i> <span>Marketing</span>
				</a> <a href="#"> <i class="ri-star-line"></i> <span>Reviews</span>
				</a> <a href="#"> <i class="ri-settings-3-line"></i> <span>Settings</span>
				</a>

			</nav>

			<div class="upgrade-card">

				<h3>Grow your business</h3>

				<p>Increase your visibility and get more orders.</p>

				<button>Upgrade Now</button>

				<div class="rocket">🚀</div>

			</div>

		</aside>

		<!-- ================= Main ================= -->

		<div class="main">

			<h1>Edit Menu Item</h1>

			<p style="margin: 10px 0 25px; color: #666;">Update the details
				of your menu item.</p>

			<div class="card">

				<form action="MenuManagementServlet?action=update" method="post">

					<input type="hidden" name="menuId" value="<%=menu.getMenuID()%>">

					<div class="grid">

						<div>

							<label>Item Name</label> <input type="text" name="itemName"
								value="<%=menu.getItemName()%>" required>

						</div>

						<div>

							<label>Price</label> <input type="number" step="0.01"
								name="price" value="<%=menu.getPrice()%>" required>

						</div>

						<div class="full">

							<label>Description</label>

							<textarea name="description" required><%=menu.getDescription()%></textarea>

						</div>

						<div>

							<label>Image Path</label> <input type="text" name="imagePath"
								value="<%=menu.getImagePath()%>" required>

						</div>

						<div>

							<label>Availability</label> <select name="available">

								<option value="true" <%=menu.getIsAvailable() ? "selected" : ""%>>
									Available</option>

								<option value="false" <%=!menu.getIsAvailable() ? "selected" : ""%>>
									Unavailable</option>

							</select>

						</div>

					</div>

					<div class="buttons">

						<button class="save" type="submit">Update Menu Item</button>

						<a class="cancel" href="OwnerMenuServlet"> Cancel </a>

					</div>

				</form>

			</div>

		</div>

	</div>

</body>

</html>