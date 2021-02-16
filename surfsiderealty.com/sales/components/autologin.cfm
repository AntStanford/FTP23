<!--- START: AUTO LOGIN CODE --->
<cftry>
<cfif isdefined('url.subscriber') and isdefined('url.accesskey')>

    <cfif url.subscriber eq DecryptEmail(url.accesskey)>

        <cfquery name="GetEmailAccount" datasource="#mls.dsn#">
            select firstname,lastname,email,phone,id
            from cl_accounts
            where email = <cfqueryparam value="#url.subscriber#" cfsqltype="CF_SQL_VARCHAR">
            LIMIT 1
        </cfquery>

        <cfif GetEmailAccount.recordcount eq 1>
            <!--- first delete any cookie/session --->
            <cfset structdelete(session,"USERFirstName",true)>
            <cfset structdelete(cookie,"USERFirstName",true)>   
            <cfset structdelete(session,"USERLastName",true)>
            <cfset structdelete(cookie,"USERLastName",true)>    
            <cfset structdelete(session,"USEREmail",true)>
            <cfset structdelete(cookie,"USEREmail",true)>   
            <cfset structdelete(session,"USERPhone",true)>
            <cfset structdelete(cookie,"USERPhone",true)>   
            <cfset structdelete(session,"LoggedIn",true)>
            <cfset structdelete(cookie,"LoggedIn",true)>
            <!--- now set new user  --->
            <cfcookie name="USERFirstName" value="#GetEmailAccount.firstname#" expires="#LoginCookiePersist#">
            <cfcookie name="USERLastName" value="#GetEmailAccount.lastname#" expires="#LoginCookiePersist#">
            <cfcookie name="USEREmail" value="#GetEmailAccount.email#" expires="#LoginCookiePersist#">
            <cfcookie name="USERPhone" value="#GetEmailAccount.phone#" expires="#LoginCookiePersist#">
            <cfcookie name="LoggedIn" value="#GetEmailAccount.id#" expires="#LoginCookiePersist#">


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

                
        </cfif>

    </cfif>
    
</cfif>
<cfcatch>
</cfcatch>
</cftry>
<!--- END: AUTO LOGIN CODE --->


