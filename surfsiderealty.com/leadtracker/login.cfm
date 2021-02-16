<cfinclude template="components/login-header.cfm">

<table class="login">
<tr>
<td align="center" valign="top">
  <div class="log-wrap">

    <h2>Leadtracker Login</h2>


		<cfif isdefined('logout')>
            <cfcookie name="LoggedInAdminID"  expires="NOW">
            <cfcookie name="LoggedInAdminName"  expires="NOW">
    
            <cfcookie name="LoggedInAgentID"  expires="NOW">
            <cfcookie name="LoggedInAgentName"  expires="NOW">
            
            <cfset StructDelete(session, "loggedInUserStruct") />
            
            <p style="color:red">You have successfully logged out.</p>
		</cfif>


	 	<cfif isdefined('form.email')>


	 		<cfif LoginType is "Agent">
	 			<!---START: LOGGIN IN AS AGENT--->

                <CFQUERY DATASOURCE="#mls.dsn#" NAME="CheckLogin">
                    SELECT *
                    FROM cl_agents
                    where email = <cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR">
                    and password = <cfqueryparam value="#form.password#" cfsqltype="CF_SQL_VARCHAR">
                </CFQUERY>


				<cfoutput>
					<cfif CheckLogin.recordcount gt 0>
                        <!---<cfcookie name="LoggedInAgentID" value="#CheckLogin.id#">
                        <cfcookie name="LoggedInAgentName" value="#CheckLogin.Firstname# #CheckLogin.Lastname#">--->
                        
                        <cfset session.loggedInUserStruct = {}>
                        <cfset session.loggedInUserStruct.LoggedInAgentID = CheckLogin.id>
                        <cfset session.loggedInUserStruct.LoggedInAgentName = CheckLogin.Firstname & " " & CheckLogin.Lastname>
                    
            
                        <cfif isdefined('form.AutoLoadContact')>
                            <meta http-equiv="REFRESH" content="0; url=/admin/contacts/contacts.cfm?Action=Edit&id=#AutoLoadContact#">
                            <cfelseif isdefined('form.AutoReplyTo')>
                            <meta http-equiv="REFRESH" content="0; url=/admin/contacts/contacts2.cfm?action=Edit&id=#form.AutoReplyTo#&display=LeadTracker##LOC">
                            <cfelse>
                            <meta http-equiv="REFRESH" content="0; url=/leadtracker/dashboard.cfm">
                        </cfif>
                            <cfelse>
                        <cflocation url="login.cfm?invalid=1" addtoken="No">
                    </cfif>
	 			</cfoutput>
	 			<!---END: LOGGIN IN AS AGENT--->
	 		<cfelse>
				<!---START: LOGGIN IN AS ADMIN--->

                <CFQUERY DATASOURCE="#mls.dsn#" NAME="CheckLogin">
                    SELECT *
                    FROM cl_passwords
                    where email = <cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR">
                    and password = <cfqueryparam value="#form.password#" cfsqltype="CF_SQL_VARCHAR">
                </CFQUERY>
    
                <cfoutput>
    
                    <cfif CheckLogin.recordcount gt 0>
                        <!---<cfcookie name="LoggedInAdminID" value="#CheckLogin.id#">
                        <cfcookie name="LoggedInAdminName" value="#CheckLogin.name#">--->
                        <cfset session.loggedInUserStruct.LoggedInAdminID = CheckLogin.id>
                        <cfset session.loggedInUserStruct.LoggedInAdminName = CheckLogin.name>
                        
                            <cfif isdefined('form.AutoLoadContact')>
                                <meta http-equiv="REFRESH" content="0; url=/admin/contacts/contacts2.cfm?Action=Edit&id=#AutoLoadContact#">
                            <cfelseif isdefined('form.AutoReplyTo')>
                                <meta http-equiv="REFRESH" content="0; url=/admin/contacts/contacts2.cfm?action=Edit&id=#form.AutoReplyTo#&display=LeadTracker##LOC">
                            <cfelse>
                                <meta http-equiv="REFRESH" content="0; url=/leadtracker/dashboard.cfm">
                            </cfif>
                        <cfelse>
                        <cflocation url="login.cfm?invalid=2" addtoken="No">
                    </cfif>
                </cfoutput>

			<!---END: LOGGIN IN AS ADMIN--->
         </cfif>



	<cfelse>

	 	<cfif isdefined('invalid')>
	 		<p style="color:red">Incorrect User / Password Combination.  Try Again.</p>
		</cfif>


	 	<form action="<cfoutput>#script_name#</cfoutput>" method="post">

	 		<cfoutput>
	 			<cfif isdefined('url.msgreply') and LEN(url.msgreply)>
	 				<input type="hidden" name="AutoReplyTo" value="#url.msgreply#">
	 			<cfelseif (isdefined('url.action') and url.action is "Edit") and isdefined('url.id')>
	 				<input type="hidden" name="AutoLoadContact" value="#url.id#">
	 			</cfif>
	 		</cfoutput>
          <table>
              <tr>
                  <td align="right" valign="middle">Login:</td>
                  <td align="left" valign="middle" ><label for="user-email">Email</label><input type="Text" name="email" message="You Must Enter Your UserName!" required="Yes" maxlength="100" id="user-email" tabindex="1"></td>
              </tr>
    
              <tr>
                  <td align="right" valign="middle">Pass:</td>
                  <td align="left" valign="middle"><label for="user-password">Password</label><input id="user-password" maxlength="10" name="password" type="password" value="" tabindex="2" /></td>
              </tr>
    
              <tr>
                  <td align="right" valign="middle">Type:</td>
                  <td align="left" valign="top">
        
                    <table>
                        <tr>
                            <td nowrap>Agent</td>
                            <td nowrap><input type="Radio" name="LoginType" value="Agent" checked="Yes" tabindex="3"></td>
                            <td align="center" nowrap>or</td>
                            <td nowrap>Admin</td>
                            <td nowrap><input type="Radio" name="LoginType" value="Admin" tabindex="4"></td>
                        </tr>
                    </table>
        
        
                    </td>
              </tr>
    
            <tr>
                <td colspan="2" align="center"><input  name="Button" type="Submit" class="backbutton" value="Login" tabindex="5"></td>
            </tr>
    
            </table>
		</form>

	</cfif>

  </div>
</td>
</tr>
</table>


<cfinclude template="components/footer.cfm">
