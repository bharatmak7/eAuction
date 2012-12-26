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
String regnId  = (String) request.getAttribute("regnId");
String vehClass  = (String) request.getAttribute("vehClass");
int vehId = 0;
if (vehClass.matches("TWO")) {
	vehId = 1;
} else {
	vehId =  2;
}
String vehNumber  = (String) request.getAttribute("vehNumber");
String serName  = (String) request.getAttribute("serName");
String startDate  = (String) request.getAttribute("startDate");
String endDate  = (String) request.getAttribute("endDate");
Integer baseAmt = null;

DatabaseConn dbConn1 = new DatabaseConn();
Connection conn1 = dbConn1.connectDb();
Statement st1=conn1.createStatement();
String getBaseAmt = "SELECT * FROM number_price_value AS NPV, region_master AS RM WHERE NPV.reg_no = '"+vehNumber+"' AND NPV.veh_id = '"+vehId+"' and RM.region_id = '"+regnId+"'";
System.out.println(getBaseAmt);
String regnName  = null;
ResultSet resRegn = st1.executeQuery(getBaseAmt);
if(null != resRegn && resRegn.first()) {
	do {
		baseAmt = resRegn.getInt("NPV.amount");
		regnName  = resRegn.getString("RM.region_name");
	} while (resRegn.next());;
}

%>
</head>

<script type="text/javascript">
document.onmousedown=disableclick;
status="Right Click Disabled";
function disableclick(e){
	if(e.button==2)
	{
 	alert(status);
 	return false;    
		}
}
</script>

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
			<legend style="font-size: 18pt; color: #123456; font-weight: bold; font-family: arail">Select Number</legend>
			<br/>
			<!-- <font size="3" color="red" style="font-size:12px;font-weight:bold;">Your Region Id Is : <%=regnId %></font> <br/><br>
			<font size="3" color="red" style="font-size:12px;font-weight:bold;">Your vehicle Class Is : <%=vehClass %></font> <br/><br>
			<font size="3" color="red" style="font-size:12px;font-weight:bold;">Your Vehicle Number Is : <%=vehNumber %></font><br/><br>
			<font size="3" color="red" style="font-size:12px;font-weight:bold;">Your Series Name Is : <%=serName %></font><br/><br>
			<font size="3" color="red" style="font-size:12px;font-weight:bold;">Your Start Date Is : <%=startDate %></font><br/><br>
			<font size="3" color="red" style="font-size:12px;font-weight:bold;">Your End Date Is : <%=endDate %></font><br><br>
			<font size="3" color="red" style="font-size:12px;font-weight:bold;">Your Base Amount Is : <%=baseAmt %> <em>INR</em></font><br><br>
			<font size="3" color="red" style="font-size:12px;font-weight:bold;">Your CMD Is : <%=(baseAmt*25)/100 %> <em>INR</em></font> -->
			<table width="100%" cellpadding="10" cellspacing="0" border="0">
				<tr style="background-color: #e2e2e2">
					<td align="center" style="background-color: #505050; color: white; font-size: 30px;" width="30%">MH-<%=regnId %>-<%=serName %><br/><br/><span style="font-size: 50px;color: yellow;"><%=vehNumber %></span></td>
					<td valign="top" width="*" style="color: #123456; font-weight: bold">
						<span style="color:#5A5655; font-size: 10px; ">RTO Region :</span> <i><%=regnName %></i><br/>
						<span style="color:#5A5655; font-size: 10px; ">Bidding Started on </span> <i><%=startDate %></i>
						<span style="color:#5A5655; font-size: 10px; ">and will be closed on</span><i> <%=endDate %></i>
						<span style="color:#5A5655; font-size: 10px; ">Base Amount : </span><i> <%=baseAmt %> &#x20B9;</i><br/>
						<span style="color:#5A5655; font-size: 10px; ">Caution Money Deposit Amount : </span><i> <%=baseAmt*20/100 %> &#x20B9;</i>
						<br/>
					</td>
				</tr>
				<tr>
					<td valign="top" align="center" style="background-color: #505050; color: #e2e2e2; font-size: 16px;"><%=regnName %></td>
					<td align="right" style="background-color: #d2d2d2;"><span style="font-size: 20px; color:#808080">Total : </span> 
					<lable style="height: 30px; width: 60px; font-size:20px; color: #505050" name="amtToPay" id="amtToPay"> <%=baseAmt*20/100 %> &#x20B9; </lable></td>
				</tr>
			</table>
			<br/>
			<br/>
			<p align="right">
				<input type="button" style="width: 100px; height: 30px; background-color: #123456; border-radius:5px; color: white; font-size: 14px;" name="addToCart" value="Pay CMD">
				<input type="button" style="width: 100px; height: 30px; background-color: #123456; border-radius:5px; color: white; font-size: 14px;" name="reset" id="reset" value="Cancel" onclick="javascript:window.location.href='LoginSystem?param=userHome'" />
			</p>
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
