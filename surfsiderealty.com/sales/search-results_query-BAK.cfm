<cfsavecontent variable="querycode">
  <cfoutput>
    <cfif isdefined('session.wsid') and session.wsid is not "">
      and mastertable.wsid = '#session.wsid#'
    </cfif>
    <cfif isdefined('session.PMIN') and session.PMIN is not "">AND mastertable.list_price >= '#session.PMIN#' and mastertable.list_price <= '#session.PMAX#'</cfif>
    <cfif isdefined('session.Bedrooms') and session.Bedrooms IS NOT "">AND mastertable.bedrooms = '#session.Bedrooms#'</cfif>
    <cfif isdefined('session.Baths_Full') and  session.Baths_Full IS NOT "">AND mastertable.baths_full >= '#session.Baths_Full#'</cfif>
    <cfif isdefined('session.area') and session.area is not "">AND mastertable.area in (#session.area#)</cfif>
    <cfif isdefined('session.mlsnumber') and session.mlsnumber is not "">AND mastertable.mlsnumber = '#session.mlsnumber#'</cfif>
    <cfif isdefined('session.subdivision') and session.subdivision is not "">AND mastertable.subdivision like '%#session.subdivision#%'</cfif>		
    

	<CFIF parameterexists(session.StreetAddress) and session.streetaddress is not "">
		<!--- Format the street address coming from the form; we are going to replace all spaces with a % sign --->
			<cfset formattedStreetAddress = replace(session.StreetAddress,' ','%','all')> 
				AND concat_ws(' ',mastertable.street_number,mastertable.street_name) like  '%#trim(formattedStreetAddress)#%'
     </CFIF>


    <cfif isdefined('session.showlistings') and session.showlistings is "Company">and mastertable.Listing_Office_Id = '#mls.CompanyMLSID#'</cfif>
    


    <!---START: SPECIAL KIND CODE--->
    <cfif isdefined('session.KIND') and session.KIND is not "">and
      <cfset listl = #listlen(session.KIND)#>
      <cfset cnt = 0>
        (
          <cfloop index="i" list="#session.KIND#" delimiters=",">
            <cfset #cnt# = #cnt# + 1>mastertable.KIND rlike '#i#' <cfif #cnt# lt #listl#>or </cfif>
          </cfloop>
        )
    </cfif>
    <!---END: SPECIAL KIND CODE--->
    
    
    
    <!---handles stipulations search --->
    <cfif IsDefined('session.stipulations') AND Len(session.stipulations)>
      <cfif ListLen(session.stipulations) GT 1>
        AND ( 1=0
          <cfloop list="#session.stipulations#" index="stipulation">
            OR mastertable.stipulation_of_sale LIKE '%#stipulation#%'
          </cfloop>
        )
      <cfelse>
        AND mastertable.stipulation_of_sale LIKE '%#session.stipulations#%'
      </cfif>
    </cfif>
    <!---HANDLES SCHOOLS--->
    <cfif isdefined('session.Elementary_School') and listlen(session.Elementary_School) eq 1>
      AND (mastertable.Elementary_School like '%#session.Elementary_School#%')
    <cfelseif isdefined('session.Elementary_School') and  listlen(session.Elementary_School) gt 1>
      AND mastertable.Elementary_School in (#listqualify(session.Elementary_School,"'")#)
    </cfif>
    <cfif isdefined('session.Middle_school') and listlen(session.Middle_school) eq 1>
      AND (mastertable.Middle_school like '%#session.Middle_school#%')
    <cfelseif isdefined('session.Middle_school') and  listlen(session.Middle_school) gt 1>
      AND mastertable.Middle_school in (#listqualify(session.Middle_school,"'")#)
    </cfif>
    <cfif isdefined('session.High_School') and listlen(session.High_School) eq 1>
      AND (mastertable.High_School like '%#session.High_School#%')
    <cfelseif isdefined('session.High_School') and  listlen(session.High_School) gt 1>
      AND mastertable.High_School in (#listqualify(session.High_School,"'")#)
    </cfif>
    <cfif isdefined('session.FavoriteList') and session.FavoriteList is not "">
      <cfquery datasource="#mls.dsn#" name="GetFavorites">
        SELECT *
        FROM cl_favorites
        where clientid = <cfqueryparam cfsqltype="cf_sql_numeric" value="#cookie.loggedin#">
        order by thedate desc
      </cfquery>
      AND mastertable.mlsnumber in (#listqualify(valuelist(GetFavorites.mlsnumber),"'")#)
    </cfif>
    <cfif isdefined('session.DaysOnMarket') and session.DaysOnMarket is not "">
      and property_dates.created_at >= '#session.DaysOnMarket#'
    </cfif>
    <cfif isdefined('session.SQFtMin') and (session.SQFtMin is not "0" and session.SQFtMax is not "999999999" and session.SQFtMax is not "")>AND mastertable.building_square_feet >= '#session.SQFtMin#' and mastertable.building_square_feet <= '#session.SQFtMax#'</cfif>
    <cfif isdefined('session.WaterType') and session.WaterType is not "">AND concat_ws(' ',mastertable.waterfront_type,mastertable.water_view_type) like  '%#trim(session.WaterType)#%'</cfif>
    


    <!---START: AMENTITIES CODE--->
    <cfif isdefined('session.Amentities') and session.Amentities is not "">and
      <cfset listl = #listlen(session.Amentities)#>
      <cfset cnt = 0>
        (
          <cfloop index="i" list="#session.Amentities#" delimiters=",">
            <cfset #cnt# = #cnt# + 1> mastertable.Amentities rlike '#i#' <cfif #cnt# lt #listl#>and </cfif>
          </cfloop>
        )
    </cfif>
    <!---END: AMENTITIES CODE--->
    
    
    
    <cfif IsDefined('session.association_fee') AND Len(session.association_fee)>and association_fee = 'No Fee'</cfif>
    <cfif isdefined('session.enotifydate') and session.enotifydate is not "">
      <cfquery datasource="#mls.dsn#" name="GetMatches">
        SELECT *
        FROM cl_saved_searches_props_returned
        where datenotified = <cfqueryparam value="#session.enotifydate#" cfsqltype="CF_SQL_DATE"> and searchid = <cfqueryparam value="#session.enotifydatesearchid#" cfsqltype="CF_SQL_VARCHAR">
      </cfquery>
      AND mastertable.mlsnumber in (#listqualify(valuelist(GetMatches.mlsnumber),"'")#)
    </cfif>
    


    <!---START: SPECIAL PROPERTY TYPE CODE--->
    <cfif isdefined('session.Property_Type') and session.Property_Type is not "">and
      <cfset listl = #listlen(session.Property_Type)#>
      <cfset cnt = 0>
        (
          <cfloop index="i" list="#session.Property_Type#" delimiters=",">
            <cfset #cnt# = #cnt# + 1>mastertable.Property_Type rlike '#i#' <cfif #cnt# lt #listl#>or </cfif>
          </cfloop>
        )
    </cfif>
    <!---END: SPECIAL PROPERTY TYPE  CODE--->
    
    
    
    <cfif isdefined('ShowMap')>
      and latitude <> ''	
    </cfif>
    <cfif isdefined('session.sortby')>
      order by #session.sortby#
    </cfif>
  </cfoutput>
</cfsavecontent>