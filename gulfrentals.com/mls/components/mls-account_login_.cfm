
<cfif cgi.request_method is "POST">

   <cfif trim(form.email) eq ''><cfset variables.e = variables.e & "<li>Email is a required field</li>"></cfif>
   <cfif trim(form.password) eq ''><cfset variables.e = variables.e & "<li>Password is a required field.</li>"></cfif>

   <cfif variables.e eq ''>

      <cfquery datasource="#application.settings.dsn#" name="CheckLogin">
       SELECT *
       FROM cl_accounts
       where email = <cfqueryparam cfsqltype="cfsql_varchar" value="#form.email#">
       and password = <cfqueryparam cfsqltype="cfsql_varchar" value="#form.password#">
     </cfquery>
     <cfif CheckLogin.recordcount gt 0>

         <cfif CheckLogin.active is "No">

            <cfset variables.e = "<li>Your account is no longer active.  Please email us at <a href='mailto:#adminemail#'>#adminemail#</a> to reactivate your account..</li>">

         <cfelse>
            <cfset theClientId = CheckLogin.id>
            <!--- Good Login --->
            <cfcookie name="USERFirstName" value="#CheckLogin.firstname#" expires="#LoginCookiePersist#">
            <cfcookie name="USERLastName" value="#CheckLogin.lastname#" expires="#LoginCookiePersist#">
            <cfcookie name="USEREmail" value="#CheckLogin.email#" expires="#LoginCookiePersist#">
            <cfcookie name="USERPhone" value="#CheckLogin.phone#" expires="#LoginCookiePersist#">
            <cfcookie name="loggedin" value="#CheckLogin.id#" expires="#LoginCookiePersist#">

            <cfquery datasource="#application.settings.dsn#" >
               Insert
               Into cl_activity
                 (clientid,RefferingSite,Action)
               values
                 (<cfqueryparam value="#TheClientID#" cfsqltype="CF_SQL_VARCHAR">,
                  <cfif isdefined('session.referringsite')><cfqueryparam value="#session.referringsite#" cfsqltype="CF_SQL_LONGVARCHAR"><cfelse>'N/A'</cfif>,
                  'Login'
                  )
            </cfquery>

            <cfinclude template="mls-account-update-cfidcftoken_.cfm">

            <cfif url.action2 eq "savesearch">
               <cflocation url="/#application.settings.mls.dir#/results?savesearch=" addtoken="false"><!--- removed .cfm --->
            <cfelse>
               <cflocation url="/#application.settings.mls.dir#/my-profile.cfm?action2=#url.action2#" addtoken="false">
            </cfif>
         </cfif>

      <cfelse>
         <cfset variables.e = "<li>Invalid Username or Password Entered</li>">
      </cfif>

   </cfif>
</cfif>

