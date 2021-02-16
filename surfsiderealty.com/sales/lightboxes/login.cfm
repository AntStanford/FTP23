<!---START: ONPAGE VARIABLES--->
<cfparam name="ReferringPage" default="#cgi.http_referer#">
<cfparam name="session.RememberMePage" default="/mls">

<cfinclude template="/sales/lightboxes/_header.cfm">

<cfif isdefined('nomoreviewsallowed')>
  <cfset returnlink = "/sales/search-results.cfm">
<cfelse>
  <cfset returnlink = "#session.RememberMePage#">
</cfif>

<div id="mls-wrapper">
<!---   <h2>Login</h2> --->
  <cfif isdefined('nomoreviewsallowed')>
    <h3>To continue to utilize our site and to get the most out of your browswer experience, we ask that you create an account.  <br>Please login or create an account to have full access.</h3>
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
      <h3> Our system shows that you already have an acccount with <cfoutput>#mls.companyname#</cfoutput>. <br><br> Please try <a hreflang="en" href="javascript:history.back()">logging in again</a>.</h3>
      <cfinclude template="/sales/lightboxes/_footer.cfm">
      <cfabort>
    </cfif>
    <!---do the passwords match--->
    <cfif password is not passwordcheck>
      <br><br>
      <h3>Your passwords do not match.  Please <a hreflang="en" href="javascript:history.back()">go back</a> and re-enter them.</h3>
      <cfinclude template="/sales/lightboxes/_footer.cfm">
      <cfabort>
    </cfif>
    <!--- now we can test the form submission --->
    <cfif Cffp.testSubmission(form)>
      <cfset session.USERFirstName = "#form.firstname#">
      <cfcookie name="USERFirstName" value="#form.firstname#" expires="#LoginCookiePersist#">
      <cfset session.USERLastName = "#form.lastname#">
      <cfcookie name="USERLastName" value="#form.lastname#" expires="#LoginCookiePersist#">
      <cfset session.USEREmail = "#form.email#">
      <cfcookie name="USEREmail" value="#form.email#" expires="#LoginCookiePersist#">
      <cfset session.USERPhone = "#form.phone#">
      <cfcookie name="USERPhone" value="#form.phone#" expires="#LoginCookiePersist#">



      <!---START: INITIATING ROUND ROBIN IS ENABLED--->
      <cfif mls.EnableRoundRobin is "Yes">
        <cfinclude template="/sales/includes/round-robin.cfm">
      <cfelse>
        <!---this is to grab the one agent to get all the leads--->
        <cfquery datasource="#mls.dsn#" name="GetPrimaryAgent">
          SELECT *
          FROM cl_agents
          where `primary` = 'Yes'
        </cfquery>
        <cfset AgentID = "#GetPrimaryAgent.id#">
        <cfset AgentEmailAddress = "#GetPrimaryAgent.email#">
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
          (firstname,lastname,email,phone,camefrom,password,accountcreatedbyviewer,agentid,lastrequest,MobileSignUp,leadsource )
        Values
          (<cfqueryparam value="#firstname#" cfsqltype="CF_SQL_VARCHAR">,<cfqueryparam value="#lastname#" cfsqltype="CF_SQL_VARCHAR">,<cfqueryparam value="#email#" cfsqltype="CF_SQL_VARCHAR">,<cfqueryparam value="#phone#" cfsqltype="CF_SQL_VARCHAR">,<cfqueryparam value="#processform#" cfsqltype="CF_SQL_VARCHAR">,<cfqueryparam value="#password#" cfsqltype="CF_SQL_VARCHAR">,'Yes',<cfqueryparam value="#AgentID#" cfsqltype="CF_SQL_VARCHAR">,<cfqueryparam value="#now()#" cfsqltype="CF_SQL_DATE">,<cfif isdefined('session.mobile')>'Yes'<cfelse>'No'</cfif>,'2')
      </cfquery>
      <cfquery datasource="#mls.dsn#" name="GetID">
        SELECT max(id) as TheMaxId
        FROM cl_accounts
        where email = <cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR">
      </cfquery>
      <cfset TheClientID = "#GetID.TheMaxId#">
    <cfelse>
      <cfquery name="UpdateQuery" datasource="#mls.dsn#">
        UPDATE cl_accounts
        SET
          firstname = <cfqueryparam value="#form.firstname#" cfsqltype="CF_SQL_VARCHAR">,
          lastname = <cfqueryparam value="#form.lastname#" cfsqltype="CF_SQL_VARCHAR">,
          phone = <cfqueryparam value="#form.phone#" cfsqltype="CF_SQL_VARCHAR">,
        password = <cfqueryparam value="#form.password#" cfsqltype="CF_SQL_VARCHAR">,
          accountcreatedbyviewer = 'Yes'
        where email = <cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR">
      </cfquery>
      <cfset TheClientID = "#CheckLogin.id#">
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
      where TheCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CFID#'> and TheCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CFTOKEN#'>
    </cfquery>
    <cfquery name="UpdateQuery" datasource="#mls.dsn#">
      UPDATE cl_leadtracker_response
      SET
        clientid = <cfqueryparam value="#TheClientID#" cfsqltype="CF_SQL_VARCHAR">
      where TheCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CFID#'> and TheCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CFTOKEN#'>
    </cfquery>
    <cfquery name="UpdateQuery" datasource="#mls.dsn#">
      UPDATE cl_saved_searches
      SET
        clientid = <cfqueryparam value="#TheClientID#" cfsqltype="CF_SQL_VARCHAR">
      where TheCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CFID#'> and TheCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CFTOKEN#'>
    </cfquery>
    <cfquery name="UpdateQuery" datasource="#mls.dsn#">
      UPDATE cl_activity
      SET
        clientid = <cfqueryparam value="#TheClientID#" cfsqltype="CF_SQL_VARCHAR">
      where TheCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CFID#'> and TheCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CFTOKEN#'>
    </cfquery>
    <!---END: UPDATE PROPERTY VIEWS WITH YOUR CLIENTID, NOW THAT WE KNOW WHO YOU ARE--->



    <cfset session.loggedin = "#TheClientID#">
    <cfcookie name="loggedin" value="#TheClientID#" expires="#LoginCookiePersist#">



    <!---START NOTIFICATION EMAIL TO THE ADMINISTRATOR AND CUSTOMER--->

      <cfmail to="#AgentEmailAddress#" from="#form.email# <#cfmail.username#>" replyto="#form.email#"
      subject="#mls.companyname# - Create Account Form" type="HTML" server="#cfmail.server#"  username="#cfmail.username#" password="#cfmail.password#"
      port="#cfmail.port#" useSSL="#cfmail.useSSL#" cc="#cfmail.cc#" bcc="#cfmail.bcc#">
      <cfinclude template="/sales/emails/_header.cfm">
        <p>First Name: #firstname#</p>
        <p>Last Name: #lastname#</p>
        <p>Email: #email#</p>
        <p>Phone: #phone#</p>
        <p>Login <a hreflang="en" href="http://#cgi.HTTP_HOST#/admin/login.cfm?Action=Edit&id=#TheClientID#">http://#cgi.HTTP_HOST#/admin/login.cfm?Action=Edit&id=#TheClientID#</a>.</p>
      <cfinclude template="/sales/emails/_footer.cfm">
    </cfmail>


     <cfmail to="#form.email#" from="#AgentEmailAddress# <#cfmail.username#>" replyto="#AgentEmailAddress#"
     subject="#mls.companyname# - Successful Account Creation" type="HTML" server="#cfmail.server#"  username="#cfmail.username#" password="#cfmail.password#"
     port="#cfmail.port#" useSSL="#cfmail.useSSL#" cc="#cfmail.cc#" bcc="#cfmail.bcc#">
      <cfinclude template="/sales/emails/_header.cfm">
        <p>Hello #firstname#,</p>
        <p>Thank you for creating an account with #mls.companyname#!  </p>
        <p>You can now login to your account anytime at <a hreflang="en" href="http://#SERVER_NAME#/sales/index.cfm?LinkToLogin=">http://#cgi.HTTP_HOST#/mls</a> using the following:</p>
        <p>Email: #form.email#<br>Password: #form.password#</p>
        <p><b>Don't forget to logout if you are on a public computer.</b></p>
        <p> Thank you,<br>#AgentName#<br>#mls.companyname#</p>
      <cfinclude template="/sales/emails/_footer.cfm">
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
      <cflocation url="/sales/lightboxes/save-search.cfm?propertycount=#propertycount#" addtoken="No">
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
          Please <a hreflang="en" href="/sales/lightboxes/send-to-a-friend.cfm?&SendToAFriendwsid=#SendToAFriendwsid#&SendToAFriendmlsid=#SendToAFriendmlsid#&SendToAFriendmlsnumber=#SendToAFriendmlsnumber#">follow this link</a> to forward this property to your friend.<Br>
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
        <h3> Your account is no longer active.  Please email us at <a hreflang="en" href="mailto:#adminemail#">#adminemail#</a> to reactivate your account..</h3>
      </cfoutput>
      <cfinclude template="/sales/lightboxes/_footer.cfm">
      <cfabort>
    </cfif>
    <cfset session.USERFirstName = "#CheckLogin.firstname#">
    <cfcookie name="USERFirstName" value="#CheckLogin.firstname#" expires="#LoginCookiePersist#">
    <cfset session.USERLastName = "#CheckLogin.lastname#">
    <cfcookie name="USERLastName" value="#CheckLogin.lastname#" expires="#LoginCookiePersist#">
    <cfset session.USEREmail = "#CheckLogin.email#">
    <cfcookie name="USEREmail" value="#CheckLogin.email#" expires="#LoginCookiePersist#">
    <cfset session.USERPhone = "#CheckLogin.phone#">
    <cfcookie name="USERPhone" value="#CheckLogin.phone#" expires="#LoginCookiePersist#">
    <cfset session.LoggedIn = "#CheckLogin.id#">
    <cfcookie name="loggedin" value="#CheckLogin.id#" expires="#LoginCookiePersist#">


    <script type="text/javascript">
      $("#submitMlsLogin").hide();
    </script>

    <script type="text/javascript">
    $('#mlsModalLogin').on('hidden.bs.modal', function () {
      window.location.reload(true);
    })
    </script>

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
      where TheCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CFID#'> and TheCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CFTOKEN#'>
    </cfquery>
    <cfquery name="UpdateQuery" datasource="#mls.dsn#">
      UPDATE cl_leadtracker_response
      SET
        clientid = <cfqueryparam value="#CheckLogin.id#" cfsqltype="CF_SQL_VARCHAR">
      where TheCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CFID#'> and TheCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CFTOKEN#'>
    </cfquery>
    <cfquery name="UpdateQuery" datasource="#mls.dsn#">
      UPDATE cl_saved_searches
      SET
        clientid = <cfqueryparam value="#CheckLogin.id#" cfsqltype="CF_SQL_VARCHAR">
      where TheCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CFID#'> and TheCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CFTOKEN#'>
    </cfquery>
    <cfquery name="UpdateQuery" datasource="#mls.dsn#">
      UPDATE cl_activity
      SET
        clientid = <cfqueryparam value="#CheckLogin.id#" cfsqltype="CF_SQL_VARCHAR">
      where TheCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CFID#'> and TheCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value='#CFTOKEN#'>
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
      <cflocation url="/sales/lightboxes/send-to-a-friend.cfm?&SendToAFriendwsid=#SendToAFriendwsid#&SendToAFriendmlsid=#SendToAFriendmlsid#&SendToAFriendmlsnumber=#SendToAFriendmlsnumber#" addtoken="No">
    </cfif>
    <!---END: AUTOMATED ACTIONS TO SEND TO A FRIEND AS YOU LOGIN--->



    <!---START: AUTOMATED ACTIONS TO RETURN TO SAVE SEARCH PAGE--->
    <cfif isdefined('action') and action is "SaveSearch">
      <cfparam name="propertycount" default="">
      <cflocation url="/sales/lightboxes/save-search.cfm?propertycount=#propertycount#" addtoken="No">
    </cfif>
    <!---END: AUTOMATED ACTIONS TO RETURN TO SAVE SEARCH PAGE--->



    <cfoutput>
      <div class="notice">
        <h3>Welcome back #CheckLogin.firstname#, You are now logged into #mls.companyname#.</h3>
        <h3>Close this window and please continue to browse our site.</h3>
      </div>
    </cfoutput>
  <cfelse>
<!---     <div class="notice">
      <h3>Please <a hreflang="en" href="javascript:history.back()">go back</a> and try re-entering your email and password.</h3>

    </div> --->
    <p>Your login was unsuccessful. Please try again.</p>
            <table id="mlsLoginTable" width="100%">
      <tr>
        <td>Email:<br><input type="text" name="Email" style="width:80%;"></td>
        <td>Password:<br><input type="Text" name="Password" style="width:80%;"></td>
      </tr>
    </table>
  </cfif>
<!---   <div align="right">
    <cfif (isdefined('session.loggedin') or isdefined('cookie.loggedin')) or ReferringPage contains "property-details.cfm">
      <cfoutput><a hreflang="en" href="#returnlink#" target="_parent" id="fancybox-close">X</a></cfoutput>
    <cfelse>
      <a hreflang="en" href="javascript:parent.$.fancybox.close();" id="fancybox-close">X</a>
    </cfif>
  </div> --->
  <!---load forms--->
<cfelse>
 <!---  <a hreflang="en" href="javascript:parent.$.fancybox.close();" id="fancybox-close">X</a> --->
  <cfoutput>
    <cfif isdefined('action') and action is "savesearch">
      <div class="notice">
        <h4>You must become a member with #mls.companyname# before you are elgible to Save Searches.  Please create an account now.</h4>
      </div>
    </cfif>
  </cfoutput>
<!---   <div align="right">
    <cfif (isdefined('session.loggedin') or isdefined('cookie.loggedin')) or ReferringPage contains "property-details.cfm">
      <cfoutput><a hreflang="en" href="#returnlink#" target="_parent" id="fancybox-close">X</a></cfoutput>
    <cfelse>
      <a hreflang="en" href="javascript:parent.$.fancybox.close();" id="fancybox-close">X</a>
    </cfif>
  </div> --->
  <table width="100%">
  <tr>
    <!---right side of the page--->
    <td>
      <div>
        <cfform action="#script_name#" method="post">
          <cfinclude template="/cfformprotect/cffp.cfm">
          <cfinput type="hidden" name="processLogin" value="Login Page - #script_name#">
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
          <table width="100%">
          <tr>
            <td>
              <p>If you already have an account, login below.  If not, please visit our <a hreflang="en" href="create-account.cfm">signup page</a>.</p>
            </td>
          </tr>
          <tr>
            <td class="ContactForm">Email:<br><cfinput type="Text" name="email" message="Please Enter a Valid Email!" validate="email" required="Yes"></td>
          </tr>
          <tr>
            <td class="ContactForm">Password:<br><cfinput type="password" name="password" message="Please Enter a Password!" required="Yes"></td>
          </tr>
          <tr>
            <td class="ContactForm" colspan="2">
              <br>

                <table>
                  <tr>
                    <td><cfinput type="submit" name="SubmitForm" value="Login" class="button"></td>
                    <td><a hreflang="en" href="/sales/lightboxes/retrieve-password.cfm" class="button light">Forgot Password?</a></td>
                    <cfif isdefined('url.nomoreviewsallowed')><td><a hreflang="en" href="../search-results.cfm" target="_parent" class="button" style="float:right;">Continue without logging in</a></td></cfif>
                  </tr>
                </table>

              </td>
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

<cfinclude template="/sales/lightboxes/_footer.cfm">