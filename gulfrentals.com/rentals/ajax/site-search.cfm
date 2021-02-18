<cfif isdefined('url.keywords') and LEN(url.keywords) gte 3>
  <cfquery datasource="#settings.booking.dsn#" name="getProperties">
    Select name,seopropertyname,propertyid,propAddress
    From bf_properties
    Where name LIKE <cfqueryparam value="%#url.keywords#%" cfsqltype="cf_sql_varchar">
    or propaddress LIKE <cfqueryparam value="%#url.keywords#%" cfsqltype="cf_sql_varchar">
    <!---or city LIKE <cfqueryparam value="%#url.keywords#%" cfsqltype="cf_sql_varchar">--->
    or propertyid LIKE <cfqueryparam value="%#url.keywords#%" cfsqltype="cf_sql_varchar">
  </cfquery>
  <!---<cfquery datasource="#settings.booking.dsn#" name="getPages">
    Select name,slug
    From cms_pages
    Where name LIKE <cfqueryparam value="%#url.keywords#%" cfsqltype="cf_sql_varchar">
    or metatitle LIKE <cfqueryparam value="%#url.keywords#%" cfsqltype="cf_sql_varchar">
    or body LIKE <cfqueryparam value="%#url.keywords#%" cfsqltype="cf_sql_varchar">
  </cfquery>--->
  <cfif getProperties.recordcount eq 0 <!---and getPages.recordcount eq 0---> >
    <span class="title">Sorry, there no matching results.</span>
  <cfelse>
    <cfif getProperties.recordcount GT 0>
      <span class="title">Property Results</span>
      <cfoutput query="getProperties"><a href="/#settings.booking.dir#/#seopropertyname#">#name#, #propAddress#</a></cfoutput>
    </cfif>
    <!---<cfif getPages.recordcount GT 0>
      <span class="title">Pages Results</span>
      <cfoutput query="getPages"><a href="/#slug#">#name#</a></cfoutput>
    </cfif>--->
  </cfif>
<cfelse>
  <span class="title">Keeping typing...</span>
</cfif>