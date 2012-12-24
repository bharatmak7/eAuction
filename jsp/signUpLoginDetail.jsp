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
function goBack()
{
window.history.back()
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
<font color="#123456" size=5>Step 2 : </font><font color="orange" size=5 >Login Details</font>
<!-- <img src="jsp/images/logo.gif" title="RTO Pune" alt="RTO Pune" width="230" height="80" border="0" /> -->
</div>
<div id="bodyPanel">
	<div style="width:762px;color:black;height: 35px;color: #123456; background-color: #E61B31" align="center" >
		<table width="100%" height="100%" style="border-radius: 10px;" cellpadding="0" cellspacing="1">
			<tr align="center">
				<td width="25%"  style="color: white; background-color: #00A513; font-size: 15px">Personal Info</td>
				<td width="25%" style="color: white;  background-color: #00A513; font-size: 15px; text-decoration: blink">Login Detail</td>
				<td width="25%" style="color: white;  font-size: 15px">Account Info</td>
				<td width="25%" style="color: white; font-size: 15px">Declaration</td>
			</tr>
		</table>
	</div>
	<form name="signUpLoginDetail" action="SignUpBankInfo" method="post">
	<h5>Note: Required fields are marked with an asterisk (*)</h5>
	<fieldset style="width: 642px">
		<legend style="font-size:16pt;color:#FF7D24;font-family:roman;">Login Details</legend><br/>
                <div style="padding: 10px;color: #123456; font-weight: bold;">
                    <label for="loginid">Choose LoginId <em>*</em> &nbsp;&nbsp;</label> 
                    <input id="loginid" type="text" name="loginid" class="txtbox" value="" />
                    <span class="error" id="errloginids"></span>
                </div>
                <div style="padding: 10px;color: #123456; font-weight: bold;">
                	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <label for="loginpassword">Password <em>*</em> &nbsp;&nbsp;</label> 
                    <input id="loginpassword" type="password" class="txtbox" name="loginpassword" value="" />&nbsp;&nbsp;
                    <img src="jsp/images/help.png" style="vertical-align:middle" alt="" /> <span style="color:green">Password Tip</span>
                </div>
                 
                <div style="padding: 10px;color: #123456; font-weight: bold;">
                    &nbsp;&nbsp;
                    <label for="repassword">Re Password  <em>*</em> &nbsp;&nbsp;</label> 
                    <input id="repassword" type="password" class="txtbox" name="repassword" value="" />
                </div>
                
			<div style="padding: 10px;color: #123456; font-weight: bold;">
			<label for="seq_ques">Security Question <em>*</em> &nbsp;&nbsp;</label> 
			<select name="security_question">
			<%
			DatabaseConn dbConn = new DatabaseConn();
			Connection conn = dbConn.connectDb();
		    Statement st=conn.createStatement();
		    ResultSet rsdoLogin = null;
		    PreparedStatement psdoLogin=null; 
		    try{
		        String sqlOption="SELECT * from security_ques";
		            
		        rsdoLogin = st.executeQuery(sqlOption);
		        if(null != rsdoLogin && rsdoLogin.first())
		        {
		        	do{
		    %>
		    <option value="<%=rsdoLogin.getString("ques_id")%>"><%=rsdoLogin.getString("question")%></option>
		    <%
		        	}while(rsdoLogin.next());
		        }else
		        {
		        	%>
		     <option value="">N.A.</option>   	
		        	<%
		        }
		    } catch(Exception e)
		    {
		        e.printStackTrace();
		    }
		    
		    conn.close();
		    %>
			
			</select>
			</div>
			
			<div style="padding: 10px;color: #123456; font-weight: bold;">
                    &nbsp;&nbsp;
                    <label for="yourAns">Your Answer <em>*</em> &nbsp;&nbsp;</label> 
                    <input id="yourAns" type="text" class="txtbox" name="yourAns" value="" />
            </div>

    	<p align="right" >
    	<input type="button" style="width: 80px; height: 25px; background-color: #123456; border-radius:5px; color: white; font-size: 14px;" name="backToPersonalInfo" id="backToPersonalInfo" value="Back" onclick="goBack();"/>&nbsp;&nbsp;&nbsp;
    	<input type="submit" style="width: 80px; height: 25px; background-color: #123456; border-radius:5px; color: white; font-size: 14px;" name="goToBankInfo" id="goToBankInfo" value="Next"/>&nbsp;&nbsp;&nbsp;</p>
	</fieldset>
	</form>
</div>
<div id="footerPanel">
        <jsp:include page="footer.jsp"/>
</div>
<br/>
</body>
</html>
