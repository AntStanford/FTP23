<cfif isdefined('url.slug') and len(url.slug)>

	<cfset errorMessage = ''>
	<cfparam name="isavailable" default="false">
	
	<!--- set a cookie to store the recently viewed properties --->
	<cfif NOT StructKeyExists(cookie,'recent')>
  	<cfcookie name="recent" expires="never">
	</cfif>
	
	<!--- Get basic property information --->
	<cfset property = application.bookingObject.getProperty('',url.slug)>
	
	<cfif property.recordcount gt 0>
	
		<!--- Add this property to cookie.recent if it has not already been added --->
		<cfif len(cookie.recent)>
      <cfif ListFind(cookie.recent,property.propertyid)>
        <cfcookie name="recent" value="#ListDeleteAt(cookie.recent,ListFind(cookie.recent,property.propertyid))#">
      </cfif>
      <cfcookie name="recent" value="#property.propertyid#,#cookie.recent#">
		<cfelse>
			<cfcookie name="recent" value="#property.propertyid#">
		</cfif>
		<!--- end cookie.recent section --->
			
		<!--- Grab the property reviews --->
		<cfset reviews = application.bookingObject.getPropertyReviews(property.propertyid)>
		<cfset numReviews = StructCount(reviews)>	
	
		<!--- Get min/max price range for this property, ex $1500 - $2500 per week --->
		<!--- <cfset priceRange = application.bookingObject.getPropertyPriceRange(property.propertyid)>	 --->
	
		<!--- function to get all property photos --->
		<cfset photos = application.bookingObject.getPropertyPhotos(property.propertyid)>


		<!--- function to get the average star rating from the be_reviews table --->
		<cfquery name="getAvgRating" dataSource="#settings.booking.dsn#">
			select avg(rating) as average from be_reviews where unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#property.propertyid#">
		</cfquery>
		
		<cfif 
			isdefined('session.booking.strcheckin') and 
			len(session.booking.strcheckin) and 
			isdefined('session.booking.strcheckout') and 
			len(session.booking.strcheckout) and
			cgi.HTTP_USER_AGENT does not contain 'bot'>
			
			<!--- make an API call to check availability and retrieve summary of fees --->			
			<cfset apiresponse = application.bookingObject.getDetailRates(property.propertyid,session.booking.strcheckin,session.booking.strcheckout)>
					
		</cfif>

		<!--- Log the user's visit --->
		<cfinclude template="_log-property-view.cfm">
	
	<cfelse>
		<cfset noproperty = true>
   	
   	<cfquery datasource="#settings.dsn#">
		insert into notfound(thepage,thereferer,remoteip)
		values(             
			<cfqueryparam value="#settings.booking.dir#/#url.slug#" cfsqltype="CF_SQL_LONGVARCHAR">,
			<cfqueryparam value="#CGI.HTTP_REFERER#" cfsqltype="CF_SQL_LONGVARCHAR">,
			<cfqueryparam value="#CGI.REMOTE_ADDR#" cfsqltype="CF_SQL_LONGVARCHAR">
		)
		</cfquery> 
		
	</cfif>

<cfelse>
  You cannot access this page without a property ID.
  <cfabort>
</cfif>