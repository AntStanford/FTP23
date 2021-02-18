<cfcomponent>
   <cffunction name="CheckQueryString" output="false" returntype="void">
      <cfargument name="query_string">
      <cfargument name="server_name">
      <cfargument name="ipaddress">

      <cfif
         arguments.query_string contains "information_schema"
         or
         arguments.query_string contains "concat"
         or
         arguments.query_string contains "group"
         or
         arguments.query_string contains "name_const"
      >
         <cftry>
            <cfquery name="insert" datasource="icnd_hosting">
               insert into securitycheck.seclog
               set
               query_string=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.query_string#">,
               server_name=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.server_name#">,
               ipaddress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.ipaddress#">
            </cfquery>
            <cfcatch>

            </cfcatch>
         </cftry>
         <cfabort>
      </cfif>
   </cffunction>
</cfcomponent>