<cfif isdefined('url.clientid') and isdefined('url.searchid')>
  <cfset transGif = "#expandpath('/sales/images/dot.gif')#">
  <cfparam name="url.opened" default="0">
  <cfset decryptedID = DEcryptID(#searchid#)>
  <cfset decryptedClientID = DecryptID(#clientid#)>
  <CFQUERY NAME="UpdateQuery" DATASOURCE="#mls.dsn#">
    UPDATE cl_saved_searches_props_returned
    SET 
      opened='Yes',
      dateopened = <cfqueryparam value="#now()#" cfsqltype="CF_SQL_TIMESTAMP">
    where clientid = <cfqueryparam value="#decryptedClientID#" cfsqltype="CF_SQL_NUMERIC"> and searchid = <cfqueryparam value="#decryptedID#" cfsqltype="CF_SQL_NUMERIC"> and datenotified = <cfqueryparam value="#datenotified#" cfsqltype="CF_SQL_DATE">
  </cfquery>
  


  <!---START: INSERT INTO ACTIVITES FOR TRACKING--->
  <cfquery datasource="#mls.dsn#" dbtype="ODBC">
    Insert
    Into cl_activity
      (clientid,RefferingSite,Action,ActionID)
    Values
      (<cfqueryparam value="#decryptedClientID#" cfsqltype="CF_SQL_VARCHAR">,
       <cfif isdefined('session.referringsite')><cfqueryparam value="#session.referringsite#" cfsqltype="CF_SQL_LONGVARCHAR"><cfelse>'N/A'</cfif>,
       <cfqueryparam value="Enotify Opened - #searchname#" cfsqltype="CF_SQL_VARCHAR">,
       <cfqueryparam value="#decryptedID#" cfsqltype="CF_SQL_VARCHAR">
      )
  </cfquery>
  


  <!---START: INSERT INTO ACTIVITES FOR TRACKING--->
  <cfcontent type="image/gif" file="#transGif#"> 
</cfif>