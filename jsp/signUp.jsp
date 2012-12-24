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
<script type="text/javascript"></script>
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
<font color="#123456" size=5>Step 1 : </font><font color="orange" size=5 >Personal Information</font>
<!-- <img src="jsp/images/logo.gif" title="RTO Pune" alt="RTO Pune" width="230" height="80" border="0" /> -->
</div>
<div id="bodyPanel">
	<div style="width:762px;color:black;height: 35px;color: #123456; background-color: #E61B31" align="center" >
		<table width="100%" height="100%" style="border-radius: 10px;" cellpadding="0" cellspacing="0">
			<tr align="center">
				<td width="25%"  style="color: white; background-color: #00A513; font-size: 15px;text-decoration: blink;">Personal Info</td>
				<td width="25%" style="color: white;  font-size: 15px">Login Detail</td>
				<td width="25%" style="color: white;  font-size: 15px">Account Info</td>
				<td width="25%" style="color: white; font-size: 15px">Declaration</td>
			</tr>
		</table>
	</div>
	<form name="signUp" action="SignUpLoginDetail" method="post">
	<h5>Note: Required fields are marked with an asterisk (*)</h5>
	<fieldset style="width: 642px">
		<legend style="font-size:16pt;color:#FF7D24;font-family:roman;">Personal Information</legend><br/>
		 <div style="padding: 7px;color: #123456; font-weight: bold;">
                <label for="username">Full Name <em>*</em>&nbsp;&nbsp;</label> 
                <select name="titletype" id="titletype" style="width:80px;color: #123456;">
                	<option value="0">[-Title-]</option>
                    <option value="Mr">Mr.</option>
                    <option value="Mr">Ms.</option>
                    <option value="Mr">M/S.</option>
                </select>
                <input id="username" type="text" style="width:400px;" name="username" value="" />
            </div>
            <div style="padding: 7px;color: #123456; font-weight: bold;">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <label for="edob">DOB <em>*</em>&nbsp;&nbsp;</label> 
                <input type="text" name="dob" id="edob"  value="" />
					<a href="javascript:show_calendar('document.signUp.dob', document.signUp.dob.value);">
					<img src="jsp/images/cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up Date" ></a>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 <label for="maritalstatus">Marital Status </label> &nbsp;&nbsp;&nbsp;&nbsp;
            	<span style="color:green">Single </span><input type="radio" name="maritalstatus" value="U" id="maritalstatus"  style="vertical-align:middle;float:" checked="checked" />&nbsp;&nbsp;&nbsp;&nbsp;
                <span style="color:green">Married </span><input type="radio" name="maritalstatus" value="M"  style="vertical-align:middle" />
            </div>
            <div style="padding: 7px;color: #123456; font-weight: bold;">
               <label for="address"> Address  <em>*</em>&nbsp;&nbsp;&nbsp;</label> 
                <textarea rows="2" cols="30" style="width:482px;height:40px;" name="address" id="address"></textarea>
            </div>
            <div style="padding: 7px;color: #123456; font-weight: bold;">
            	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            	<label for="city">City <em>*</em>&nbsp;&nbsp;</label> 
                <span id="loadcities">
                	<input id="city" type="text" class="txtbox" name="city" value=""  />
                </span>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            	<label for="pincode">Pin Code </label>&nbsp;&nbsp;
                <input id="pincode" type="text" class="txtbox" name="pincode" value=""  />
            </div>
             <div style="padding: 7px;color: #123456; font-weight: bold;">
             	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            	<label for="distt">Distt. </label>&nbsp;&nbsp; 
                <span id="loadDistt">
                	<input id="distt" type="text" class="txtbox" name="distt" value=""  />
                </span>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            	<label for="state">State. </label>&nbsp;&nbsp;
                <span id="loadstate">
                	<input id="state" type="text" class="txtbox" name="state" value=""  />
                </span>
                
			<div style="padding: 7px;color: green; font-weight: bold;">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            	<input type="checkbox" name="copyaddress" id="copyaddress" style="vertical-align:middle" />&nbsp;&nbsp;&nbsp;&nbsp; <i>[same as first address]</i>
            </div>
            <div style="padding: 7px;color: #123456; font-weight: bold;">
                <label for="saddress" style="vertical-align: top;">Perm <br/>Address </label> &nbsp;&nbsp;&nbsp;
                <textarea rows="2" cols="30" style="width:482px;height:40px;" name="saddress" id="saddress"></textarea>
            </div>
           
             <div style="padding: 7px;color: #123456; font-weight: bold;">
             	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            	<label for="city">City </label>&nbsp;&nbsp; 
               	<input id="shipcity" type="text" class="txtbox" name="shipcity" value=""  />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            	<label for="shippincode">Pin Code </label> &nbsp;&nbsp;
                <input id="shippincode" type="text" class="txtbox" name="shippincode" value=""  />
            </div>
             <div style="padding: 7px;color: #123456; font-weight: bold;">
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            	<label for="shipdistt">Distt. </label> &nbsp;&nbsp;
               	<input id="shipdistt" type="text" class="txtbox" name="shipdistt" value=""  />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            	<label for="shipstate">State. </label> &nbsp;&nbsp;
                	<input id="shipstate" type="text" class="txtbox" name="shipstate" value=""  />
            </div>
            <div style="padding: 7px;color: #123456; font-weight: bold;">
            	&nbsp;
            	<label for="emailid"> Email Id <em>*</em></label> &nbsp;&nbsp;
                <input id="emailid" type="text" class="txtbox" name="emailid" value=""  />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <label for="mobile">Mobile Number <em>*</em></label> &nbsp;&nbsp;
                <input id="mobile" type="text" name="mobile" class="txtbox" value="" />
            </div>
            
             <!--  <div style="padding: 7px;color: #123456; font-weight: bold;">
                <label for="telno">Tel Number </label> &nbsp;
                <input id="telno" type="text" name="telno" class="txtbox" value="" />
               	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <label for="occupation">Occupation </label> &nbsp;&nbsp;
                <input id="occupation" type="text" class="txtbox" name="occupation" value="" />
                
            </div>-->
            
             <div style="padding: 7px;color: #123456; font-weight: bold;">
                &nbsp;&nbsp;<label for="panno">PAN No. <em>*</em></label> &nbsp;&nbsp;
                <input id="panno" type="text" name="panno" class="txtbox" value="" />
			</div>
			<div style="padding: 7px;color: #123456; font-weight: bold;">				
               <label for="identityproof">Identity Proof. <em>*</em>&nbsp;&nbsp;</label>
               <!-- <select id="identityproof" name="identityproof" class="txtbox" style="width:184px;color: #123456;" >
                        <option value="">-[SELECT]-</option>
                        <option value="Voter Card">Voter Card</option>
                        <option value="Ration Card">Ration Card</option>
                        <option value="Bank Statement">Bank Statement</option>
                        <option value="Driving License">Driving License</option>
                        <option value="Employer Certificate">Employer Certificate</option>
                        <option value="Phone Bill">Phone Bill</option>
                        <option value="PAN Card">PAN Card</option>
                        <option value="Certificate by MC/MLA/Gazetted Officer">Certificate by MC/MLA/Gazetted Officer</option>
               </select>
               -->
			<select name="security_question">
			<%
			DatabaseConn dbConn = new DatabaseConn();
			Connection conn = dbConn.connectDb();
		    //Class.forName("com.mysql.jdbc.Driver").newInstance();
		    //conn = DriverManager.getConnection("jdbc:mysql://localhost/balajiso_eauction","auction", "eauction@1234");
		    Statement st=conn.createStatement();
		    ResultSet rsdoLogin = null;
		    PreparedStatement psdoLogin=null; 
		    try{
		        String sqlOption="SELECT * from indentityproof_master";
		            
		        rsdoLogin = st.executeQuery(sqlOption);
		        if(null != rsdoLogin && rsdoLogin.first())
		        {
		        	do{
		    %>
		    <option value="<%=rsdoLogin.getString("identityproof_id")%>"><%=rsdoLogin.getString("indentity_proof")%></option>
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
			 &nbsp; &nbsp;
			<label for="idProofNo">ID Proof Nos <em>*</em>&nbsp;</label> &nbsp;
                <input id="idProofNo" type="text" name="idProofNo" class="txtbox" value="" />            
            </div>
          
    	</div>
    	<p align="right" ><input type="submit" style="width: 80px; height: 25px; background-color: #123456; border-radius:5px; color: white; font-size: 14px;" name="personalInfoSubmit" id="personalInfoSubmit" value="Next"/>&nbsp;&nbsp;&nbsp;</p>
	</fieldset>
	</form>
</div>
<div id="footerPanel">
        <jsp:include page="footer.jsp"/>
</div>
<br/>
</body>
</html>
