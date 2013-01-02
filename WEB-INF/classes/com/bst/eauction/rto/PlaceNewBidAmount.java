package com.bst.eauction.rto;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PlaceNewBidAmount
 */
@WebServlet("/PlaceNewBidAmount")
public class PlaceNewBidAmount extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PlaceNewBidAmount() {
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
		String  orderId = (String) request.getParameter("orderId");
		String  bidAmt = (String) request.getParameter("bidAmt");

		
		DatabaseConn dbConn2 = new DatabaseConn();
		Connection conn2;
		try {
			conn2 = dbConn2.connectDb();
			Statement st2=conn2.createStatement();
			String getBaseAmt1 = "UPDATE `bid_record` SET `bid_amount`='"+bidAmt+"' WHERE `order_id` = '"+orderId+"'";
			System.out.println("query : " + getBaseAmt1);
			st2.executeUpdate(getBaseAmt1);
			conn2.close();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		String  productKey = (String) request.getParameter("productKey");
		System.out.println(productKey + " this is the product Key");
		request.setAttribute("productKey", productKey);
		getServletContext().getRequestDispatcher("/jsp/showBid.jsp").forward(request, response);
	}

}
