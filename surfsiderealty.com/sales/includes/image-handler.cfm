<!---
<cfif mls.MLSID is "7" or mls.MLSID is "3" or mls.MLSID is "4" or mls.MLSID is "2">
  <!--- Hilton Head MLS --->
	<cfset HowManyPhotos = "#listlen(GetListings.photo_link)#">
	<cfif listlen(GetListings.photo_link) gt 1>
		<cfset ThePhoto = "#listgetat(GetListings.photo_link,'1')#">
		<cfset AllPhotos = "#ListDeleteAt(GetListings.photo_link,'1')#">
			<cfelse>
		<cfset ThePhoto = "#GetListings.photo_link#">
		<cfset AllPhotos = "">
	</cfif>
<cfelse>
  <!--- Suitable for most Rets --->
	<cfquery name="GetImage" datasource="#RetsImages#">
		Select path
		from #ImageTableName#
		where mlnumber = '#mlsnumber#'
		order by `Index`
	</cfquery>
	<cfset HowManyPhotos = "#GetImage.recordcount#">
	<cfset ThePhoto = "#GetImage.path#">
	<cfquery name="GetImage" datasource="#RetsImages#">
		Select path
		from #ImageTableName#
		where mlnumber = '#mlsnumber#'
		order by `Index`
		limit 2,999
	</cfquery>
	<cfset AllPhotos = "#valuelist(GetImage.path)#">
</cfif>
  --->
<cfif mls.MLSID is "7" or mls.MLSID is "3" or mls.MLSID is "4" or mls.MLSID is "2" or mls.mlsid is "17">
  <!--- Hilton Head MLS --->
	<cfset HowManyPhotos = "#listlen(GetListings.photo_link)#">
	<cfif listlen(GetListings.photo_link) gt 1>
		<cfset ThePhoto = "#listgetat(GetListings.photo_link,'1')#">
		<cfset AllPhotos = "#ListDeleteAt(GetListings.photo_link,'1')#">
			<cfelse>
		<cfset ThePhoto = "#GetListings.photo_link#">
		<cfset AllPhotos = "">
	</cfif>
<cfelse>
  <!--- Suitable for most Rets --->
	<cfquery name="GetImage" datasource="#RetsImages#">
		Select path
		from rets20.#ImageTableName#
		where mlnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value="#mlsnumber#">
		order by `Index`
	</cfquery>
	<cfset HowManyPhotos = "#GetImage.recordcount#">
	<cfset ThePhoto = "#GetImage.path#">
	<cfquery name="GetImage" datasource="#RetsImages#">
		Select path
		from rets20.#ImageTableName#
		where mlnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value="#mlsnumber#">
		order by `Index`
		limit 2,999
	</cfquery>
	<cfset AllPhotos = "#valuelist(GetImage.path)#">
</cfif>

