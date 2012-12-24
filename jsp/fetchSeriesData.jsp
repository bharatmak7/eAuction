<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Date"%>
<%@page import="com.bst.eauction.rto.DatabaseConn"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	Date date = new Date();
	SimpleDateFormat format = new SimpleDateFormat("YYYY-MM-dd");
	String dat = format.format(date);

	String adminFrom = request.getParameter("adminFrom");
	String sql = "SELECT * FROM `series_launch` WHERE `ser_st_date`> DATE '"
			+ dat + "' AND `region_id`='" + adminFrom + "'";
	DatabaseConn dbObj = new DatabaseConn();
	Statement admStmt = dbObj.connectDb().createStatement();
	ResultSet rs = admStmt.executeQuery(sql);
	String jsonObj = "[";
	String jsonBody = "";
	int cnt = 0;
	while (rs.next()) { // found send JSON string with employee details to client
		jsonBody = jsonBody + "{\"series_id\":\""
				+ rs.getInt("series_id") + "\",\"series_name\":\""
				+ rs.getString("series_name") + "\"},";
		cnt++;
	}
	if (cnt != 0) {
		jsonObj = jsonObj
				+ jsonBody.substring(0, jsonBody.length() - 1) + "]";
		response.setContentType("application/json");
		System.out.println("Json in fetch series data");
		response.getWriter().write(jsonObj);
	} else {
		out.println("{\"error\":\"data not found\"}");
	}

	//System.out.println(jsonObj);
	//{"userName":"MyName","id":"myId"}
	rs.close();
%>