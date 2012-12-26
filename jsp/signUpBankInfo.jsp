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

document.onmousedown=disableclick;
var status = "Right Click Disabled";
function disableclick(e){
	if(e.button==2)
	{
 	alert(status);
 	return false;    
		}
}


function goBack()
{
window.history.back();
}
</script>
<STYLE>
em {
	color:red;
}

</STYLE>
</head>

<body>
<div id="topPanel">
<ul>
<li><a href="/eAuction/LoginSystem?param=logoutme">Home</a></li>
<li class="active">Sign Up</li>
</ul>
<font color="#123456" size=5>Step 3 : </font><font color="orange" size=5 >Account Information</font>
<!-- <img src="jsp/images/logo.gif" title="RTO Pune" alt="RTO Pune" width="230" height="80" border="0" /> -->
</div>
<div id="bodyPanel">
	<div style="width:762px;color:black;height: 35px;color: #123456; background-color: #E61B31" align="center" >
		<table width="100%" height="100%" style="border-radius: 10px;" cellpadding="0" cellspacing="1">
			<tr align="center">
				<td width="25%"  style="color: white; background-color: #00A513; font-size: 15px">Personal Info</td>
				<td width="25%" style="color: white;  background-color: #00A513; font-size: 15px">Login Detail</td>
				<td width="25%" style="color: white;  background-color: #00A513;text-decoration: blink; font-size: 15px">Account Info</td>
				<td width="25%" style="color: white; font-size: 15px">Declaration</td>
			</tr>
		</table>
	</div>
	<form name="signUpDeclaration" action="SignUpDeclaration" method="post">
	<h5>Note: Required fields are marked with an asterisk (*)</h5>
	<fieldset style="width: 642px">
		<legend style="font-size:16pt;color:#FF7D24;font-family:roman;">Bank Information</legend><br/>
            <div style="padding: 7px;color: #123456; font-weight: bold;">
                <label for="bankname">Bank Name <em>*</em></label> &nbsp;&nbsp;&nbsp;
                <input id="bankname" type="text" name="bankname" class="txtbox" value="" />
                 <span class="error" id="errbankname"></span>
            </div>
            <div style="padding: 7px;color: #123456; font-weight: bold;">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <label for="branch">Branch <em>*</em></label> &nbsp;&nbsp;&nbsp;
                <input id="branch" type="text" name="branch" class="txtbox" value="" />
                <span class="error" id="errbranch"></span>
            </div>
            <div style="padding: 7px;color: #123456; font-weight: bold;">
                <label for="accountno">Account no <em>*</em></label> &nbsp;&nbsp;&nbsp;
                <input id="accountno" type="text" name="accountno" class="txtbox" value="" />
                <span class="error" id="erraccountno"></span>
               
            </div>
            <div style="padding: 7px;color: #123456; font-weight: bold;">
            	<label for="accounttype">Account Type </label> &nbsp;&nbsp;&nbsp;
            	<span style="color:green">Saving  </span><input type="radio" name="accounttype" value="S" id="bleg" checked="checked" style="vertical-align:middle" />
                &nbsp;&nbsp;&nbsp;<span style="color:green">Current </span><input type="radio" name="accounttype" value="C"  style="vertical-align:middle" />
            </div>
            <div style="padding: 7px;color: #123456; font-weight: bold;">
            &nbsp;&nbsp;&nbsp;
                <label for="ifsccode">IFSC Code <em>*</em> </label> &nbsp;&nbsp;&nbsp;
                <input id="ifsccode" type="text" name="ifsccode" class="txtbox" value="" />
                <span class="error" id="errifsccode"></span>
            </div>

    	<p align="right" >
    		<input type="button" style="width: 80px; height: 25px; background-color: #123456; border-radius:5px; color: white; font-size: 14px;" name="backToLoginDetail" id="backToLoginDetail" value="Back" onclick="goBack();"/>&nbsp;&nbsp;&nbsp;
    		<input type="submit" style="width: 80px; height: 25px; background-color: #123456; border-radius:5px; color: white; font-size: 14px;" name="bankInfoSubmit" id="bankInfoSubmit" value="Next"/>&nbsp;&nbsp;&nbsp;
    	</p>
	</fieldset>
	</form>
</div>
<div id="footerPanel">
        <jsp:include page="footer.jsp"/>
</div>
<br/>
</body>
</html>
