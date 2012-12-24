<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Date"%>
<%@page import="com.bst.eauction.rto.DatabaseConn"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String ser_id = request.getParameter("ser_id");
	String sql = "SELECT * FROM `series_launch` WHERE  `series_id`='"+ser_id+"'";
	DatabaseConn dbObj = new DatabaseConn();
	Statement admStmt = dbObj.connectDb().createStatement();
	ResultSet rs = admStmt.executeQuery(sql);
	String jsonObj = "[";
	String jsonBody = "";
	int cnt = 0;
	while (rs.next()) { // found send JSON string with employee details to client
		String[] start_date_time=rs.getString("ser_st_date").split(" ");
		String start_date=start_date_time[0];
		
		String[] end_date_time=rs.getString("ser_end_date").split(" ");
		String end_date=end_date_time[0];
		jsonBody = jsonBody + "{\"start_date\":\""
				+ "<font color='green'>"+start_date +"</font>"+ "\",\"end_date\":\""
				+ "<font color='green'>"+end_date +"</font>"+ "\"},";
		cnt++;
	}
	if (cnt != 0) {
		jsonObj = jsonObj
				+ jsonBody.substring(0, jsonBody.length() - 1) + "]";
		response.setContentType("application/json");
		response.getWriter().write(jsonObj);
	} else {
		out.println("{\"error\":\"data not found\"}");
	}

	//System.out.println(jsonObj);
	//{"userName":"MyName","id":"myId"}
	rs.close();
%>