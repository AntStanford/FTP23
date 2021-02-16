<cftry>
   <cfcache action="flush" key="cms_long_term_rentals">
   <cfcatch></cfcatch>
</cftry>

<!--- On page variables --->
<!--- <cfset uppicture = #ExpandPath('/images/longtermrentals')#> --->
<cfset table = 'cms_long_term_rentals'>



<!--- Deleting an uploaded photo --->
<cfif isdefined('url.id') and isdefined('url.delete')>
  
    
  
  <!--- Finally, delete the property ---> 
  <cfquery dataSource="#settings.dsn#">
    delete from #table# where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>
  
  
  <cflocation addToken="no" url="index.cfm?success">







<!--- Update Existing Record --->  
<cfelseif isdefined('form.id')>

   
    <cfquery dataSource="#settings.dsn#">
      update #table# set
      name = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">,
      address1 = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.address1#">,
      address2 = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.address2#">,  
      beds = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.beds#">,
      baths = <cfqueryparam CFSQLType="CF_SQL_DOUBLE" value="#form.baths#">,
        <cfif form.rate eq ''>
          rate = <cfqueryparam CFSQLType="CF_SQL_DOUBLE" value="0">,
        <cfelse>
          rate = <cfqueryparam CFSQLType="CF_SQL_DOUBLE" value="#form.rate#">,
        </cfif>
      description = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.description#">,
      city = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.city#">,
      state  = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.state#">,
      zip  = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.zip#">,
      furnished  = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.furnished#">,
      community  = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.community#">,
      longitude  = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.longitude#">,
      latitude  = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.latitude#">
      where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
    </cfquery>       
    
    <cflocation addToken="no" url="form.cfm?id=#id#&success"> 


<!--- Add New Record --->    
<cfelse>  	

     
    <cfquery dataSource="#settings.dsn#">
      insert into #table#(name,address1,address2,beds,baths,rate,description,city,state,zip,furnished,community,longitude,latitude) 
      values(
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.address1#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.address2#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.beds#">,
        <cfqueryparam CFSQLType="CF_SQL_DOUBLE" value="#form.baths#">,
          <cfif form.rate eq ''>
            <cfqueryparam CFSQLType="CF_SQL_DOUBLE" value="0">,
          <cfelse>
            <cfqueryparam CFSQLType="CF_SQL_DOUBLE" value="#form.rate#">,
          </cfif>
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.description#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.city#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.state#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.zip#">,
        <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.furnished#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.community#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.longitude#">,
        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.latitude#">
        )
    </cfquery>
    
        
    <cflocation addToken="no" url="form.cfm?success"> 
  
  
</cfif>  



       




