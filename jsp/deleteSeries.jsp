<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.bst.eauction.rto.DatabaseConn"%>
<%@ page language="java" import="java.sql.*" errorPage=""%>
<%@ page language="java" import="java.util.Date" errorPage=""%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type; pragma;"
	content="text/html; charset=iso-8859-1; no-cache;" />
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

	function goBack() {
		window.history.back()
	}
	function populateFruitVariety() {

		$.getJSON('jsp/fetchSeriesData.jsp', {
			adminFrom : $('#admReg').val()
		}, displayResult);

	}
	function displayResult(data) {
		if (!data.error) // emp not found
		{
			var select = $('#selSeries');
			//var options = select.prop('options');
			$('option', select).remove();
			$("<option />", {
				value : "Select",
				text : "Select"
			}).appendTo(select);
			$.each(data, function(index, array) {
				$("<option />", {
					value : array['series_id'],
					text : array['series_name']
				}).appendTo(select);
				//options[options.length] = new Option(array['admin_fullname']);
				// options[options.length].attr("value", array['admin_id']);
				populateDates();
			});

		} else {
			var select = $('#selSeries');
			$('option', select).remove();
			$("<option />", {
				value : "Select",
				text : "Select"
			}).appendTo(select);
			populateDates();
		}
	}

	$(document).ready(function() {
		populateFruitVariety();
		$('#admReg').change(function() {
			populateFruitVariety();
		});
	});

	function populateDates() {

		$.getJSON('jsp/fetchDateForSeriesDelete.jsp', {
			ser_id : $('#selSeries').val()
		}, displayResultDates);

	}
	$(document).ready(function() {
		populateFruitVariety();
		$('#selSeries').change(function() {
			populateDates();
		});
	});

	function displayResultDates(data) {
		if (!data.error) // emp not found
		{
			var start = null;
			var end = null;

			$.each(data, function(index, array) {
				start = array['start_date'];
				end = array['end_date'];
			});
			document.getElementById("101").innerHTML = start;
			document.getElementById("102").innerHTML = end;

		}else{
			document.getElementById("101").innerHTML = "";
			document.getElementById("102").innerHTML = "";
		}
	}
</script>
<STYLE>
em {
	color: red;
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
		<font color="#123456" size=6 style="font-weight: normal;">Manage
			Admin</font>
		<!-- <img src="jsp/images/logo.gif" title="RTO Pune" alt="RTO Pune" width="230" height="80" border="0" /> -->
	</div>
	<div id="bodyPanel">
		<p align="right" style="font-size: 12pt; color: green;">
			Welcome to eAuction, <font color="orange"><%=adminName%></font>
		</p>
		<br />
		<table width="100%" border="0" height="93%" cellpadding="5"
			cellspacing="1" style="background-color: #ededed;">
			<tr valign="top">
				<td style="width: 200px; padding-left: 10px;"><jsp:include
						page="adminMenu.jsp" /></td>
				<td width="*">
					<form name="delSeries" action="DeleteSeries" method="post">
						<fieldset>
							<legend
								style="font-size: 16pt; color: #FF7D24; font-family: roman;">Delete
								Series</legend>
							<%
								String showMessage = (String) request.getAttribute("showMessage");
								if (("true").equals(showMessage)) {
							%>
							<p align="right" style="color: green; background-color: #e2e2e2">
								<i>Series deleted successfully. </i>&nbsp;
							</p>
							<%
								} else if (("false").equals(showMessage)) {
							%>
							<p align="right" style="color: red; background-color: #e2e2e2">
								<i>Error occurred while deleting.</i>&nbsp;
							</p>
							<%
								}
							%>
							<br />
							<table cellpadding="10" cellspacing="0" width="100%" border="0">
								<tr>
									<td width="35%" align="right" style="color: #123456">Select
										Region</td>
									<td width="*" align="left"><select name="admReg"
										id="admReg">
											<%
												DatabaseConn dbConn = new DatabaseConn();
												Connection conn = dbConn.connectDb();
												Statement st = conn.createStatement();
												ResultSet rsdoLogin = null;
												PreparedStatement psdoLogin = null;
												try {
													String sqlOption = "SELECT * FROM `region_master`";
													rsdoLogin = st.executeQuery(sqlOption);
													if (null != rsdoLogin && rsdoLogin.first()) {
														do {
											%>
											<option value="<%=rsdoLogin.getString("region_id")%>"><%=rsdoLogin.getString("region_name")%>-<%=rsdoLogin.getString("region_id")%></option>
											<%
												} while (rsdoLogin.next());
													} else {
											%>
											<option value="">N.A.</option>
											<%
												}
												} catch (Exception e) {
													e.printStackTrace();
												}
												//conn.close();
											%>

									</select></td>
								</tr>
								<tr>
									<td width="35%" align="right" style="color: #123456">Select
										Series</td>
									<td width="*" align="left"><select name="selSeries"
										id="selSeries">
									</select></td>
								</tr>
								<tr>
									<td width="35%" align="right" style="color: #123456">Start
										Date</td>
									<td align="left"><i id="101"><font color="red"
											size="1"> </font></i></td>
								</tr>
								<tr>
									<td width="35%" align="right" style="color: #123456">End
										Date</td>
									<td><i id="102"><font color="red" size="1"> </font></i></td>
								</tr>


							</table>
							<br />
							<p align="right">
								<input type="button"
									style="width: 80px; height: 25px; background-color: #123456; border-radius: 5px; color: white; font-size: 14px;"
									name="reset" id="reset" value="Cancel"
									onclick="javascript:window.location.href='/eAuction/LoginSystem?param=adminHome'" />&nbsp;&nbsp;&nbsp;
								<input type="submit"
									style="width: 80px; height: 25px; background-color: #123456; border-radius: 5px; color: white; font-size: 14px;"
									name="delReg" id="delReg" value="Delete" />&nbsp;&nbsp;&nbsp;
							</p>
						</fieldset>
					</form>
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
