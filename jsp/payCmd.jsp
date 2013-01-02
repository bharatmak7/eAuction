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
String getBaseAmt = "SELECT * FROM number_price_value AS NPV, region_master AS RM WHERE NPV.reg_no = '" + vehNumber + "' AND NPV.veh_id = '" + vehId + "' and RM.region_id = '" + regnId + "'";
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

function prog_bar(cur_val,min_val,max_val,width,height,border,fill)
{
var str = "",res = 0;
if(cur_val>=min_val && cur_val<=max_val)
{
  if(min_val<max_val)
  {
    res = ((cur_val-min_val)/(max_val-min_val))*100;
res = Math.floor(res);
  }
  else
  {
    res = 0;
  }
}
else
{
  res = 0;
}
str = str + "<div  style=\"border:"+border+" solid thin; width:"+width+"px; height:"+height+"px;\">";
str = str + "<div style=\"background-color:"+fill+"; width:"+res+"%; height:"+height+"px;\">";
str = str + "</div></div>Processing... ";
str = str + res + "%";
document.getElementById("prog_bar").innerHTML = str;
}

function waitProcess() {
	prog_bar(30,0,100,200,5,"#0066FF","#c2c2c2");
	setTimeout(function(){prog_bar(60,0,100,200,5,"#0066FF","#c2c2c2");},1000);
	setTimeout(function(){prog_bar(80,0,100,200,5,"#0066FF","#c2c2c2");},2000);
	setTimeout(function(){
		prog_bar(100,0,100,200,5,"#0066FF","#c2c2c2");
		var userId = document.getElementById("userId").value; 
		var ruleId = document.getElementById("ruleId").value;
		var seriesId = document.getElementById("seriesId").value;
		var productKey = document.getElementById("productKey").value;
		var regnId = document.getElementById("regnId").value;
		var serName = document.getElementById("serName").value;
		var vehClass = document.getElementById("vehClass").value;
		var vehNumber = document.getElementById("vehNumber").value;
		var regnName = document.getElementById("regnName").value;
		var cmdAmt = document.getElementById("cmdAmt").value;
		var str = "userId=" + userId + "&ruleId=" + ruleId + "&seriesId=" + seriesId+"&productKey="+productKey+"&cmdAmt="+cmdAmt
		+"&regnId="+regnId+"&vehClass="+vehClass+"&vehNumber="+vehNumber+"&serName="+serName+"&regnName="+regnName;
		window.location.href="PlaceBidOnce?param=placeBidOnce&"+str; 
		return true;
	},3000);
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
			<div id="prog_bar">
			</div>
			<p align="center" style="font-size: 14pt; padding :5px; font-weight: bold; background-color:#d2d2d2; color: #505050;font-family: times">Vehicle Number Information</p>
			<form name="payCmd"  action="" method="post">
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
			long accountNo = 0;
			int accountType = -1;
			String accType = null;
			String ifscCode = null;
			String getBaseAmt2 = "SELECT * FROM users AS U, users_bankacc_info AS UBI, users_personal_info AS UPI WHERE user_id = '"+userId+"' and U.bankacc_info_id = UBI.bankacc_info_id and UPI.personal_info_id = U.personal_info_id";
			System.out.println(getBaseAmt2);
			ResultSet resRegn2 = st2.executeQuery(getBaseAmt2);
			if(null != resRegn2 && resRegn2.first()) {
				do {
					fullName = resRegn2.getString("fullname");
					bankName = resRegn2.getString("UBI.bank_name");
					branchName = resRegn2.getString("UBI.branch_name");
					accountNo = resRegn2.getLong("UBI.account_number");
					accountType = resRegn2.getInt("UBI.account_type");
					System.out.println(accountNo  +":"+accountType);
					if (accountType == 1) {
						accType = "SAVINGS";
					} else {
						accType = "CURRENT";
					}
					ifscCode = resRegn2.getString("UBI.ifsc_code");
				} while (resRegn.next());;
			}
			
			%>
			<br/>
			<p align="center" style="font-size: 14pt; padding :5px; font-weight: bold; background-color:#d2d2d2; color: #505050;  font-family: times">User Account Information</p>
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
			<input type="hidden" name="cmdAmt" id="cmdAmt" value="<%=baseAmt*25/100 %>">
			<input type="hidden" name="userId" id="userId" value="<%=userId %>">
			<input type="hidden" name="seriesId" id="seriesId" value="<%=seriesId %>">
			<input type="hidden" name="ruleId" id="ruleId" value="<%=ruleId %>">
			<input type="hidden" name="regnId" id="regnId" value="<%=regnId %>">
			<input type="hidden" name="serName" id="serName" value="<%=serName %>">
			<input type="hidden" name="vehClass" id="vehClass" value="<%=vehClass %>">
			<input type="hidden" name="vehNumber" id="vehNumber" value="<%=vehNumber %>">
			<input type="hidden" name="regnName" id="regnName" value="<%=regnName %>">
			<input type="hidden" name="productKey" id="productKey" value="MH<%=regnId %><%=serName %><%=vehClass %><%=vehNumber %>">
			<p align="right">
				<input type="button" style="width: 140px; height: 30px; background-color: #123456; border-radius:5px; color: white; font-size: 14px;" name="addToCart" value="Make CMD Payment" onclick="return waitProcess();">
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
