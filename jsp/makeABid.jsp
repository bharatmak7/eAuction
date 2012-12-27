<%@ page language="java" import="java.sql.*" errorPage=""%>
<%@ page import="com.bst.eauction.rto.DatabaseConn"%>
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
%>
		<style>
		.tooltip{display:inline;position:relative}
 .tooltip:hover:after{
   background:#111;
   background:rgba(0,0,0,.8);
   border-radius:5px;
   bottom:18px;
   color:yellow;
   content:attr(title);
   display:block;
   left:50%;
   padding:5px 15px;
   position:absolute;
   white-space:nowrap;
   z-index:98;
   font-size: 14px
  }
  .tooltip:hover:before{
    border:solid;
    border-color:#111 transparent;
    border-width:6px 6px 0 6px;
    bottom:12px;
    content:"";
    display:block;
    left:75%;
    position:absolute;
    z-index:99
   }
		.black_overlay{
			display: none;
			position: absolute;
			top: 0%;
			left: 0%;
			width: 100%;
			height: 100%;
			background-color: gray;
			z-index:1001;
			-moz-opacity: 0.8;
			opacity:.80;
			filter: alpha(opacity=80);
		}
		.white_content {
			display: none;
			position: absolute;
			top: 15%;
			left: 20%;
			width: 50%;
			height: 40%;
			padding: 16px;
			border: 16px solid #ededed;
			background-color: #c3c3c3;
			z-index:1002;
			overflow: auto;
		}
	</style>
	<script type="text/javascript">
	document.onmousedown=disableclick;
	var status="Right Click Disabled";
	function disableclick(e){
  	if(e.button==2)
   	{
     	alert(status);
     	return false;    
   		}
	}
	
	function checkNumber(id, visibility) 
	{
		var series = document.getElementById('vehNumber').value;
		var regname = /^[0-9]+$/;
		if(series == '' || regname.test(series)==false )
		{
				document.getElementById(id).style.display = 'inline';
				return false;
		}
		
	}
	
	function setVisibility(id, visibility) {
		document.getElementById(id).style.display = 'none';
	}
	
	function validateForm() {
		return checkNumber(101, 'inline');
	}
	function resetAll() {
		document.getElementById('101').style.display = 'none';
		document.getElementById('vehNumber').focus();
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
			<legend style="font-size: 18pt; color: #123456; font-weight: bold; font-family: arail">Select Region</legend>
			<table cellpadding="5" cellspacing="5" width="100%" border="0">
				<tr>
					<td width="50%"></td>
					<td width="10%" style="background-color: #88BA00;text-align: center;"></td>
					<td style="color:#123456; font-size: 12px;font-weight: bold;"> Live</td>
					<td width="10%" style="background-color: #E7F98D;text-align: center;"></td>
					<td style="color:#123456; font-size: 12px;font-weight: bold;"> Not Live</td>
				</tr>
			</table>
			<br/>
			<table cellpadding="3" cellspacing="3" width="100%" border="1" >
							<%
						DatabaseConn dbConn = new DatabaseConn();
						Connection conn = dbConn.connectDb();
		    			Statement st=conn.createStatement();
		    			ResultSet rsdoLogin = null;
		    			PreparedStatement psdoLogin=null; 
		    			try{
		        			String sqlOption = "SELECT * from region_master";
		        			rsdoLogin = st.executeQuery(sqlOption);
		        			if(null != rsdoLogin && rsdoLogin.first()) {
		        			int i = 0;
		        			int counter = 0;
		        				do{
		    			%>
		    				
		    			<% if (i%5 == 0) { %>
		    				<tr align="left" height="50px">
		    			<% } 
		    				int regnId = rsdoLogin.getInt("region_id");
		    				String regnName = rsdoLogin.getString("region_name");
		    				
		    				DatabaseConn dbConn1 = new DatabaseConn();
							Connection conn1 = dbConn1.connectDb();
			    			Statement st1=conn1.createStatement();
		    				String getStatus = "SELECT * from series_launch AS SL, region_master AS RM Where SL.region_id = '" + rsdoLogin.getInt("region_id") + "' and SL.region_id = RM.region_id";
		    				//System.out.println(getStatus);
		    				ResultSet resRegn = st1.executeQuery(getStatus);
		    				if(null != resRegn && resRegn.first()) {
		    					if(resRegn.getInt("SL.series_status") == 1){
		    						String serName = resRegn.getString("SL.series_name");
				    				Date stDate = resRegn.getDate("SL.ser_st_date");
				    				Date endDate = resRegn.getDate("SL.ser_end_date");
				    				String regionName = resRegn.getString("RM.region_name");
				    				Integer vehId = resRegn.getInt("SL.veh_id");
				    				Integer seriesId = resRegn.getInt("SL.series_id");
				    				String vehtype = null;
				    				if (vehId == 1) {
				    					vehtype = "TWO WHEELER";
				    				} else {
				    					vehtype = "FOUR WHEELER";
				    				}
				    				
		    			%>
		    				<td style="background-color: #88BA00;text-align: center;">
		   					<a href = "javascript:void(0)"  title=" MAHARASHTRA &#13; RTO : <%=regnName%>-<%=regnId%> &#13; Series : <%=serName %> - <%=vehtype %> &#13; Start Date : <%=stDate%> &#13; End Date : <%=endDate %>"  style="text-decoration:none" onclick = "document.getElementById('seriesId').value='<%=seriesId %>';document.getElementById('vehId').value='<%=vehId %>';document.getElementById('regnId').value='<%=regnId %>';document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">
		   						<span style="color: #ffffff; font-size: 12px;" ><%=regnName%>-<%=regnId%></span>
		   					</a>
							<div id="light" class="white_content">
								<form name="makeABid<%=counter %>" onsubmit="return validateForm();" action="SelectRegion" method="post">
								<input type="hidden" name="regnId" id="regnId" value="">

								<input type="hidden" name="serName" id="serName" value="<%=serName %>">
								<input type="hidden" name="startDate" id="startDate" value="<%=stDate %>">
								<input type="hidden" name="endDate" id="endDate" value="<%=endDate %>">
								<input type="hidden" name="vehId" id="vehId" value="">
								<input type="hidden" name="seriesId" id="seriesId" value="">
								
								<table width="100%"  cellspacing="0" cellpadding="5" border="0">
									<tr valign="top">
									<td align="center" style="background-color: orange; color: #123456; font-size: 20px; font-family: text; font-weight: bold;" >
										Insert Vehicle Number
									</td>
									<td></td>
									<td align="right">
										<a href = "javascript:void(0)"  style="text-decoration: none" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">
											<img src="jsp/images/close_but.png" height="30px" width="30px">
										</a>
									</td>
									</tr>
									<tr>
										<td ></td>
										<td><img src="jsp/images/two_wheel.png" height="80px" width="80px"></td>
										<td><img src="jsp/images/four_wheel.png" height="80px" width="80px"></td>
									</tr>
									<tr valign="top">
										<td style="font-size: 16px; color: #123456; font-weight: bold" align="center" > Select Vehicle</td>
										
											<td><input type="radio" name="vehicleClass" value="TWO" checked="checked" ></td>
										<td><input type="radio" name="vehicleClass" value="FOUR" ></td>
									</tr>
									<tr>
										<td ></td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<tr valign="top">
										<td style="font-size: 16px; color: #123456; font-weight: bold" align="center" > Enter Vehicle Number</td>
										<td align="center">
										<input type="text" name="vehNumber" id="vehNumber" maxlength="4" size="10" style="height: 30px; width : 50px; font-weight:bold; font-size: 16px; background-color: #ededed;color: #123456; " onfocus="setVisibility('101','none');" onBlur="checkNumber('101','inline');" tabindex="1"></td>
										<td align="left"><i id="101"><font color="red" size="1">Enter valid number </font></i></td>
									</tr>
									<!-- 
									<tr>
										<td ></td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									 -->
									<tr>
									<td></td>
									<td>
										<input type="submit" style="width: 120px; height: 30px; background-color: #123456; border-radius:5px; color: white; font-size: 14px;" name="goToBid" id="goToBid" value="Go For Bid" tabindex="2">
									</td>
									<td>
										<input type="button" style="width: 100px; height: 30px; background-color: #123456; border-radius:5px; color: white; font-size: 14px;" name="reset" id="reset" value="Cancel" tabindex="3" onclick="javascript:window.location.href='LoginSystem?param=userHome'" />
									</td>
									</tr>
								</table>
								</form>
							</div>
							<div id="fade" class="black_overlay">
							</div>
		    					
		    					
		    				</td>
		    			<%
		    				
		    					}
		    				} else {
		    			%>
		    			
		    				<td style="background-color: #E7F98D;text-align: center;">
		    					<span style="color: #123456; font-size: 12px;"><%=regnName%>-<%=regnId%></span>
		    				</td>
						<% 
		    				}
		    				conn1.close();
		    				
						i++;
						if (i%5 == 0) { %>
		    				</tr>
		    			<% } %>		    				
		    			<%
		    			counter++;
		        				} while (rsdoLogin.next());
		        			}
		    			} catch(Exception e) {
		        			e.printStackTrace();
		    			}
		    			conn.close();
		    			%>
			</table>
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
