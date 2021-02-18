<cfcomponent>

<cffunction name="init" access="public" output="no">
   <cfargument name="settings" type="struct" required="yes">
   <cfset variables.settings = arguments.settings>
   <cfreturn this>
</cffunction>

<cffunction name="getFieldSettings">
   <cfargument name="siteid">

   <cfset var qFieldSettings = queryNew("")>

   <cfquery name="qFieldSettings" datasource="#application.settings.mls.propertydsn#">
      select
         field_lookups.id as fieldid,
         ifnull(fields.label,field_lookups.label) as customer_label,
         fields.display_on_advanced,
         fields.display_on_refine,
         fields.display_on_quick,
         fields.display_on_pdp,
         fields.display_on_results

      from field_lookups left join fields on field_lookups.id = fields.fieldid

   where

   fields.siteid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.siteid#">
   <!---and siteid=<cfqueryparam cfsqltype="cf_sql_integer" value="#settings.id#">--->
   </cfquery>

   <cfreturn qFieldSettings>

</cffunction>


<cffunction name="clabel">
   <cfargument name="fieldid">

   <cfset var ret = false>

   <cfset var qCheck = queryNew("")>

   <cfquery name="qCheck" dbtype="query">
      select customer_label
      from application.settings.mls.fieldsettings
      where
         fieldid = <Cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.fieldid#">

   </cfquery>

      <cfreturn qCheck.customer_label>

</cffunction>

<cffunction name="showOnAdvanced">
   <cfargument name="fieldid">

   <cfset var ret = false>

   <cfset var qCheck = queryNew("")>

   <cfquery name="qCheck" dbtype="query">
      select display_on_advanced
      from application.settings.mls.fieldsettings
      where
         fieldid = <Cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.fieldid#">

   </cfquery>

   <cfif qCheck.display_on_advanced eq 1>
      <cfreturn true>
   <cfelse>
      <cfreturn false>
   </cfif>
</cffunction>


<cffunction name="showOnRefine">
   <cfargument name="fieldid">

   <cfset var ret = false>

   <cfset var qCheck = queryNew("")>

   <cfquery name="qCheck" dbtype="query">
      select display_on_refine
      from application.settings.mls.fieldsettings
      where
         fieldid = <Cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.fieldid#">

   </cfquery>

   <cfif qCheck.display_on_refine eq 1>
      <cfreturn true>
   <cfelse>
      <cfreturn false>
   </cfif>
</cffunction>

<cffunction name="showOnResults">
   <cfargument name="fieldid">

   <cfset var ret = false>

   <cfset var qCheck = queryNew("")>

   <cfquery name="qCheck" dbtype="query">
      select display_on_results
      from application.settings.mls.fieldsettings
      where
         fieldid = <Cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.fieldid#">

   </cfquery>

   <cfif qCheck.display_on_results eq 1>
      <cfreturn true>
   <cfelse>
      <cfreturn false>
   </cfif>
</cffunction>

<cffunction name="showOnPDP">
   <cfargument name="fieldid">

   <cfset var ret = false>

   <cfset var qCheck = queryNew("")>

   <cfquery name="qCheck" dbtype="query">
      select display_on_pdp
      from application.settings.mls.fieldsettings
      where
         fieldid = <Cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.fieldid#">

   </cfquery>

   <cfif qCheck.display_on_pdp eq 1>
      <cfreturn true>
   <cfelse>
      <cfreturn false>
   </cfif>
</cffunction>




<cffunction name="getAreaSettings">
   	<cfargument name="siteid">

   	<cfset var qAreaSettings = queryNew("")>
<!--- 
   	CBSloane wants to filter the area list by zip code - onlys specific zip codes are to be included
   	The following query works, assuming masterareas_cleaned.areashidden is a single value, not a list.
   	NOTE: An area will not appear on the list if there are no properties in that area in the mastertable.
   	The origianl query has been left (commented)
   	2018-04-15 A.DOUTE
 --->
 	<cfquery name="qAreaSettings" datasource="#application.settings.mls.propertydsn#">
 		SELECT DISTINCT  id, `area`, latitude, longitude, areashidden, display_on_advanced, display_on_refine
		FROM 	(
				SELECT
						masterareas_cleaned.id,
						masterareas_cleaned.city AS `area`,
						masterareas_cleaned.latitude,
						masterareas_cleaned.longitude,
						masterareas_cleaned.areashidden,
						fields_areas.display_on_advanced,
						fields_areas.display_on_refine,
						fields_areas.display_on_quick,
						zipcode.zip_code
				FROM 	fields_areas 
				JOIN 	masterareas_cleaned ON fields_areas.masterareas_cleaned_id = masterareas_cleaned.id
				JOIN 	(SELECT DISTINCT mastertable.Zip_Code, `area` FROM mastertable) AS zipcode ON zipcode.area = masterareas_cleaned.areashidden
				-- for CBSloane - requires areashidden be a single area
				WHERE 	fields_areas.siteid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.siteid#">
				AND 	LENGTH(IFNULL(masterareas_cleaned.city, '')) > 0 
				<cfif isdefined('application.settings.mls.filter_zipcodes') and len(application.settings.mls.filter_zipcodes)>
					AND 	zipcode.zip_code IN (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#application.settings.mls.filter_zipcodes#">)
	            	<!--- '28467','28468','28469','28470','28462','28461','28465','28422','28420' --->
					-- for CBSloane - they only want to show specific zip codes
				</cfif>
            UNION            
            SELECT
                  masterareas_cleaned.id,
                  masterareas_cleaned.city AS `area`,
                  masterareas_cleaned.latitude,
                  masterareas_cleaned.longitude,
                  masterareas_cleaned.areashidden,
                  fields_areas.display_on_advanced,
                  fields_areas.display_on_refine,
                  fields_areas.display_on_quick,
                  NULL AS zip_code
            FROM  fields_areas 
            JOIN  masterareas_cleaned ON fields_areas.masterareas_cleaned_id = masterareas_cleaned.id   
            -- for CBSloane - requires areashidden be a single area
            WHERE    fields_areas.siteid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.siteid#">
            AND   LENGTH(IFNULL(masterareas_cleaned.city, '')) > 0 
            AND   masterareas_cleaned.areashidden IN (
                        SELECT DISTINCT `area` 
                        FROM  mastertable 
                        WHERE Listing_Office_Id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#settings.mls.CompanyMLSID#" list="true">)
                        AND   status in (<cfqueryparam cfsqltype="cf_sql_integer" list="true" value="#application.settings.mls.statusestoincludeinsearch#">)
               )
				) AS dt
		ORDER BY `area`
	</cfquery>
 <!--- original query
   	<cfquery name="qAreaSettings" datasource="#application.settings.mls.propertydsn#">
      select
         masterareas_cleaned.id,
         masterareas_cleaned.city as area,
         masterareas_cleaned.latitude,
         masterareas_cleaned.longitude,
         masterareas_cleaned.areashidden,
         fields_areas.display_on_advanced,
         fields_areas.display_on_refine,
         fields_areas.display_on_quick

      from fields_areas join masterareas_cleaned on fields_areas.masterareas_cleaned_id = masterareas_cleaned.id
   	where
   	fields_areas.siteid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.siteid#">
   	and masterareas_cleaned.city <>'' and masterareas_cleaned.city is not null

   	order by city

   	</cfquery>
 --->
   	<cfreturn qAreaSettings>

</cffunction>


<cffunction name="getSearchAreas">
   <cfargument name="which" hint="advanced, refine or quick">

   <cfset var qGetAdvancedAreas = queryNew("")>

   <cfquery name="qGetAdvancedAreas" dbtype="query">
      select * from application.settings.mls.getMasterAreas where display_on_#which# = 1
      ;
   </cfquery>

   <cfreturn qGetAdvancedAreas>

</cffunction>

<!--- Cities --->
<cffunction name="getCitySettings">
   <cfargument name="siteid">

   <cfset var qCitySettings = queryNew("")>

   <cfquery name="qCitySettings" datasource="#application.settings.mls.propertydsn#">
      select
         id,
         city,
         city as areashidden,
         fields_cities.display_on_advanced,
         fields_cities.display_on_refine,
         fields_cities.display_on_quick

      from fields_cities
      where siteid='#settings.id#'

   order by city

   </cfquery>

   <cfreturn qCitySettings>

</cffunction>
<cffunction name="getSearchCities">
   <cfargument name="which" hint="advanced, refine or quick">

   <cfset var qGetAdvancedCities = queryNew("")>

   <cfquery name="qGetAdvancedCities" dbtype="query">
      select * from application.settings.mls.getMasterCities where display_on_#which# = 1
      ;
   </cfquery>

   <cfreturn qGetAdvancedCities>

</cffunction>



</cfcomponent>
