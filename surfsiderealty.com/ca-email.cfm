<cftry>
  <cfset url.id = 177 />

  <cfquery name="getClientSettings" dataSource="#settings.bcDSN#">
  select * from settings where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>

  <cfquery name="getDetailPageUsers" dataSource="#settings.bcDSN#">
  select id,email,unitcode,property,firstname,favoritesList,viewedList,thekey
  from cart_abandonment_detail_page
  where siteid = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
  and followUpEmailSent != 'Yes'
  and email != ''
  and unitcode != ''
  </cfquery>

  <cfquery name="getBookNowPageUsers" dataSource="#settings.bcDSN#">
  select id,email,unitcode,property,firstname,startdate,enddate,favoritesList,viewedList,thekey,totalamount
  from cart_abandonment
  where siteid = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
  and followUpEmailSent != 'Yes'
  and email != ''
  and unitcode != ''
  limit 1
  </cfquery>

  <cfset myunitcode = getBookNowPageUsers.unitcode>
  <cfset guestEmail = getBookNowPageUsers.email>
  <cfset guestFirstName = getBookNowPageUsers.firstname>
  <cfset strCheckIn = dateformat(getBookNowPageUsers.startdate,'m/d/yyyy')>
  <cfset strCheckOut = dateformat(getBookNowPageUsers.enddate,'m/d/yyyy')>
  <cfset favoritesList = getBookNowPageUsers.favoritesList>
  <cfset viewedList = getBookNowPageUsers.viewedList>

  <!--- delete from here up - it'll be handled in the run.cfm file --->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
  <style type="text/css">
  div,p,a,li,td{ -webkit-text-size-adjust:none;}
  #outlook a{padding:0;} /* Force Outlook to provide a "view in browser" menu link. */
  html{width:100%;}
  body{font-family:Arial;width:100% !important;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%;margin:0;padding:0;}
  /* Prevent Webkit and Windows Mobile platforms from changing default font sizes,while not breaking desktop design. */
  .ExternalClass{width:100%;} /* Force Hotmail to display emails at full width */
  .ExternalClass,.ExternalClass p,.ExternalClass span,.ExternalClass font,.ExternalClass td,.ExternalClass div{line-height:100%;} /* Force Hotmail to display normal line spacing. */
  #backgroundTable{margin:0;padding:0;width:100% !important;line-height:100% !important;}
  img{outline:none;text-decoration:none;border:none;-ms-interpolation-mode:bicubic;}
  a img{border:none;}
  .image_fix{display:block;}
  table[class=footer] p{margin:0px 0px !important;}
  table td{border-collapse:collapse;}
  table{ border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt;}
  a{color:#000000;text-decoration:none;text-decoration:none!important;}
  /*STYLES*/
  table[class=full]{ width:100%;clear:both;}
  table.devicewidth.social-wrapper img{margin-right:10px;}
  img[class=img-border]{border:1px solid #ccc;padding:2px;background:#eee;}
  /*IPAD STYLES*/
  @media only screen and (max-width:640px){
    a[href^="tel"],a[href^="sms"]{text-decoration:none;color:#000000;pointer-events:none;cursor:default;}
    .mobile_link a[href^="tel"],.mobile_link a[href^="sms"]{text-decoration:default;color:#000000 !important;pointer-events:auto;cursor:default;}
    table[class=devicewidth]{width:440px!important;}
    table[class=center]{text-align:center!important;}
    table[class=devicewidthinner]{width:420px!important;}
    img[class=banner]{width:440px!important;height:220px!important;}
    img[class=col2img]{width:440px!important;height:220px!important;}
   }
    /*IPHONE STYLES*/
    @media only screen and (max-width:480px){
      a[href^="tel"],a[href^="sms"]{text-decoration:none;color:#000000;pointer-events:none;cursor:default;}
      .mobile_link a[href^="tel"],.mobile_link a[href^="sms"]{text-decoration:default;color:#000000 !important;pointer-events:auto;cursor:default;}
      table[class=devicewidth]{width:280px!important;}
      table.devicewidth.social-wrapper{width:280px;}
      table[class=devicewidthinner]{width:260px!important;}
      img[class=banner]{width:280px!important;height:140px!important;}
      img[class=col2img]{width:280px!important;height:140px!important;}
      table.devicewidthinner img{display:block;width:100%;margin-bottom:9px;}
   }
  </style>
</head>
<body>

 	<cfquery name="getPropertyInfo" dataSource="#getClientSettings.dsn#">
 	select *
 	from pp_propertyinfo
 	where strpropid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#myunitcode#" />
 	</cfquery>

 	<cfif getPropertyInfo.recordcount gt 0>

  	  <!---<cfmail subject="Come back and book now!" to="#guestEmail#" from="#getClientSettings.company# <#getClientSettings.cfmailusername#" replyto="#getClientSettings.clientemail#" server="#getClientSettings.cfmailserver#" username="#getClientSettings.cfmailusername#" password="#getClientSettings.cfmailpassword#" port="#getClientSettings.cfmailport#" useSSL="#getClientSettings.cfmailSSL#" type="HTML">--->
    <cfoutput>
		  <style>
			img {padding-right:10px; padding-left:10px;}
		  </style>
		  <center>
  		  <table width="100%" bgcolor="##ffffff" cellpadding="0" cellspacing="0" border="0">
  			  <tr>
  				  <td width="100%" valign="top">
                <!-- Header -->
                <table bgcolor="##06407c" width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                    <td>
            				  <center>
                				<table width="600" cellpadding="0" cellspacing="0" border="0" style="padding-top:10px; padding-bottom:10px; color: ##ffffff;">
                					<tr>
                						<td width="200" valign="top"><img src="http://#getClientSettings.website#/images/layout/logo.png"></td>
                						<td width="400" style="padding-right: 20px;">
                							<p style="margin:0; font-size:14px; text-align:right;">#getClientSettings.company#<br><a href="mailto:#getClientSettings.clientEmail#" style="color:##ffffff;">#getClientSettings.clientEmail#</a></p>
                							<p style="margin:0; font-size:14px; text-align:right;">#getClientSettings.tollFree#</p>
                						</td>
                					</tr>
                				</table>
            				  </center>
                    </td>
                  </tr>
                </table>
        				<!-- End Header -->
                <table bgcolor="##f9f9f9" width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                    <td>
                      <br>
            				  <center>
                				<table width="600" cellpadding="0" cellspacing="0" border="0" bgcolor="##ffffff" style="padding-top:10px; padding-right:10px; padding-bottom:20px; padding-left:10px;">
                					<tr>
                						<td width="600" valign="top" style="padding:35px;">
                  						<h3>Hello #guestfirstname#,</h3>
                              <p>We noticed that you didn't complete your reservation of <b><a href="http://#getClientSettings.website#/rentals/#getPropertyInfo.seopropertyname#/#myunitcode#">#getPropertyInfo.strname#</a></b>.</p>
                  						
                              <table bgcolor="##ffffff" width="600" cellpadding="0" cellspacing="0" border="0" align="center" class="devicewidth">
                    						<tr>
                      						<td valign="center">
                                    <center>
                        						<img src="#listfirst(getPropertyInfo.picList)#" width="70%" style="margin:0;padding:0;height:auto;">

                                    
                                    <table>
                                      <tr>
                                        <td><strong>Sleeps:</strong></td><td>#getPropertyInfo.intoccu# &nbsp;</td>
                                        <td><strong>Type:</strong></td><td>#getPropertyInfo.strcomplex# &nbsp;</td>
                                        <td><strong>Beds:</strong></td><td>#getPropertyInfo.dblbeds# &nbsp;</td>
                                        <td><strong>Baths:</strong></td><td>#getPropertyInfo.dblbaths#</td>
                                      </tr>
                                    </table>
                                  </center>
                                  <br/>
                        						<center>
                          						<p><strong>If you are interested, don't wait!</strong><br>Book this property before someone else does!</p>
                          						<!---<a href="https://www.surfsiderealty.com/rentals/book-now.cfm?strpropid=#myunitcode#&strcheckin=#strcheckin#&strcheckout=#strCheckOut#" style="display:inline-block;padding:15px 30px;background:##1fb9de;color:white;">Book Now</a>--->
                                      <a href="https://www.surfsiderealty.com/rentals/#getPropertyInfo.seopropertyname#/#myunitcode#" style="display:inline-block;padding:15px 30px;background:##1fb9de;color:white;">View Property</a>
                        						</center>
                      						</td>
                    						</tr>
                  						</table>
                  						<p>Properties are filling up fast, so don't delay if you're thinking about booking.  We are here to help!  If we can answer any questions or assist with your vacation planning, please contact us at  #getClientSettings.tollFree#.</p>
                  						<h4><a href="http://#getClientSettings.website#?utm_source=return&utm_medium=email&utm_campaign=cart-abandon-email">Visit our website at #getClientSettings.website#</a></h4>
                						</td>
                					</tr>
                				</table>
            				  </center>
                      <br>
                    </td>
                  </tr>
                </table>
                <!-- Start of footer -->
                <table width="100%" class="footer" bgcolor="##06407c" cellpadding="0" cellspacing="0" border="0" id="backgroundTable" st-sortable="postfooter" >
                  <tbody>
                    <tr>
                      <td>
                        <table width="600" cellpadding="0" cellspacing="0" border="0" align="center" class="devicewidth">
                          <tbody>
                            <!-- Spacing -->
                            <tr>
                              <td width="100%" height="5"></td>
                            </tr>
                            <!-- Spacing -->
                            <cfif LEN(getClientSettings.company)>
                              <tr width="600">
                                <td height="30" align="center" valign="middle" style="font-family:Helvetica,arial,sans-serif;font-size:16px;font-weight:bold;color:##b8b8b8" st-content="menu">
                                  <cfoutput>
                                    <p style="color:##ffffff !important;">#getClientSettings.company#</p>
                                  </cfoutput>
                                </td>
                              </tr>
                            </cfif>
                            <cfif LEN(getClientSettings.address)>
                              <tr width="600">
                                <td align="center" valign="middle" style="font-family:Helvetica,arial,sans-serif;font-size:13px;color:##b8b8b8" st-content="menu">
                                  <cfoutput>
                                    <p style="padding:0 0 5px 0;color:##ffffff !important;line-height:20px;">#getClientSettings.address# <br /> #getClientSettings.city#,#getClientSettings.state# #getClientSettings.zip#</p>
                                  </cfoutput>
                                </td>
                              </tr>
                            </cfif>
                            <cfif LEN(getClientSettings.tollFree)>
                              <tr width="600">
                                <td align="center" valign="middle" style="font-family:Helvetica,arial,sans-serif;font-size:13px;color:##b8b8b8" st-content="menu">
                                  <cfoutput>
                                    <p style="padding:0;"><a href="tel:#getClientSettings.company#" style="color:##ffffff !important;">#getClientSettings.tollFree#</a></p>
                                  </cfoutput>
                                </td>
                              </tr>
                            </cfif>
                            <!-- Spacing -->
                            <tr>
                              <td width="100%" height="10"></td>
                            </tr>
                            <!-- Spacing -->
                          </tbody>
                        </table>
                      </td>
                    </tr>
                  </tbody>
                </table>
                <table width="100%" bgcolor="##06407c" cellpadding="0" cellspacing="0" border="0" id="backgroundTable" st-sortable="footer">
                  <tbody>
                    <tr>
                      <td>
                        <table width="600" cellpadding="0" cellspacing="0" border="0" align="center" class="devicewidth">
                          <tbody>
                            <tr>
                              <td width="100%">
                                <table width="600" cellpadding="0" cellspacing="0" border="0" align="center" class="devicewidth">
                                <tbody>
                                  <!-- Spacing -->
                                  <tr>
                                    <td>
                                      <cfoutput>
                                        <!-- Social icons -->
                                        <table  width="150" align="center" border="0" cellpadding="0" cellspacing="0" class="devicewidth social-wrapper">
                                          <tbody>
                                            <tr>
                                              <cfif LEN(getClientSettings.facebookURL)>
                                                <td width="43" height="43" align="center">
                                                  <div class="imgpop">
                                                   <a href="#getClientSettings.facebookURL#" target="_blank" class="" target="_blank"><img src="http://www.icoastalnet.com/images/social/facebook.jpg" alt="facebook" border="0" width="43" height="43" style="display:block;border:none;outline:none;text-decoration:none;"></a>
                                                  </div>
                                                </td>
                                              </cfif>
                                              <cfif LEN(getClientSettings.twitterURL)>
                                                <td width="43" height="43" align="center">
                                                  <div class="imgpop">
                                                    <a href="#getClientSettings.twitterURL#" target="_blank" class="" target="_blank"><img src="http://www.icoastalnet.com/images/social/twitter.jpg" alt="twitter" border="0" width="43" height="43" style="display:block;border:none;outline:none;text-decoration:none;"></a>
                                                  </div>
                                                </td>
                                              </cfif>
                                              <cfif LEN(getClientSettings.pinterestURL)>
                                                <td width="43" height="43" align="center">
                                                  <div class="imgpop">
                                                    <a href="#getClientSettings.pinterestURL#" target="_blank" class="" target="_blank"><img src="http://www.icoastalnet.com/images/social/pinterest.jpg" alt="pinterest" border="0" width="43" height="43" style="display:block;border:none;outline:none;text-decoration:none;"></a>
                                                  </div>
                                                  </td>
                                                </cfif>
                                                <cfif LEN(getClientSettings.youtubeURL)>
                                                  <td width="43" height="43" align="center">
                                                    <div class="imgpop">
                                                      <a href="#getClientSettings.youtubeURL#" target="_blank" class="" target="_blank"><img src="http://www.icoastalnet.com/images/social/youtube.jpg" alt="youtube" border="0" width="43" height="43" style="display:block;border:none;outline:none;text-decoration:none;"></a>
                                                    </div>
                                                  </td>
                                                </cfif>
                                                <cfif LEN(getClientSettings.googlePlusURL)>
                                                  <td width="43" height="43" align="center">
                                                    <div class="imgpop">
                                                      <a href="#getClientSettings.googlePlusURL#" target="_blank" class="" target="_blank"><img src="http://www.icoastalnet.com/images/social/googleplus.jpg" alt="googleplus" border="0" width="43" height="43" style="display:block;border:none;outline:none;text-decoration:none;"></a>
                                                    </div>
                                                  </td>
                                                </cfif>
                                              </tr>
                                            </tbody>
                                          </table>
                                        </cfoutput>
                                        <!-- end of Social icons -->
                                      </td>
                                    </tr>
                                    <!-- Spacing -->
                                    <tr>
                                      <td height="10" style="font-size:1px;line-height:1px;mso-line-height-rule:exactly;">&nbsp;</td>
                                    </tr>
                                    <!-- Spacing -->
                                  </tbody>
                                </table>
                              </td>
                            </tr>
                          </tbody>
                        </table>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </center>
            </td>
          </tr>
        </table>
		  </center>
      <img src="http://apis.icnd.net/cart_abandonment/opened-email.cfm?email=#guestEmail#&unitcode=#myunitcode#&siteid=#getClientSettings.id#">

    </cfoutput>
      <!---</cfmail>--->
  </cfif>


</body>
</html>

<cfcatch>
   <cfdump var="#cfcatch#" abort="true" />
</cfcatch>

</cftry>