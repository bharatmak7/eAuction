package com.bst.eauction.rto;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AssignRegionToAdmin
 */
@WebServlet("/AssignRegionToAdmin")
public class AssignRegionToAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AssignRegionToAdmin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String getRegion = (String) request.getParameter("selCheckBox");
		String[] region = getRegion.split(",");
		String admId = (String) request.getParameter("selAdmin");
		String regnId = (String) request.getParameter("admReg");
		DatabaseConn dbObj = new DatabaseConn();
		for (int i = 0; i < region.length; i++) {
			try {
				Statement insertAdmin = dbObj.connectDb().createStatement();
				String insertStmt = "INSERT INTO `rel_region_admin`(`region_id`, `admin_id`) VALUES " +
						"("+region[i]+","+admId+")";
				//System.out.println(insertStmt);
				insertAdmin.execute(insertStmt);
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
		}
		System.out.println("Regn : " + getRegion + "adm Id : " +admId + "regn Id" + regnId);
		request.setAttribute("showMessage", "true");
		getServletContext().getRequestDispatcher("/jsp/assignRegionToAdmin.jsp").forward(request, response);
	}

}
