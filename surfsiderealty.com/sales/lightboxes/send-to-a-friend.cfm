<!--- <cfinclude template="/sales/lightboxes/_header.cfm"> --->

<div id="mls-wrapper">
<!---   <h2>Send To A Friend</h2> --->
  <!---IF NOT LOGGED IN REDIRECT--->
  <cfif isdefined('cookie.loggedin') is "No">
    <cfparam name="SendToAFriendmlsid" type="string" default="">
    <cfparam name="SendToAFriendwssid" type="string" default="">
    <cfparam name="SendToAFriendmlsnumber" type="string" default="">
    <cflocation url="/sales/lightboxes/create-account.cfm?action=#action#&SendToAFriendwsid=#SendToAFriendwsid#&SendToAFriendmlsid=#SendToAFriendmlsid#&SendToAFriendmlsnumber=#SendToAFriendmlsnumber#" addtoken="No">
  <cfelse>



    <cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />
    <cfif isdefined('processform') and isValid('email',form.email)>



      <!---START: PROCESSING FORM--->
      <cfif Cffp.testSubmission(form)>



        <!---START: AUTOMATED ACTIONS TO ADD TO FAVORITES AS THE ACCOUNT IS CREATED--->
        <cfquery datasource="#mls.dsn#" dbtype="ODBC">
          Insert
          Into cl_send_friend
            (clientid,mlsid,wsid,mlsnumber,comments,firstname,lastname,email)
          Values
            (<cfqueryparam value="#cookie.LoggedIn#" cfsqltype="CF_SQL_VARCHAR">,
             <cfqueryparam value="#SendToAFriendmlsid#" cfsqltype="CF_SQL_VARCHAR">,
             <cfqueryparam value="#SendToAFriendwsid#" cfsqltype="CF_SQL_VARCHAR">,
             <cfqueryparam value="#SendToAFriendmlsnumber#" cfsqltype="CF_SQL_VARCHAR">,
             <cfqueryparam cfsqltype="cf_sql_longvarchar" value='#comments#'>,
             <cfqueryparam value="#firstname#" cfsqltype="CF_SQL_VARCHAR">,
             <cfqueryparam value="#lastname#" cfsqltype="CF_SQL_VARCHAR">,
             <cfqueryparam value="#email#" cfsqltype="CF_SQL_VARCHAR"> )
        </cfquery>
        <!---END: AUTOMATED ACTIONS TO ADD TO FAVORITES AS THE ACCOUNT IS CREATED--->



        <!---START NOTIFICATION EMAIL TO THE ADMINISTRATOR AND CUSTOMER--->

         <cfmail to="#form.email#" from="#mls.adminemail# <#cfmail.username#>" replyto="#mls.adminemail#"
          subject="#mls.companyname# - Send To A Friend - From #cookie.USERFirstName#" type="HTML" server="#cfmail.server#"  username="#cfmail.username#" password="#cfmail.password#"
          port="#cfmail.port#" useSSL="#cfmail.useSSL#" cc="#cfmail.cc#" bcc="#cfmail.bcc#">
          <cfinclude template="/sales/emails/_header.cfm">
            <p>Hello #form.firstname#,</p>
            <p>#cookie.USERFirstName# would like for you to check out this property: <br />
            <div><!--Property Picture--></div>
            <a hreflang="en" href="http://#cgi.HTTP_HOST#/sales/property-details.cfm?mlsnumber=#SendToAFriendmlsnumber#&mlsid=#SendToAFriendmlsid#&wsid=#SendToAFriendwsid#">MLS ## #SendToAFriendmlsnumber#</a>  </p>
            <p><a hreflang="en" href="http://#cgi.HTTP_HOST#/sales/property-details.cfm?mlsnumber=#SendToAFriendmlsnumber#&mlsid=#SendToAFriendmlsid#&wsid=#SendToAFriendwsid#">Click Here</a> to view this Property</p>
            <p>Comments from #cookie.USERFirstName#:<br>#comments#</p>
          <cfinclude template="/sales/emails/_footer.cfm">
        </cfmail>
        <!---END NOTIFICATION EMAIL TO THE ADMINISTRATOR AND CUSTOMER--->



        <!---START: LOG ACTIVITY--->
        <cfquery datasource="#mls.dsn#" dbtype="ODBC">
          Insert
          Into cl_activity
            (clientid,RefferingSite,Action)
          Values
            (<cfqueryparam value="#cookie.LoggedIn#" cfsqltype="CF_SQL_VARCHAR">,
             <cfif isdefined('session.referringsite')><cfqueryparam value="#session.referringsite#" cfsqltype="CF_SQL_LONGVARCHAR"><cfelse>'N/A'</cfif>,'Send To A Friend'
            )
        </cfquery>



        <!---START: LOG ACTIVITY--->



        <!---START: ON SCREEN NOTIFICATIONS--->
        <cfoutput>
          <div class="notice">
            <h3>Thank you!<br>The Property Information has been sent to #form.firstname#<br>Close this mini-window and continue browsing our site!</h3>
          </div>
        </cfoutput>
        <!---END: ON SCREEN NOTIFICATIONS--->

       <script type="text/javascript">
       $(document).ready(function()
        {
       $("#submitMlsSTAF").hide();
        $("#success-staf").show();
        });
       </script>

      <cfelse>
      <table id="mlsSTAFTable" width="100%">
                <cfoutput>
                <tr><td colspan="2"><p>Please enter a valid Email address to send email.</p></td></tr>
                  <tr>
                    <td>Friend's First Name:<br><input type="Text" name="firstname" style="width:80%;"></td>
                    <td>Friend's Last Name:<br><input type="Text" name="lastname" style="width:80%;"></td>
                  </tr>
                  <tr>
                    <td colspan="2">Friend's Email:<br><input type="Text" name="email" style="width:80%;"></td>
                  </tr>
                  <tr>
                    <td colspan="2">Comments/Questions:<br><textarea name="comments" style="width:80%;height:200px;">#form.comments#</textarea></td>
                  </tr>
                  </cfoutput>
            </table>
      </cfif>
      <!---END: PROCESSING FORM--->



    <cfelse>



      <!---START: FORM INPUTS--->
<!---       <cfform action="#script_name#" class="form-horizontal" method="post">
        <cfinclude template="/cfformprotect/cffp.cfm">
        <input type="hidden" name="processform" value="">
        <div class="form-field largest"><label for="full_name">Friend's First Name</label><cfinput type="Text" name="firstname" message="Enter Your Friend's First Name!" required="Yes" id="full_name"></div>
        <div class="form-field largest"><label for="full_name">Friend's Last Name</label><cfinput id="full_name" name="lastname"  type="text" /></div>
        <div class="form-field large largest"><label for="email">Email Address</label><cfinput type="Text" name="email" message="You Must Enter A Valid Email Address!" validate="email" required="Yes" id="email"></div>
        <div class="form-field large largest"><label for="comments">Comments/Questions</label><textarea id="comments" name="comments" required="required"><cfoutput>Check out this property listed on #mls.companyname#.  MLS ## #SendToAFriendMLSNUMBER# http://#cgi.HTTP_HOST#/sales/property-details.cfm?mlsnumber=#SendToAFriendMLSNUMBER#&mlsid=#SendToAFriendmlsID#&wsid=#SendToAFriendwsid#</cfoutput></textarea></div>
        <cfoutput>
          <input id="mlsNumber" name="SendToAFriendmlsNumber" type="hidden" value="#SendToAFriendMLSNUMBER#"/>
          <input id="mlsID" name="SendToAFriendmlsID" type="hidden" value="#SendToAFriendmlsid#"/>
          <input id="mlsID" name="SendToAFriendwsid" type="hidden" value="#SendToAFriendwsid#"/>
        </cfoutput><br>
        <cfinput type="submit" name="submit" value="Send To Your Friend" class="button">
      </cfform> --->
      <!---END: FORM INPUTS--->
      <table id="mlsSTAFTable" width="100%">
                <cfoutput>
                <tr><td colspan="2"><p>Please enter a valid Email address to send email.</p></td></tr>
                  <tr>
                    <td>Friend's First Name:<br><input type="Text" name="firstname" style="width:80%;"></td>
                    <td>Friend's Last Name:<br><input type="Text" name="lastname" style="width:80%;"></td>
                  </tr>
                  <tr>
                    <td colspan="2">Friend's Email:<br><input type="Text" name="email" style="width:80%;"></td>
                  </tr>
                  <tr>
                    <td colspan="2">Comments/Questions:<br><textarea name="comments" style="width:80%;height:200px;">#form.comments#</textarea></td>
                  </tr>
                  <tr>
                    <td colspan="2">
                    	<div id="sendtofriendcaptcha"></div><br />
            			<div class="g-recaptcha-error"></div>
                    </td>
                  </tr>
                  </cfoutput>
            </table>


    </cfif>
  </cfif>
</div>

<!--- <cfinclude template="/sales/lightboxes/_footer.cfm"> --->