<cfset originalPath = #ExpandPath('/images/resorts')#>

<!--- Delete --->
<cfif isdefined('url.photo') and isdefined('url.photoid')> 
 
  <cfif FileExists('#originalPath#/#url.photo#')><cffile action="delete" file="#originalPath#/#url.photo#"></cfif>   
   
  <cfquery dataSource="#settings.dsn#">
    delete from cms_assets where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.photoid#">
  </cfquery>
  
  <cflocation addToken="no" url="index.cfm?deletephoto">
  
</cfif>  
       




