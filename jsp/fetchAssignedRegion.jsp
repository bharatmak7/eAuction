<%@page import="java.sql.ResultSet"%>
<%@page import="com.bst.eauction.rto.DatabaseConn"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
 String adminId = request.getParameter("adminId");
System.out.println("admin id * "+adminId);
 String sql = "SELECT ADM.admin_id, REG.region_name, ADM.admin_from,REG.region_id FROM `rel_region_admin` As REL,`admin` As ADM,`region_master` As REG WHERE  ADM.admin_id = REL.admin_id and REL.region_id= REG.region_id and ADM.admin_id= '" + adminId +"'";
 DatabaseConn dbObj = new DatabaseConn();
 Statement admStmt = dbObj.connectDb().createStatement();
 ResultSet rs =  admStmt.executeQuery(sql);
 String jsonObj = "[";
 String jsonBody = "";
 int cnt = 0;
 while ( rs.next()) { // found send JSON string with employee details to client
	 jsonBody = jsonBody + "{\"admin_id\":\"" + rs.getInt("ADM.admin_id") + "\",\"region_name\":\"" + rs.getString("REG.region_name") + "\"},";
	 cnt++;
 }
 if(cnt != 0) {
 	jsonObj = jsonObj + jsonBody.substring(0, jsonBody.length()-1) + "]";
 	response.setContentType("application/json");
 	 response.getWriter().write(jsonObj);
 } else {
	 out.println("{\"error\":\"data not found\"}");
 }
 
 System.out.println(jsonObj);
//{"userName":"MyName","id":"myId"}
 rs.close();
%>