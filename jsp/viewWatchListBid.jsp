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
String productKey  = (String) request.getAttribute("productKey");
		
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
String getBaseAmt = "SELECT * FROM `users` AS U, `series_allocation_record` AS SAR, `bid_record` AS BR, `users_personal_info` AS UPI "+
"WHERE U.user_id = SAR.user_id AND SAR.order_id = BR.order_id AND U.personal_info_id = UPI.personal_info_id AND SAR.status =1 "+
" AND SAR.product_key like '"+productKey+"' ORDER BY BR.bid_amount DESC";

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
			<form name="showBid" action="PlaceNewBidAmount" method="post">
			<table width="100%" cellpadding="10" cellspacing="3">
			<%
			Integer bidAmount = 0;
			String userIdTbl = null;
			String fullname = null;
			Timestamp bidTime = null;
			Integer orderId = null;
			if(null != resRegn && resRegn.first()) {
				int cnt = 1;
				do {

					fullname = resRegn.getString("UPI.fullname");
					bidAmount = resRegn.getInt("BR.bid_amount");
					userIdTbl = resRegn.getString("U.user_id");
					orderId = resRegn.getInt("SAR.order_id");
					bidTime = resRegn.getTimestamp("BR.bid_timestamp");
					System.out.println(fullname + " :" + bidAmount + " : "+userIdTbl);
					%>

					<tr style="background-color: #DEDEDE" height="105px">
						<td align="center" style="background-color: #FFAF00" width="15%"><span style="color: #303030; font-size: 50px;"> <%=cnt %> </span></td>
						<td valign="top" style="color: #123456; font-weight: bold;" width="65%">
							<span style="color: #505050; font-size:10px; font-weight: bold;">Name : </span> <%=fullname %><br/>
							<span style="color: #505050; font-size:10px; font-weight: bold;">Product Key : </span> <%=productKey %><br/>
							<span style="color: #505050; font-size:10px; font-weight: bold;">Order Id : </span> <%=orderId %><br/>
							<span style="color: #505050; font-size:10px; font-weight: bold;">Bid Time stamp : </span> <%=bidTime %>
						</td>
						<td valign=top align="center">
							<span style="color: #505050; font-size:8px; font-weight: bold;">Current Bid Amount</span>
							
							<span style="color: #6495ED; font-size:24px;"><%=bidAmount %></span>
							<br/><br/>
							<span style="color: brown; font-size:40px;">&#x20B9;</span>
						</td>
					</tr>
			<%
				cnt++;
				} while (resRegn.next());
			} else {
			%>
			<span style="color: red; font-size: 12px;">No one has made Bid on this number <%=productKey %></span>
			<%} %>
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
