<!---
	Use this file to as needed based on your project and PMS

	Examples below are for the demo site, which uses Escapia
--->
<cfoutput>

	<!--- Guests filter on search results --->
	<cfif isdefined('session.booking.sleeps') and isvalid("integer",session.booking.sleeps) and session.booking.sleeps gt 0>
  		and maxoccupancy >= <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#session.booking.sleeps#">
	</cfif>

	<!--- Bedrooms filter on quick search and search results --->
	<cfif isdefined('session.booking.bedrooms') and session.booking.bedrooms neq ''>
	  <cfif session.booking.bedrooms contains ','> <!--- refine search --->
	    <cfset theMinBed = ListFirst(session.booking.bedrooms)>
	    <cfset theMaxBed = ListLast(session.booking.bedrooms)>
	    and escapia_properties.bedrooms between <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#theMinBed#"> and <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#theMaxBed#">
	  <cfelseif session.booking.bedrooms gt 0> <!--- quick search --->
	    <cfset theMinBed = session.booking.bedrooms>
	    <cfset theMaxBed = settings.booking.maxBed>
	    and escapia_properties.bedrooms between <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#theMinBed#"> and <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#theMaxBed#">
	  </cfif>
	</cfif>

	<cfif isdefined('session.booking.bathrooms') and session.booking.bathrooms neq ''>
	  <cfif session.booking.bathrooms contains ','> <!--- refine search --->
	    <cfset theMinBath = ListFirst(session.booking.bathrooms)>
	    <cfset theMaxBath = ListLast(session.booking.bathrooms)>
	    and escapia_properties.bathrooms between <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#theMinBath#"> and <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#theMaxBath#">
	  <cfelseif session.booking.bedrooms gt 0> <!--- quick search --->
	    <cfset theMinBath = session.booking.bathrooms>
	    <cfset theMaxBath = settings.booking.maxBath>
	    and escapia_properties.bedrooms between <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#theMinBath#"> and <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#theMaxBath#">
	  </cfif>
	</cfif>


	<!--- Amenities - Refine Search --->
	<cfif isdefined('session.booking.amenities') and ListLen(session.booking.amenities)>

    <cfloop list="#session.booking.amenities#" index="i">
      AND escapia_properties.unitcode IN (SELECT distinct unitcode 
                                          FROM escapia_amenities 
                                          WHERE <cfif i EQ "WiFi">
                                                 		 categoryvalue = 'High Speed Internet'
                                                 <cfelseif i EQ "Pool Heat Available">
                                                     categoryvalue LIKE '%Heated Pool%'
                                                 <cfelseif i EQ "Pet Friendly w/ Fee">
                                                     category = 'PET FRIENDLY' AND categoryvalue = 'FEES APPLY'
                                                 <cfelse>
                                                   categoryvalue = <cfqueryparam cfsqltype="cf_sql_varchar" value="#i#">
                                                 </cfif>
                                                )
    </cfloop>

	</cfif>

	<!--- Custom Search Results Properties --->
	<cfif isdefined('session.booking.properties') and ListLen(session.booking.properties)>

		AND escapia_properties.unitcode IN (<cfqueryparam value="#session.booking.properties#" cfsqltype="cf_sql_varchar" list="yes">)

	</cfif>

	<!--- More Filters->Unit Type filter on search results --->
	<cfif isdefined('session.booking.type') and ListLen(session.booking.type)>
		and escapia_properties.unitCategory IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#session.booking.type#" list="Yes">)
	</cfif>

	<!--- More Filters->location filter on search results --->
	<cfif isdefined('session.booking.location') and ListLen(session.booking.location)>
		and escapia_properties.cityname IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#session.booking.location#" list="Yes">)
	</cfif>

	<!--- More Filters->View filter on search results --->
	<cfif isdefined('session.booking.area') and ListLen(session.booking.area)>
		and escapia_properties.unitcode IN
			(
			SELECT distinct unitcode 
      FROM escapia_amenities 
      WHERE category = 'Location' 
            AND categoryvalue IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#session.booking.area#" list="Yes">)
			)
	</cfif>

	<cfif isdefined('session.booking.complex') and ListLen(session.booking.complex)>
		and escapia_properties.unitcode IN
			(
			SELECT distinct unitcode 
      FROM escapia_amenities 
      WHERE category = 'complex' 
            AND categoryvalue IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#session.booking.complex#" list="Yes">)
			)
	</cfif>

	<cfif isdefined('session.booking.monthlyRentals') and session.booking.monthlyRentals EQ "Yes">
		and escapia_properties.unitcode IN
			(
			SELECT distinct unitcode 
      FROM escapia_amenities 
      WHERE category = 'Monthly Rentals' 
            AND categoryvalue LIKE '%Yes%'
			)
	</cfif>

	<cfif isdefined('session.booking.nightlyRentals') and session.booking.nightlyRentals EQ "Yes">
		and escapia_properties.unitcode IN
			(
			SELECT distinct unitcode 
      FROM escapia_amenities 
      WHERE category = 'Nightly Rentals' 
            AND categoryvalue LIKE '%Yes%'
			)
	</cfif>

	<!--- Specials search results page --->
	<cfif isdefined('session.booking.specialid') and session.booking.specialid gt 0>

		<cfquery name="getProperties" dataSource="#settings.dsn#">
			select unitcode from cms_specials_properties where specialID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#session.booking.specialid#">
			and active = 'yes'
		</cfquery>

		<cfif getProperties.recordcount gt 0>
			and escapia_properties.unitcode IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#ValueList(getProperties.unitcode)#" list="Yes">)
		</cfif>

	</cfif>

	<!--- More Filters->Area filter on search results --->
	<!--- code this as needed per client --->


</cfoutput>