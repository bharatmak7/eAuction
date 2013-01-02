<%@page import="com.bst.eauction.rto.DatabaseConn"%>
<%@ page language="java" import="java.sql.*" errorPage=""%>
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
String userId = (String) session.getAttribute("userId");
%>

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
<%
DatabaseConn dbConn1 = new DatabaseConn();
Connection conn1 = dbConn1.connectDb();
Statement st1=conn1.createStatement();
String getBaseAmt = "SELECT * FROM `users` AS U, `users_watchlist` AS UWL WHERE UWL.user_id = U.user_id AND U.user_id = '"+userId+"'";
System.out.println(getBaseAmt);
ResultSet resRegn = st1.executeQuery(getBaseAmt);

%>
</head>

<body>
<div id="topPanel">
<ul>
<li><a href="/eAuction/LoginSystem?param=logout">Logout</a></li>
<li><a href="/eAuction/LoginSystem?param=userProfile">My Profile</a></li>
<li><a href="/eAuction/LoginSystem?param=userLoginDetail">Login Detail</a></li>
<li><a href="/eAuction/LoginSystem?param=userAccountInfo">Account Info </a></li>
<li class="active">Home</li>
</ul>
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
			<legend style="font-size: 18pt; color: #123456; font-weight: bold; font-family: arail">View Watch List</legend>
			<br/>
			<form name="viewWL" action="ViewWatchListShow" method="post">
			<table width="100%" cellpadding="15" cellspacing="0">
			<%
			String productKey = null;
			if(null != resRegn && resRegn.first()) {
				int cnt = 0;
				do {
					productKey = resRegn.getString("UWL.watchlist");
					if (cnt%2==0){
			%>
					<tr style="background-color: #b3b3b3" height="80px">
					<% } else { %>
					<tr style="background-color: #DEDEDE" height="80px">
					<% } %>
						<td style="color: #123456; font-weight: bold;"><span style="color: #505050; font-size:10px; font-weight: bold;">Watch List : </span> <%=productKey %></td>
						<td></td>
						<td align="right" >
							<input type="hidden" name="productKey" id="productKey" value="">
							<input type="submit" style="height: 30px;width: 80px;border-radius:7px;background-color: #123456; color: white;" name="showBid" id="showBid" value="View" onclick="javascript:document.getElementById('productKey').value='<%=productKey  %>';">
						</td>
					</tr>
			<%
				cnt++;
				} while (resRegn.next());
			}
			%>
			</table>
			</form>
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
