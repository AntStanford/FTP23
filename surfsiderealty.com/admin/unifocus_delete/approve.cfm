<cfset success = 'false'>

<cfif isdefined('url.id')>
	
	<cfset id = replace(replace(url.id,'approve',''),'remove','')>

	<cfif isNumeric(id)>

		<cfif isdefined('url.approve')>
		  <cfquery name="GetReviewDetailsToApprove" datasource="#settings.dsn#">
		    select * from cms_unifocus_reviews 
		    where ID = <cfqueryparam value="#id#" cfsqltype="cf_sql_integer"> 
		  </cfquery>
		  <cfquery name="ApproveReviews" datasource="#settings.dsn#">
		    Update cms_unifocus_reviews 
		    Set approved = 1
		    where email = <cfqueryparam value="#GetReviewDetailsToApprove.email#" cfsqltype="cf_sql_varchar"> 
		    and surveydate = <cfqueryparam value="#GetReviewDetailsToApprove.surveydate#" cfsqltype="cf_sql_date"> 
		  </cfquery>
		  <cfset success = id>
		<cfelseif isdefined('url.remove')>
		  <cfquery name="GetReviewDetailsToRemove" datasource="#settings.dsn#">
		    select * from cms_unifocus_reviews 
		    where ID = <cfqueryparam value="#id#" cfsqltype="cf_sql_integer"> 
		  </cfquery>
		  <cfquery name="RemoveReviews" datasource="#settings.dsn#">
		    Update cms_unifocus_reviews 
		    Set approved = 0
		    where email = <cfqueryparam value="#GetReviewDetailsToRemove.email#" cfsqltype="cf_sql_varchar"> 
		    and surveydate = <cfqueryparam value="#GetReviewDetailsToRemove.surveydate#" cfsqltype="cf_sql_date"> 
		  </cfquery>
		  <cfset success = id>
		</cfif>

	</cfif>

</cfif>

<cfoutput>#success#</cfoutput>