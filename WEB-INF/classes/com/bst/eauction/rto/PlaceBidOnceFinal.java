package com.bst.eauction.rto;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PlaceBidOnceFinal
 */
@WebServlet("/PlaceBidOnceFinal")
public class PlaceBidOnceFinal extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PlaceBidOnceFinal() {
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
		String bidAmt = request.getParameter("bidAmt");
		String orderId = request.getParameter("orderId");
		System.out.println("bidAmount : " + bidAmt + " order Id " +orderId);
		
		DatabaseConn dbcon = new DatabaseConn();
		Connection conn1;
			try {
				conn1 = dbcon.connectDb();
				Statement st=conn1.createStatement();
				String insertSAR = "INSERT INTO `bid_record`( `order_id`, `bid_amount`) VALUES ('"+orderId+"','"+bidAmt	+"')";
				st.executeUpdate(insertSAR);
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
			getServletContext().getRequestDispatcher("/jsp/bidStatus.jsp").forward(request, response);
			
	}

}
