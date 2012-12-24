package com.bst.eauction.rto;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SelectRegion
 */
@WebServlet("/SelectRegion")
public class SelectRegion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectRegion() {
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
		String regnId = (String) request.getParameter("regnId");
		String vehClass = (String) request.getParameter("vehicleClass");
		String vehNum = (String) request.getParameter("vehNumber");
		System.out.println("regnId id post : "+ vehClass + vehNum);
		request.setAttribute("regnId", regnId);
		request.setAttribute("vehClass", vehClass);
		request.setAttribute("vehNumber", vehNum);
		getServletContext().getRequestDispatcher("/jsp/InputNumbers.jsp").forward(request, response);
	}

}
