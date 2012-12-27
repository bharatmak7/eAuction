package com.bst.eauction.rto;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PayCmd
 */
@WebServlet("/PayCmd")
public class PayCmd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PayCmd() {
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
		String regnId = (String) request.getParameter("regnId");
		String vehClass = (String) request.getParameter("vehicleClass");
		String vehNum = (String) request.getParameter("vehNumber");
		String serName = (String) request.getParameter("serName");
		String startDate = (String) request.getParameter("startDate");
		String endDate = (String) request.getParameter("endDate");
		String  baseAmt = (String) request.getParameter("baseAmt");
		String  cmdAmt = (String) request.getParameter("cmdAmt");
		String  userId = (String) request.getParameter("userId");
		String  ruleId = (String) request.getParameter("ruleId");
		String  seriesId = (String) request.getParameter("seriesId");
		
		request.setAttribute("regnId", regnId);
		request.setAttribute("vehClass", vehClass);
		request.setAttribute("vehNumber", vehNum);
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);
		request.setAttribute("serName", serName);
		request.setAttribute("baseAmt", baseAmt);
		request.setAttribute("cmdAmt", cmdAmt);
		request.setAttribute("userId", userId);
		request.setAttribute("ruleId", ruleId);
		request.setAttribute("seriesId", seriesId);
		
		getServletContext().getRequestDispatcher("/jsp/payCmd.jsp").forward(request, response);
	}

}
