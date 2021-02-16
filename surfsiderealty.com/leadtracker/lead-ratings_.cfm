<!---  Update or Add --->
 <cfif cgi.request_method eq 'post' and form.submit eq 'Edit'>

	<cfquery datasource="#mls.dsn#">
		Update cl_ratings
		Set rating = <cfqueryparam value="#form.ratingname#" cfsqltype="cf_sql_varchar">
		Where ID = <cfqueryparam value="#form.theid#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cflocation addtoken="false" url="lead-ratings.cfm">

 <cfelseif cgi.request_method eq 'post' and form.submit eq 'Add'>

	<cfquery datasource="#mls.dsn#">
		Insert into cl_ratings(rating)
		Values(<cfqueryparam value="#form.ratingname#" cfsqltype="cf_sql_varchar">)
	</cfquery>

	<cflocation addtoken="false" url="lead-ratings.cfm">

 </cfif>

 <cfif isdefined('url.id') and LEN(url.id) and isdefined('url.delete')>

	<cfquery datasource="#mls.dsn#">
		delete from cl_ratings
		Where ID = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
	</cfquery>

	<cflocation addtoken="false" url="lead-ratings.cfm">

 </cfif>

 <!--- Get Sources --->
<cfquery datasource="#mls.dsn#" name="getInfo">
	select *
	from cl_ratings
	<cfif isdefined('url.id') and LEN(url.id)>Where ID = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer"></cfif>
	order by rating
</cfquery>

