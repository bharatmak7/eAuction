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
 * Servlet implementation class UpdateNewSeries
 */
@WebServlet("/UpdateNewSeries")
public class UpdateNewSeries extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateNewSeries() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String state_code = (String) request.getParameter("state_code");
		String rto_code = (String) request.getParameter("rto_code");
		String series_name = (String) request.getParameter("series_name");
		String vehicle_class = (String) request.getParameter("vehicle_class");
		String st_date = (String) request.getParameter("st_date");
		String end_date = (String) request.getParameter("end_date");
		String adminId = (String) request.getParameter("adminMasterId");
		String[] startDate = st_date.split("-");
		String[] endDate = end_date.split("-");
		st_date = startDate[2] + "-" + startDate[1] + "-" + startDate[0];
		end_date = endDate[2] + "-" + endDate[1] + "-" + endDate[0];

		DatabaseConn dbObj = new DatabaseConn();
		try {
			Statement stmt = dbObj.connectDb().createStatement();
			String updateSeries = "UPDATE `series_launch` SET `ser_st_date`= '"
					+ st_date + " 00:00:00" + "',`ser_end_date`='" + end_date  + " 00:00:00"
					+ "' WHERE `series_name`='" + series_name
					+ "' AND `veh_id`='" + vehicle_class + "'";
			System.out.println(updateSeries);
			int result = stmt.executeUpdate(updateSeries);
			if (result > 0) {
				request.setAttribute("showMessage", "true");
			} else {
				request.setAttribute("showMessage", "false");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		getServletContext().getRequestDispatcher("/jsp/updateNewSeries.jsp")
				.forward(request, response);

	}

}
