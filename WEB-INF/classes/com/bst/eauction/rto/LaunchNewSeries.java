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
 * Servlet implementation class LaunchNewSeries
 */
@WebServlet("/LaunchNewSeries")
public class LaunchNewSeries extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LaunchNewSeries() {
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
		String state_code = (String) request.getParameter("state_code");
		String rto_code = (String) request.getParameter("rto_code");
		String serie_name = (String) request.getParameter("series_name");
		String vehicle_class = (String) request.getParameter("vehicle_class");
		String st_date = (String) request.getParameter("st_date");
		String end_date = (String) request.getParameter("end_date");
		String adminId = (String) request.getParameter("adminMasterId");
		String[] startDate = st_date.split("-");
		String[] endDate = end_date.split("-");
		st_date = startDate[2]+"-"+startDate[1]+"-"+startDate[0];
		end_date = endDate[2]+"-"+endDate[1]+"-"+endDate[0];
		System.out.println("state_code : " + state_code);
		System.out.println("rto_code : " + rto_code);
		System.out.println("series_name : " + serie_name);
		System.out.println("vehicle_class : " + vehicle_class);
		System.out.println("st_date : " + st_date);
		System.out.println("end_date : " + end_date);
		System.out.println("adminId : " + adminId);
		
		
		DatabaseConn dbObj = new DatabaseConn();
		try {
			Statement stmt = dbObj.connectDb().createStatement();
			String checkSeries="SELECT * FROM `series_launch` WHERE `region_id`="+rto_code+" AND `veh_id`="+vehicle_class+" AND `series_name`='"+serie_name+"'";
			ResultSet rs=stmt.executeQuery(checkSeries);
			if(rs.next()){
				request.setAttribute("showMessage", "false");
			}else{
			String insertSeries = "INSERT INTO `series_launch`( `admin_id`, `series_name`, `veh_id`, `ser_st_date`, `ser_end_date`, `series_status`,`region_id`) " +
								  "VALUES ('"+adminId+"','"+serie_name+"','"+vehicle_class+"','"+st_date+" 00:00:00','"+end_date+" 00:00:00',1,'"+rto_code+"')";
			stmt.execute(insertSeries);
			request.setAttribute("showMessage", "true");
			}
			
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
		getServletContext().getRequestDispatcher("/jsp/launchNewSeries.jsp").forward(request, response);
	}

}
