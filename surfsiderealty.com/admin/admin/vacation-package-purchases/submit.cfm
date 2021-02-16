<cfset table = 'vacation_package_additions'>

<cfif isdefined('form.id')> <!--- update statement --->
  
<cfif isdefined('form.processed')>
  <cfquery dataSource="#settings.dsn#">
    update #table# set 
    processed = 'Yes'
    where ConfirmationCode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.id#">
  </cfquery>  
</cfif>
  
  <cflocation addToken="no" url="form.cfm?id=#form.id#&success">

  
</cfif>