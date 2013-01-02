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
String userId  = (String) request.getAttribute("userId");
String seriesId  = (String) request.getAttribute("seriesId");
String ruleId  = (String) request.getAttribute("ruleId");
String productKey  = (String) request.getAttribute("productKey");
String cmdAmt  = (String) request.getAttribute("cmdAmt");
String orderId  = (String) request.getAttribute("orderId");
String regnId  = (String) request.getAttribute("regnId");
String serName  = (String) request.getAttribute("serName");
String vehClass  = (String) request.getAttribute("vehClass");
String vehNumber  = (String) request.getAttribute("vehNumber");
String regnName  = (String) request.getAttribute("regnName");
String txnId  = (String) request.getAttribute("txnId");
Integer baseAmt  = Integer.parseInt(cmdAmt) * 4 ; 

DatabaseConn dbConn1 = new DatabaseConn();
Connection conn1 = dbConn1.connectDb();
Statement st1=conn1.createStatement();
Date startDate = null;
Date endDate = null;
String getBaseAmt = "SELECT * FROM series_launch WHERE series_id = '"+seriesId+"'";

ResultSet resRegn = st1.executeQuery(getBaseAmt);
if(null != resRegn && resRegn.first()) {
	do {
		startDate = resRegn.getDate("ser_st_date");
		endDate = resRegn.getDate("ser_end_date");

	} while (resRegn.next());;
}
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
			<legend style="font-size: 18pt; color: #123456; font-weight: bold; font-family: arail">Place Bid</legend>
			<br/>
			<form name="placeBid" action="PlaceBidOnceFinal" method="post">
			<table width="100%" cellpadding="10" cellspacing="0" border="0">
				<tr style="background-color: #e2e2e2">
					<td align="center" style="background-color: #505050; color: white; font-size: 30px;" width="30%">MH-<%=regnId %>-<%=serName %><br/><br/><span style="font-size: 50px;color: yellow;"><%=vehNumber %></span></td>
					<td valign="top" width="*" style="color: #123456; font-weight: bold">
						<span style="color:#5A5655; font-size: 10px; ">RTO Region :</span> <i><%=regnName %></i>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span style="color:#5A5655; font-size: 10px; ">Vehicle Class :</span> <i><%=vehClass %> Wheeler</i><br/>
						<span style="color:#5A5655; font-size: 10px; ">Bidding Started on </span> <i><%=startDate %></i>
						<span style="color:#5A5655; font-size: 10px; ">and will be closed on</span><i> <%=endDate %></i>
						<span style="color:#5A5655; font-size: 10px; ">Base Amount : </span><i> <%=baseAmt %> &#x20B9;</i><br/>
						<span style="color:#5A5655; font-size: 10px; ">Caution Money Deposited Amount : </span><i> <%=cmdAmt %> &#x20B9;</i><br/>
						<span style="color:#5A5655; font-size: 10px; ">Transaction id is : </span><i> <%=txnId %></i>
						<span style="color:#5A5655; font-size: 10px; ">&nbsp;&nbsp; for Order id is : </span><i> <%=txnId %></i>
						<br/>
					</td>
				</tr>
				<%
				Integer  bidAmt = 0;
				DatabaseConn dbConn2 = new DatabaseConn();
				Connection conn2 = dbConn2.connectDb();
				Statement st2=conn1.createStatement();

				String getBaseAmt1 = "SELECT max( BR.bid_amount ) AS Max_Bid FROM `bid_record` AS BR, `series_allocation_record` AS SAR WHERE BR.order_id = SAR.order_id AND SAR.product_key = '"+productKey+"'";
				System.out.println(getBaseAmt1);
				ResultSet resRegn1 = st2.executeQuery(getBaseAmt1);
				if(null != resRegn1 && resRegn1.first()) {
					do {
						if(resRegn1.getInt("Max_Bid") != 0) {
							bidAmt = resRegn1.getInt("Max_Bid");
							System.out.println("base amount error 1 : " + bidAmt);
						} else {
							bidAmt = baseAmt;
							System.out.println("base amount error : " + bidAmt);
						}
					} while (resRegn.next());;
				} 
				%>
				<tr>
					<td valign="top" align="center" style="background-color: #404040; color: #f2f2f2; font-size: 16px;"><%=regnName %></td>
					<td align="left" style="background-color: #d2d2d2;">
					<span style="font-size: 20px; color:#808080">Bid Amount : </span> 
					<select name="bidAmt" id="bidAmt">
						<%for (int cnt = 1; cnt <= 10; cnt++) { %>
						<option value="<%=bidAmt+(500*cnt) %>"><%=bidAmt+(500*cnt) %></option>
						<% } %>
					</select>
				</tr>
			</table>
			<br/>
			<br/>
			<input name="regnId" id="regnId" type="hidden" value="<%=regnId %>">
			<input name="vehicleClass" id="vehicleClass" type="hidden" value="<%=vehClass %>">
			<input name="vehNumber" id="vehNumber" type="hidden" value="<%=vehNumber %>">
			<input name="serName" id="serName" type="hidden" value="<%=serName %>">
			<input name="startDate" id="startDate" type="hidden" value="<%=startDate %>">
			<input name="endDate" id="endDate" type="hidden" value="<%=endDate %>">
			<input name="baseAmt" id="baseAmt" type="hidden" value="<%=baseAmt %>">
			<input name="cmdAmt" id="cmdAmt" type="hidden" value="<%=cmdAmt %>">
			<input name="userId" id="userId" type="hidden" value="<%=userId %>">
			<input name="ruleId" id="ruleId" type="hidden" value="<%=ruleId %>">
			<input name="seriesId" id="seriesId" type="hidden" value="<%=seriesId %>">
			<input name="orderId" id="orderId" type="hidden" value="<%=orderId %>">
			<p align="right">
				<input type="submit" style="width: 100px; height: 30px; background-color: #123456; border-radius:5px; color: white; font-size: 14px;" name="addToCart" value="Place Bid">
				<input type="button" style="width: 100px; height: 30px; background-color: #123456; border-radius:5px; color: white; font-size: 14px;" name="reset" id="reset" value="Cancel" onclick="javascript:window.location.href='LoginSystem?param=userHome'" />
			</p>
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
