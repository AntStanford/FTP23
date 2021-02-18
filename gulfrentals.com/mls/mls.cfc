<cfcomponent>

<cffunction name="init" access="public" output="no">
   <cfargument name="settings" type="struct" required="yes">
   <cfset variables.settings = arguments.settings>
   <cfreturn this>
</cffunction>

<cffunction name="getSimilarProps" hint="returns a query of similar properties, based on the same number of beds & baths, within 10% of the price">
  <cfargument name="wsid" required="true" type="numeric" hint="The WSID to search for">
  <cfargument name="price" required="true" type="numeric" hint="The price">
  <cfargument name="companyOnly" required="false" default="false" type="boolean" hint="true / false - return Company listings only (default false)">
  <cfargument name="limit" required="false" type="numeric" default="1" hint="Limits the number or properties returned">
  <cfargument name="beds" required="false" default="0" type="numeric" hint="The number of bedrooms">
  <cfargument name="baths" required="false" default="0" type="numeric" hint="The number of bathrooms">

  <cfset variables.minPrice = int(arguments.price * .9) />
  <cfset variables.maxPrice = ceiling(arguments.price * 1.1) />

  <cfquery name="qrySimilarProps" datasource="#application.settings.mls.propertydsn#">
    SELECT  mastertable.*,
            IF(LENGTH(IFNULL(latlong.latitude,mastertable.latitude)) > 0, IFNULL(latlong.latitude,mastertable.latitude), 36.062187) AS map_latitude,
            IF(LENGTH(IFNULL(latlong.longitude,mastertable.longitude)) > 0, IFNULL(latlong.longitude,mastertable.longitude), -75.691306) AS map_longitude,
            master_status.name AS status_name,
            LCASE(
                CONCAT(
                  mastertable.mlsnumber, '-', mastertable.wsid, '-', mastertable.mlsid, '/',
                  IFNULL(mastertable.street_number,''), '-',
                  REPLACE(
                    REPLACE(mastertable.street_name, ' ', '-')
                    ,'\'',''
                  )
                )
              ) AS proplink
    FROM    mastertable
    JOIN    master_status ON mastertable.status = master_status.id
    INNER JOIN property_dates ON  mastertable.MLSNumber =  property_dates.mlsnumber
    LEFT JOIN latlong ON (latlong.mlsnumber =  mastertable.MLSNumber AND latlong.mlsid = mastertable.mlsid AND latlong.wsid = mastertable.wsid)
    WHERE   mastertable.mlsid IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#application.settings.mls.mlsid#" list="true">)
    AND     property_dates.mlsid IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#application.settings.mls.mlsid#" list="true">)
    AND     mastertable.wsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.wsid#">
    AND     mastertable.mlsid =  property_dates.mlsid
    AND     mastertable.wsid =  property_dates.wsid
    <cfif arguments.beds neq 0>
      AND   mastertable.bedrooms = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.beds#">
    </cfif>
    <cfif arguments.baths neq 0>
      AND   mastertable.baths_full = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.baths#">
    </cfif>
    <cfif arguments.companyOnly is true>
      AND   mastertable.Listing_Office_Id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#settings.mls.CompanyMLSID#" list="true">)
    </cfif>
    AND   mastertable.list_price >= <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.minPrice#">
    AND   mastertable.list_price <= <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.maxPrice#">
    <!--- company / specific zip code filter (restricts all results to specific zip codes, plus any company listings, regardless of zip code) --->
    <cfif isdefined('application.settings.mls.filter_zipcodes') and len(application.settings.mls.filter_zipcodes)>
    AND (
          (
            mastertable.Listing_Office_Id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#settings.mls.CompanyMLSID#" list="true">)
          )
          OR
          (
            mastertable.zip_code IN (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#application.settings.mls.filter_zipcodes#">)
          )
        )
    </cfif>
    ORDER BY RAND()
    LIMIT <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.limit#">
  </cfquery>

  <cfif qrySimilarProps.recordcount is 0>

    <cfquery name="qrySimilarProps2" datasource="#application.settings.mls.propertydsn#">
      SELECT  mastertable.*,
              IFNULL(latlong.latitude,mastertable.latitude) AS map_latitude,
              IFNULL(latlong.longitude,mastertable.longitude) AS map_longitude,
              master_status.name AS status_name,
              LCASE(
                  CONCAT(
                    mastertable.mlsnumber, '-', mastertable.wsid, '-', mastertable.mlsid, '/',
                    IFNULL(mastertable.street_number,''), '-',
                    REPLACE(
                      REPLACE(mastertable.street_name, ' ', '-')
                      ,'\'',''
                    )
                  )
                ) AS proplink
      FROM    mastertable
      JOIN    master_status ON mastertable.status = master_status.id
      INNER JOIN property_dates ON  mastertable.MLSNumber =  property_dates.mlsnumber
      LEFT JOIN latlong ON (latlong.mlsnumber =  mastertable.MLSNumber AND latlong.mlsid = mastertable.mlsid AND latlong.wsid = mastertable.wsid)
      WHERE   mastertable.mlsid IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#v.mlsid#" list="true">)
      AND     property_dates.mlsid IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#v.mlsid#" list="true">)
      AND     mastertable.wsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.wsid#">
      AND     mastertable.mlsid =  property_dates.mlsid
      AND     mastertable.wsid =  property_dates.wsid
      <cfif arguments.beds neq 0>
        AND   mastertable.bedrooms >= <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.beds#">
      </cfif>
      <cfif arguments.baths neq 0>
        AND   mastertable.baths_full >= <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.baths#">
      </cfif>
      <cfif arguments.companyOnly is true>
        AND   mastertable.Listing_Office_Id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#settings.mls.CompanyMLSID#" list="true">)
      </cfif>
      AND   mastertable.list_price >= <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.minPrice#">
      AND   mastertable.list_price <= <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.maxPrice#">
      <!--- company / specific zip code filter (restricts all results to specific zip codes, plus any company listings, regardless of zip code) --->
      <cfif isdefined('application.settings.mls.filter_zipcodes') and len(application.settings.mls.filter_zipcodes)>
      AND (
            (
              mastertable.Listing_Office_Id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#settings.mls.CompanyMLSID#" list="true">)
            )
            OR
            (
              mastertable.zip_code IN (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#application.settings.mls.filter_zipcodes#">)
            )
          )
      </cfif>
      ORDER BY RAND()
      LIMIT <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.limit#">
    </cfquery>

    <cfset variables.returnQry = duplicate(qrySimilarProps2) />

  <cfelse><!--- qrySimilarProps.recordcount if --->

    <cfset variables.returnQry = duplicate(qrySimilarProps) />

  </cfif>

  <cfreturn variables.returnQry>
</cffunction>


<cffunction name="addPropertyView">
   <cfargument name="clientid">
   <cfargument name="thecfid">
   <cfargument name="thecftoken">
   <cfargument name="mlsid">
   <cfargument name="wsid">
   <cfargument name="mlsnumber">
   <cfargument name="TotalPropViews">

   <cfset var qInsertView = queryNew("")>

   <cfquery name="qInsertView" datasource="#application.settings.mls.propertydsn#">
      Insert
      Into cl_properties_viewed
          (clientid,TheCFID,TheCFTOKEN,mlsid,wsid,mlsnumber,AllViewsCount)
      Values
          (
         <cfqueryparam value="#arguments.clientid#" cfsqltype="CF_SQL_VARCHAR">,
         <cfqueryparam value="#arguments.cfid#" cfsqltype="CF_SQL_VARCHAR">,
         <cfqueryparam value="#arguments.cftoken#" cfsqltype="CF_SQL_VARCHAR">,
         <cfqueryparam value="#arguments.mlsid#" cfsqltype="CF_SQL_VARCHAR">,
         <cfqueryparam value="#arguments.wsid#" cfsqltype="CF_SQL_VARCHAR">,
         <cfqueryparam value="#arguments.mlsnumber#" cfsqltype="CF_SQL_VARCHAR">,
         <cfqueryparam value="#arguments.TotalPropViews#" cfsqltype="CF_SQL_INTEGER">
         )
     </cfquery>

</cffunction>



<cffunction name="getCities">

   <cfset var qCities = queryNew("")>
   <cfquery name="qCities" datasource="#application.settings.mls.propertydsn#"  cachedwithin="#CreateTimeSpan(0, 0, 30, 0)#">
       SELECT distinct(city_or_township) as city
       FROM mastertable
       where mlsid in (#settings.mls.mlsid#) and city_or_township <> ''
       <cfoutput>
       <cfif settings.mls.AsCityFields neq ''>

        and city_or_township IN (<cfqueryparam value="#settings.mls.AsCityFields#" cfsqltype="CF_SQL_VARCHAR" list="Yes">)
      </cfif>
      </cfoutput>
      order by city_or_township ASC
   </cfquery>

   <cfreturn qCities>

</cffunction>

<cffunction name="getCommunityFeatures">

   <cfset var qCommunityFeatures = queryNew("")>
   <cfquery name="qCommunityFeatures" datasource="#application.settings.mls.propertydsn#" cachedwithin="#CreateTimeSpan(0, 0, 30, 0)#">
	SELECT *
	FROM custom_search_features
        where ( 1 = 2 
               <cfloop list="#settings.mls.mlsid#" index="mlsid">
                 or mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mlsid#">
               </cfloop>
              )
  and `grouping` = 'Community Features'
	order by displayname
   </cfquery>

   <cfreturn qCommunityFeatures>

</cffunction>

<cffunction name="getElementarySchools">

   <cfset var qElementarySchools = queryNew("")>
   <cfquery name="qElementarySchools" datasource="#application.settings.mls.propertydsn#" cachedwithin="#CreateTimeSpan(0, 0, 30, 0)#">
	SELECT distinct (Elementary_School)
        FROM mastertable
        where ( 1 = 2 
               <cfloop list="#settings.mls.mlsid#" index="mlsid">
                 or mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mlsid#">
               </cfloop>
              )
        and Elementary_School <> ''
        order by Elementary_School
   </cfquery>

   <cfreturn qElementarySchools>

</cffunction>

<cffunction name="getSubdivisions">

   <cfset var qSubdivisions = queryNew("")>
   <cfquery name="qSubdivisions" datasource="#application.settings.mls.propertydsn#" cachedwithin="#CreateTimeSpan(0, 0, 30, 0)#">
	SELECT distinct (subdivision)
        FROM mastertable
        where
         ( 1 = 2 
           <cfloop list="#settings.mls.mlsid#" index="mlsid">
             or mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mlsid#">
           </cfloop>
          ) 
        and subdivision <> ''
        order by subdivision
   </cfquery>

   <cfreturn valuelist(qSubdivisions.subdivision)>

</cffunction>

<cffunction name="getHighSchools">

   <cfset var qHighSchools = queryNew("")>
   <cfquery name="qHighSchools" datasource="#application.settings.mls.propertydsn#" cachedwithin="#CreateTimeSpan(0, 0, 30, 0)#">
	SELECT distinct (High_School)
        FROM mastertable
        where
           ( 1 = 2 
             <cfloop list="#settings.mls.mlsid#" index="mlsid">
               or mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mlsid#">
             </cfloop>
            ) 
        and High_School <> ''
        order by High_School
   </cfquery>

   <cfreturn qHighSchools>

</cffunction>

<cffunction name="getKinds">

   <cfset var qKinds = queryNew("")>
   <cfquery name="qKinds" datasource="#application.settings.mls.propertydsn#" cachedwithin="#CreateTimeSpan(0, 0, 30, 0)#">
      SELECT distinct KIND
      FROM mastertable
      where
         ( 1 = 2 
           <cfloop list="#settings.mls.mlsid#" index="mlsid">
             or mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mlsid#">
           </cfloop>
          ) 
      and kind <> ''
      order by Kind ASC
   </cfquery>

   <cfreturn valuelist(qKinds.kind)>

</cffunction>



<cffunction name="getListing">
   <cfargument name="mlsid">
   <cfargument name="mlsnumber">
   <cfargument name="wsid" default="">
   <cfargument name="columns" default="*">

   <cfset var qListing = queryNew("")>
   <cfquery name="qListing" datasource="#application.settings.mls.propertydsn#" cachedwithin="#CreateTimeSpan(0, 0, 30, 0)#">
      SELECT replace(substring_index(photo_link,',',2),',','') as prop_photo,
      mastertable.#arguments.columns#,
              lcase(
                concat(
                  mastertable.mlsnumber, '-', mastertable.wsid, '-', mastertable.mlsid, '/',
                  IFNULL(mastertable.street_number,''), '-',
                  REPLACE(
                    REPLACE(mastertable.street_name, ' ', '-')
                    ,'\'',''
                  )
                )
              ) as proplink
      FROM mastertable
         join property_dates on mastertable.mlsid = property_dates.mlsid
      WHERE
         mastertable.wsid=property_dates.wsid
         and mastertable.mlsnumber=property_dates.mlsnumber
         and mastertable.mlsnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.mlsnumber#">
         and mastertable.mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.mlsid#">
         <cfif arguments.wsid neq "">and mastertable.wsid= <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.wsid#"></cfif>
   </cfquery>

   <cfreturn qListing>

</cffunction>

<cffunction name="getMarketTrends">
   <cfargument name="mlsid">
   <cfargument name="area">

   <cfset var qMarketTrends = queryNew("")>

   <cfquery name="qMarketTrends" datasource="#application.settings.mls.propertydsn#">
      SELECT
         date,
         property_count,
         average_price,
         median_price,
         average_bedrooms,
         average_bathrooms,
         average_square_footage,
         average_price_per_sq_ft
      FROM
         stats_by_area
      WHERE
         mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mlsid#">
         and  area = <cfqueryparam cfsqltype="cf_sql_integer" value="#area#">
         and date > <cfqueryparam cfsqltype="cf_sql_date" value="#dateadd('d', -10, now())#">
         order by date DESC
         limit 1
   </cfquery>

   <cfreturn qMarketTrends>

</cffunction>

<cffunction name="getMasterAreas">

   <cfset var qMasterAreas = queryNew("")>

   <cfquery name="qMasterAreas" datasource="#application.settings.mls.propertydsn#">
      SELECT *
      FROM masterareas_cleaned
      WHERE mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#settings.mls.mlsid#"> <!---and latitude <> '' and longitude <> ''--->
      <cfif settings.mls.AsAreaFields neq ''>

        and area IN (<cfqueryparam value="#settings.mls.AsAreaFields#" cfsqltype="CF_SQL_VARCHAR" list="Yes">)
      </cfif>
      order by city
   </cfquery>

   <cfreturn qMasterAreas>

</cffunction>

<cffunction name="getMiddleSchools">

   <cfset var qMiddleSchools = queryNew("")>
   <cfquery name="qMiddleSchools" datasource="#application.settings.mls.propertydsn#" cachedwithin="#CreateTimeSpan(0, 0, 30, 0)#">
	SELECT distinct (Middle_School)
        FROM mastertable
        where ( 1 = 2 
           <cfloop list="#settings.mls.mlsid#" index="mlsid">
             or mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mlsid#">
           </cfloop>
          )
        and Middle_School <> ''
        order by Middle_School
   </cfquery>

   <cfreturn qMiddleSchools>

</cffunction>

<cffunction name="getMinMaxes">

   <cfset var qMinMax = queryNew("")>
   <cfquery name="qMinMax" datasource="#application.settings.mls.propertydsn#" cachedwithin="#CreateTimeSpan(0, 0, 30, 0)#">
      select
         min(bedrooms) as minBed,
         max(bedrooms) as maxBed,
         min(baths_full) as minBath,
         max(baths_full) as maxBath
      from
         mastertable
        where ( 1 = 2 
           <cfloop list="#settings.mls.mlsid#" index="mlsid">
             or mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mlsid#">
           </cfloop>
          )
   </cfquery>

   <cfreturn qMinMax>
   </cffunction>


<cffunction name="getMLSFeeds">

   <cfset var getmlscoinfo = queryNew("")>
   <cfset var first_id = settings.mls.mlsid>

   <cfif listlen(first_id) gt 1>
      <cfset first_id = listfirst(settings.mls.mlsid)>
   </cfif>

   <cfquery name="getmlscoinfo" datasource="#application.settings.mls.propertydsn#" cachedwithin="#CreateTimeSpan(0, 0, 0, 0)#">
      SELECT *
      FROM mlsfeeds
      WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#first_id#">
   </cfquery>

   <cfreturn getmlscoinfo>

</cffunction>

<cffunction name="getViewCount">
   <cfargument name="mlsid">
   <cfargument name="mlsnumber">
   <cfargument name="wsid">
   <cfargument name="clientid" default="">

   <cfset var qGetViewCount = queryNew("")>

   <cfquery name="qGetViewCount" datasource="#application.settings.mls.propertydsn#" cachedwithin="#CreateTimeSpan(0, 0, 30, 0)#">
      SELECT COUNT(mlsnumber) as thecount
      FROM cl_properties_viewed
      WHERE
         mlsnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.mlsnumber#">
         and wsid= <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.wsid#">
         and mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.mlsid#">
         <cfif arguments.clientid neq "">and clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.clientid#"></cfif>

   </cfquery>

   <cfreturn qGetViewCount>

</cffunction>



<cffunction name="getWaterTypes">

   <cfset var WaterTypes = ''>

   <cfquery name="qWaterTypes" datasource="#application.settings.mls.propertydsn#" cachedwithin="#CreateTimeSpan(0, 0, 30, 0)#">
       SELECT distinct mastertable.waterfront_type as WaterTypes
       FROM mastertable
       where ( 1 = 2 
           <cfloop list="#settings.mls.mlsid#" index="mlsid">
             or mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mlsid#">
           </cfloop>
          )
       order by mastertable.waterfront_type
   </cfquery>

   <cfset WaterTypes = ListSort(ListRemoveDuplicates(valuelist(qWaterTypes.WaterTypes)),'text')>

   <cfreturn WaterTypes>

</cffunction>

<cffunction name="getWaterViews">

   <cfset var qWaterViews = queryNew("")>
   <cfquery name="qWaterViews" datasource="#application.settings.mls.propertydsn#" cachedwithin="#CreateTimeSpan(0, 0, 30, 0)#">
       SELECT distinct water
       FROM mastertable
       where ( 1 = 2 
           <cfloop list="#settings.mls.mlsid#" index="mlsid">
             or mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mlsid#">
           </cfloop>
          )
       order by water
   </cfquery>

   <cfreturn qWaterViews>

</cffunction>

<cffunction name="getPools">

   <cfset var qPools = queryNew("")>
   <cfquery name="qPools" datasource="#application.settings.mls.propertydsn#" cachedwithin="#CreateTimeSpan(0, 0, 30, 0)#">
       SELECT distinct pool
       FROM mastertable
       where mlsid= <cfqueryparam cfsqltype="cf_sql_integer" value="#settings.mls.mlsid#">
       and pool <>'' and pool is not null
       order by pool
   </cfquery>

   <cfreturn qPools>

</cffunction>



<cffunction name="all_properties">

   <cfargument name="mlsid">
   <cfset var results = structNew()>

   <cfquery name="qSearch" datasource="#application.settings.mls.propertydsn#" result = "qSearchResults" cachedwithin="#CreateTimeSpan(1,0,0,0)#">
      select

            SQL_CALC_FOUND_ROWS
            mastertable.street_number,
            master_status.name as status_name,
            mastertable.street_name,
            mastertable.city,
            mastertable.zip_code,
            mastertable.mlsnumber,
            mastertable.mlsid,
            mastertable.wsid,
            mastertable.list_price,
            mastertable.bedrooms,
            mastertable.baths_full,
            mastertable.state

        from mastertable
        join master_status on mastertable.status = master_status.id

        Inner Join property_dates

         where
            mastertable.MLSNumber =  property_dates.mlsnumber
            and mastertable.mlsid in (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.mlsid#" list="true">)
            and property_dates.mlsid in (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.mlsid#" list="true">)
            and mastertable.mlsid =  property_dates.mlsid
            and mastertable.wsid =  property_dates.wsid
            and mastertable.street_name != ''
            order by  list_price DESC

   </cfquery>

   <cfset results.query=qSearch>
   <cfset results.queryResult = qSearchResults>

   <cfreturn results>

</cffunction>

<cffunction name="property_search">
   <cfargument name="search">
   <cfargument name="start_record" default="0">
   <cfargument name="records_per_page" default="10">
   <cfargument name="countonly" default="false">



   <cfset var qSearch = queryNew("")>
   <cfset var v = arguments.search>
   <cfset var i = 0>
   <cfset var getFavorites = queryNew("")>
   <cfset var mlsnumberlist="">
   <cfset var results = structNew()>
   <cfset var qSearchResults = structNew()>
   <cfset var qCount = queryNew("")>

   <cfif isdefined('v.listed_price') and listlen(v.listed_price) is 2>
    <cfset v.pmin = listfirst(listed_price) />
    <cfset v.pmax = listlast(listed_price) />
   </cfif>



   <cfquery name="qSearch" datasource="#application.settings.mls.propertydsn#" result = "qSearchResults">
         select
         <cfif arguments.countonly eq false>
            SQL_CALC_FOUND_ROWS
            mastertable.*,
            <!---concat('#settings.mls.getmlscoinfo.imageurl#',mastertable.wsid,'/',replace(substring_index(photo_link,',',2),',','')) as mapphoto,--->
            photo_link as mapphoto,
            ifnull(latlong.latitude,mastertable.latitude) as map_latitude,
            ifnull(latlong.longitude,mastertable.longitude) as map_longitude,
            master_status.name as status_name,
            lcase(
                concat(
                  mastertable.mlsnumber, '-', mastertable.wsid, '-', mastertable.mlsid, '/',
                  IFNULL(REPLACE(mastertable.street_number,' ','-'),''), '-',
                  REPLACE(
                    REPLACE(mastertable.street_name, ' ', '-')
                    ,'\'',''
                  )
                )
              ) as proplink
        <cfelse>
            count(*) as thecount
        </cfif>

        from mastertable
        join master_status on mastertable.status = master_status.id

         Inner Join property_dates on  mastertable.MLSNumber =  property_dates.mlsnumber
         left join latlong on (latlong.mlsnumber =  mastertable.MLSNumber and latlong.mlsid = mastertable.mlsid and latlong.wsid = mastertable.wsid)
         where ( 1 = 2 
           <cfloop list="#v.mlsid#" index="mlsid">
             or mastertable.mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mlsid#">
           </cfloop>
         )
         and ( 1 = 2 
           <cfloop list="#v.mlsid#" index="mlsid">
             or property_dates.mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mlsid#">
           </cfloop>
         )
            and  mastertable.mlsid =  property_dates.mlsid
            and  mastertable.wsid =  property_dates.wsid


        <cfif arguments.records_per_page gt 100>
          and latitude != ''
        </cfif>

         <!--- company / specific zip code filter (restricts all results to specific zip codes, plus any company listings, regardless of zip code) --->
         <cfif isdefined('application.settings.mls.filter_zipcodes') and len(application.settings.mls.filter_zipcodes)>
            and (
                  (
                    mastertable.Listing_Office_Id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#settings.mls.CompanyMLSID#" list="true">)
                  )
                  OR
                  (
                    mastertable.zip_code IN (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#application.settings.mls.filter_zipcodes#">)
                  )
                )
         </cfif>

         <cfif v.mlsnumber  neq "">
            <cfif listlen(v.mlsnumber) eq 1>
               and mastertable.mlsnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value="#v.mlsnumber#">
            <cfelse>
               and mastertable.mlsnumber in (<cfqueryparam cfsqltype="sql_var_char" value="#replace(v.mlsnumber,' ','','all')#" list="true">)
            </cfif>
         </cfif>

         <cfif isdefined('v.quicksearch') and v.quicksearch neq "">

            <cfset variables.seachText = trim(replace(replace(v.quicksearch,',',' ','all'),' ','%','all')) />
            and
            (
              mastertable.mlsnumber LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#v.quicksearch#%"> OR
              mastertable.subdivision LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#v.quicksearch#%"> OR
              mastertable.street_number LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#v.quicksearch#%"> OR
              mastertable.street_name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#v.quicksearch#%"> OR
              mastertable.city LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#variables.seachText#"> OR
              mastertable.city_or_township LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#variables.seachText#"> OR
              mastertable.zip_code LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#variables.seachText#"> OR
              concat_ws(' ',mastertable.street_number,mastertable.street_name) like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#variables.seachText#%"> OR
              concat_ws(' ',mastertable.street_number,mastertable.street_name,mastertable.city) like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#variables.seachText#%"> OR
              concat_ws(' ',mastertable.street_number,mastertable.street_name,mastertable.city,mastertable.state) like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#variables.seachText#%"> OR
              concat_ws(' ',mastertable.street_number,mastertable.street_name,mastertable.city,mastertable.state,mastertable.zip_code) like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#variables.seachText#%">
            )
        </cfif>

        <cfif isdefined('v.lotlocations') and v.lotlocations is not "">
          AND mastertable.lot_description like '%#v.lotlocations#%'
        </cfif>

        <cfif isdefined('v.golf') and v.golf is 'golf'>
          and (mastertable.lot_description LIKE '%golf course%' OR mastertable.Amentities LIKE '%golf course%')
        </cfif>

         <cfif v.area  neq "">


            and (

               <cfloop from="1" to="#listlen(v.area)#" index="i">
                  mastertable.area = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listgetat(v.area,i)#"><cfif i lt listlen(v.area)> OR </cfif>
               </cfloop>

           )

         </cfif>

         <!--- 
         <cfif v.status  neq "">
            and mastertable.status in ( <cfqueryparam cfsqltype="cf_sql_varchar" value="#v.status#" list="yes">)
         </cfif>
         --->

         <cfif v.status eq '6'>
          <cfset dtStart = #now()# />
            <cfset dtToday = DateFormat(dtStart, "mm/dd/yyyy") />
            <cfset dtLastYear=DateFormat(dateAdd('yyyy',-1,dtToday),"mm/dd/yyyy")>
           <cfif isDefined("v.strCheckin") and v.strCheckin neq ''>
             and solddate >= <cfqueryparam cfsqltype="cf_sql_date" value="#v.strCheckin#">
           <cfelse>
              and solddate >= <cfqueryparam cfsqltype="cf_sql_date" value="#dtLastYear#">
           </cfif>
           <cfif isDefined("v.strCheckout") and v.strCheckout neq ''>
             and solddate <= <cfqueryparam cfsqltype="cf_sql_date" value="#v.strCheckout#">
            <cfelse>
              and solddate <= <cfqueryparam cfsqltype="cf_sql_date" value="#dtToday#">
           </cfif>
         </cfif>

         <cfif v.pmin neq ""and v.pmin neq 0>
            and mastertable.list_price >= <cfqueryparam cfsqltype="cf_sql_integer" value="#v.pmin#">
         </cfif>

         <cfif v.pmax neq "" and v.pmax neq 0>
            and mastertable.list_price <= <cfqueryparam cfsqltype="cf_sql_integer" value="#v.pmax#">
         </cfif>

         <cfif v.wsid neq 2>
            <cfset tmpbdrms = replace(v.bedrooms,'%2C',",")>
            <cfif trim(v.bedrooms) neq "" and tmpbdrms neq "0,11" and v.bedrooms neq 0>
               <cfif listlen(tmpbdrms) eq 1>
                  and mastertable.bedrooms >= <cfqueryparam cfsqltype="cf_sql_integer" value="#v.bedrooms#">
               <cfelse>

                  and mastertable.bedrooms >= <cfqueryparam cfsqltype="cf_sql_integer" value="#listGetAt(tmpbdrms,1)#">
                  and mastertable.bedrooms <= <cfqueryparam cfsqltype="cf_sql_integer" value="#listGetAt(tmpbdrms,2)#">
               </cfif>
            </cfif>
            <cfset tmpbaths = replace(v.baths_full,'%2C',",")>
            <cfif trim(v.baths_full) neq "" and V.baths_full neq "0,11" and v.baths_full neq 0>

               <cfif listlen(v.baths_full) eq 1>
               and mastertable.baths_full >= <cfqueryparam cfsqltype="cf_sql_integer" value="#v.baths_full#">
               <cfelse>
               and mastertable.baths_full >= <cfqueryparam cfsqltype="cf_sql_integer" value="#listGetAt(tmpbaths,1)#">
               and mastertable.baths_full <= <cfqueryparam cfsqltype="cf_sql_integer" value="#listGetAt(tmpbaths,2)#">
               </cfif>
            </cfif>
         </cfif>



         <!--- <cfif v.subdivision neq "">
            and mastertable.subdivision like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#v.subdivision#%">
         </cfif> --->
         <cfif v.subdivision neq "">
           and (
                 <cfloop from="1" to="#listlen(v.subdivision)#" index="i">
                    mastertable.subdivision rlike <cfqueryparam cfsqltype="cf_sql_varchar" value="#rereplace(listgetat(v.subdivision,i), "'","\'","ALL")#"><cfif i lt listlen(v.subdivision)> OR </cfif>
                 </cfloop>
             )
          </cfif>

         <cfif v.streetaddress neq "">
        AND concat_ws(' ',mastertable.street_number,mastertable.street_name) like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#trim(replace(v.streetaddress,' ','%','all'))#%">
         </cfif>

         <cfif v.showlistings eq "Company">
            and mastertable.Listing_Office_Id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#settings.mls.CompanyMLSID#" list="true"> )
         </cfif>

         <cfif v.kind neq "">
           and (

               <cfloop from="1" to="#listlen(v.kind)#" index="i">
                  mastertable.kind rlike <cfqueryparam cfsqltype="cf_sql_varchar" value="#listgetat(v.kind,i)#"><cfif i lt listlen(v.kind)> OR </cfif>
               </cfloop>

           )
         </cfif>

         <cfif v.water_view_type neq "">
           and (

               <cfloop from="1" to="#listlen(v.water_view_type)#" index="i">
                  mastertable.water_view_type rlike <cfqueryparam cfsqltype="cf_sql_varchar" value="#listgetat(v.water_view_type,i)#"><cfif i lt listlen(v.water_view_type)> OR </cfif>
               </cfloop>

           )
         </cfif>

         <cfif isdefined('v.waterViewFront') and v.waterViewFront neq "">
           AND concat_ws(' ',mastertable.waterfront_type,mastertable.water_view_type) like  '%#trim(v.waterViewFront)#%'
         </cfif>



         <cfif v.city neq "">
           and (

               <cfloop from="1" to="#listlen(v.city)#" index="i">
                  mastertable.city_or_township = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listgetat(v.city,i)#"><cfif i lt listlen(v.city)> OR </cfif>
               </cfloop>

           )
         </cfif>


         <cfif isdefined('v.mls_city') and v.mls_city neq "">
           and (

               <cfloop from="1" to="#listlen(v.mls_city)#" index="i">
                  mastertable.city_or_township = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listgetat(v.mls_city,i)#"><cfif i lt listlen(v.mls_city)> OR </cfif>
               </cfloop>

           )
         </cfif>

         <cfif isdefined('v.mls_county') and v.mls_county neq "">
           and mastertable.county = <cfqueryparam cfsqltype="cf_sql_varchar" value="#v.mls_county#">
         </cfif>

         <cfif v.stipulations neq "">
           and (

               <cfloop from="1" to="#listlen(v.stipulations)#" index="i">
                  mastertable.stipulation_of_sale rlike <cfqueryparam cfsqltype="cf_sql_varchar" value="#listgetat(v.stipulations,i)#"><cfif i lt listlen(v.stipulations)> OR </cfif>
               </cfloop>

           )
         </cfif>

         <cfif v.elementary_school neq "">
            and mastertable.elementary_school like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#v.elementary_school#%">
         </cfif>

         <cfif v.middle_school neq "">
            and mastertable.middle_school like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#v.middle_school#%">
         </cfif>

         <cfif v.high_school neq "">
            and mastertable.high_school like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#v.high_school#%">
         </cfif>



         <cfif v.favoritelist neq "">
            AND mastertable.mlsnumber in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#v.favoritelist#" list="true">)
         </cfif>

         <cfif v.daysonmarket is not "">
            and property_dates.created_at >= <cfqueryparam cfsqltype="cf_sql_date" value="#v.daysonmarket#">
         </cfif>

         <!--- <cfif v.daysonmarket is not "">
            and property_dates.created_at >= <cfqueryparam cfsqltype="cf_sql_integer" value="#v.daysonmarket#">
         </cfif> --->

         <cfif isDefined("v.daysonsite") and v.daysonsite is not "" and isNumeric(v.DAYSONSITE)>
            and property_dates.created_at >= <cfqueryparam cfsqltype="cf_sql_date" value="#DateAdd('d',(v.daysonsite*-1),now())#">
         </cfif>

         <cfif v.SQFtMin neq "" and v.SQFtMax neq 999999999 and v.SQFtMax neq "">
           and ((
              mastertable.Total_Heated_Square_Feet >= <cfqueryparam cfsqltype="cf_sql_integer" value="#v.SQFtMin#">
              and mastertable.Total_Heated_Square_Feet <= <cfqueryparam cfsqltype="cf_sql_integer" value="#v.SQFtMax#">

              )
            or
            (
            mastertable.Building_Square_Feet >= <cfqueryparam cfsqltype="cf_sql_integer" value="#v.SQFtMin#">
            and mastertable.building_square_feet <= <cfqueryparam cfsqltype="cf_sql_integer" value="#v.SQFtMax#">
            )

           )

         </cfif>

         <cfif v.WaterType is not "">
              AND mastertable.waterfront_type like (<cfqueryparam cfsqltype="cf_sql_varchar" value="%#trim(v.WaterType)#%">)
         </cfif>

         <cfif v.amentities neq "">
           and (

               <cfloop from="1" to="#listlen(v.amentities)#" index="i">
                  mastertable.amentities rlike <cfqueryparam cfsqltype="cf_sql_varchar" value="#listgetat(v.amentities,i)#"><cfif i lt listlen(v.amentities)> OR </cfif>
               </cfloop>

           )
         </cfif>

         <cfif v.association_fee neq "">
            and association_fee = <cfqueryparam cfsqltype="cf_sql_varchar" value="No Fee">
         </cfif>

         <cfif isdefined('v.enotifydate') and v.enotifydate is not "">
            <cfset mlsnumberlist = getENotifiedMLSNumbers(v.enotifydate,v.enotifydatesearchid)>
            <cfif mlsnumberlist neq "">
               AND mastertable.mlsnumber in (#listqualify(mlsnumberlist,"'")#)
            </cfif>
         </cfif>


         <cfif v.property_type neq "">
           and (

               <cfloop from="1" to="#listlen(v.property_type)#" index="i">
                  mastertable.property_type rlike <cfqueryparam cfsqltype="cf_sql_varchar" value="#listgetat(v.property_type,i)#"><cfif i lt listlen(v.property_type)> OR </cfif>
               </cfloop>

           )
         </cfif>

         <cfif v.remarks neq "">
            and remarks = <cfqueryparam cfsqltype="cf_sql_varchar" value="#v.remarks#">
         </cfif>

         <cfif isDefined("v.listing_agent_id") and v.listing_agent_id neq "">
            and listing_agent_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#v.listing_agent_id#">
         </cfif>

         <cfif v.waterfront neq "">
            and waterfront = <cfqueryparam cfsqltype="cf_sql_varchar" value="#v.waterfront#">
         </cfif>

         <cfif v.waterview neq "">
            and waterview = <cfqueryparam cfsqltype="cf_sql_varchar" value="#v.waterview#">
         </cfif>


         <cfif isDefined("v.centralair") and v.centralair eq 'Yes'>
            and
            ( cooling like '%central%'
              and mastertable.MLSNumber not in (
                SELECT mlsnumber FROM mastertable
                where mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#v.mlsid#" list="true">
                and cooling rlike 'heat'
                and cooling not rlike 'Central Air'
                and cooling not rlike 'Central A/C'
                and cooling not rlike 'Central AC'
              )
            )

         <cfelseif isDefined("v.centralair") and v.centralair eq 'No'>
            and (
                cooling not rlike 'Central Air'
                and cooling not rlike 'Central A/C'
                and cooling not rlike 'Central AC'
                and cooling not rlike 'Central'
              )
         </cfif>

         <cfif isDefined("v.gasheat") and v.gasheat eq 'Yes'>
            and heating rlike 'gas'
         <cfelseif isDefined("v.gasheat") and v.gasheat eq 'No'>
            and heating not rlike 'gas'
         </cfif>

         <cfif isDefined("v.garage") and v.garage eq 'Yes'>
              and find_in_set('garage',parking) > 0
         <cfelseif isDefined("v.garage") and v.garage eq 'No'>
              and find_in_set('garage',parking) = 0
         </cfif>

         <cfif isDefined("v.pool") and v.pool eq 'Yes'>
            and (exterior_features rlike 'pool' or amentities rlike 'pool')
         <cfelseif isDefined("v.pool") and v.pool eq 'No'>
            and (exterior_features not rlike 'pool' and amentities not rlike 'pool')
         </cfif>

         <cfif isDefined("v.fence") and v.fence eq 'Yes'>
            and exterior_features rlike 'fence'
         <cfelseif isDefined("v.fence") and v.fence eq 'No'>
            and exterior_features not rlike 'fence'
         </cfif>

         <cfif isDefined("v.boatslip") and v.boatslip eq 'Yes'>
            and (find_in_set('boat slips',exterior_features) > 0 or find_in_set('boat slips',amentities) > 0)
         <cfelseif isDefined("v.boatslip") and v.boatslip eq 'No'>
            and (find_in_set('boat slips',exterior_features) = 0 and find_in_set('boat slips',amentities) = 0)
         </cfif>

         <cfif isDefined("v.waterviews") and v.waterviews eq 'Yes'>
            and (find_in_set('water view',lot_location) > 0 or find_in_set('water view',lot_water_features) > 0)
         <cfelseif isDefined("v.waterviews") and v.waterviews eq 'No'>
            and (find_in_set('water view',lot_location) = 0 and find_in_set('water view',lot_water_features) = 0)
         </cfif>

         <cfif isDefined("v.fireplace") and v.fireplace eq 'Yes'>
            and interior_features rlike 'fireplace'
         <cfelseif isDefined("v.fireplace") and v.fireplace eq 'No'>
            and interior_features not rlike 'fireplace'
         </cfif>

         <cfif isDefined("v.patio") and v.patio eq 'Yes'>
            and find_in_set('patio',exterior_features) > 0
         <cfelseif isDefined("v.patio") and v.patio eq 'No'>
            and find_in_set('patio',exterior_features) = 0
         </cfif>

         <cfif isDefined("v.new_construction") and v.new_construction eq 'Yes'>
            and new_construction='Yes'
         <cfelseif isDefined("v.new_construction") and v.new_construction eq 'No'>
            and new_construction ='No'
         </cfif>

         <cfif isDefined("v.water") and v.water neq ''>
            <cfif listlen(v.water) gt 0>
               and (
               <cfloop from="1" to="#listlen(v.water)#" index="i">
                  find_in_set(<cfqueryparam cfsqltype="cf_sql_varchar" value="#listgetat(v.water,i)#">,mastertable.water) > 0 <cfif i lt listlen(v.water)> OR </cfif>
               </cfloop>
               )
            <cfelse>
               and water = <cfqueryparam cfsqltype="cf_sql_varchar" value="#v.water#">
            </cfif>
         </cfif>

         <cfif isDefined("v.pooltype") and v.pooltype neq "">
            and pool = <cfqueryparam cfsqltype="cf_sql_varchar" value="#v.pooltype#">
         </cfif>

         <cfif isDefined("v.elevator") and v.elevator eq "Yes">
            and extrainfo rlike <cfqueryparam cfsqltype="cf_sql_varchar" value="elevator">
         </cfif>

         <cfif structKeyExists(v,"ShowMap")>
            and latitude <> ''
         </cfif>

          <cfif isDefined("v.wsid") and v.wsid neq "">
            AND mastertable.wsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#v.wsid#">
          <cfelse>
          </cfif>
          
          AND mastertable.status = 1

         <cfif v.sortby neq "" and v.daysonmarket neq "">
            order by  property_dates.updated_at DESC, #v.sortby#
         <cfelse>
            <cfif v.sortby neq "">
               <!---order by  #v.sortby#--->
               order by case when mastertable.Listing_office_Id = #settings.mls.CompanyMLSID# then -1 else mastertable.Listing_office_Id end, #v.sortby#
              <cfelse>
              <!---order by property_dates.updated_at DESC, property_dates.created_at DESC--->
              order by case when mastertable.Listing_office_Id = #settings.mls.CompanyMLSID# then -1 else mastertable.Listing_office_Id end, property_dates.updated_at DESC, property_dates.created_at DESC
            </cfif>

         </cfif>

         <!--- LIMIT #arguments.start_record#, #arguments.records_per_page# --->
   </cfquery>

   <cfif arguments.countonly eq false>
      <cfquery name="qCount" datasource="#application.settings.mls.propertydsn#">
         SELECT FOUND_ROWS() as thecount;
      </cfquery>

      <cfset results.total_properties = qcount.thecount>
   <cfelse>
      <cfset results.total_properties = qSearch.thecount>
   </cfif>

   <cfset results.query=qSearch>
   <cfset session.qSearch=qSearch>
   <cfset results.queryResult = qSearchResults>
   <cfset results.formatted_sql = "<pre>"&results.queryResult.sql&"</pre>">
   <cfset results.arguments = arguments>
   <cfset results.help="results.query = search results <br> results.queryResult = cfquery result varaiable <br>results.formatted_sql = formatted sql statement <br> results.arguments = arguments passed into search function">


   <cfreturn results>


</cffunction>

<!---
<cffunction name="property_search">
   <cfargument name="search">
   <cfargument name="start_record" default="0">
   <cfargument name="records_per_page" default="10">
   <cfargument name="countonly" default="false">



   <cfset var qSearch = queryNew("")>
   <cfset var v = arguments.search>
   <cfset var i = 0>
   <cfset var getFavorites = queryNew("")>
   <cfset var mlsnumberlist="">
   <cfset var results = structNew()>
   <cfset var qSearchResults = structNew()>
   <cfset var qCount = queryNew("")>



   <cfquery name="qSearch" datasource="#application.settings.mls.propertydsn#" result = "qSearchResults">
         select
         <cfif arguments.countonly eq false>
            SQL_CALC_FOUND_ROWS
            mastertable.*,
            master_status.name as status_name
        <cfelse>
            count(*) as thecount
        </cfif>

        from mastertable
        join master_status on mastertable.status = master_status.id

         Inner Join property_dates

         where
            mastertable.MLSNumber =  property_dates.mlsnumber
            and mastertable.mlsid in ( <cfqueryparam cfsqltype="cf_sql_integer" value="#v.mlsid#" list="true">)
            and property_dates.mlsid in ( <cfqueryparam cfsqltype="cf_sql_integer" value="#v.mlsid#" list="true">)
            and  mastertable.mlsid =  property_dates.mlsid
            and  mastertable.wsid =  property_dates.wsid


        <cfif arguments.records_per_page gt 100>
          and latitude != ''
        </cfif>
         <cfif v.mlsnumber  neq "">
            <cfif listlen(v.mlsnumber) eq 1>
               and mastertable.mlsnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value="#v.mlsnumber#">
            <cfelse>
               and mastertable.mlsnumber in (<cfqueryparam cfsqltype="sql_var_char" value="#replace(v.mlsnumber,' ','','all')#" list="true">)
            </cfif>
         </cfif>


         <cfif v.wsid  neq "">
            and mastertable.wsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#v.wsid#">
         </cfif>

         <cfif v.area  neq "">


            and (

               <cfloop from="1" to="#listlen(v.area)#" index="i">
                  mastertable.area = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listgetat(v.area,i)#"><cfif i lt listlen(v.area)> OR </cfif>
               </cfloop>

           )

         </cfif>

         <cfif v.status  neq "">
            and mastertable.status in ( <cfqueryparam cfsqltype="cf_sql_varchar" value="#v.status#" list="yes">)
         </cfif>
         <cfif v.status eq '6'>
          <cfset dtStart = #now()# />
            <cfset dtToday = DateFormat(dtStart, "mm/dd/yyyy") />
            <cfset dtLastYear=DateFormat(dateAdd('yyyy',-1,dtToday),"mm/dd/yyyy")>
           <cfif isDefined("v.strCheckin") and v.strCheckin neq ''>
             and solddate >= <cfqueryparam cfsqltype="cf_sql_date" value="#v.strCheckin#">
           <cfelse>
              and solddate >= <cfqueryparam cfsqltype="cf_sql_date" value="#dtLastYear#">
           </cfif>
           <cfif isDefined("v.strCheckout") and v.strCheckout neq ''>
             and solddate <= <cfqueryparam cfsqltype="cf_sql_date" value="#v.strCheckout#">
            <cfelse>
              and solddate <= <cfqueryparam cfsqltype="cf_sql_date" value="#dtToday#">
           </cfif>
         </cfif>
         <cfif v.pmin neq ""and v.pmin neq 0>
            and mastertable.list_price >= <cfqueryparam cfsqltype="cf_sql_integer" value="#v.pmin#">
         </cfif>

         <cfif v.pmax neq "" and v.pmax neq 0>
            and mastertable.list_price <= <cfqueryparam cfsqltype="cf_sql_integer" value="#v.pmax#">
         </cfif>

         <cfif v.wsid neq 2>
            <cfset tmpbdrms = replace(v.bedrooms,'%2C',",")>
            <cfif v.bedrooms neq "" and tmpbdrms neq "0,11">
               <cfif listlen(tmpbdrms) eq 1>
                  and mastertable.bedrooms >= <cfqueryparam cfsqltype="cf_sql_integer" value="#v.bedrooms#">
               <cfelse>

                  and mastertable.bedrooms >= <cfqueryparam cfsqltype="cf_sql_integer" value="#listGetAt(tmpbdrms,1)#">
                  and mastertable.bedrooms <= <cfqueryparam cfsqltype="cf_sql_integer" value="#listGetAt(tmpbdrms,2)#">
               </cfif>
            </cfif>
            <cfset tmpbaths = replace(v.baths_full,'%2C',",")>
            <cfif v.baths_full neq "" and V.baths_full neq "0,11">

               <cfif listlen(v.baths_full) eq 1>
               and mastertable.baths_full >= <cfqueryparam cfsqltype="cf_sql_integer" value="#v.baths_full#">
               <cfelse>
               and mastertable.baths_full >= <cfqueryparam cfsqltype="cf_sql_integer" value="#listGetAt(tmpbaths,1)#">
               and mastertable.baths_full <= <cfqueryparam cfsqltype="cf_sql_integer" value="#listGetAt(tmpbaths,2)#">
               </cfif>
            </cfif>
         </cfif>



         <cfif v.subdivision neq "">
            and mastertable.subdivision like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#v.subdivision#%">
         </cfif>

         <cfif v.streetaddress neq "">
				AND concat_ws(' ',mastertable.street_number,mastertable.street_name) like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#trim(replace(v.streetaddress,' ','%','all'))#%">
         </cfif>

         <cfif v.showlistings eq "Company">
            and mastertable.Listing_Office_Id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#settings.mls.CompanyMLSID#" list="true"> )
         </cfif>

         <cfif v.kind neq "">
           and (

               <cfloop from="1" to="#listlen(v.kind)#" index="i">
                  mastertable.kind rlike <cfqueryparam cfsqltype="cf_sql_varchar" value="#listgetat(v.kind,i)#"><cfif i lt listlen(v.kind)> OR </cfif>
               </cfloop>

           )
         </cfif>

         <cfif v.water_view_type neq "">
           and (

               <cfloop from="1" to="#listlen(v.water_view_type)#" index="i">
                  mastertable.water_view_type rlike <cfqueryparam cfsqltype="cf_sql_varchar" value="#listgetat(v.water_view_type,i)#"><cfif i lt listlen(v.water_view_type)> OR </cfif>
               </cfloop>

           )
         </cfif>



         <cfif v.city neq "">
           and (

               <cfloop from="1" to="#listlen(v.city)#" index="i">
                  mastertable.city = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listgetat(v.city,i)#"><cfif i lt listlen(v.city)> OR </cfif>
               </cfloop>

           )
         </cfif>

         <cfif v.stipulations neq "">
           and (

               <cfloop from="1" to="#listlen(v.stipulations)#" index="i">
                  mastertable.stipulation_of_sale rlike <cfqueryparam cfsqltype="cf_sql_varchar" value="#listgetat(v.stipulations,i)#"><cfif i lt listlen(v.stipulations)> OR </cfif>
               </cfloop>

           )
         </cfif>

         <cfif v.elementary_school neq "">
            and mastertable.elementary_school like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#v.elementary_school#%">
         </cfif>

         <cfif v.middle_school neq "">
            and mastertable.middle_school like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#v.middle_school#%">
         </cfif>

         <cfif v.high_school neq "">
            and mastertable.high_school like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#v.high_school#%">
         </cfif>



         <cfif v.favoritelist neq "">
            AND mastertable.mlsnumber in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#v.favoritelist#" list="true">)
         </cfif>

         <cfif v.daysonmarket is not "">
            and property_dates.created_at >= <cfqueryparam cfsqltype="cf_sql_integer" value="#v.daysonmarket#">
         </cfif>

         <cfif v.daysonmarket is not "">
            and property_dates.created_at >= <cfqueryparam cfsqltype="cf_sql_integer" value="#v.daysonmarket#">
         </cfif>

         <cfif isDefined("v.daysonsite") and v.daysonsite is not "" and isNumeric(v.DAYSONSITE)>
            and property_dates.created_at >= <cfqueryparam cfsqltype="cf_sql_date" value="#DateAdd('d',(v.daysonsite*-1),now())#">
         </cfif>

         <cfif v.SQFtMin neq "" and v.SQFtMax neq 999999999 and v.SQFtMax neq "">
           and ((
              mastertable.Total_Heated_Square_Feet >= <cfqueryparam cfsqltype="cf_sql_integer" value="#v.SQFtMin#">
              and mastertable.Total_Heated_Square_Feet <= <cfqueryparam cfsqltype="cf_sql_integer" value="#v.SQFtMax#">

              )
            or
            (
            mastertable.Building_Square_Feet >= <cfqueryparam cfsqltype="cf_sql_integer" value="#v.SQFtMin#">
            and mastertable.building_square_feet <= <cfqueryparam cfsqltype="cf_sql_integer" value="#v.SQFtMax#">
            )

           )

         </cfif>

         <cfif v.WaterType is not "">
            AND concat_ws(' ',mastertable.waterfront_type,mastertable.water_view_type) like  <cfqueryparam cfsqltype="cf_sql_varchar" value="%#trim(v.WaterType)#%">
         </cfif>

         <cfif v.amentities neq "">
           and (

               <cfloop from="1" to="#listlen(v.amentities)#" index="i">
                  mastertable.amentities rlike <cfqueryparam cfsqltype="cf_sql_varchar" value="#listgetat(v.amentities,i)#"><cfif i lt listlen(v.amentities)> OR </cfif>
               </cfloop>

           )
         </cfif>

         <cfif v.association_fee neq "">
            and association_fee = <cfqueryparam cfsqltype="cf_sql_varchar" value="No Fee">
         </cfif>

         <cfif isdefined('v.enotifydate') and v.enotifydate is not "">
            <cfset mlsnumberlist = getENotifiedMLSNumbers(v.enotifydate,v.enotifydatesearchid)>
            <cfif mlsnumberlist neq "">
               AND mastertable.mlsnumber in (#listqualify(mlsnumberlist,"'")#)
            </cfif>
         </cfif>


         <cfif v.property_type neq "">
           and (

               <cfloop from="1" to="#listlen(v.property_type)#" index="i">
                  mastertable.property_type rlike <cfqueryparam cfsqltype="cf_sql_varchar" value="#listgetat(v.property_type,i)#"><cfif i lt listlen(v.property_type)> OR </cfif>
               </cfloop>

           )
         </cfif>

         <cfif v.remarks neq "">
            and remarks = <cfqueryparam cfsqltype="cf_sql_varchar" value="#v.remarks#">
         </cfif>

         <cfif isDefined("v.listing_agent_id") and v.listing_agent_id neq "">
            and listing_agent_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#v.listing_agent_id#">
         </cfif>

         <cfif v.waterfront neq "">
            and waterfront = <cfqueryparam cfsqltype="cf_sql_varchar" value="#v.waterfront#">
         </cfif>

         <cfif v.waterview neq "">
            and waterview = <cfqueryparam cfsqltype="cf_sql_varchar" value="#v.waterview#">
         </cfif>


         <cfif isDefined("v.centralair") and v.centralair eq 'Yes'>
            and
            ( cooling like '%central%'
              and mastertable.MLSNumber not in (
                SELECT mlsnumber FROM mastertable
                where mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#v.mlsid#" list="true">
                and cooling rlike 'heat'
                and cooling not rlike 'Central Air'
                and cooling not rlike 'Central A/C'
                and cooling not rlike 'Central AC'
              )
            )

         <cfelseif isDefined("v.centralair") and v.centralair eq 'No'>
            and (
                cooling not rlike 'Central Air'
                and cooling not rlike 'Central A/C'
                and cooling not rlike 'Central AC'
                and cooling not rlike 'Central'
              )
         </cfif>

         <cfif isDefined("v.gasheat") and v.gasheat eq 'Yes'>
            and heating rlike 'gas'
         <cfelseif isDefined("v.gasheat") and v.gasheat eq 'No'>
            and heating not rlike 'gas'
         </cfif>

         <cfif isDefined("v.garage") and v.garage eq 'Yes'>
              and find_in_set('garage',parking) > 0
         <cfelseif isDefined("v.garage") and v.garage eq 'No'>
              and find_in_set('garage',parking) = 0
         </cfif>

         <cfif isDefined("v.pool") and v.pool eq 'Yes'>
            and (exterior_features rlike 'pool' or amentities rlike 'pool')
         <cfelseif isDefined("v.pool") and v.pool eq 'No'>
            and (exterior_features not rlike 'pool' and amentities not rlike 'pool')
         </cfif>

         <cfif isDefined("v.fence") and v.fence eq 'Yes'>
            and exterior_features rlike 'fence'
         <cfelseif isDefined("v.fence") and v.fence eq 'No'>
            and exterior_features not rlike 'fence'
         </cfif>

         <cfif isDefined("v.boatslip") and v.boatslip eq 'Yes'>
            and (find_in_set('boat slips',exterior_features) > 0 or find_in_set('boat slips',amentities) > 0)
         <cfelseif isDefined("v.boatslip") and v.boatslip eq 'No'>
            and (find_in_set('boat slips',exterior_features) = 0 and find_in_set('boat slips',amentities) = 0)
         </cfif>

         <cfif isDefined("v.waterviews") and v.waterviews eq 'Yes'>
            and (find_in_set('water view',lot_location) > 0 or find_in_set('water view',lot_water_features) > 0)
         <cfelseif isDefined("v.waterviews") and v.waterviews eq 'No'>
            and (find_in_set('water view',lot_location) = 0 and find_in_set('water view',lot_water_features) = 0)
         </cfif>

         <cfif isDefined("v.fireplace") and v.fireplace eq 'Yes'>
            and interior_features rlike 'fireplace'
         <cfelseif isDefined("v.fireplace") and v.fireplace eq 'No'>
            and interior_features not rlike 'fireplace'
         </cfif>

         <cfif isDefined("v.patio") and v.patio eq 'Yes'>
            and find_in_set('patio',exterior_features) > 0
         <cfelseif isDefined("v.patio") and v.patio eq 'No'>
            and find_in_set('patio',exterior_features) = 0
         </cfif>

         <cfif isDefined("v.new_construction") and v.new_construction eq 'Yes'>
            and new_construction='Yes'
         <cfelseif isDefined("v.new_construction") and v.new_construction eq 'No'>
            and new_construction ='No'
         </cfif>

         <cfif isDefined("v.water") and v.water neq ''>
            <cfif listlen(v.water) gt 0>
               and (
               <cfloop from="1" to="#listlen(v.water)#" index="i">
                  find_in_set(<cfqueryparam cfsqltype="cf_sql_varchar" value="#listgetat(v.water,i)#">,mastertable.water) > 0 <cfif i lt listlen(v.water)> OR </cfif>
               </cfloop>
               )
            <cfelse>
               and water = <cfqueryparam cfsqltype="cf_sql_varchar" value="#v.water#">
            </cfif>
         </cfif>

         <cfif isDefined("v.pooltype") and v.pooltype neq "">
            and pool = <cfqueryparam cfsqltype="cf_sql_varchar" value="#v.pooltype#">
         </cfif>

         <cfif isDefined("v.elevator") and v.elevator eq "Yes">
            and extrainfo rlike <cfqueryparam cfsqltype="cf_sql_varchar" value="elevator">
         </cfif>





         <cfif structKeyExists(v,"ShowMap")>
            and latitude <> ''
         </cfif>

         <cfif v.sortby neq "" and v.daysonmarket neq "">
            order by  property_dates.updated_at DESC, #v.sortby#
         <cfelse>
            <cfif v.sortby neq "">order by  #v.sortby#
              <cfelse>
              order by property_dates.updated_at DESC, property_dates.created_at DESC
            </cfif>

         </cfif>

         LIMIT #arguments.start_record#, #arguments.records_per_page#
   </cfquery>

   <cfif arguments.countonly eq false>
      <cfquery name="qCount" datasource="#application.settings.mls.propertydsn#">
         SELECT FOUND_ROWS() as thecount;
      </cfquery>

      <cfset results.total_properties = qcount.thecount>
   <cfelse>
      <cfset results.total_properties = qSearch.thecount>
   </cfif>

   <cfset results.query=qSearch>
   <cfset results.queryResult = qSearchResults>
   <cfset results.formatted_sql = "<pre>"&results.queryResult.sql&"</pre>">
   <cfset results.arguments = arguments>
   <cfset results.help="results.query = search results <br> results.queryResult = cfquery result varaiable <br>results.formatted_sql = formatted sql statement <br> results.arguments = arguments passed into search function">


   <cfreturn results>


</cffunction> --->



<cffunction name="addFavorite">
   <cfargument name="siteid">
   <cfargument name="clientid">
   <cfargument name="mlsnumber">
   <cfargument name="mlsid">
   <cfargument name="wsid">
   <cfargument name="cfid">
   <cfargument name="cftoken">

   <cfset var qInsertFavorite = queryNew("")>

   <cfquery name="qInsertFavorite" datasource="#settings.dsn#"><!--- settings.mls.propertydsn --->
      insert into cl_favorites
      set

      clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.clientid#">,
      mlsnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.mlsnumber#">,
      mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.mlsid#">,
      wsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.wsid#">,
      ClientCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.cfid#">,
      ClientCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.cftoken#">
   </cfquery>

   <cfreturn getFavorites(arguments.clientid, arguments.siteid,true, arguments.cfid, arguments.cftoken)>

</cffunction>

<cffunction name="removeFavorite">
   <cfargument name="siteid">
   <cfargument name="clientid">
   <cfargument name="mlsnumber">
   <cfargument name="mlsid">
   <cfargument name="wsid">
   <cfargument name="cfid">
   <cfargument name="cftoken">

   <cfset var qRemoveFavorite = queryNew("")>

   <cfquery name="qRemoveFavorite" datasource="#settings.dsn#"><!--- settings.mls.propertydsn --->
      delete from  cl_favorites
      where
      mlsnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.mlsnumber#">
      and mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.mlsid#">
      and (
            clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.clientid#">

            or (
            ClientCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.cfid#">
            and
            ClientCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.cftoken#">
            )
         )
   </cfquery>

   <cfreturn getFavorites(arguments.clientid, arguments.siteid,true, arguments.cfid, arguments.cftoken)>

</cffunction>

<cffunction name="getFavorites">
   <cfargument name="loggedin">
   <cfargument name="siteid">
   <cfargument name="returnCount" default="false">
   <cfargument name="cfid">
   <cfargument name="cftoken">

   <cfset var getFavorites = queryNew("")>

   <cfquery name="getUserFavorites" datasource="#settings.dsn#">
      select * from cl_favorites
      where clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.loggedin#">
      <cfif arguments.loggedin eq 0>
        and
        ClientCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.cfid#">
        and
        ClientCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.cftoken#">
      </cfif>
   </cfquery>

   <cfset variables.userFavorites = valueList(getUserFavorites.mlsnumber) />

   <cfquery datasource="#application.settings.mls.propertydsn#" name="GetFavorites">
        SELECT
               <cfif arguments.returnCount eq false>distinct mastertable.mlsnumber<cfelse>count(distinct mastertable.mlsnumber) as thecount</cfif>
        FROM mastertable
        inner join property_dates on mastertable.mlsnumber = property_dates.mlsnumber
        where mastertable.mlsnumber in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#variables.userFavorites#">)
        and mastertable.mlsid in (<cfqueryparam cfsqltype="cf_sql_integer" value="#settings.mls.mlsid#" list="true">)
        and property_dates.mlsid in (<cfqueryparam cfsqltype="cf_sql_integer" value="#settings.mls.mlsid#" list="true">)
        order by mastertable.mlsnumber Asc
   </cfquery>

   <cfif cgi.remote_addr eq "69.139.28.11">

   <!---<cfdump var="#getFavorites#">--->

   </cfif>


   <cfif arguments.returnCount eq false>
      <cfif getFavorites.recordcount gt 0>
         <cfreturn listRemoveDuplicates(valuelist(GetFavorites.mlsnumber))>
      <cfelse>
         <cfreturn "">
      </cfif>
   <cfelse>
      <cfreturn getFavorites.thecount>
   </cfif>


</cffunction>



<cffunction name="getFavoritesQry">
   <cfargument name="loggedin">
   <cfargument name="siteid">
   <cfargument name="returnCount" default="false">
   <cfargument name="cfid">
   <cfargument name="cftoken">

   <cfset var getFavorites = queryNew("")>

   <cfquery name="getUserFavorites" datasource="#settings.dsn#">
      select * from cl_favorites
      where clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.loggedin#">
      <cfif arguments.loggedin eq 0>
        and
        ClientCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.cfid#">
        and
        ClientCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.cftoken#">
      </cfif>
   </cfquery>

   <cfset variables.userFavorites = valueList(getUserFavorites.mlsnumber) />

   <cfquery datasource="#application.settings.mls.propertydsn#" name="GetFavorites">
        SELECT mastertable.*
        FROM mastertable
        inner join property_dates on mastertable.mlsnumber = property_dates.mlsnumber
        where mastertable.mlsnumber in (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#variables.userFavorites#">)
        and mastertable.mlsid in (<cfqueryparam cfsqltype="cf_sql_integer" value="#settings.mls.mlsid#" list="true">)
        and property_dates.mlsid in (<cfqueryparam cfsqltype="cf_sql_integer" value="#settings.mls.mlsid#" list="true">)
        order by mastertable.mlsnumber Asc
   </cfquery>

   <cfif cgi.remote_addr eq "69.139.28.11">

   <!---<cfdump var="#getFavorites#">--->

   </cfif>


   <cfif arguments.returnCount eq false>
      <cfif getFavorites.recordcount gt 0>
         <cfreturn listRemoveDuplicates(valuelist(GetFavorites.mlsnumber))>
      <cfelse>
         <cfreturn "">
      </cfif>
   <cfelse>
      <cfreturn getFavorites.thecount>
   </cfif>


</cffunction>


<cffunction name="getFavoriteProperties">
   <cfargument name="mlsnumbers">
   <cfargument name="mlsid">

   <cfset var qProperties = queryNew("")>
   <cfset var qPropertiesResults = structNew()>

   <cfquery name="qProperties" datasource="#application.settings.mls.propertydsn#" result="qPropertiesResults">
      select distinct mastertable.*
      from mastertable

      Inner Join property_dates
      where
         mastertable.MLSNumber =  property_dates.mlsnumber
         and mastertable.mlsid in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.mlsid#" list="true">)
         and property_dates.mlsid in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.mlsid#" list="true">)
         and  mastertable.mlsid =  property_dates.mlsid
         and  mastertable.wsid =  property_dates.wsid
         and mastertable.mlsnumber in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#mlsnumbers#" list="true">)
         and mastertable.wsid != 11
         and property_dates.wsid != 11
   </cfquery>

   <cfreturn qProperties>
</cffunction>

<!---getENotifiedMLSNumbers(enotifydate,enotifydatesearchid)--->

<cffunction name="getENotifiedMLSNumbers">
   <cfargument name="enotifydate">
   <cfargument name="enotifydatesearchid">

   <cfset var GetMatches = queryNew("")>

    <cfquery datasource="#application.settings.mls.propertydsn#" name="GetMatches">
        SELECT *
        FROM cl_saved_searches_props_returned
        where datenotified = <cfqueryparam value="#arguments.enotifydate#" cfsqltype="CF_SQL_DATE">
        and searchid = <cfqueryparam value="#arguments.enotifydatesearchid#" cfsqltype="CF_SQL_VARCHAR">
      </cfquery>

   <cfif GetMatches.recordcount gt 0>
      <cfreturn valuelist(GetMatches.mlsnumber)>
   <cfelse>
      <cfreturn "">
   </cfif>
</cffunction>

<cffunction name="getMarketTrend">
   <cfargument name="mlsid" default="#settings.mls.mlsid#">

   <cfset qMarketTrends = queryNew("")>

   <cfquery name="qMarketTrends" datasource="#application.settings.mls.propertydsn#">
      SELECT *
      FROM stats_by_mls
      where mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.mlsid#">
      and `date` > <cfqueryparam value="#dateadd('d','-1',now())#" cfsqltype="CF_SQL_DATE">
      order by date desc
      limit 1;
   </cfquery>

   <cfreturn qMarketTrends>
</cffunction>

<cffunction name="firstphoto">
   <cfargument name="photo_link">

   <cfif arguments.photo_link is not "">
      <cfreturn listgetat(photo_link,'1')>
   <cfelse>
      <cfreturn "">
   </cfif>
</cffunction>

</cfcomponent>
