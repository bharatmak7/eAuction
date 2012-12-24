<%
	String adminName = (String) session.getAttribute("admin");
	String isSuperUser = (String) session.getAttribute("isSuperUser");
%>
	<ul id="menu">
		<li  style="text-align: center; padding-top : 10px; font-family: arail;font-size: 20pt;background-color: #a2a2a2;color: #123456; height: 40px"> Menu</li>
		<li>
		<a href="#">Series Launch</a>
			<ul>
				<li><a href="/eAuction/LoginSystem?param=launchNewSeries"><img alt="" src="jsp/images/bull1.png">&nbsp;&nbsp;Launch New Series</a></li>
				<li><a href="/eAuction/LoginSystem?param=updateNewSeries"><img alt="" src="jsp/images/bull1.png">&nbsp;&nbsp;Update Series</a></li>
				<% if (isSuperUser.matches("1") ) { %>
					<li><a href="/eAuction/LoginSystem?param=deleteSeries"><img alt="" src="jsp/images/bull1.png">&nbsp;&nbsp;Delete Series</a></li>
				<% } %>
			</ul>
		</li>
		<% 
		if (isSuperUser.matches("1") ) {%>
		<li>
			<a href="#">Manage Admin</a>
			<ul>
				<li><a title="Create a new regional admin" href="/eAuction/LoginSystem?param=createRtoAdmin"><img src="jsp/images/bull1.png">&nbsp;&nbsp;Create Admin</a></li>
				<li><a title="Assign Region to Admin" href="/eAuction/LoginSystem?param=assignRegionToAdmin"><img src="jsp/images/bull1.png">&nbsp;&nbsp;Assign Region</a></li>
				<li><a title="Delete assigned Region to Admin" href="/eAuction/LoginSystem?param=deleteRegionToAssign"><img src="jsp/images/bull1.png">&nbsp;&nbsp;Delete Assigned Region</a></li>
				<li><a title="Delete Admin" href="#"><img src="jsp/images/bull1.png">&nbsp;&nbsp;Delete Admin</a></li>
			</ul>
		</li>
		<%} %>
		
		<li>
			<a href="#">Search</a>
			<ul>
				<li><a title="Series wise searching" href="#"><img src="jsp/images/bull1.png">&nbsp;&nbsp;Series wise</a></li>
				<li><a title="Date wise searching" href="#"><img src="jsp/images/bull1.png">&nbsp;&nbsp;Date Wise</a></li>
				<li><a title="User wise searching" href="#"><img src="jsp/images/bull1.png">&nbsp;&nbsp;User Wise</a></li>
			</ul>
		</li>
		
		<li>
			<a href="#">Generate Reports</a>
			<ul>
				<li><a href="#" title="Generate Reports seires wise"><img src="jsp/images/bull1.png">&nbsp;&nbsp;Series wise</a></li>
				<li><a href="#" title="Generate Reports date wise"><img src="jsp/images/bull1.png">&nbsp;&nbsp;Date Wise</a></li>
				<li><a href="#" title="Generate Reports user wise"><img src="jsp/images/bull1.png">&nbsp;&nbsp;User Wise</a></li>
			</ul>
		</li>

	</ul>