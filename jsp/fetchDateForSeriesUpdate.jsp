<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Date"%>
<%@page import="com.bst.eauction.rto.DatabaseConn"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String rto_code = request.getParameter("rto_code");
	String series_name = request.getParameter("series_name");
	String vehicle_class = request.getParameter("vehicle_class");
	SimpleDateFormat simpleDateFormat=new SimpleDateFormat("dd-MM-yyyy");

	String sql = "SELECT * FROM `series_launch` WHERE  `region_id`='"
			+ rto_code + "' AND `series_name`='" + series_name
			+ "' AND `veh_id`='" + vehicle_class + "' ";

	DatabaseConn dbObj = new DatabaseConn();
	Statement admStmt = dbObj.connectDb().createStatement();
	ResultSet rs = admStmt.executeQuery(sql);
	String jsonObj = "[";
	String jsonBody = "";
	int cnt = 0;
	while (rs.next()) { // found send JSON string with employee details to client
		Date start_date_time = rs.getTimestamp("ser_st_date");
		String start_date=simpleDateFormat.format(start_date_time);
	
		System.out.println("start_date=" + start_date);
		
		Date end_date_time  = rs.getTimestamp("ser_end_date");
		String end_date=simpleDateFormat.format(end_date_time);
		
		System.out.println("end_date= " + end_date);
		
		
		jsonBody = jsonBody + "{\"start_date\":\"" + start_date
				+ "\",\"end_date\":\"" + end_date + "\"},";
		cnt++;
	}
	if (cnt != 0) {
		jsonObj = jsonObj
				+ jsonBody.substring(0, jsonBody.length() - 1) + "]";
		response.setContentType("application/json");
		response.getWriter().write(jsonObj);
		System.out.println("Json for Update :+++ " + jsonObj);
	} else {
		out.println("{\"error\":\"data not found\"}");
	}

	//System.out.println(jsonObj);
	//{"userName":"MyName","id":"myId"}
	rs.close();
%>