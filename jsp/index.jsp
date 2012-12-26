<%@ page language="java" import="java.sql.*" errorPage=""%>
<%@page import="com.bst.eauction.rto.DatabaseConn"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type; pragma;"
	content="text/html; charset=iso-8859-1; no-cache;" />
<title>E Auction System for MH RTO : Home</title>
<link href="jsp/css/style.css" rel="stylesheet" type="text/css" />
<script src="jsp/js/jquery-1.7.js" type="text/javascript"></script>
<script src="jsp/js/menu.js" type="text/javascript"></script>
<script type="text/javascript">
document.onmousedown=disableclick;
var status = "Right Click Disabled";
function disableclick(e){
	if(e.button==2)
	{
 	alert(status);
 	return false;    
		}
}
</script>
</head>

<body>
	<div style="background-color: orange; width: 762px; position: relative; margin: 0 auto; padding: 0; height: 90px; border: 0px solid; border-radius: 3px; border-color: #123456">
		<form name="LoginForm" method="post" action="LoginSystem">
			<table border=0 cellpadding=0 cellspacing=0 width="100%">
				<tr height="30px" valign="bottom">
					<td width="46%"></td>
					<td width="23%"
						style="color: #123456; font-size: 15px; font-family: text; font-weight: bold">Username</td>
					<td width="22%"
						style="color: #123456; font-size: 15px; font-family: text; font-weight: bold">Password</td>
					<td></td>
				</tr>
				<tr height="30px">
					<td align="center" valign="top"><span
						style="color: black; font-size: 35px; font-family: arail;"><span
							style="color: red; font-size: 37px; font-family: arail;">e</span>Auction System</span></td>
					<td><input type="text" id="user" name="user" style="width: 150px" /></td>
					<td><input type="password" id="password" name="password" style="width: 150px;" /></td>
					<td><input type="submit" id="login" align="left" name="login" value="Login" style="border: 1; border-radius: 5px; padding: 3px 3px; background: #123456; color: white;" /></td>
				</tr>
				<tr>
					<td align="center"><span
						style="color: green; font-size: 20px; font-family: arail; text-decoration: blink;">
							Maharashtra RTO</span></td>
					<td><input type="checkbox" id="isAdmin" name="isAdmin" />&nbsp;<span
						style="color: gray; font-size: 12px; font-family: text;"><i><b>
									&nbsp;is Admin</b></i></span>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/eAuction/LoginSystem?param=signUp"><span
							style="font-size: 14px; font-family: text;">SignUp</span></a></td>
					<td>&nbsp;<a href="/eAuction/LoginSystem?param=forgotPass"><span
							style="font-size: 14px; font-family: text;">Forgot your
								Password?</span></a>
					</td>
					<td></td>
				</tr>
			</table>
			<table border=0 cellpadding=0 cellspacing=0 width="100%">
			<tr valign="top">
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="20%"></td>
			<td>
			<%
				String showMessage = (String) request.getAttribute("showMessage");
				if (("InvalidAdmin").equals(showMessage)) {
			%>
			<h5 style="color: Red;" align="right">Invalid UserName or Password OR You are not an Administrator.</h5>
			<%
				} else if (("InvalidUser").equals(showMessage)) {
			%>
			<h5 style="color: Red;" align="right">Invalid UserName or Password.</h5>
			<%
				}
			%>
			</td>
			</tr>
			</table>
		</form>
	</div>
	<br />
	<div id="topPanel">
		<ul>
			<li><a href="#">Download</a></li>
			<li><a href="#">Sitemap</a></li>
			<li><a href="#">FAQ's</a></li>
			<li><a href="#">Offices</a></li>
			<li><a href="#">About Us</a></li>
			<li class="active">Home</li>
		</ul>
		<!-- <img src="jsp/images/logo.gif" title="RTO Pune" alt="RTO Pune" width="230px" height="60px" border="0" />-->
	</div>
	<div id="bodyPanel">
		<table border=0 cellpadding=5 cellspacing=10 align="center"
			height="80%">
			<tr valign="top">
				<td width="60%"><br />
					<h1
						style="font-size: 20pt; text-transform: capitalize; color: #123456; font-family: times, sans serif;">Objective
						:</h1> <br /> <span
					style="font-size: 12pt; color: gray; font-family: times, sans serif;">The
						Objective is to develop a user-friendly auctioning site for RTO
						Pune where fancy registration number of vehicles can be auctioned
						and provide value-added services to the bidders and the sellers.
						The bidders will be authenticated and the site provides a safe
						environment for online users.<br />
					<br /> Subject to the reserve price fixed by RTO PUNE for fancy
						numbers or persons duly authorized by RTO PUNE in this regard and
						subject to the terms and conditions contained herein all sales shall
						be made to the highest bidder.
				</span><br />
				<br /></td>

				<td>
					<div
						style="background-color: #123456; height: 300px; border: 0px solid; border-radius: 10px; border-color: #123456">
						<marquee behavior="alternate" scrollamount="1"
							style="text-align: center;">
							<font size="4" color="#0AAA3D"><br />
							<font size=6 color="white">Maharashtra RTO </font><br /> E
								Auction System <br /></font>
						</marquee>
						<hr color="white" width="90%" />
						<marquee behavior="scroll" direction="up" scrollamount="4"
							style="text-align: center;" onmouseover="this.stop();"
							onmouseout="this.start();">
							<%
							DatabaseConn dbConn = new DatabaseConn();
							Connection conn = dbConn.connectDb();
			    			Statement st=conn.createStatement();
			    			ResultSet rsdoLogin = null;
			    			PreparedStatement psdoLogin=null; 
							String selData = "SELECT R.region_name, V.vehicle_type, S.ser_st_date, S.ser_end_date, R.state_code,R.region_code,S.series_name  FROM `series_launch` As S, `vehicle_class` As V, `region_master` As R WHERE S.region_id = R.region_id and V.vehicle_id = S.veh_id and S.series_status != 0";
							rsdoLogin = st.executeQuery(selData);
							if(null != rsdoLogin && rsdoLogin.first()) {
		        				do{
							%>
							<font size="2" color="gray"> 
								RTO Region : <span style="color:white;font-size: 14px"><%=rsdoLogin.getString("region_name") %></span><br />
								Vehicle Class : <span style="color:yellow;font-size: 12px"><%=rsdoLogin.getString("vehicle_type") %></span><br /> 
								Series : <span style="color:yellow;font-size: 12px"><%=rsdoLogin.getString("state_code") %><%=rsdoLogin.getString("region_code") %> - <%=rsdoLogin.getString("series_name") %></span><br />
								Start Date : <span style="color:yellow;font-size: 12px"><%=rsdoLogin.getString("ser_st_date") %><br /></span>
								End Date : <span style="color:yellow;font-size: 12px"><%=rsdoLogin.getString("ser_end_date") %></span>
							</font>
							<hr width="80%" />
							<%
		        				} while (rsdoLogin.next());
		        			} else {
		        			
		        			%>
		        			<font size="2" color="red"><em>No series has been launched</em></font>
		        			<%
		        			}
							%>
						</marquee>
					</div>
				</td>
			</tr>
			<tr valign="top">
				<td>
					<h1
						style="font-size: 20pt; text-transform: capitalize; color: #123456; font-family: times, sans serif;">Users
						:</h1>
					<br /> <span
					style="font-size: 12pt; color: gray; font-family: times, sans serif;">
						<b style="color: orange; font-size: 18px"> 1. SELLER : </b> Seller
						referred in these conditions of sale, is the Department of RTO
						Pune through their officers And/OR the Custodian.<br /> <b
						style="color: orange; font-size: 18px">2. AUCTIONEER : </b> <b style="color:#123456">M/s.
						Balaji Software Technology</b> is an agency appointed as an auctioneer
						to facilitate e-Auction on Internet by RTO Pune. They are expected
						to facilitate organizing and conducting e-Auction and are
						considered as third party not particularly interested in the
						details of the registration numbers being sold for and on behalf
						of RTO Pune.<br /> <b style="color: orange; font-size: 18px">
							3. BIDDER : </b> Any person representing as an individual OR
						proprietor Or as a partner OR as an authorized representative of
						any company who has been registered with the Auctioneer and who
						has paid the Caution Money Deposit (CMD) as per the terms and
						conditions herein shall be considered as a Bidder.
				</span>
				</td>
				<td>
					<h1
						style="font-size: 20pt; text-transform: capitalize; color: #123456; font-family: times, sans serif;">Offices
						:</h1>
					<br /> <span
					style="font-size: 12pt; color: gray; font-family: times, sans serif;">
						<font color="black">Regional Transport Officer, Pune</font><br />
						38, Dr. Ambedkar Road, Near Sangam Bridge, Pune 411 001.<br />
						Phone no.<br /> +91 20 26058080<br /> +91 20 26058090/8282<br />
					<br />
				</span> <span
					style="font-size: 12pt; color: gray; font-family: times, sans serif;">
						<font color="black">Regional Transport Officer, Alandi</font><br />
						Road Office Near Fulenagar,<br /> Next to Bombay Engineering
						Group, Pune.
				</span>
				</td>
			</tr>
		</table>
	</div>
	<div id="footerPanel">
		<jsp:include page="footer.jsp" />
	</div>
	<br />
</body>
</html>
