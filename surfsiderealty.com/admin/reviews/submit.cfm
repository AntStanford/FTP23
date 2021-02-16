<!--- Flush the cache if it exists --->
<cftry> 
     <cfcache action="flush" key="be_reviews">
     <cfcatch></cfcatch> 
</cftry>

<!--- On page variables --->
<cfset table = 'be_reviews'>

<!--- Delete --->
<cfif isdefined('url.id') and isdefined('url.delete')>
       
  <cfquery dataSource="#settings.dsn#">
    delete from #table# where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>
  
  <!--- delete any review responses --->
  <cfquery datasource="#settings.dsn#">
  	delete from be_responses_to_reviews where reviewid = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
  </cfquery>
  
  <cflocation addToken="no" url="index.cfm?delete">


<!--- Update Existing Record --->  
<cfelseif isdefined('url.id') and isdefined('url.approve')>
  
  <cfquery dataSource="#settings.dsn#">
    update #table# 
    set approved = 'Yes'
    where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>
  
  <cflocation addToken="no" url="index.cfm?success">

<!--- Update Existing Record --->  
<cfelseif isdefined('url.id') and isdefined('url.unapprove')>
  
  <cfquery dataSource="#settings.dsn#">
    update #table# 
    set approved = 'No'
    where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>
  
  <cflocation addToken="no" url="index.cfm?successunapprove">

<cfelse>
   
   <!--- Adding a new review --->
   
   <cfquery dataSource="#settings.dsn#">
      insert into #table#(firstname,lastname,email,checkInDate,checkOutDate,title,review,unitcode,approved,rating,hometown) 
      values(
         <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.firstname#">,
         <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.lastname#">,
         <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.email#">,
         <cfqueryparam CFSQLType="CF_SQL_DATE" value="#form.checkInDate#">,
         <cfqueryparam CFSQLType="CF_SQL_DATE" value="#form.checkOutDate#">,
         <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.title#">,
         <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.review#">,
         <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.propertyid#">,
         'Yes',
         <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.rating#">,
         <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.hometown#">
      )
   </cfquery>
   
   <cflocation addToken="no" url="form.cfm?success">
  
</cfif>  
       




