<cfif isdefined('form.propertyid')>
  
   <!--- Does the propertyid exist? --->
   <cfquery name="propertyidcheck" dataSource="#settings.dsn#">
      select propertyid from flipkey_property_ids where propertyid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.propertyid#">
      and siteID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#settings.id#">
   </cfquery>
   
   <cfif propertyidcheck.recordcount eq 0>
      
      <cfquery dataSource="#settings.dsn#">
         insert into flipkey_property_ids(propertyid,flipkeyid,siteID) 
         values(
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.propertyid#">,
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.flipkeyid#">,
            <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#settings.id#">
            )
      </cfquery>
      
   <cfelse>
      
      <cfquery dataSource="#settings.dsn#">
         update flipkey_property_ids set 
         flipkeyid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.flipkeyid#">
         where propertyid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.propertyid#">	
         and siteID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#settings.id#">
      </cfquery>
   
   </cfif>    
   
   <cflocation addToken="no" url="index.cfm?success">

</cfif> 
  
