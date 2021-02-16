<!---START: ONPAGE VARIABLES--->
<cfparam name="ReferringPage" default="#cgi.http_referer#">
<cfinclude template="/mls/lightboxes/_header.cfm"> 

<cfif isdefined('nomoreviewsallowed')>
  <cfset returnlink="/mls/search-results.cfm">
<cfelse>
	<cfif isdefined('session.RememberMePage')>
			<cfset returnlink="#session.RememberMePage#">	
		<cfelse>
			<cfset returnlink="/mls/search-results.cfm">
	</cfif>
  
</cfif>

<div id="mls-wrapper">


  <h2>Create An Account</h2>
  <cfif isdefined('nomoreviewsallowed')>
    <div class="notice">To continue to utilize our site and to get the most out of your browser experience, we ask that you create an account.  Please login or create an account to have full access.</div>
  </cfif>
  


  <!---START: CREATE ACCOUNT--->
  <cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />
  <cfif isdefined('processform')>
    <!---has an account already been created with this email address--->
    <cfquery datasource="#mls.dsn#" name="Check">
      SELECT * 
      FROM cl_accounts
      where email = <cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR"> and accountcreatedbyviewer = 'Yes'
    </cfquery>
    <cfif check.recordcount gt 0>
      <br><br>
      <h3> Our system shows that you already have an acccount with <cfoutput>#mls.companyname#</cfoutput>. <br><br> Please try <a href="javascript:history.back()">logging in again</a>.</h3>
      <cfinclude template="/mls/lightboxes/_footer.cfm">
      <cfabort>
    </cfif>
    <!--- now we can test the form submission --->
    <cfif Cffp.testSubmission(form)>
      <cfset session.USERFirstName="#form.firstname#">
      <cfcookie name="USERFirstName" value="#form.firstname#" expires="#LoginCookiePersist#">
      <cfset session.USERLastName="#form.lastname#">
      <cfcookie name="USERLastName" value="#form.lastname#" expires="#LoginCookiePersist#">
      <cfset session.USEREmail="#form.email#">
      <cfcookie name="USEREmail" value="#form.email#" expires="#LoginCookiePersist#">
      <cfset session.USERPhone="#form.phone#">
      <cfcookie name="USERPhone" value="#form.phone#" expires="#LoginCookiePersist#">
      


      <!---START: INITIATING ROUND ROBIN IS ENABLED--->
      <cfif mls.EnableRoundRobin is "Yes">
        <cfinclude template="/mls/includes/round-robin.cfm">
      <cfelse>
        <!---this is to grab the one agent to get all the leads--->
        <cfquery datasource="#mls.dsn#" name="GetPrimaryAgent">
          SELECT * 
          FROM cl_agents
          where `primary` = 'Yes'
        </cfquery>
        <cfset AgentID="#GetPrimaryAgent.id#">
        <cfset AgentEmailAddress="#GetPrimaryAgent.email#">
        <cfset AgentName= "#GetPrimaryAgent.FirstName# #GetPrimaryAgent.LastName#">
      </cfif>
      <!---END: INITIATING ROUND ROBIN IS ENABLED--->
      


      <!---START: NOW THAT I'M INSERTING INTO ACCOUNTS WITH JUST A PROPERTY REQUEST, WE MUST TEST NOW TO SEE IF EXISTS AND UPDATE--->
      <cfquery datasource="#mls.dsn#" name="CheckLogin">
        SELECT * 
        FROM cl_accounts
        where email = <cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR">
      </cfquery>
      <cfif CheckLogin.recordcount eq "0">
        <cfquery datasource="#mls.dsn#" dbtype="ODBC">
          Insert 
          Into cl_accounts
            (firstname,lastname,email,phone,camefrom,password,accountcreatedbyviewer,agentid,lastrequest,MobileSignUp,leadsource,AgentOpened ) 
          Values 
            (<cfqueryparam value="#firstname#" cfsqltype="CF_SQL_VARCHAR">,<cfqueryparam value="#lastname#" cfsqltype="CF_SQL_VARCHAR">,<cfqueryparam value="#email#" cfsqltype="CF_SQL_VARCHAR">,<cfqueryparam value="#phone#" cfsqltype="CF_SQL_VARCHAR">,<cfqueryparam value="#processform#" cfsqltype="CF_SQL_VARCHAR">,<cfqueryparam value="#thepassword#" cfsqltype="CF_SQL_VARCHAR">,'Yes',<cfqueryparam value="#AgentID#" cfsqltype="CF_SQL_VARCHAR">,<cfqueryparam value="#now()#" cfsqltype="CF_SQL_DATE">,<cfif isdefined('session.mobile')>'Yes'<cfelse>'No'</cfif>,'2','No')
        </cfquery>
        <cfquery datasource="#mls.dsn#" name="GetID">
          SELECT max(id) as TheMaxId
          FROM cl_accounts
          where email = <cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
        <cfset TheClientID="#GetID.TheMaxId#">
      <cfelse>
        <cfquery name="UpdateQuery" datasource="#mls.dsn#">
          UPDATE cl_accounts
          SET 
            firstname = <cfqueryparam value="#form.firstname#" cfsqltype="CF_SQL_VARCHAR">,
            lastname = <cfqueryparam value="#form.lastname#" cfsqltype="CF_SQL_VARCHAR">,
            phone = <cfqueryparam value="#form.phone#" cfsqltype="CF_SQL_VARCHAR">,
          password = <cfqueryparam value="#form.thepassword#" cfsqltype="CF_SQL_VARCHAR">,
            accountcreatedbyviewer = 'Yes'
          where email = <cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR">
        </cfquery>	
        <cfset TheClientID="#CheckLogin.id#">
      </cfif> 
      <!---END: NOW THAT I'M INSERTING INTO ACCOUNTS WITH JUST A PROPERTY REQUEST, WE MUST TEST NOW TO SEE IF EXISTS AND UPDATE--->		
      


      <!---START: LOG THIS LOGIN--->
      <cfquery datasource="#mls.dsn#" dbtype="ODBC">
        Insert 
        Into cl_activity
          (clientid,RefferingSite,Action) 
        Values 
          (<cfqueryparam value="#TheClientID#" cfsqltype="CF_SQL_VARCHAR">,
           <cfif isdefined('session.referringsite')><cfqueryparam value="#session.referringsite#" cfsqltype="CF_SQL_LONGVARCHAR"><cfelse>'N/A'</cfif>,'Login'
          )
      </cfquery>
      <!---END: LOG THIS LOGIN--->
      


      <!---START: UPDATE PROPERTY VIEWS AND PROPERTY REQUESTS WITH YOUR CLIENTID, NOW THAT WE KNOW WHO YOU ARE--->
      <cfquery name="UpdateQuery" datasource="#mls.dsn#">
        UPDATE cl_properties_viewed
        SET 
          clientid = <cfqueryparam value="#TheClientID#" cfsqltype="CF_SQL_VARCHAR">
        where TheCFID = '#CFID#' and TheCFTOKEN = '#CFTOKEN#'
      </cfquery>		
      <cfquery name="UpdateQuery" datasource="#mls.dsn#">
        UPDATE cl_leadtracker_response
        SET 
          clientid = <cfqueryparam value="#TheClientID#" cfsqltype="CF_SQL_VARCHAR">
        where TheCFID = '#CFID#' and TheCFTOKEN = '#CFTOKEN#'
      </cfquery>	
      <cfquery name="UpdateQuery" datasource="#mls.dsn#">
        UPDATE cl_saved_searches
        SET 
          clientid = <cfqueryparam value="#TheClientID#" cfsqltype="CF_SQL_VARCHAR">
        where TheCFID = '#CFID#' and TheCFTOKEN = '#CFTOKEN#'
      </cfquery>
      <cfquery name="UpdateQuery" datasource="#mls.dsn#">
        UPDATE cl_activity
        SET 
          clientid = <cfqueryparam value="#TheClientID#" cfsqltype="CF_SQL_VARCHAR">
        where TheCFID = '#CFID#' and TheCFTOKEN = '#CFTOKEN#'
      </cfquery>
      <!---END: UPDATE PROPERTY VIEWS WITH YOUR CLIENTID, NOW THAT WE KNOW WHO YOU ARE--->
      
      
      
      <cfset session.loggedin="#TheClientID#">
      <cfcookie name="loggedin" value="#TheClientID#" expires="#LoginCookiePersist#">
      


      <!---START NOTIFICATION EMAIL TO THE ADMINISTRATOR AND CUSTOMER--->
        
        <cfmail to="#AgentEmailAddress#" from="#form.email# <#cfmail.username#>" replyto="#form.email#"
        subject="#mls.companyname# - Create Account Form" type="HTML" server="#cfmail.server#"  username="#cfmail.username#" password="#cfmail.password#"
        port="#cfmail.port#" useSSL="#cfmail.useSSL#" cc="#cfmail.cc#" bcc="#cfmail.bcc#">
        
        <cfinclude template="/mls/emails/_header.cfm">
          <p>First Name: #firstname#</p>
          <p>Last Name: #lastname#</p>
          <p>Email: #email#</p>
          <p>Phone: #phone#</p>
          <p>Login <a href="http://#cgi.HTTP_HOST#/admin/login.cfm?Action=Edit&id=#TheClientID#">http://#cgi.HTTP_HOST#/admin/login.cfm?Action=Edit&id=#TheClientID#</a>.</p>
        <cfinclude template="/mls/emails/_footer.cfm">
		
	 <!--this must stay for tracking-->
    <img src="http://#server_name#/mls/opened-lead-by-agent.cfm?openclientid=#TheClientID#" alt="" border="0">
    <!--this must stay for tracking-->
		
      </cfmail>
	  

        <cfmail to="#form.email#" from="#AgentEmailAddress# <#cfmail.username#>" replyto="#AgentEmailAddress#"
        subject="#mls.companyname# - Successful Account Creation" type="HTML" server="#cfmail.server#"  username="#cfmail.username#" password="#cfmail.password#"
        port="#cfmail.port#" useSSL="#cfmail.useSSL#" cc="#cfmail.cc#" bcc="#cfmail.bcc#">
        
        <cfinclude template="/mls/emails/_header.cfm">
          <p>Hello #firstname#,</p>
          <p>Thank you for creating an account with #mls.companyname#!  </p>
          <p>You can now login to your account anytime at <a href="http://#SERVER_NAME#/mls/index.cfm?LinkToLogin=">http://#cgi.HTTP_HOST#/mls</a> using the following:</p>
          <p>Email: #form.email#<br> Password: #form.thepassword#</p>
          <p><b>Don't forget to logout if you are on a public computer.</b></p>
          <p> Thank you,<br> #AgentName#<br> #mls.companyname#</p>
        <cfinclude template="/mls/emails/_footer.cfm">
      </cfmail>
      <!---END NOTIFICATION EMAIL TO THE ADMINISTRATOR AND CUSTOMER--->
      


      <!---START: AUTOMATED ACTIONS TO ADD TO FAVORITES AS THE ACCOUNT IS CREATED--->
     <cfif isdefined('action') and action is "addtofavorites">
        <cfquery datasource="#mls.dsn#" dbtype="ODBC">
          Insert 
          Into cl_favorites
            (clientid,mlsid,wsid,mlsnumber) 
          Values 
            (<cfqueryparam value="#TheClientID#" cfsqltype="CF_SQL_VARCHAR">,
             <cfqueryparam value="#FavoriteMLSID#" cfsqltype="CF_SQL_VARCHAR">,
             <cfqueryparam value="#FavoriteWSID#" cfsqltype="CF_SQL_VARCHAR">,
             <cfqueryparam value="#Favoritemlsnumber#" cfsqltype="CF_SQL_VARCHAR"> )
        </cfquery>
      </cfif>
      <!---END: AUTOMATED ACTIONS TO ADD TO FAVORITES AS THE ACCOUNT IS CREATED--->
      


      <!---START: AUTOMATED ACTIONS TO RETURN TO SAVE SEARCH PAGE--->
      <cfif isdefined('action') and action is "SaveSearch">
        <cfparam name="propertycount" default="">
        <cflocation url="/mls/lightboxes/save-search.cfm?propertycount=#propertycount#" addtoken="No">
      </cfif>
      <!---END: AUTOMATED ACTIONS TO RETURN TO SAVE SEARCH PAGE--->
      
      
      
      <br><br>
      


      <!---START: ON SCREEN NOTIFICATIONS--->
   <cfif isdefined('action') and action is "addtofavorites">
        <h3>
          <cfoutput>
            Thank you for creating an account with #mls.companyname#.<br>
            The property has been added to your favorites.<Br>
            Close this window and please continue to browse our site.
          </cfoutput>
        </h3>
      <cfelseif isdefined('action') and action is "SendToAFriend">
        <h3>
          <cfoutput>
            Thank you for creating an account with #mls.companyname#.<br>
            Please <a href="/mls/lightboxes/send-to-a-friend.cfm?&SendToAFriendwsid=#SendToAFriendwsid#&SendToAFriendmlsid=#SendToAFriendmlsid#&SendToAFriendmlsnumber=#SendToAFriendmlsnumber#">follow this link</a> to forward this property to your friend.<Br>
          </cfoutput>
        </h3>
      <cfelse>
        <cfoutput>
          <h3>Thank you for creating an account with #mls.companyname#!<br>Close this window and please continue to browse our site.</h3>
        </cfoutput>
      </cfif>  
      <!---END: ON SCREEN NOTIFICATIONS--->
    
    
    
    <cfelse>
      Spam Bot
      <cfabort>
    </cfif> 
    
    
    
    <!---HANDLES LOGGING IN---> 
    <cfelseif isdefined('processLogin')>
      <!---check login--->
      <cfquery datasource="#mls.dsn#" name="CheckLogin">
        SELECT * 
        FROM cl_accounts
        where email = <cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR"> and password = <cfqueryparam value="#form.password#" cfsqltype="CF_SQL_VARCHAR">
      </cfquery>
      <cfif CheckLogin.recordcount gt 0>
        <cfif CheckLogin.active is "No">
          <br><br>
          <cfoutput>
            <h3> Your account is no longer active.  Please email us at <a href="mailto:#adminemail#">#adminemail#</a> to reactivate your account..</h3>
          </cfoutput>
          <cfinclude template="/mls/lightboxes/_footer.cfm">
          <cfabort>
        </cfif>
        <cfset session.USERFirstName="#form.firstname#">
        <cfcookie name="USERFirstName" value="#form.firstname#" expires="#LoginCookiePersist#">
        <cfset session.USERLastName="#form.lastname#">
        <cfcookie name="USERLastName" value="#form.lastname#" expires="#LoginCookiePersist#">
        <cfset session.USEREmail="#form.email#">
        <cfcookie name="USEREmail" value="#form.email#" expires="#LoginCookiePersist#">
        <cfset session.USERPhone="#form.phone#">
        <cfcookie name="USERPhone" value="#form.phone#" expires="#LoginCookiePersist#">
        <cfset session.LoggedIn="#CheckLogin.id#">
        <cfcookie name="loggedin" value="#CheckLogin.id#" expires="#LoginCookiePersist#">
        


        <!---START: LOG THIS LOGIN--->
        <cfquery datasource="#mls.dsn#" dbtype="ODBC">
          Insert 
          Into cl_activity
            (clientid,RefferingSite,Action) 
          Values 
            (<cfqueryparam value="#CheckLogin.id#" cfsqltype="CF_SQL_VARCHAR">,
             <cfif isdefined('session.referringsite')><cfqueryparam value="#session.referringsite#" cfsqltype="CF_SQL_LONGVARCHAR"><cfelse>'N/A'</cfif>,'Login'
            )
        </cfquery>
        <!---END: LOG THIS LOGIN--->
        


        <!---START: UPDATE PROPERTY VIEWS AND PROPERTY REQUESTS WITH YOUR CLIENTID, NOW THAT WE KNOW WHO YOU ARE--->
        <cfquery name="UpdateQuery" datasource="#mls.dsn#">
          UPDATE cl_properties_viewed
          SET 
            clientid = <cfqueryparam value="#CheckLogin.id#" cfsqltype="CF_SQL_VARCHAR">
          where TheCFID = '#CFID#' and TheCFTOKEN = '#CFTOKEN#'
        </cfquery>		
        <cfquery name="UpdateQuery" datasource="#mls.dsn#">
          UPDATE cl_leadtracker_response
          SET 
            clientid = <cfqueryparam value="#CheckLogin.id#" cfsqltype="CF_SQL_VARCHAR">
          where TheCFID = '#CFID#' and TheCFTOKEN = '#CFTOKEN#'
        </cfquery>	
        <cfquery name="UpdateQuery" datasource="#mls.dsn#">
          UPDATE cl_saved_searches
          SET 
            clientid = <cfqueryparam value="#CheckLogin.id#" cfsqltype="CF_SQL_VARCHAR">
          where TheCFID = '#CFID#' and TheCFTOKEN = '#CFTOKEN#'
        </cfquery>
        <cfquery name="UpdateQuery" datasource="#mls.dsn#">
          UPDATE cl_activity
          SET 
            clientid = <cfqueryparam value="#CheckLogin.id#" cfsqltype="CF_SQL_VARCHAR">
          where TheCFID = '#CFID#' and TheCFTOKEN = '#CFTOKEN#'
        </cfquery>
        <!---END: UPDATE PROPERTY VIEWS WITH YOUR CLIENTID, NOW THAT WE KNOW WHO YOU ARE--->
        


        <!---START: AUTOMATED ACTIONS TO ADD TO FAVORITES AS YOU LOGIN--->
    <cfif isdefined('action') and action is "addtofavorites">
          <cfquery datasource="#mls.dsn#" dbtype="ODBC">
            Insert 
            Into cl_favorites
              (clientid,mlsid,wsid,mlsnumber) 
            Values 
              (<cfqueryparam value="#CheckLogin.id#" cfsqltype="CF_SQL_VARCHAR">,
               <cfqueryparam value="#FavoriteMLSID#" cfsqltype="CF_SQL_VARCHAR">,
               <cfqueryparam value="#FavoriteWSID#" cfsqltype="CF_SQL_VARCHAR">,
               <cfqueryparam value="#Favoritemlsnumber#" cfsqltype="CF_SQL_VARCHAR"> )
          </cfquery>
        </cfif>  
        <!---END: AUTOMATED ACTIONS TO ADD TO FAVORITES AS YOU LOGIN--->
        


        <!---START: AUTOMATED ACTIONS TO SEND TO A FRIEND AS YOU LOGIN--->
        <cfif isdefined('action') and action is "SendToAFriend">
          <cflocation url="/mls/lightboxes/send-to-a-friend.cfm?&SendToAFriendwsid=#SendToAFriendwsid#&SendToAFriendmlsid=#SendToAFriendmlsid#&SendToAFriendmlsnumber=#SendToAFriendmlsnumber#" addtoken="No">
        </cfif>
        <!---END: AUTOMATED ACTIONS TO SEND TO A FRIEND AS YOU LOGIN--->
        


        <!---START: AUTOMATED ACTIONS TO RETURN TO SAVE SEARCH PAGE--->
        <cfif isdefined('action') and action is "SaveSearch">
          <cfparam name="propertycount" default="">
          <cflocation url="/mls/lightboxes/save-search.cfm?propertycount=#propertycount#" addtoken="No">
        </cfif>
        <!---END: AUTOMATED ACTIONS TO RETURN TO SAVE SEARCH PAGE--->
        
        
        
        <cfoutput>
          <h3>Welcome back #CheckLogin.firstname#, You are now logged into #mls.companyname#.</h3>
          <h3>Close this window and please continue to browse our site.</h3>
        </cfoutput>
      <cfelse>
        <h3> Please <a href="javascript:history.back()">go back</a> and try re-entering your email and password.</h3>
      </cfif> 

	  
    <!---load forms--->  
    <cfelse>
   
      <cfoutput>
        <cfif isdefined('action') and action is "savesearch">
          <h4>You must become a member with #mls.companyname# before you are elgible to Save Searches.  Please create an account now.</h4>
        </cfif>
      </cfoutput>


      <table>
      <tr>
        <!---left side of the page--->
        <td>
          <div>
            <cfform action="#script_name#" method="post" name="thisform" onsubmit="return validateForm();"> 
              <cfinclude template="/cfformprotect/cffp.cfm">
              <cfinput type="hidden" name="processform" value="Create Account - #script_name#">
              


              <!---START: THIS IS TO AUTOMATE THE PROCESS OF ADDING THE FAVORITE PROPERTY TO YOUR ACCOUNT WHEN CREATED--->
              <cfoutput>
                <input type="hidden" name="ReferringPage" value="#cgi.http_referer#">
                <cfif isdefined('action')>
                  <input type="hidden" name="action" value="#action#">
                </cfif>
                <cfif isdefined('FavoriteWSID')>
                  <input type="hidden" name="FavoriteWSID" value="#FavoriteWSID#">
                </cfif>
                <cfif isdefined('FavoriteMLSID')>
                  <input type="hidden" name="FavoriteMLSID" value="#FavoriteMLSID#">
                </cfif>
                <cfif isdefined('Favoritemlsnumber')>
                  <input type="hidden" name="Favoritemlsnumber" value="#Favoritemlsnumber#">
                </cfif> 
                <cfif isdefined('SendToAFriendWSID')>
                  <input type="hidden" name="SendToAFriendWSID" value="#SendToAFriendWSID#">
                </cfif>
                <cfif isdefined('SendToAFriendMLSID')>
                  <input type="hidden" name="SendToAFriendMLSID" value="#SendToAFriendMLSID#">
                </cfif>
                <cfif isdefined('SendToAFriendmlsnumber')>
                  <input type="hidden" name="SendToAFriendmlsnumber" value="#SendToAFriendmlsnumber#">
                </cfif> 
                <cfif isdefined('propertycount')>
                  <input type="hidden" name="propertycount" value="#propertycount#">
                </cfif>
              </cfoutput>
              <cfparam name="session.useremail" default="">
              <cfparam name="session.userfirstname" default="">
              <cfparam name="session.userlastname" default="">
              <cfparam name="session.userphone" default="">
              <table height="400" width="350">
               <tr>
                <td colspan="2"> 
                  <cfif isdefined('action') and action is "addtofavorites">
                    <p><b>To Save Your Favorites</b></p>
                  <cfelse>
                    <p>Enjoy all the great features <cfoutput>#mls.companyname#'s</cfoutput> website offers by filling out the form below.</p>
                  </cfif>
                </td>
              </tr> 
              <cfoutput>
              <tr>
                <td class="ContactForm">First Name:<br><input type="Text" name="firstname"></td>
                <td class="ContactForm">Last Name:<br><input type="Text" name="lastname"></td>
              </tr>
              <tr>
                <td class="ContactForm">Phone:<br><input type="text" name="Phone"></td>
                <td class="ContactForm">Email:<br><input type="Text" name="email"></td>
              </tr>
              <tr>
                <td class="ContactForm">Password:<br><input type="password" name="thepassword"></td>
              </cfoutput>
                <td class="ContactForm">

                    <cfif mls.EnableRoundRobin is "Yes">

                      <cfif isdefined('session.useremail') and session.useremail is not "">

                          <cfquery datasource="#mls.dsn#" name="CheckExists">
                            SELECT * 
                            FROM cl_accounts
                            where email = <cfqueryparam value="#session.useremail#" cfsqltype="CF_SQL_VARCHAR">
                          </cfquery>
                          <cfoutput><input type="hidden" name="agentid" value="#CheckExists.agentid#"></cfoutput>

                        <cfelse>

                          <cfquery datasource="#mls.dsn#" name="GetAgents">
                            SELECT * 
                            FROM cl_agents
                            where roundrobin = 'Yes'
                          </cfquery>
                          Are you working with an existing agent?  
                          <select name="agentid">
                            <option value="No" SELECTED>No</option>
                            <cfoutput query="GetAgents">
                              <option value="#id#">Yes - #firstname# #lastname#</option>
                            </cfoutput>
                          </select>

                      </cfif> 

                    <cfelse>
                        <input type="hidden" name="agentid" value="No">
                    </cfif>   
				                 
                </td>
              </tr>
              <tr>
                <cfoutput><td class="ContactForm" colspan="2"><br><cfinput type="submit" name="SubmitForm" value="Create An Account" class="button"> <a href="login.cfm<cfif isdefined('url.nomoreviewsallowed')>?nomoreviewsallowed=<cfelseif isdefined('action') and action is "addtofavorites">?#cgi.query_string#</cfif>" class="fb_dynamic button">Login</a> <cfif isdefined('url.nomoreviewsallowed')><a href="../search-results.cfm" target="_parent" class="button" style="float:right;">Continue without signing up</a></cfif></td></cfoutput>
              </tr>  
              </table>
            </cfform>
          </div>
        </td>
      </tr>
      </table>
    </cfif>
    <!---END: CREATE ACCOUNT--->
    
    
    
  </div>

<cfinclude template="/mls/lightboxes/_footer.cfm">
