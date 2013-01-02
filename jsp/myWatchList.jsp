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

function populateFruitVariety() {
	   
    $.getJSON('jsp/fetchActiveRtoData.jsp', {rtoCode:$('#rtoCode').val()}, displayResult);
    
}

function displayResult(data) {
	 if (!data.error) // emp not found
	  {
      	$.each(data, function(index, array) {
      		$("#seriesName").val(array['series_name']);
      		$("#vehClass").val(array['vehicle_type']);
      		
      });
	}
}

$(document).ready(function() {
	populateFruitVariety();
	$('#rtoCode').change(function() {
		populateFruitVariety();
	});
});


function setVisibility(id, visibility) {
	document.getElementById(id).style.display = 'none';
}

function checkNumber(id, visibility) {
	var veh_no = document.getElementById('vehNum').value;
	var regamount = /^[0-9]+$/;
	if(veh_no == '' || regamount.test(veh_no)==false) {
		document.getElementById(id).style.display = 'inline';
		return false;
	} else
		return true;					
}

function validateForm() {
	var v1 = checkNumber(101, 'inline');
	return v1;
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
			<legend style="font-size: 18pt; color: #123456; font-weight: bold; font-family: arail">Add numbers to Watch List</legend>
			<br/>
			<form name="myWatchList" onsubmit="return validateForm();" action="AddWatchList" method="post">
			<table width="100%" cellpadding="4" cellspacing="0" border="0">
			<tr align="center" style="background-color: #dedede; color: #123456; font-size:14px; font-weight:bold; font-family:text;">
				<td width="10%">State</td>
				<td width="30%">Select RTO</td>
				<td width="10%">Series</td>
				<td width="10%">Vehicle Class</td>
				<td width="*" align="left">Insert No</td>
			</tr>
			<%
			DatabaseConn dbConn1 = new DatabaseConn();
			Connection conn1 = dbConn1.connectDb();
			Statement st1=conn1.createStatement();
			String getBaseAmt = "SELECT * FROM `series_launch` AS SL,`region_master` AS RM WHERE SL.region_id = RM.region_code and SL.`series_status` = 1";
			ResultSet resRegn = st1.executeQuery(getBaseAmt);
			%>
			<tr valign="top" align="center">
				<td><input type="text" name="stCode" id="stCode" value="MH" style="width:30px;color:#123456; height: 30px; font-size: 14px;background-color: #c2c2c2" readonly="readonly"></td>
				<td>
				<select name="rtoCode" id="rtoCode" style="color:#123456; height: 35px; font-size: 14px;background-color: #c2c2c2">
					<% if(null != resRegn && resRegn.first()) {
						int cnt = 1;
						do {
							String regnName = resRegn.getString("RM.region_name");
							Integer regnId = resRegn.getInt("RM.region_code");
					 %>
					<option value="<%=regnId %>"><%=regnName %>-<%=regnId %></option>
					
					<%} while(resRegn.next());
						
					}%>
				</select>
				</td>
				<td><input type="text" name="seriesName" id="seriesName" size="3px" readonly="readonly" style="color:#123456; height: 30px; font-size: 14px;"></td>
				<td><input type="text" name="vehClass" id="vehClass" size="3px" readonly="readonly" style="color:#123456; height: 30px; font-size: 14px;"></td>
				<td align="left">
					<input type="hidden" name="userId" id="userId" value="<%=userId %>">
					<input type="text" name="vehNum" id="vehNum" style="width:40px; color:#123456; height: 30px; font-size: 16px;" maxlength="4" onfocus="setVisibility('101','none');" onBlur="checkNumber('101','inline');">&nbsp;&nbsp;
					<input type="submit" name="addToWatchList" id="addToWatchList" Value="Add" style="height: 30px;width: 70px;border-radius:7px;background-color: #123456; color: white; font-size: 12px;"> 
				</td>
			</tr>
			
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td>&nbsp;</td>
				<td align="left"><i id='101' > <font color="red" size="1"> Enter valid number </font> </i></td>
			</tr>
			
			</table>
				<%
				String showMessage = (String)request.getAttribute("showMessage");
				String msg = (String)request.getAttribute("message");
				if(("true").equals(showMessage))
				{
				%>
					<p align="left" style="color: green;background-color: #e2e2e2">
					<i><%=msg %>
						<span style="color: #123456;" > To view watch list click </span>
						<a href="/eAuction/LoginSystem?param=viewWatchList">here</a>
					</i>&nbsp;</p>
				<%} %>
			
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
