package com.bst.eauction.rto;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddWatchList
 */
@WebServlet("/AddWatchList")
public class AddWatchList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddWatchList() {
        super();
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
		String  rtoCode = (String) request.getParameter("rtoCode");
		String  seriesName = (String) request.getParameter("seriesName");
		String  vehClass = (String) request.getParameter("vehClass");
		String  vehNum = (String) request.getParameter("vehNum");
		String  userId = (String) request.getParameter("userId");
		
		String productWL = "MH" + rtoCode + seriesName + vehClass + vehNum;
		DatabaseConn dbConn1 = new DatabaseConn();
		Connection conn1;
		try {
			conn1 = dbConn1.connectDb();
			Statement st1=conn1.createStatement();
			String checkData = "SELECT * FROM `users_watchlist` WHERE user_id ='"+userId+"' AND watchlist = '"+productWL+"'";
			ResultSet resRegn =	st1.executeQuery(checkData);
				if(null != resRegn && resRegn.first()) {
					request.setAttribute("message", productWL+ " already added to Watch list.");
				} else {
					String insertWL = "INSERT INTO `users_watchlist`(`watchlist`, `user_id`) VALUES " +
							"('"+productWL+"','"+userId+"')";
					st1.execute(insertWL);
					request.setAttribute("message", productWL+ " added to Watch list.");
				}
			conn1.close();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("showMessage", "true");
		getServletContext().getRequestDispatcher("/jsp/myWatchList.jsp").forward(request, response);
	}

}
