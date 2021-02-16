<cfquery name="GetDateMatches" datasource="#mls.dsn#">
  select *
  from cl_saved_searches
  where NextNotificationDate = <cfqueryparam value="#now()#" cfsqltype="CF_SQL_DATE">
</cfquery>

<cfloop query="GetDateMatches">
  


<!---START: PARSING OUT MY SEARCH PARAMETERS--->
  <cfinclude template="/sales/includes/parse-search-parameters.cfm">
  <!---END: PARSING OUT MY SEARCH PARAMETERS--->
  <cfif daysonmarket is not "">
    <cfset session.DaysOnMarket = #DateAdd("d", Now(), DaysOnMarket)#>
    <cfset session.DaysOnMarket = #dateformat(session.DaysOnMarket,'yyyy-mm-dd')#>
  </cfif>
  <cfinclude template="/sales/search-results_query.cfm">
  <cfquery datasource="#DSNMLS#" name="GetAllListings">
    SELECT 
      mastertable.*,
      property_dates.created_at
    FROM mastertable
    Inner Join property_dates
    where mastertable.MLSNumber =  property_dates.mlsnumber and mastertable.mlsid = <cfqueryparam value="#mls.mlsid#" cfsqltype="cf_sql_integer"> and property_dates.mlsid = <cfqueryparam value="#mls.mlsid#" cfsqltype="cf_sql_integer">	 
    #preservesinglequotes(querycode)#		
  </cfquery>	
  
<!--- Update Next Notification Date --->
<cfquery name="UpdateQuery2" datasource="#mls.dsn#">
  update cl_saved_searches
  set NextNotificationDate = <cfqueryparam value="#DateAdd('d', GetDateMatches.howoften, now())#" cfsqltype="CF_SQL_DATE">
  where  id =  <cfqueryparam value="#GetDateMatches.id#" cfsqltype="CF_SQL_INTEGER"> and clientid = <cfqueryparam value="#GetDateMatches.clientid#" cfsqltype="CF_SQL_VARCHAR">
</cfquery>


<!---START: LOOP THROUGH ALL THE LISTING THAT ARE NOW RETURNED AND SEE IF ANY HAVE NOT BEEN INSERTED IN THE PROPS RETURNED TABLE--->		
  <cfloop query="GetAllListings">
    <cfquery name="GetListing" datasource="#mls.dsn#">
      select *
      from cl_saved_searches_props_returned
      where searchid = <cfqueryparam value="#GetDateMatches.id#" cfsqltype="CF_SQL_INTEGER"> and mlsnumber = '#mlsnumber#' and wsid = '#wsid#' and mlsid = '#mlsid#'
    </cfquery>
    <!---if the listing is not found, that means it is a new listing, insert it and have it ready to be emailed out--->
    <cfif getlisting.recordcount eq 0>
      <cfquery datasource="#mls.dsn#">
        INSERT INTO cl_saved_searches_props_returned (NotifiedYet, mlsnumber, wsid, mlsid, clientid, searchid) 
        VALUES(
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="No">,
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#mlsnumber#">,
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#wsid#">,
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#mlsid#">,
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetDateMatches.clientid#">,
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetDateMatches.id#">			
        )
      </cfquery>
    </cfif>
  </cfloop>
  <!---END: LOOP THROUGH ALL THE LISTING THAT ARE NOW RETURNED AND SEE IF ANY HAVE NOT BEEN INSERTED IN THE PROPS RETURNED TABLE--->		
</cfloop>

<a href="enotify-step-2-send.cfm">Now Go Send The Notifications</a>.

<cfabort>

<cfloop index="i" list="#SearchString#" delimiters="&">
  <cfoutput>
    <!--- #i#  --->
    <cfif i contains "wsid" and listlen(i,'=') gt 1>
      <cfset wsid="#listgetat(i,'2','=')#">
    <cfelse>
      <cfset wsid="">
    </cfif>
    <cfif i contains "pmin" and listlen(i,'=') gt 1>
      <cfset pmin="#listgetat(i,'2','=')#">
    <cfelse>
      <cfset pmin="">
    </cfif>
    <cfif i contains "pmax" and listlen(i,'=') gt 1>
      <cfset pmax="#listgetat(i,'2','=')#">
    <cfelse>
      <cfset pmax="">
    </cfif>
    <cfif i contains "Bedrooms" and listlen(i,'=') eq 1>
      <cfset local.Bedrooms="">7
    <cfelse>
      <cfset local.Bedrooms="#listgetat(i,'1','=')#">6
    </cfif>
    <cfif i contains "Baths_Full" and listlen('Baths_Full') gt 1>
      <cfset Baths_Full="#listgetat(i,'2','=')#">
    <cfelse>
      <cfset Baths_Full="">
    </cfif>
    <cfif i contains "area" and listlen('area') gt 1>
      <cfset area="#listgetat(i,'2','=')#">
    <cfelse>
      <cfset area="">
    </cfif>
    <cfif i contains "mlsnumber" and listlen('mlsnumber') gt 1>
      <cfset mlsnumber="#listgetat(i,'2','=')#">
    <cfelse>
      <cfset mlsnumber="">
    </cfif>
    <cfif i contains "subdivision" and listlen('subdivision') gt 1>
      <cfset subdivision="#listgetat(i,'2','=')#">
    <cfelse>
      <cfset subdivision="">
    </cfif>
    <cfif i contains "StreetAddress" and listlen('StreetAddress') gt 1>
      <cfset StreetAddress="#listgetat(i,'2','=')#">
    <cfelse>
      <cfset StreetAddress="">
    </cfif>
    <cfif i contains "showlistings" and listlen('showlistings') gt 1>
      <cfset showlistings="#listgetat(i,'2','=')#">
    <cfelse>
      <cfset showlistings="">
    </cfif>
    <cfif i contains "KIND" and listlen('KIND') gt 1>
      <cfset KIND="#listgetat(i,'2','=')#">
    <cfelse>
      <cfset KIND="">
    </cfif>
    <cfif i contains "stipulations" and listlen('stipulations') gt 1>
      <cfset stipulations="#listgetat(i,'2','=')#">
    <cfelse>
      <cfset stipulations="">
    </cfif>
    <cfif i contains "Elementary_School" and listlen('Elementary_School') gt 1>
      <cfset Elementary_School="#listgetat(i,'2','=')#">
    <cfelse>
      <cfset Elementary_School="">
    </cfif>
    <cfif i contains "Middle_school" and listlen('Middle_school') gt 1>
      <cfset Middle_school="#listgetat(i,'2','=')#">
    <cfelse>
      <cfset Middle_school="">
    </cfif>
    <cfif i contains "High_School" and listlen('High_School') gt 1>
      <cfset High_School="#listgetat(i,'2','=')#">
    <cfelse>
      <cfset High_School="">
    </cfif>
    <cfif i contains "sortby" and #listlen(i,'=')# gt 1> 
      <cfset sortby="#listgetat(i,'2','=')#">
    <cfelse>
      <cfset sortby=""> 
    </cfif>
    <cfif i contains "FavoriteList" and listlen('FavoriteList') gt 1>
      <cfset FavoriteList="#listgetat(i,'2','=')#">
    <cfelse>
      <cfset FavoriteList="">
    </cfif>
    <cfif i contains "DaysOnMarket" and listlen('FavoriteList') gt 1>
      <cfset DaysOnMarket="#listgetat(i,'2','=')#">
    <cfelse>
      <cfset DaysOnMarket="">
    </cfif>
    <cfif i contains "SQFtMin" and listlen('FavoriteList') gt 1>
      <cfset SQFtMin="#listgetat(i,'2','=')#">
    <cfelse>
      <cfset SQFtMin="">
    </cfif>
    <cfif i contains "SQFtMax" and listlen('FavoriteList') gt 1>
      <cfset SQFtMax="#listgetat(i,'2','=')#">
    <cfelse>
      <cfset SQFtMax="">
    </cfif>
    <cfif i contains "WaterType" and listlen('FavoriteList') gt 1>
      <cfset WaterType="#listgetat(i,'2','=')#">
    <cfelse>
      <cfset WaterType="">
    </cfif> 
    <cfif i contains "Remarks" and listlen('FavoriteList') gt 1>
    <cfset Remarks="#listgetat(i,'2','=')#">
  <cfelse>
    <cfset Remarks="">
  </cfif> 
 <cfif i contains "city" and listlen('FavoriteList') gt 1>
    <cfset city="#listgetat(i,'2','=')#">
  <cfelse>
    <cfset city="">
  </cfif> 

    <br>
  </cfoutput>
</cfloop>