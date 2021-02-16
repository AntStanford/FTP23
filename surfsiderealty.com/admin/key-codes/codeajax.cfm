<cfdump var='#url#'>

<cfif isdefined('url.id') and isdefined('url.code')>
  
  <cfquery name="Insert" datasource="#settings.dsn#">
    Insert into cms_key_codes (intquotenum,keycode,createdat)
    values(
      <cfqueryparam value="#url.id#" cfsqltype="cf_sql_varchar">,
      <cfqueryparam value="#url.code#" cfsqltype="cf_sql_varchar">,
      <cfqueryparam value="#now()#" cfsqltype="cf_sql_date">
      )
  </cfquery>

</cfif>