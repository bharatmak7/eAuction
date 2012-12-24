package com.bst.eauction.rto;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CreateRtoAdmin
 */
@WebServlet("/CreateRtoAdmin")
public class CreateRtoAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateRtoAdmin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String getFullname = (String) request.getParameter("admName");
		String getLoginId = (String) request.getParameter("admLogId");
		String getPassword = (String) request.getParameter("admPass");
		String getPhone = (String) request.getParameter("admPhone");
		String getEmail = (String) request.getParameter("admEmail");
		String getRegn = (String) request.getParameter("admReg");
		System.out.println("full name : " + getFullname);
		System.out.println("Log Id : " + getLoginId);
		System.out.println("Password : " + getPassword);
		System.out.println("Phone Number : " + getPhone);
		System.out.println("Email Id : " + getEmail);
		System.out.println("Admin Regn : " + getRegn);
		String[] regn_code = getRegn.split("-"); 
		DatabaseConn dbObj = new DatabaseConn();
		try {
			Statement insertAdmin = dbObj.connectDb().createStatement();
			String insertStmt = "INSERT INTO `admin`(`login_name`, `password`, `admin_phone`, `admin_email`, `admin_superuser`, `admin_fullname`, `admin_from`) " +
								"VALUES ('"+ getLoginId+"','"+getPassword +"','"+getPhone+"','"+getEmail+"',0,'"+getFullname+"','"+getRegn+"')";
			insertAdmin.execute(insertStmt);
			
			String selectAdm = "SELECT admin_id FROM `admin`WHERE  admin_superuser != 1 and login_name = '"+getLoginId+"'";
			ResultSet rs = insertAdmin.executeQuery(selectAdm);
			Integer admId = null;
			while(rs.next()) {
				admId = rs.getInt("admin_id");
			}
			
			String insertRegn = "INSERT INTO `rel_region_admin`(`region_id`, `admin_id`) VALUES " +
					"("+regn_code[1]+","+admId+")";
			insertAdmin.execute(insertRegn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("showMessage", "true");
		getServletContext().getRequestDispatcher("/jsp/createRtoAdmin.jsp").forward(request, response);
	}

}
