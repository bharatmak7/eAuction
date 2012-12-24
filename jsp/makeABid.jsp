<%@ page language="java" import="java.sql.*" errorPage=""%>
<%@ page import="com.bst.eauction.rto.DatabaseConn"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type; pragma;" content="text/html; charset=iso-8859-1; no-cache;" />
<title>E Auction System for MH RTO</title>
<link href="jsp/css/style.css" rel="stylesheet" type="text/css" />
<script src="jsp/js/jquery-1.7.js" type="text/javascript"></script>
<script src="jsp/js/menu.js" type="text/javascript"></script>
<%
String userName = (String) session.getAttribute("user");
%>
		<style>
		.black_overlay{
			display: none;
			position: absolute;
			top: 0%;
			left: 0%;
			width: 100%;
			height: 100%;
			background-color: black;
			z-index:1001;
			-moz-opacity: 0.8;
			opacity:.80;
			filter: alpha(opacity=80);
		}
		.white_content {
			display: none;
			position: absolute;
			top: 15%;
			left: 20%;
			width: 50%;
			height: 50%;
			padding: 16px;
			border: 16px solid white;
			background-color: #c3c3c3;
			z-index:1002;
			overflow: auto;
		}
	</style>
<script type="text/javascript">
	function checkNumber(id, visibility) 
	{
		var series = document.getElementById('vehNumber').value;
		var regname = /^[0-9]+$/;
		if(series == '' || regname.test(series)==false )
		{
				document.getElementById(id).style.display = 'inline';
				return false;
		}
		
	}
	
	function setVisibility(id, visibility) {
		document.getElementById(id).style.display = 'none';
	}
	
	function validateForm() {
		
		return checkNumber(101, 'inline');
	}
	function resetAll() {
		document.getElementById('101').style.display = 'none';
	}
</script>
</head>

<body onload="resetAll();">
<div id="topPanel">
<ul>
<li><a href="/eAuction/LoginSystem?param=logout">Logout</a></li>
<li><a href="/eAuction/LoginSystem?param=userProfile">My Profile</a></li>
<li><a href="/eAuction/LoginSystem?param=userLoginDetail">Login Detail</a></li>
<li><a href="/eAuction/LoginSystem?param=userAccountInfo">Account Info </a></li>
<li class="active">Home</li>
</ul>
<font color="#123456" size=6  style="font-weight: normal;">Make a Bid</font>
</div>
<div id="bodyPanel">
<p align="right" style="font-size:12pt; color:green;">Welcome to eAuction, <font color="orange"><%=userName %></font></p>
<br/>
<table width="100%" border="0" height="93%" cellpadding="5" cellspacing="1" style="background-color: #ededed;">
<tr valign="top" >
	<td style="width: 200px;padding-left: 10px;" >
		<jsp:include page="userMenu.jsp" />
	</td>
	<td>
		<fieldset style="border-color: #e2e2e2">
			<legend style="font-size: 18pt; color: #123456; font-weight: bold; font-family: arail">Select Region</legend>
			<table cellpadding="5" cellspacing="5" width="100%" border="0">
				<tr>
					<td width="50%"></td>
					<td width="10%" style="background-color: #88BA00;text-align: center;"></td>
					<td style="color:#123456; font-size: 12px;font-weight: bold;"> Live</td>
					<td width="10%" style="background-color: #E7F98D;text-align: center;"></td>
					<td style="color:#123456; font-size: 12px;font-weight: bold;"> Not Live</td>
				</tr>
			</table>
			<br/>
			<table cellpadding="3" cellspacing="3" width="100%" border="1" >
							<%
						DatabaseConn dbConn = new DatabaseConn();
						Connection conn = dbConn.connectDb();
		    			Statement st=conn.createStatement();
		    			ResultSet rsdoLogin = null;
		    			PreparedStatement psdoLogin=null; 
		    			try{
		        			String sqlOption = "SELECT * from region_master";
		        			rsdoLogin = st.executeQuery(sqlOption);
		        			if(null != rsdoLogin && rsdoLogin.first()) {
		        			int i = 0;
		        				do{
		    			%>
		    				
		    			<% if (i%5 == 0) { %>
		    				<tr align="left" height="50px">
		    			<% } 
		    				int regnId = rsdoLogin.getInt("region_id");
		    				String regnName = rsdoLogin.getString("region_name");
		    				DatabaseConn dbConn1 = new DatabaseConn();
							Connection conn1 = dbConn1.connectDb();
			    			Statement st1=conn1.createStatement();
		    				String getStatus = "SELECT * from series_launch Where region_id = '" + rsdoLogin.getInt("region_id") + "'";
		    				//System.out.println(getStatus);
		    				ResultSet resRegn = st1.executeQuery(getStatus);
		    				if(null != resRegn && resRegn.first()) {
		    					if(resRegn.getInt("series_status") == 1){
		    			%>
		    				<td style="background-color: #88BA00;text-align: center;">
		   					<a href = "javascript:void(0)"  style="text-decoration: none" onclick = "document.getElementById('regnId').value=<%=regnId %>;document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">
		   						<font style="color: #ffffff; font-size: 12px;" ><%=regnName%>-<%=regnId%></font>
		   					</a>
							<div id="light" class="white_content">
								<form name="makeABid" onsubmit="return validateForm();" action="SelectRegion" method="post">
								<!-- <a href="SelectRegion?regnId="></a> --> 
								<input type="hidden" name="regnId" id="regnId" >
								<table width="100%"  cellspacing="0" cellpadding="15" border="0">
									<tr>
									<td></td>
									<td align="center" style="background-color: orange; color: #123456; font-size: 20px; font-family: text; font-weight: bold;" >
										Insert Vehicle Number
									</td>
									
									<td align="right">
										<a href = "javascript:void(0)" style="text-decoration: none" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">
											<img src="jsp/images/close_but.png" height="30px" width="30px">
										</a>
									</td>
									</tr>
									<tr>
										<td ></td>
										<td><img src="jsp/images/two_wheel.png" height="80px" width="80px"></td>
										<td><img src="jsp/images/four_wheel.png" height="80px" width="80px"></td>
									</tr>
									<tr>
										<td style="font-size: 16px; color: #123456; font-weight: bold" align="center" > Select Vehicle</td>
										<td><input type="radio" name="vehicleClass" value="Two Wheeler" checked="checked"></td>
										<td><input type="radio" name="vehicleClass" value="Four Wheeler" ></td>
									</tr>
									<tr>
										<td style="font-size: 16px; color: #123456; font-weight: bold" align="center" > Enter Vehicle Number</td>
										<td>
										<input type="text" name="vehNumber" id="vehNumber" maxlength="4" onfocus="setVisibility('101','none');"	onBlur="checkNumber('101','inline');"></td>
										<td align="left"><i id="101"><font color="red" size="1">Enter valid number </font></i></td>
									</tr>
									<tr>
									<td></td>
									<td>
										<input type="submit" style="width: 120px; height: 30px; background-color: #123456; border-radius:5px; color: white; font-size: 14px;" name="goToBid" id="goToBid" value="Go For Bid" >
									</td>
									<td>
										<input type="button" style="width: 100px; height: 30px; background-color: #123456; border-radius:5px; color: white; font-size: 14px;" name="reset" id="reset" value="Cancel" onclick="javascript:window.location.href='LoginSystem?param=userHome'" />
									</td>
									</tr>
								</table>
								</form>
							</div>
							<div id="fade" class="black_overlay">
							</div>
		    					
		    					
		    				</td>
		    			<%
		    					}
		    				} else {
		    			%>
		    			
		    				<td style="background-color: #E7F98D;text-align: center;">
		    					<span style="color: #123456; font-size: 12px;"><%=regnName%>-<%=regnId%></span>
		    				</td>
						<% 
		    				}
		    				conn1.close();
						i++;
						if (i%5 == 0) { %>
		    				</tr>
		    			<% } %>		    				
		    			<%
		        				} while (rsdoLogin.next());
		        			}
		    			} catch(Exception e) {
		        			e.printStackTrace();
		    			}
		    			conn.close();
		    			%>
			</table>
		</fieldset>
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
