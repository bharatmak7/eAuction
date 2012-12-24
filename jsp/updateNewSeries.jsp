<%@page import="com.bst.eauction.rto.DatabaseConn"%>
<%@ page language="java" import="java.sql.*" errorPage=""%>
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
	function goBack() {
		window.history.back()
	}
	function populateFruitVariety() {

		$.getJSON('jsp/fetchDateForSeriesUpdate.jsp', {
			rto_code : $('#rto_code').val(),
			series_name : $('#series_name').val(),
			vehicle_class : $('#vehicle_class').val()
		}, displayResultDates);

	}

	function displayResultDates(data) {
		if (!data.error) // emp not found
		{
			var start = null;
			var end = null;

			$.each(data, function(index, array) {
				start = array['start_date'];
				end = array['end_date'];
			});
			if (start != null && end != null) {

				var start_split = start.split("-");
				var start_date = new Date();
				start_date.setFullYear(start_split[2], start_split[1] - 1,
						start_split[0]);

				var end_split = end.split("-");
				var end_date = new Date();
				end_date.setFullYear(end_split[2], end_split[1] - 1,
						end_split[0]);
				var today = new Date();

				if (today > start_date && today > end_date) {
					document.getElementById("st_date").value = start;
					document.getElementById("end_date").value = end;

					document.getElementById("st_date").setAttribute("readonly",
							"readonly");
					document.getElementById("end_date").setAttribute(
							"readonly", "readonly");

				} else if (today > start_date && today < end_date) {
					document.getElementById("st_date").value = start;
					document.getElementById("end_date").value = end;
					document.getElementById("st_date").setAttribute("readonly",
							"readonly");

				} else {
					document.getElementById("st_date").value = start;
					document.getElementById("end_date").value = end;
				}
			}

		} else {
			document.getElementById("st_date").value = "";
			document.getElementById("end_date").value = "";
		}
	}
	$(document).ready(function() {
		populateFruitVariety();
		$('#vehicle_class').change(function() {
			populateFruitVariety();
		});
	});

	function setVisibility(id, visibility) {
		document.getElementById(id).style.display = 'none';
	}

	function checkStateCode(id, visibility) {
		var veh_no = document.getElementById('state_code').value;
		var regamount = /^[a-z|A-Z]+$/;
		if (veh_no == '' || veh_no != 'MH') {
			document.getElementById(id).style.display = 'inline';
			return false;
		} else
			return true;
	}
	function checkSeriesName(id, visibility) {
		var veh_no = document.getElementById('series_name').value;
		if (veh_no == '') {
			document.getElementById(id).style.display = 'inline';
			return false;
		} else
			return true;
	}

	function checkStDate(id, visibility) {
		var datev = document.getElementById('st_date').value;
		var datereg = /^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$/;//"/^[0-9+\-]+$/";
		if (datev == '' || datereg.test(datev) == false) {
			document.getElementById(id).style.display = 'inline';
			return false;
		} else
			return true;
	}

	function checkEndDate(id, visibility) {
		var datev = document.getElementById('end_date').value;
		var datereg = /^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$/;//"/^[0-9+\-]+$/";
		if (datev == '' || datereg.test(datev) == false) {
			document.getElementById(id).style.display = 'inline';
			return false;
		} else
			return true;
	}
	function checkDateBefore() {
		var start_date = document.getElementById('st_date').value;
		var end_date = document.getElementById('end_date').value;
		var startdate = start_date.split('-');
		start_date = new Date();
		start_date.setFullYear(startdate[2], startdate[1] - 1, startdate[0]);
		var enddate = end_date.split('-');
		end_date = new Date();
		end_date.setFullYear(enddate[2], enddate[1] - 1, enddate[0]);
		var today = new Date();
		if (today > start_date) {
			alert("Invalid Start Date");
			return false;
		} else if (start_date > end_date) {
			alert("Invalid Date Range!\nStart Date cannot be after End Date!");
			return false;
		}

	}
	function resetAll() {
		document.getElementById('101').style.display = 'none';
		document.getElementById('103').style.display = 'none';
		document.getElementById('104').style.display = 'none';
		document.getElementById('105').style.display = 'none';
		document.getElementById('state_code').value = '';
		document.getElementById('series_name').value = '';
		document.getElementById('st_date').value = '';
		document.getElementById('end_date').value = '';
	}
	function validateForm() {
		var v1 = checkStateCode(101, 'inline');
		var v3 = checkSeriesName(103, 'inline');
		var v4 = checkStDate(104, 'inline');
		var v5 = checkEndDate(105, 'inline');
		var v6 = checkDateBefore();
		var result = (v1 && v3 && v4 && v5 && v6);
		return result;
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
	String adminMasterId = (String) session.getAttribute("userId");

	DatabaseConn dbConn = new DatabaseConn();
	Connection conn = dbConn.connectDb();
	Statement st = conn.createStatement();
	ResultSet rsdoLogin = null;
	PreparedStatement psdoLogin = null;
%>
</head>

<body onload="resetAll();">
	<div id="topPanel">
		<ul>
			<li><a href="/eAuction/LoginSystem?param=logout">Logout</a></li>
			<li><a href="#">My Profile</a></li>
			<li class="active">Home</li>
		</ul>
		<font color="#123456" size=6 style="font-weight: normal;">Series
			Launch</font>
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
					<form name="seriesLaunch" action="UpdateNewSeries" method="post"
						onsubmit="return validateForm();">
						<fieldset>
							<legend
								style="font-size: 16pt; color: #FF7D24; font-family: roman;">Update
								Series</legend>
							<br />
							<%
								String showMessage = (String) request.getAttribute("showMessage");
								if (("true").equals(showMessage)) {
							%>
							<p align="right" style="color: green; background-color: #e2e2e2">
								<i>Series Updated successfully. </i>&nbsp;
							</p>
							<%
								} else if (("false").equals(showMessage)) {
							%>
							<p align="right" style="color: red; background-color: #e2e2e2">
								<i>Error updating series. </i>&nbsp;
							</p>
							<%
								}
							%>
							<table cellpadding="10" cellspacing="0" width="100%" border="0">
								<tr>
									<td width="30%" align="right" style="color: #123456">State
										Code <em>*</em>
									</td>
									<td width="35%" align="left"><input id="state_code"
										type="text" onfocus="setVisibility('101','none');"
										onBlur="checkStateCode('101','inline');" name="state_code"
										class="txtbox" value="" /></td>
									<td></td>
									<td><i id="101"><font color="red" size="1">
												Enter valid state code </font></i></td>
								</tr>
								<tr>
									<td width="30%" align="right" style="color: #123456">RTO
										Code <em>*</em>
									</td>
									<td width="35%" align="left"><select name="rto_code"
										id="rto_code">
											<%
												try {
													String sqlOption;
													if (isSuperUser.matches("1")) {
														sqlOption = "SELECT * from region_master";
													} else {
														sqlOption = "SELECT ADM.admin_id, REG.region_name, ADM.admin_from,REG.region_id FROM `rel_region_admin` As REL,`admin` As ADM,`region_master` As REG WHERE  ADM.admin_id = REL.admin_id and REL.region_id= REG.region_id and ADM.admin_id= '"
																+ adminMasterId + "'";
													}

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
												conn.close();
												rsdoLogin = null;
												psdoLogin = null;
											%>

									</select></td>
									<td></td>
								</tr>
								<tr>
									<td width="30%" align="right" style="color: #123456">Series
										Name <em>*</em>
									</td>
									<td width="35%" align="left"><input id="series_name"
										type="text" onfocus="setVisibility('103','none');"
										onBlur="checkSeriesName('103','inline');" class="txtbox"
										name="series_name" value="" maxlength="2" /></td>
									<td></td>
									<td><i id="103"><font color="red" size="1">
												Enter valid series name </font></i></td>
								</tr>
								<tr>
									<td width="30%" align="right" style="color: #123456">Vehicle
										Class <em>*</em>
									</td>
									<td width="35%" align="left"><select name="vehicle_class"
										id="vehicle_class">
											<%
												try {
													conn = dbConn.connectDb();
													st = conn.createStatement();
													String sqlOption1 = "SELECT * from vehicle_class";

													rsdoLogin = st.executeQuery(sqlOption1);
													if (null != rsdoLogin && rsdoLogin.first()) {
														do {
											%>
											<option value="<%=rsdoLogin.getString("vehicle_id")%>"><%=rsdoLogin.getString("vehicle_type")%></option>
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

												conn.close();
											%>

									</select></td>
									<td></td>
								</tr>

								<tr>
									<td width="30%" align="right" style="color: #123456">Series
										Start Date <em>*</em>
									</td>
									<td width="35%" align="left"><input type="text"
										name="st_date" onfocus="setVisibility('104','none');"
										onchange="checkStDate('104','inline');"
										onBlur="checkStDate('104','inline');" id="st_date" value="" />
										<a
										href="javascript:show_calendar('document.seriesLaunch.st_date', document.seriesLaunch.st_date.value);">
											<img src="jsp/images/cal.gif" width="16" height="16"
											border="0" alt="Click Here to Pick up Date">
									</a></td>
									<td></td>
									<td><i id="104"><font color="red" size="1">
												Enter valid start date </font></i></td>
								</tr>


								<tr>
									<td width="30%" align="right" style="color: #123456">Series
										End Date <em>*</em>
									</td>
									<td width="35%" align="left"><input type="text"
										name="end_date" onfocus="setVisibility('105','none');"
										onchange="checkEndDate('105','inline');"
										onBlur="checkEndDate('105','inline');" id="end_date" value="" />
										<a
										href="javascript:show_calendar('document.seriesLaunch.end_date', document.seriesLaunch.end_date.value);">
											<img src="jsp/images/cal.gif" width="16" height="16"
											border="0" alt="Click Here to Pick up Date">
									</a></td>
									<td></td>
									<td><i id="105"><font color="red" size="1">
												Enter valid end date </font></i></td>
								</tr>
							</table>
							<br />
							<p align="right">
								<input type="button"
									style="width: 80px; height: 25px; background-color: #123456; border-radius: 5px; color: white; font-size: 14px;"
									name="reset" id="reset" value="Reset" onclick="resetAll();" />&nbsp;&nbsp;&nbsp;
								<input type="submit"
									style="width: 80px; height: 25px; background-color: #123456; border-radius: 5px; color: white; font-size: 14px;"
									name="lauchSer" id="lauchSer" value="Launch" />&nbsp;&nbsp;&nbsp;
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
