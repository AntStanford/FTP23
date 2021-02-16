<cfinclude template="../application.cfm">

<!--- Admin Global Settings --->
<cfset dsn = settings.dsn>
<cfset application.dsn = settings.dsn>

<cfapplication name="surfsiderealty2018Admin" clientmanagement="Yes" sessionmanagement="Yes" sessiontimeout="#sessiontimeout#" setDomainCookies="Yes">

<cfset application.contactInfoEncryptKey = "5CX4EsJrtDI3fGiK3TncNw==">

<cfif NOT IsDefined('getCount')>
    <cffunction name="getCount" returnType="string">

      <cfargument name="table" hint="Name of the database table" required="true" type="string">

      <cfif left(table,3) eq "be_">

         <cfquery name="returnCount" dataSource="#settings.bcDSN#">
           select count(id) as 'numrows' from #table# where siteid = <cfqueryparam cfsqltype="cf_sql_integer" value="#settings.id#">
         </cfquery>

      <cfelse>

         <cfquery name="returnCount" dataSource="#settings.dsn#">
           select count(id) as 'numrows' from #table#
         </cfquery>

      </cfif>

      <cfreturn returnCount.numrows>

    </cffunction>
</cfif>

<cfif NOT IsDefined('checkLoggedInUserSecurity')>
    <cffunction name = "checkLoggedInUserSecurity">

        <cfif isDefined('session.loggedInUserStruct')>

            <cfreturn true>
        <cfelse>

            <cfreturn false>
        </cfif>

    </cffunction>
</cfif>

<cfinclude template="/cfformprotect/icndmailer/send-email.cfm">