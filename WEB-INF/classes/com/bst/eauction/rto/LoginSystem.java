package com.bst.eauction.rto;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginSystem
 */
@WebServlet("/LoginSystem")
public class LoginSystem extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginSystem() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Inside doGet method of LoginServlet.");		
		String param = request.getParameter("param");
		if(null != param && !param.equals(""))
		{
			System.out.println("Parameter : "+ param);

			if(param.equals("logout"))
				masterRedirect(request, response,"/jsp/logout.jsp");
			else if(param.equals("signUp"))
				masterRedirect(request, response,"/jsp/signUp.jsp");
			else if(param.equals("logmeagain"))
				masterRedirect(request, response,"/jsp/index.jsp");
			else if(param.equals("logoutme"))
				masterRedirect(request, response,"/jsp/index.jsp");
			else if(param.equals("forgotPass"))
				masterRedirect(request, response,"/jsp/index.jsp");
			else if(param.equals("launchNewSeries"))
				masterRedirect(request, response,"/jsp/launchNewSeries.jsp");
			else if(param.equals("createRtoAdmin"))
				masterRedirect(request, response,"/jsp/createRtoAdmin.jsp");
			else if(param.equals("assignRegionToAdmin"))
				masterRedirect(request, response,"/jsp/assignRegionToAdmin.jsp");			
			else if(param.equals("deleteRegionToAssign"))
				masterRedirect(request, response,"/jsp/deleteRegionToAssign.jsp");
			else if(param.equals("updateNewSeries"))
				masterRedirect(request, response,"/jsp/updateNewSeries.jsp");
			else if(param.equals("adminHome"))
				masterRedirect(request, response,"/jsp/admin.jsp");
			else if(param.equals("userProfile"))
				masterRedirect(request, response,"/jsp/userProfile.jsp");
			else if(param.equals("userLoginDetail"))
				masterRedirect(request, response,"/jsp/userLoginDetail.jsp");
			else if(param.equals("userAccountInfo"))
				masterRedirect(request, response,"/jsp/userAccountInfo.jsp");
			else if(param.equals("makeABid"))
				masterRedirect(request, response,"/jsp/makeABid.jsp");
			else if(param.equals("userHome"))
				masterRedirect(request, response,"/jsp/users.jsp");
			else if(param.equals("deleteSeries"))
				masterRedirect(request, response,"/jsp/deleteSeries.jsp");
			
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 		System.out.println("Inside doPost method of LoginServlet.");
		String userId = null;
		String userName = null;
		String password = null;
		String isAdmin = "";
		String sql = null;
		String isSuperUser = "0";
		Statement st = null;
		ResultSet rs = null;

		HttpSession session = request.getSession();		
		session.setAttribute("user_session", "start");

		userName = request.getParameter("user");
		password = request.getParameter("password");
		isAdmin = request.getParameter("isAdmin");

		if(null != userName && !userName.equals(""))
			System.out.println("UserName : "+userName);
		if(null != password && !password.equals(""))
			System.out.println("Password : "+password);		
		
		System.out.println("isAdmin value : "+isAdmin);
		if(null != isAdmin && !isAdmin.equals(""))
		{			
			sql = "select * from admin WHERE login_name like '"+userName+"' and password like '"+password+"'";
			
		} else {
			sql = "SELECT * FROM `users` as U,`users_login_info` as UI  WHERE U.login_info_id= UI.login_info_id and UI.login_name like '"+userName+"' and UI.password like '"+password+"'";
			System.out.println(sql);
		}


		try {
			DatabaseConn dbConn = new DatabaseConn(); 
			st= dbConn.connectDb().createStatement();
			rs = st.executeQuery(sql);
			if(null != rs && rs.first() == true)
			{
				System.out.println("Record set not null : "+rs);
				userName = rs.getString("login_name");
				password = rs.getString("password");
				System.out.println("u" + userName + "pd" + password);
				if(null != isAdmin && isAdmin.equals("on"))
				{
					userId = rs.getString("admin_id");
					isSuperUser = rs.getString("admin_superuser");
					session.setAttribute("admin", userName);
					session.setAttribute("isSuperUser", isSuperUser);
					session.setAttribute("userId", userId);
					masterRedirect(request, response,"/jsp/admin.jsp");
					rs.close();
					st.close();
					return;
					//getServletContext().getRequestDispatcher("/jsp/admin.jsp").forward(request, response);
				} else {
					userId = rs.getString("user_id");
					session.setAttribute("user", userName);
					session.setAttribute("userId", userId);
					//getServletContext().getRequestDispatcher("/jsp/users.jsp").forward(request, response);
					masterRedirect(request, response,"/jsp/users.jsp");
					rs.close();
					st.close();
					return;
				}
			} else {
				System.out.println("Record set null : "+rs);
				if(null != isAdmin && isAdmin.equals("on"))
				{
					System.out.println("Invalid UserName or Password. OR ");
					System.out.println("You are not an Administrator.");	
					request.setAttribute("showMessage", "InvalidAdmin");
				}else
				{
					System.out.println("Invalid UserName or Password.");
					request.setAttribute("showMessage", "InvalidUser");
				}
				masterRedirect(request, response,"/jsp/index.jsp");
				//getServletContext().getRequestDispatcher("/jsp/index.jsp").forward(request, response);
				rs.close();
				st.close();
				return;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}	
	}

	public void masterRedirect(HttpServletRequest request,
			HttpServletResponse response, String url) {
		try {
			getServletContext().getRequestDispatcher(url).forward(request, response);
			return;
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}	
	}
}
