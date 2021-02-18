<!---
	Use this file to as needed based on your project and PMS

	Examples below are for the demo site, which uses Escapia
--->
<cfoutput>
<cfif settings.booking.pms eq 'Escapia'>

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

	<!--- Must Have - quick search --->
	<cfif isdefined('session.booking.must_haves') and ListLen(session.booking.must_haves)>

		<cfif ListFind(session.booking.must_haves,'Pet Friendly')>
			and escapia_properties.petsallowedcode = 'Pets Allowed'
		</cfif>

		<cfif ListFind(session.booking.must_haves,'Condominium')>
			and escapia_properties.unitcategory = 'Condominium'
		</cfif>

		<cfif ListFind(session.booking.must_haves,'Oceanfront')>
			and escapia_properties.unitcode IN (select distinct unitcode from escapia_amenities where categoryvalue = 'Oceanfront')
		</cfif>

		<cfif ListFind(session.booking.must_haves,'Cable TV')>
			and escapia_properties.unitcode IN (select distinct unitcode from escapia_amenities where categoryvalue = 'Cable TV')
		</cfif>

	</cfif>

	<!--- Amenities - Refine Search --->
	<cfif isdefined('session.booking.amenities') and ListLen(session.booking.amenities)>

		and escapia_properties.unitcode IN (select distinct unitcode from escapia_amenities where
		<cfset tempcounter = 1>
		<cfloop list="#session.booking.amenities#" index="i">
			 categoryvalue = <cfqueryparam cfsqltype="cf_sql_varchar" value="#i#"><cfif tempcounter lt listlen(session.booking.amenities)> OR </cfif>
			 <cfset tempcounter += 1>
		</cfloop>
		)

	</cfif>

	<!--- More Filters->Unit Type filter on search results --->
	<cfif isdefined('session.booking.type') and ListLen(session.booking.type)>
		and escapia_properties.unitCategory IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#session.booking.type#" list="Yes">)
	</cfif>

	<!--- More Filters->View filter on search results --->
	<cfif isdefined('session.booking.view') and ListLen(session.booking.view)>
		and escapia_properties.unitcode IN
			(
			select distinct unitcode from escapia_amenities where category = 'LOCATION_TYPE' and categoryvalue IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#session.booking.view#" list="Yes">)
			)
	</cfif>

	<!--- Specials search results page --->
	<cfif isdefined('session.specialid') and session.specialid gt 0>

		<cfquery name="getProperties" dataSource="#settings.dsn#">
			select unitcode from cms_specials_properties where specialID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#session.specialid#">
			and active = 'yes'
		</cfquery>

		<cfif getProperties.recordcount gt 0>
			and escapia_properties.unitcode IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#ValueList(getProperties.unitcode)#" list="Yes">)
		</cfif>

	</cfif>

	<!--- More Filters->Area filter on search results --->
	<!--- code this as needed per client --->


<cfelseif settings.booking.pms eq 'Barefoot'>

	<!---and bf_properties.propertyid IN ( select distinct strpropid from cms_property_enhancements where showonsite = 'yes')--->
	<!--- Guests filter on search results --->
	<cfif isdefined('session.booking.sleeps') and isvalid("integer",session.booking.sleeps) and session.booking.sleeps gt 0>
		and bf_properties.propertyid IN (
		select distinct propertyid from bf_property_amenities where aid='a53' AND cast(amenityvalue AS INTEGER) >= <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#session.booking.sleeps#">)
	</cfif>

	<!--- Bedrooms filter on quick search and search results --->
	<cfif isdefined('session.booking.bedrooms') and session.booking.bedrooms neq ''>

		<cfif session.booking.bedrooms contains ','> <!--- refine search --->

			<cfset theMinBed = ListFirst(session.booking.bedrooms)>
      		<cfset theMaxBed = ListLast(session.booking.bedrooms)>

		<cfelseif session.booking.bedrooms gte 0> <!--- quick search --->

			<cfset theMinBed = session.booking.bedrooms>
      		<cfset theMaxBed = settings.booking.maxBed>

		</cfif>

		and bf_properties.propertyid IN
		( select distinct propertyid from bf_property_amenities where aid='a56' and cast(amenityvalue AS INTEGER) >= <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#session.booking.bedrooms#">)
<!---between #theMinBed# and #theMaxBed#--->
	</cfif>

	<!--- Must Have - quick search - change this as needed per project --->
	<cfif isdefined('session.booking.must_haves') and ListLen(session.booking.must_haves)>

		<cfif ListFind(session.booking.must_haves,'Pet Friendly')>
			and bf_properties.petsAllowed = -1
		</cfif>

		<cfif ListFind(session.booking.must_haves,'Condominium')>
			and bf_properties.unitType = 'Condominium'
		</cfif>

		<cfif ListFind(session.booking.must_haves,'Oceanfront')>
			and bf_properties.view = 'Oceanfront'
		</cfif>

		<cfif ListFind(session.booking.must_haves,'Cable TV')>
			and bf_properties.propertyid IN
				( select distinct propertyid from bf_property_amenities where amenityvalue = 'Cable TV' )
		</cfif>

	</cfif>

	<!--- Amenities - Refine Search --->
	<cfif isdefined('session.booking.amenities') and listlen(session.booking.amenities)>

	   <!---and bf_properties.propertyid IN ( select distinct propertyid from bf_property_amenities where name IN

		   (
		   <cfset amenityCounter = 1>
		   <cfloop list="#session.booking.amenities#" index="i">
		   	 '<cfoutput>#i#</cfoutput>'<cfif amenityCounter lt listlen(session.booking.amenities)>,</cfif>
		   	 <cfset amenityCounter = amenityCounter + 1>
		   </cfloop>
		   )

	   )--->
	   	and bf_properties.propertyid IN (SELECT distinct bfa.propertyid FROM bf_property_amenities bfa
	   	where 1=1
	   	<cfloop list="#session.booking.amenities#" item="eachAmenity">
	   		and
	   		bfa.propertyid IN(
	   			SELECT distinct  propertyid FROM bf_property_amenities where aid = '#eachAmenity#' and amenityvalue = -1
	   		)
	   	</cfloop>
	   	)

		<!---and bf_properties.propertyid IN (SELECT bfa.propertyid FROM bf_property_amenities bfa where 1=1--->
										<!---<cfif ListFindNoCase("Community Pool,Private Pool,Hot Tub,Pets Allowed,No Pets Allowed,Screened Porch,Pool Heat,Free Wifi,Ground Level,Wheelchair Accessible",amenity)>
											and bfa.name = <cfqueryparam value="#amenity#" cfsqltype="cf_sql_varchar"> and bfa.amenityvalue = -1
										<cfelseif ListFindNoCase("Fireplace,Elevator",amenity)>
											and bfa.name = "#amenity# Available for Guest" and bfa.amenityvalue = -1
										<cfelseif ListFindNoCase("Boat Dock,Fishing Pier",amenity)>
											and bfa.name = <cfqueryparam value="#amenity#" cfsqltype="cf_sql_varchar"> and bfa.amenityvalue != ''
										<cfelseif ListFindNoCase("Special Events",amenity)>
											and bfa.name = "Allows Special Events" and bfa.amenityvalue = -1
										<cfelseif ListFindNoCase("Beach Gear Credit",amenity)>
											and bfa.name = "Beach Gear Offered" and bfa.amenityvalue = "Yes"
										<cfelseif ListFindNoCase("Virtual Tour",amenity)>
											and bfa.name = "Matterport Tour" and bfa.amenityvalue != ''
										<cfelseif ListFindNoCase("Semi-Private Pool",amenity)>
											and bfa.amenityvalue = "Semi-Private Pool"
										</cfif>--->
										 <!---WHERE cms.title = <cfqueryparam value="#amenity#" cfsqltype="cf_sql_varchar">
											   <cfif amenity EQ "## Video Streaming Devices">
												 AND bfa.amenityValue > 0
											   <cfelseif ListFindNoCase("Community Pool,Community Tennis Court,Fireplace",amenity)>
												 AND bfa.amenityvalue != ''
											   <cfelse>
												 AND bfa.amenityvalue = -1
											   </cfif>--->


											<!---and bfa.aid = <cfqueryparam value="#amenity#" cfsqltype="cf_sql_varchar"> and bfa.amenityvalue = -1--->



											<!--- bfa.aid IN (<cfqueryparam cfsqltype="cf_sql_varchar" list ="true" value="#session.booking.amenities#">) and bfa.amenityvalue = -1 --->

	  <!--- ) --->
	</cfif>

	<!--- propMapAreas - property map page --->
	<cfif isdefined('session.booking.propMapAreas') and listlen(session.booking.propMapAreas) and not listFindNoCase(session.booking.propMapAreas, 'all')>
	   	and bf_properties.propertyid IN (SELECT distinct bfa.propertyid FROM bf_property_amenities bfa
	   	where 11=11 and (
	   	<cfloop list="#session.booking.propMapAreas#" item="thisArea">
	   		bfa.propertyid IN(
	   			SELECT distinct  propertyid FROM bf_property_amenities where aid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#thisArea#"> and amenityvalue = -1
	   		) <cfif thisArea is not  listLast(session.booking.propMapAreas)> OR </cfif>
	   	</cfloop>
	   	))
	</cfif>

	<cfif isdefined('session.booking.properties') and ListLen(session.booking.properties)>
		and bf_properties.propertyid IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#session.booking.properties#" list="Yes">)
	</cfif>


	<!--- More Filters->Unit Type filter on search results --->
	<cfif isdefined('session.booking.type') and ListLen(session.booking.type)>
		and bf_properties.unitType IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#session.booking.type#" list="Yes">)
	</cfif>

	<!--- More Filters->View filter on search results --->
	<cfif isdefined('session.booking.view') and ListLen(session.booking.view)>
		and bf_properties.view IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#session.booking.view#" list="Yes">)
	</cfif>

	<cfif isdefined('session.booking.location') and ListLen(session.booking.location)>
		and bf_properties.propertyid IN
		( select distinct propertyid from bf_property_amenities where aid = 'a6' and amenityvalue IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#session.booking.location#" list="Yes">) )
	</cfif>

	<cfif isdefined('session.booking.Neighborhood') and ListLen(session.booking.Neighborhood)>
		and bf_properties.propertyid IN
		( select distinct propertyid from bf_property_amenities where amenityvalue IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#session.booking.Neighborhood#" list="Yes">) )
	</cfif>

	<!--- Specials search results page --->
	<cfif isdefined('session.booking.specialid') and session.booking.specialid gt 0>

		<cfquery name="getProperties" dataSource="#settings.dsn#">
			select unitcode from cms_specials_properties where specialID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#session.booking.specialid#">
			and active = 'yes'
		</cfquery>

		<cfif getProperties.recordcount gt 0>
			and bf_properties.propertyid IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#ValueList(getProperties.unitcode)#" list="Yes">)
		</cfif>

	</cfif>


<cfelseif settings.booking.pms eq 'Homeaway'>


	<!--- Guests --->
	<cfif isdefined('session.booking.sleeps') and isvalid("integer",session.booking.sleeps) and session.booking.sleeps gt 0>
		and intoccu >= <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#session.booking.sleeps#">
	</cfif>

	<!--- Bedrooms --->
	<cfif isdefined('session.booking.bedrooms') and session.booking.bedrooms neq ''>

		<cfif session.booking.bedrooms contains ','> <!--- refine search --->

			<cfset theMinBed = ListFirst(session.booking.bedrooms)>
      <cfset theMaxBed = ListLast(session.booking.bedrooms)>

		<cfelseif session.booking.bedrooms gt 0> <!--- quick search --->

			<cfset theMinBed = session.booking.bedrooms>
      <cfset theMaxBed = settings.booking.maxBed>

		</cfif>

		and pp_propertyinfo.dblbeds between <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#theMinBed#"> and <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#theMaxBed#">

	</cfif>

	<!--- Must Have - quick search - change this as needed per project --->
	<cfif isdefined('session.booking.must_haves') and ListLen(session.booking.must_haves)>

		<cfif ListFind(session.booking.must_haves,'Pet Friendly')>
			and pp_propertyinfo.featurelist like '%Pet Friendly%'
		</cfif>

		<cfif ListFind(session.booking.must_haves,'Condominium')>
			and pp_propertyinfo.strType = 'Condominium'
		</cfif>

		<cfif ListFind(session.booking.must_haves,'Oceanfront')>
			and pp_propertyinfo.strArea = 'Oceanfront'
		</cfif>

		<cfif ListFind(session.booking.must_haves,'Cable Tv')>
			and pp_propertyinfo.featurelist like '%Cable TV%'
		</cfif>

	</cfif>

	<!--- Price Range --->
	<cfif isdefined('session.booking.rentalRate') and session.booking.rentalRate contains ','>

		<cfset minRent = ListFirst(session.booking.rentalRate)>
		<cfset maxRent = ListLast(session.booking.rentalRate)>

		and pp_propertyinfo.strPropID in
		(
		select
			distinct strpropid
		from
			pp_season_rates
		where
			strchargebasis = 'Weekly'
		and
			dblrate between <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#minRent#"> and <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#maxRent#">
		)
	</cfif>

	<!--- Amenities - Refine Search --->
	<cfif isdefined('session.booking.amenities') and ListLen(session.booking.amenities)>
		and
		(
			<cfset counter = 1>
			<cfloop list="#session.booking.amenities#" index="i">
				featurelist like <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#i#"><cfif counter lt listlen(session.booking.amenities)> OR</cfif>
				<cfset counter = counter + 1>
			</cfloop>
		)
	</cfif>


	<!--- More Filters->Unit Type --->
	<cfif isdefined('session.booking.type') and ListLen(session.booking.type)>
		and pp_propertyinfo.strType IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#session.booking.type#" list="yes">)
	</cfif>

	<!--- Add query here for views depending on where client enters that info --->

	<!--- Specials search results page --->
	<cfif isdefined('session.specialid') and session.specialid gt 0>

		<cfquery name="getProperties" dataSource="#settings.dsn#">
			select unitcode from cms_specials_properties where specialID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#session.specialid#">
			and active = 'yes'
		</cfquery>

		<cfif getProperties.recordcount gt 0>
			and pp_propertyinfo.strpropid IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#ValueList(getProperties.unitcode)#" list="Yes">)
		</cfif>

	</cfif>


<cfelseif settings.booking.pms eq 'Streamline'>


	<!--- Guests --->
	<cfif isdefined('session.booking.sleeps') and isvalid("integer",session.booking.sleeps) and session.booking.sleeps gt 0>
		and max_occupants >= <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#session.booking.sleeps#">
	</cfif>

	<!--- Bedrooms --->
	<cfif isdefined('session.booking.bedrooms') and session.booking.bedrooms neq ''>

		<cfif session.booking.bedrooms contains ','> <!--- refine search --->

			<cfset theMinBed = ListFirst(session.booking.bedrooms)>
      <cfset theMaxBed = ListLast(session.booking.bedrooms)>

		<cfelseif session.booking.bedrooms gt 0> <!--- quick search --->

			<cfset theMinBed = session.booking.bedrooms>
      <cfset theMaxBed = settings.booking.maxBed>

		</cfif>

		and streamline_properties.bedrooms_number between #theMinBed# and #theMaxBed#

	</cfif>

	<!--- Must Haves OR More Filters->Amenities --->
	<cfif isdefined('session.booking.amenities') and ListLen(session.booking.amenities)>
		and streamline_properties.unit_id IN
		(
			select distinct unit_id from streamline_amenities where
			<cfset counter = 1>
			<cfloop list="#session.booking.amenities#" index="i">
			   amenity_name = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#i#">
				<cfif counter lt listlen(session.booking.amenities)> OR</cfif>
				<cfset counter = counter + 1>
			</cfloop>
		)
	</cfif>

	<!--- Price Range --->
	<cfif isdefined('session.booking.rentalRate') and session.booking.rentalRate contains ','>

		<cfset minRent = ListFirst(session.booking.rentalRate)>
		<cfset maxRent = ListLast(session.booking.rentalRate)>

		and streamline_properties.unit_id in
		(
		select
			distinct unit_id
		from
			streamline_rates
		where
			weekly_price between #minRent# and #maxRent#
		)
	</cfif>

	<!--- More Filters->Unit Type --->
	<cfif isdefined('session.booking.type') and ListLen(session.booking.type)>
		and streamline_properties.home_type IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#session.booking.type#" list="yes">)
	</cfif>

	<!--- More Filters->Area --->
	<cfif isdefined('session.booking.area') and ListLen(session.booking.area)>
		and streamline_properties.location_area_name IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#session.booking.area#" list="yes">)
	</cfif>

	<!--- Specials search results page --->
	<cfif isdefined('session.specialid') and session.specialid gt 0>

		<cfquery name="getProperties" dataSource="#settings.dsn#">
			select unitcode from cms_specials_properties where specialID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#session.specialid#">
			and active = 'yes'
		</cfquery>

		<cfif getProperties.recordcount gt 0>
			and streamline_properties.unit_id IN (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#ValueList(getProperties.unitcode)#" list="Yes">)
		</cfif>

	</cfif>

</cfif>
</cfoutput>