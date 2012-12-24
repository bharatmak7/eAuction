<%@page import="java.sql.ResultSet"%>
<%@page import="com.bst.eauction.rto.DatabaseConn"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
 String adminFrom = request.getParameter("adminFrom");
 String sql = "select `admin_id`, `admin_fullname` from `admin` where admin_superuser != 1 and admin_from = '" + adminFrom +"'";
 DatabaseConn dbObj = new DatabaseConn();
 Statement admStmt = dbObj.connectDb().createStatement();
 ResultSet rs =  admStmt.executeQuery(sql);
 String jsonObj = "[";
 String jsonBody = "";
 int cnt = 0;
 while ( rs.next()) { // found send JSON string with employee details to client
	 jsonBody = jsonBody + "{\"admin_id\":\"" + rs.getInt("admin_id") + "\",\"admin_fullname\":\"" + rs.getString("admin_fullname") + "\"},";
	 cnt++;
 }
 if(cnt != 0) {
 	jsonObj = jsonObj + jsonBody.substring(0, jsonBody.length()-1) + "]";
 	response.setContentType("application/json");
 	 response.getWriter().write(jsonObj);
 } else {
	 out.println("{\"error\":\"data not found\"}");
 }
 
 //System.out.println(jsonObj);
//{"userName":"MyName","id":"myId"}
 rs.close();
%>