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
</head>

<body>
<div id="topPanel">
<ul>
<li><a href="/eAuction/LoginSystem?param=logout">Logout</a></li>
<li><a href="/eAuction/LoginSystem?param=userProfile">My Profile</a></li>
<li class="active">Login Detail</li>
<li><a href="/eAuction/LoginSystem?param=userAccountInfo">Account Info </a></li>
<li ><a href="/eAuction/LoginSystem?param=userHome">Home</a></li>
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
			<legend style="font-size: 18pt; color: #123456; font-weight: bold; font-family: arail">Login Details</legend>
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
