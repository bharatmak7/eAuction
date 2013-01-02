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
 * Servlet implementation class PlaceBidOnce
 */
@WebServlet("/PlaceBidOnce")
public class PlaceBidOnce extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PlaceBidOnce() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("userId");
		String seriesId = request.getParameter("seriesId");
		String ruleId = request.getParameter("ruleId");
		String productKey = request.getParameter("productKey");
		String cmdAmt = request.getParameter("cmdAmt");
		String regnId = request.getParameter("regnId");
		String serName = request.getParameter("serName");
		String vehClass = request.getParameter("vehClass");
		String vehNumber = request.getParameter("vehNumber");
		String regnName = request.getParameter("regnName");
		Integer orderId = 0;
		Integer txnId = 0;
		System.out.println("User Id : "+ userId);
		DatabaseConn dbcon = new DatabaseConn();
		Connection conn1;
		try {
			conn1 = dbcon.connectDb();
			Statement st=conn1.createStatement();
			String insertSAR = "INSERT INTO `series_allocation_record`( `product_key`, `series_id`, `user_id`, `rule_id`, `status`, `special_case`)" +
					" VALUES ('"+productKey+"','"+seriesId+"','"+userId+"','"+ruleId+"','1','0')";
			int rowsAffected  = st.executeUpdate(insertSAR);
			if(rowsAffected != 0) {
				ResultSet rs = st.executeQuery("SELECT LAST_INSERT_ID() AS id");
				rs.next();
				orderId = rs.getInt("id");

				}
			String insertTxn = "INSERT INTO `transaction`( `txn_flag`, `user_id`, `order_id`, `series_id`, `amount`, `ip_address`)" +
					" VALUES (1,'"+userId+"','"+orderId+"','"+seriesId+"','"+cmdAmt+"','127.0.0.1')";
			int rowsAffected1 =  st.executeUpdate(insertTxn);
			if(rowsAffected1 != 0) {
				ResultSet rs = st.executeQuery("SELECT LAST_INSERT_ID() AS id");
				rs.next();
				txnId = rs.getInt("id");

				}
			st.close();
			dbcon.destroy();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("userId", userId);
		request.setAttribute("seriesId", seriesId);
		request.setAttribute("ruleId", ruleId);
		request.setAttribute("productKey", productKey);
		request.setAttribute("cmdAmt", cmdAmt);
		request.setAttribute("orderId",orderId.toString());
		request.setAttribute("regnId",regnId);
		request.setAttribute("serName",serName);
		request.setAttribute("vehClass",vehClass);
		request.setAttribute("vehNumber",vehNumber);
		request.setAttribute("regnName",regnName);
		request.setAttribute("txnId",txnId.toString());
		getServletContext().getRequestDispatcher("/jsp/placeBidOnce.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
