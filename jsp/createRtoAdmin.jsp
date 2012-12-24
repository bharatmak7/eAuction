<%@page import="com.bst.eauction.rto.DatabaseConn"%>
<%@ page language="java" import="java.sql.*" errorPage="" %>
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
<script src="jsp/js/ts_picker.js" type="text/javascript"></script>
<script type="text/javascript">
//var regEmail = /^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$/;

function goBack() {
window.history.back()
}

function setVisibility(id, visibility) {
	document.getElementById(id).style.display = 'none';
}

function checkFullname(id, visibility) {
	var veh_no = document.getElementById('admName').value;
	var regamount = /^[a-z|A-Z|.+ ]+$/;
	if(veh_no == '' || regamount.test(veh_no)==false) {
		document.getElementById(id).style.display = 'inline';
		return false;
	} else
		return true;					
}

function checkLoginId(id, visibility) {
	var veh_no = document.getElementById('admLogId').value;
	var regamount = /^[a-z|A-Z|0-9| ]+$/;
	if(veh_no == '' || regamount.test(veh_no)==false) {
		document.getElementById(id).style.display = 'inline';
		return false;
	} else
		return true;					
}

function checkPassword(id, visibility) {
	var veh_no = document.getElementById('admPass').value;
	if(veh_no == '') {
		document.getElementById(id).style.display = 'inline';
		return false;
	} else
		return true;					
}

function checkConPassword(id, visibility) {
	var conPass = document.getElementById('admConPass').value;
	var pass = document.getElementById('admPass').value;
	if(conPass == '' || pass!=conPass ) {
		document.getElementById(id).style.display = 'inline';
		return false;
	} else
		return true;					
}


function checkEmail(id, visibility) {
	var veh_no = document.getElementById('admEmail').value;
	var regEmail = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i;
	if(veh_no == '' || regEmail.test(veh_no)==false) {
		document.getElementById(id).style.display = 'inline';
		return false;
	} else
		return true;					
}

function checkPhone(id, visibility) {
	var veh_no = document.getElementById('admPhone').value;
	var regamount = /^[0-9]+$/;
	if(veh_no == '' || regamount.test(veh_no)==false || veh_no.length != 10) {
		document.getElementById(id).style.display = 'inline';
		return false;
	} else
		return true;					
}

function resetAll() {
	document.getElementById('101').style.display = 'none';
	document.getElementById('102').style.display = 'none';
	document.getElementById('103').style.display = 'none';
	document.getElementById('104').style.display = 'none';
	document.getElementById('105').style.display = 'none';
	document.getElementById('106').style.display = 'none';
	document.getElementById('admName').value = '';
	document.getElementById('admPass').value = '';
	document.getElementById('admConPass').value = '';
	document.getElementById('admLogId').value = '';
	document.getElementById('admPhone').value = '';
	document.getElementById('admEmail').value = '';
}

function validateForm() {
	var v1 = checkFullname(101, 'inline');		
	var v2 = checkPassword(103, 'inline');
	var v3 = checkConPassword(104, 'inline');
	var v4 = checkEmail(106, 'inline');
	var v5 = checkLoginId(102, 'inline');
	var v6 = checkPhone(105, 'inline');
	var result = (v1 && v2 && v3 && v4 && v5 && v6);
	return result;
}		
</script>
<STYLE>
em {
	color:red;
}

</STYLE>
<%
String adminName = (String) session.getAttribute("admin");
String isSuperUser = (String) session.getAttribute("isSuperUser");
%>
</head>

<body onload="resetAll();">
<div id="topPanel">
<ul>
<li><a href="/eAuction/LoginSystem?param=logout">Logout</a></li>
<li><a href="#">My Profile</a></li>
<li class="active">Home</li>
</ul>
<font color="#123456" size=6  style="font-weight: normal;">Manage Admin</font>
<!-- <img src="jsp/images/logo.gif" title="RTO Pune" alt="RTO Pune" width="230" height="80" border="0" /> -->
</div>
<div id="bodyPanel">
<p align="right" style="font-size:12pt; color:green;">Welcome to eAuction, <font color="orange"><%=adminName %></font></p>
<br/>
<table width="100%" border="0" height="93%" cellpadding="5" cellspacing="1" style="background-color: #ededed;">
<tr valign="top" >
	<td style="width: 200px;padding-left: 10px;" >
		<jsp:include page="adminMenu.jsp" />
	</td>
	<td width="*">
		<form name="createRtoAdm" onsubmit="return validateForm();" action="CreateRtoAdmin" method="post">
		<fieldset>
			<legend style="font-size:16pt;color:#FF7D24;font-family:roman;">Create Admin for RTO</legend>
				<%
				String showMessage = (String)request.getAttribute("showMessage");
				if(("true").equals(showMessage))
				{
				%>
					<p align="right" style="color: green;background-color: #e2e2e2"><i>Admin created successfully. </i>&nbsp;</p>
				<%} %>
			<table cellpadding="10" cellspacing="0" width="100%" border="0">
				<tr>
					<td width="30%" align="right" style="color: #123456">Admin Fullname <em>*</em></td>
					<td width="35%" align="left">
						<input name="admName" id="admName" type="text" size="30px" onfocus="setVisibility('101','none');" onBlur="checkFullname('101','inline');"/>
					</td>
					<td align="left"><i id='101' > <font color="red" size="1"> Enter valid name </font> </i></td>
				</tr>
				<tr>
					<td width="30%" align="right" style="color: #123456">Login Id <em>*</em></td>
					<td width="35%" align="left">
						<input name="admLogId" id="admLogId" type="text" size="30px" onfocus="setVisibility('102','none');" onBlur="checkLoginId('102','inline');" />
					</td>
					<td align="left"><i id='102' > <font color="red" size="1"> Enter valid Login Id </font> </i></td>
				</tr>
				<tr>
					<td width="30%" align="right" style="color: #123456">Password <em>*</em></td>
					<td width="35%" align="left">
						<input name="admPass" id="admPass" type="password" size="30px" onfocus="setVisibility('103','none');" onBlur="checkPassword('103','inline');"/>
					</td>
					<td align="left"><i id='103' > <font color="red" size="1"> Enter valid password  </font> </i></td>
				</tr>
				<tr>
					<td width="30%" align="right" style="color: #123456">Confirmed Password <em>*</em></td>
					<td width="35%" align="left">
						<input name="admConPass" id="admConPass" type="password" size="30px" onfocus="setVisibility('104','none');" onBlur="checkConPassword('104','inline');"/>
					</td>
					<td align="left"><i id='104'> <font color="red" size="1"> Wrong password </font> </i></td>
				</tr>
				<tr>
					<td width="30%" align="right" style="color: #123456"> Phone Number <em>*</em></td>
					<td width="35%" align="left">
						<input name="admPhone" id="admPhone" type="text" maxlength="10" size="30px" onfocus="setVisibility('105','none');" onBlur="checkPhone('105','inline');"/>
					</td>
					<td align="left"><i id='105'> <font color="red" size="1"> Enter Valid phone Number </font> </i></td>
				</tr>
				<tr>
					<td width="30%" align="right" style="color: #123456">Email Id <em>*</em></td>
					<td width="35%" align="left">
						<input name="admEmail" id="admEmail" type="text" size="30px" onfocus="setVisibility('106','none');" onBlur="checkEmail('106','inline');"/>
					</td>
					<td align="left"><i id='106'> <font color="red" size="1"> Enter valid email id </font> </i></td>
				</tr>
				<tr>
				<td width="30%" align="right" style="color: #123456">Select Region <em>*</em></td>
					<td width="35%" align="left">
					<select name="admReg">
					<%
						DatabaseConn dbConn = new DatabaseConn();
						Connection conn = dbConn.connectDb();
		    			Statement st=conn.createStatement();
		    			ResultSet rsdoLogin = null;
		    			PreparedStatement psdoLogin=null; 
		    			try{
		        			String sqlOption="SELECT * from region_master";
		        			rsdoLogin = st.executeQuery(sqlOption);
		        			if(null != rsdoLogin && rsdoLogin.first()) {
		        				do{
		    			%>
		    				<option value="<%=rsdoLogin.getString("region_name")%>-<%=rsdoLogin.getString("region_id")%>"><%=rsdoLogin.getString("region_name")%>-<%=rsdoLogin.getString("region_id")%></option>
		    			<%
		        				} while (rsdoLogin.next());
		        			} else {
		        		%>
		     				<option value="">N.A.</option>   	
		        		<%
		        			}
		    			} catch(Exception e) {
		        			e.printStackTrace();
		    			}
		    			conn.close();
		    			%>
			
						</select>
					</td>
					<td></td>
				</tr>
			</table>
			<br/>
			<p align="right" >
    		<input type="button" style="width: 80px; height: 25px; background-color: #123456; border-radius:5px; color: white; font-size: 14px;" name="reset" id="reset" value="Reset" onclick="resetAll();" />&nbsp;&nbsp;&nbsp;
	    	<input type="submit" style="width: 80px; height: 25px; background-color: #123456; border-radius:5px; color: white; font-size: 14px;" name="admcreate" id="admcreate" value="Create"/>&nbsp;&nbsp;&nbsp;
    	</p>
		</fieldset>
	</form>
	</td>
</tr>
</table>
</div>
<div id="footerPanel">
        <jsp:include page="footer.jsp"/>
</div>
<br/>
</body>
</html>
