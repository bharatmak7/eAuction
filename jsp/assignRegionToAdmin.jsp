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
function goBack() {
	window.history.back()
}

function mpfunc()
{
   var comp = '';

   var elements = document.getElementById("assignedRegn").elements;
   for(var i=0; i< elements.length;i++){
      if(elements[i].type == 'checkbox' && elements[i].checked)
         comp = comp + elements[i].value +",";
   }
   if(comp == '') {
	   alert("Please select atleast one region");
	   return false;
   } else {
	   document.getElementById("selCheckBox").value = comp;
	   return true;
   }
}

function resetAll() {
   var elements = document.getElementById("assignedRegn").elements;
   for(var i=0; i< elements.length;i++){
      if(elements[i].type == 'checkbox' && elements[i].checked)
         elements[i].checked = false;
   }
}

function populateFruitVariety() {
	   
    $.getJSON('jsp/fetchAdminData.jsp', {adminFrom:$('#admReg').val()}, displayResult);
    
}

function displayResult(data) {
	 if (!data.error) // emp not found
	  {
	    var select = $('#selAdmin');
      	//var options = select.prop('options');
      	$('option', select).remove();
      	$.each(data, function(index, array) {
      		$("<option />", {value: array['admin_id'], text: array['admin_fullname']}).appendTo(select);
          //options[options.length] = new Option(array['admin_fullname']);
         // options[options.length].attr("value", array['admin_id']);
      });
	}
}

$(document).ready(function() {
	populateFruitVariety();
	$('#admReg').change(function() {
		populateFruitVariety();
	});
});



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

<body>
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
		<form name="assignedRegn" id="assignedRegn" onsubmit="return mpfunc();" action="AssignRegionToAdmin" method="post">
		<fieldset>
			<legend style="font-size:16pt;color:#FF7D24;font-family:roman;">Assign Region to Admin</legend>
				<%
				String showMessage = (String)request.getAttribute("showMessage");
				if(("true").equals(showMessage))
				{
				%>
					<p align="right" style="color: green;background-color: #e2e2e2"><i>Region assigned successfully. </i>&nbsp;</p>
				<%} %>
			<table cellpadding="10" cellspacing="0" width="100%" border="0">
				<tr>
				<td width="30%" align="left" style="color: #123456">Select Region </td>
					<td width="*" align="left">
					<select name="admReg" id="admReg">
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
		    			//conn.close();
		    			%>
			
						</select>
					</td>
				</tr>
				<tr>
				<td width="30%" align="left" style="color: #123456">Select Admin Name </td>
					<td width="*" align="left">
					<select name="selAdmin" id="selAdmin"></select>
					</td>
				</tr>				
			</table>
			&nbsp;&nbsp;
			<span style="color: #123456">Select Region to Assign <em>*</em></span>
			<br/><br/>
			<table cellpadding="2" cellspacing="0" width="100%" border="0" >
							<%
						//DatabaseConn dbConn = new DatabaseConn();
						//Connection conn = dbConn.connectDb();
		    			//Statement st=conn.createStatement();
		    			//ResultSet rsdoLogin = null;
		    			//PreparedStatement psdoLogin=null; 
		    			try{
		        			String sqlOption="SELECT * from region_master";
		        			rsdoLogin = st.executeQuery(sqlOption);
		        			if(null != rsdoLogin && rsdoLogin.first()) {
		        			int i = 0;
		        				do{
		    			%>
		    				
		    			<% if (i%3 == 0) { %>
		    				<tr align="left">
		    			<% } %>
		    				<td style="background-color: #e2e2e2"><input type="checkbox" id="<%=rsdoLogin.getString("region_id")%>" value="<%=rsdoLogin.getString("region_id")%>"> &nbsp;&nbsp;<span style="color: #123456; font-size: 11px;"><%=rsdoLogin.getString("region_name")%>-<%=rsdoLogin.getString("region_id")%></span></td>
						<% 
						i++;
						if (i%3 == 0) { %>
		    				</tr>
		    			<% } %>		    				
		    			<%
		        				} while (rsdoLogin.next());
		        			}
		    			} catch(Exception e) {
		        			e.printStackTrace();
		    			}
		    			conn.close();
		    			%>
			</table>
			<br/><br/>
			<p align="right" >
			<input name="selCheckBox" id="selCheckBox" type="hidden">
    		<input type="button" style="width: 80px; height: 25px; background-color: #123456; border-radius:5px; color: white; font-size: 14px;" name="reset" id="reset" value="Reset" onclick="resetAll();" />&nbsp;&nbsp;&nbsp;
	    	<input type="submit" style="width: 80px; height: 25px; background-color: #123456; border-radius:5px; color: white; font-size: 14px;" name="assignReg" id="assignReg" value="Assign"/>&nbsp;&nbsp;&nbsp;
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
