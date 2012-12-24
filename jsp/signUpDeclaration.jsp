<%@ page language="java" import="java.sql.*" errorPage="" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type; pragma;" content="text/html; charset=iso-8859-1; no-cache;" />
<title>E Auction System for MH RTO</title>
<link href="jsp/css/style.css" rel="stylesheet" type="text/css" />
<script src="jsp/js/jquery-1.7.js" type="text/javascript"></script>
<script src="jsp/js/menu.js" type="text/javascript"></script>
<script src="jsp/js/ts_picker.js" type="text/javascript"></script>
<script type="text/javascript">
function goBack() {
	window.history.back();
}
</script>
<STYLE>
em {
	color:red;
}

</STYLE>
</head>

<body>
<div id="topPanel">
<ul>
<li><a href="/eAuction/LoginSystem?param=logoutme">Home</a></li>
<li class="active">Sign Up</li>
</ul>
<font color="#123456" size=5>Step 4 : </font><font color="orange" size=5 >Declaration</font>
<!-- <img src="jsp/images/logo.gif" title="RTO Pune" alt="RTO Pune" width="230" height="80" border="0" /> -->
</div>
<div id="bodyPanel">
	<div style="width:762px;color:black;height: 35px;color: #123456; background-color: #E61B31" align="center" >
		<table width="100%" height="100%" style="border-radius: 10px;" cellpadding="0" cellspacing="1">
			<tr align="center">
				<td width="25%"  style="color: white; background-color: #00A513; font-size: 15px">Personal Info</td>
				<td width="25%" style="color: white;  background-color: #00A513; font-size: 15px">Login Detail</td>
				<td width="25%" style="color: white;  background-color: #00A513; font-size: 15px">Account Info</td>
				<td width="25%" style="color: white; background-color: #00A513; font-size: 15px; text-decoration: blink">Declaration</td>
			</tr>
		</table>
	</div>
	<br/>
	<form name="signUpLoginDetail" action="#" method="post">
	<br/>
	<fieldset style="width: 642px">
		<legend style="font-size:16pt;color:#FF7D24;font-family:roman;">Terms and Conditions</legend><br/>
  		<textarea rows="25" cols="70" readonly="readonly" name="declaration" id="declaration">
1 Objective / Vision
The Objective is to develop a user-friendly auctioning site for RTO Pune where
fancy registration number of vehicles can be auctioned and provide value-added
services to the bidders and the sellers.
The bidders will be authenticated and the site provides a safe environment for online
users.
Subject to the reserve price fixed by RTO PUNE for fancy numbers or persons
duly authorized by RTO PUNE in this regard and subject to the terms and conditions
contained herein all sales shall be made to the highest bidder.
2 Functional Requirements
1. Secure registration of all users including a personal profile
2. Administrators would authorize the bidder to auction, set auction dates and
minimum auction amount for that REG NO.
3. Prior to each bid, the bidders bank or credit account must be authenticated
for available balance required for the bid.
4. Users can select their interested fields for bidding and periodic SMS/Mail
alerts must be sent in case a two/four wheeler series in that field goes on
auction.
5. Complete Search/Site Map of the entire site for easy access.
6. Online Legal Documentation to avoid disputes. Guidance to the users about
the same must be available
7. Special numbers such as 1, 7, 77 may be withheld by owner on the advice of
the administrator to be thrown open in special auctions held by the site so as
to increase the bid-values.
3 Users
1. SELLER : Seller referred in these conditions of sale, is the Department of
RTO Pune through their officers And/OR the Custodian.
2. AUCTIONEER : M/s. Balaji Software Technology is an agency appointed
as an auctioneer to facilitate e-Auction on Internet by RTO Pune. They are
3
expected to facilitate organizing and conducting e-Auction and are considered
as third party not particularly interested in the details of the registration
numbers being sold for and on behalf of RTO Pune.
3. BIDDER : Any person representing as an individual OR proprietor Or as a
partner OR as an authorized representative of any company who has been
registered with the Auctioneer and who has paid the Caution Money Deposit
(CMD) as per the terms and conditions herein shall be considered as a Bidder.
One individual can represent as a bidder on his own behalf or on behalf
of his company. But he can not register separately for himself and company at
the same time. A Bidder must read the terms and conditions of the auction
sale very carefully and then only place his signature on the "Registrationcum-
Acceptance Form". He is also expected to record his address, Telephone
Numbers, Fax No, e-Mail address, as all the communication would
be forwarded only at his e-mail address.
The rules of auction are categorized into three:
(a) Rules that govern the admission of bids.
(b) Rules that govern the information revealed by the auction.
(c) Rules that govern how the auction computes trades.
4 Participation Process
Step 1 The prospective bidder, if not already registered, has to register himself
with the Auctioneer M/s. Balaji Software Technology at RTO Pune Disposal
Unit.
Step 2 The prospective bidder shall have to deposit Registration Fee (nonrefundable)
as a one time Registration Fee which will be valid for fixed period from
the date of issue of Registration Card.
Step 3 The Registration Fee shall be deposited by way of Demand Draft / Pay
Order drawn on any Scheduled / Nationalised Bank drawn in the favour of
"RTO Pune" payable at Pune. NO CASH TRANSACTION WILL BE
ACCEPTED.
Step 4 On receipt of Registration Fee, a Bidder Registration Card will be issued
which will be used by the Bidders for participation in the Display/Auction.
On receipt of registration fees from registered Bidders, M/s. Balaji Software
Technology will provide User Identity and Password to the Bidder, which is
to be used for ACTUAL Online Auction.
  		
  		</textarea><br/><br/>
  		<div class="fullset">
            <input type="checkbox" name="acceptterms"  id="acceptterms" style="vertical-align:middle;margin-left:0px;border:0px;" class="checkset" /> 
            I hereby agree to all the <font color="red">terms and conditions</font> of the company mentioned above.<br />
            <input type="checkbox" name="acceptage"  id="acceptage" style="vertical-align:middle;margin-left:0px;border:0px;" class="checkset" /> 
            I confirm that I am over 18 yrs of age..
            </div>
    	<p align="right">
    	<input type="button" style="width: 80px; height: 25px; background-color: #123456; border-radius:5px; color: white; font-size: 14px;" name="backToBankInfo" id="backToBankInfo" value="Back" onclick="goBack();"/>&nbsp;&nbsp;&nbsp;
    	<input type="button" style="width: 80px; height: 25px; background-color: #123456; border-radius:5px; color: white; font-size: 14px;" name="cancelSignUp" id="cancelSignUp" value="Cancel" onclick="javascript:window.location.href='LoginSystem?param=logoutme'"/>&nbsp;&nbsp;&nbsp;
    	<input type="submit" style="width: 80px; height: 25px; background-color: #123456; border-radius:5px; color: white; font-size: 14px;" name="getMeRegister" id="getMeRegister" value="Register"/>&nbsp;&nbsp;&nbsp;</p>
	</fieldset>
	</form>
</div>
<div id="footerPanel">
        <jsp:include page="footer.jsp"/>
</div>
<br/>
</body>
</html>
