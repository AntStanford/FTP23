<cfif isdefined('url.id') and isnumeric(url.id) and isdefined('url.rating') and isnumeric(url.rating) and url.rating lte 5>
  
<cfquery name="GetEmail" datasource="#settings.dsn#">
  Select email,arrivaldate from cms_unifocus_reviews 
  where id = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
</cfquery>

<cfif GetEmail.recordcount eq 1>
  
  <cfquery name="UpdateRating" datasource="#settings.dsn#">
    Update cms_unifocus_reviews
    set rating = <cfqueryparam value="#url.rating#" cfsqltype="cf_sql_double">
    where email = <cfqueryparam value="#GetEmail.email#" cfsqltype="cf_sql_varchar">
    and arrivaldate = <cfqueryparam value="#GetEmail.arrivaldate#" cfsqltype="cf_sql_date">
  </cfquery>

  success

</cfif>


</cfif>