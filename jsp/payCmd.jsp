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
String regnId  = (String) request.getAttribute("regnId");
String vehClass  = (String) request.getAttribute("vehClass");
String seriesId  = (String) request.getAttribute("seriesId");
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
String regnName  = null;
int ruleId = 0;
ResultSet resRegn = st1.executeQuery(getBaseAmt);
if(null != resRegn && resRegn.first()) {
	do {
		baseAmt = resRegn.getInt("NPV.amount");
		regnName  = resRegn.getString("RM.region_name");
		ruleId = resRegn.getInt("NPV.rule_id");
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
			<legend style="font-size: 18pt; color: #123456; font-weight: bold; font-family: arail">Make CMD Payment</legend>
			<br/>
			<p align="left" style="font-size: 14pt; padding :5px; background-color:#d2d2d2; color: orange;font-family: verdana">Vehicle Number Information</p>
			<form name="payCmd" action="#" method="post">
			<table width="100%" cellpadding="10" cellspacing="0" border="0">
				<tr style="background-color: #e2e2e2">
					<td align="center" style="background-color: #505050; color: white; font-size: 30px;" width="30%">MH-<%=regnId %>-<%=serName %><br/><br/><span style="font-size: 50px;color: yellow;"><%=vehNumber %></span></td>
					<td valign="top" width="*" style="color: #123456; font-weight: bold">
						<span style="color:#5A5655; font-size: 10px; ">RTO Region :</span> <i><%=regnName %></i><br/>
						<span style="color:#5A5655; font-size: 10px; ">Bidding Started on </span> <i><%=startDate %></i>
						<span style="color:#5A5655; font-size: 10px; ">and will be closed on</span><i> <%=endDate %></i>
						<span style="color:#5A5655; font-size: 10px; ">Base Amount : </span><i> <%=baseAmt %> &#x20B9;</i><br/>
						<span style="color:#5A5655; font-size: 10px; ">Caution Money Deposit Amount : </span><i> <%=baseAmt*25/100 %> &#x20B9;</i>
						<br/>
					</td>
				</tr>
				<tr>
					<td valign="top" align="center" style="background-color: #404040; color: #f2f2f2; font-size: 16px;"><%=regnName %></td>
					<td align="right" style="background-color: #d2d2d2;"><span style="font-size: 20px; color:#808080">Total : </span> 
					<lable style="height: 30px; width: 60px; font-size:20px; color: #505050" name="amtToPay" id="amtToPay"> <%=baseAmt*25/100 %> &#x20B9; </lable></td>
				</tr>
			</table>			
			<%
			DatabaseConn dbConn2 = new DatabaseConn();
			Connection conn2 = dbConn1.connectDb();
			Statement st2=conn2.createStatement();
			String fullName = null;
			String bankName = null;
			String branchName = null;
			Integer accountNo = null;
			Integer accountType = null;
			String accType = null;
			String ifscCode = null;
			String getBaseAmt2 = "SELECT * FROM users AS U, users_bankacc_info AS UBI, users_personal_info AS UPI WHERE user_id = '"+userId+"' and U.bankacc_info_id = UBI.bankacc_info_id and UPI.personal_info_id = U.personal_info_id";

			ResultSet resRegn2 = st2.executeQuery(getBaseAmt2);
			if(null != resRegn2 && resRegn2.first()) {
				do {
					fullName = resRegn2.getString("fullname");
					bankName = resRegn2.getString("UBI.bank_name");
					branchName = resRegn2.getString("UBI.branch_name");
					accountNo = resRegn2.getInt("UBI.account_number");
					accountType = resRegn2.getInt("UBI.account_type");
					if (accountType.equals(1)) {
						accType = "SAVINGS";
					} else {
						accType = "CURRENT";
					}
					ifscCode = resRegn2.getString("UBI.ifsc_code");
				} while (resRegn.next());;
			}
			
			%>
			<br/>
			<p align="left" style="font-size: 14pt; padding :5px; background-color:#d2d2d2; color: orange;  font-family: verdana">User Account Information</p>
			<table width="100%" cellpadding="3" cellspacing="0" border="0" style="background-color: #e2e2e2"> 
				<tr style="color: green; font-weight: bold;">
					<td width="40%"><span style="color:#5A5655; font-size: 10px; ">User Full Name :</span> <i><%=fullName %></i></td>
					<td></td>
				</tr>
				<tr style="color: #123456; font-weight: bold;">
					<td><span style="color:#5A5655; font-size: 10px; ">Bank Name :</span> <i><%=bankName %></i></td>
					<td><span style="color:#5A5655; font-size: 10px; ">Branch Name :</span> <i><%=branchName %></i></td>
				</tr>				
				<tr style="color: #123456; font-weight: bold;">
					<td><span style="color:#5A5655; font-size: 10px; ">Account Number :</span> <i><%=accountNo %></i></td>
					<td><span style="color:#5A5655; font-size: 10px; ">Account Type :</span> <i><%=accType %></i></td>
				</tr>			
				<tr style="color: #123456; font-weight: bold;">
					<td><span style="color:#5A5655; font-size: 10px; ">IFSC Code :</span> <i><%=ifscCode %></i></td>
					<td></td>
				</tr>
				<tr style="color: #123456; font-weight: bold; ">
					<td style="background-color: #d3d3d3"><span style="color:#505050; font-size: 10px; ">Enter PIN Number :</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="password" name="pinNo" id="pinNo" maxlength="4" style="height: 20px;width: 50px; background-color: #f2f2f2;color: #123456;"> 
					</td>
					<td></td>
				</tr>
				<tr style="color: #123456; font-weight: bold; ">
					<td style="background-color: #d3d3d3"><span style="color:#505050; font-size: 10px; ">Enter CVV Number :</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="password" name="pinNo" id="pinNo" maxlength="4" style="height: 20px;width: 50px; background-color: #f2f2f2;color: #123456;"> 
					</td>
					<td></td>
				</tr>
								
			</table>
			<br/>
			<br/>
			<p align="right">
				<input type="submit" style="width: 140px; height: 30px; background-color: #123456; border-radius:5px; color: white; font-size: 14px;" name="addToCart" value="Make CMD Payment">
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
