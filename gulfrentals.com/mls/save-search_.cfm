<!---START: ADDING ALL THE SESSION VALUES THAT COULD EXIST FOR A SAVED SEARCH--->
<cfif isdefined('session.mlssearch.wsid')>
  <cfset SSwsid = "&wsid=#trim(session.mlssearch.wsid)#">
<cfelse>
  <cfset SSwsid = "">
</cfif>

<cfif isdefined('session.mlssearch.pmin')>
  <cfset SSPMin = "&pmin=#trim(session.mlssearch.pmin)#">
<cfelse>
  <cfset SSPMin = "">
</cfif>

<cfif isdefined('session.mlssearch.pmax')>
  <cfset SSPMax = "&pmax=#trim(session.mlssearch.pmax)#">
<cfelse>
  <cfset SSPMax = "">
</cfif>

<cfif isdefined('session.mlssearch.Bedrooms')>
  <cfset SSBedrooms = "&Bedrooms=#trim(session.mlssearch.Bedrooms)#">
<cfelse>
  <cfset SSBedrooms = "">
</cfif>

<cfif isdefined('session.mlssearch.Baths_Full')>
  <cfset SSBaths_Full = "&Baths_Full=#trim(session.mlssearch.Baths_Full)#">
<cfelse>
  <cfset SSBaths_Full = "">
</cfif>

<cfif isdefined('session.mlssearch.area')>
  <cfset SSarea = "&area=#trim(session.mlssearch.area)#">
<cfelse>
  <cfset SSarea = "">
</cfif>

<cfif isdefined('session.mlssearch.mlsnumber')>
  <cfset SSmlsnumber = "&mlsnumber=#trim(session.mlssearch.mlsnumber)#">
<cfelse>
  <cfset SSmlsnumber = "">
</cfif>

<cfif isdefined('session.mlssearch.subdivision')>
  <cfset SSsubdivision = "&subdivision=#trim(session.mlssearch.subdivision)#">
<cfelse>
  <cfset SSsubdivision = "">
</cfif>

<cfif isdefined('session.mlssearch.StreetAddress')>
  <cfset SSStreetAddress = "&StreetAddress=#trim(session.mlssearch.StreetAddress)#">
<cfelse>
  <cfset SSStreetAddress = "">
</cfif>

<cfif isdefined('session.mlssearch.showlistings')>
  <cfset SSshowlistings = "&showlistings=#trim(session.mlssearch.showlistings)#">
<cfelse>
  <cfset SSshowlistings = "">
</cfif>

<cfif isdefined('session.mlssearch.KIND')>
  <cfset SSKIND = "&KIND=#trim(session.mlssearch.KIND)#">
<cfelse>
  <cfset SSKIND = "">
</cfif>

<cfif isdefined('session.mlssearch.stipulations')>
  <cfset SSstipulations = "&stipulations=#trim(session.mlssearch.stipulations)#">
<cfelse>
  <cfset SSstipulations = "">
</cfif>

<cfif isdefined('session.mlssearch.Elementary_School')>
  <cfset SSElementary_School = "&Elementary_School=#trim(session.mlssearch.Elementary_School)#">
<cfelse>
  <cfset SSElementary_School = "">
</cfif>

<cfif isdefined('session.mlssearch.Middle_school')>
  <cfset SSMiddle_school = "&Middle_school=#trim(session.mlssearch.Middle_school)#">
<cfelse>
  <cfset SSMiddle_school = "">
</cfif>

<cfif isdefined('session.mlssearch.High_School')>
  <cfset SSHigh_School = "&High_School=#trim(session.mlssearch.High_School)#">
<cfelse>
  <cfset SSHigh_School = "">
</cfif>

<cfif isdefined('session.mlssearch.sortby')>
  <cfset SSsortby = "&sortby=#trim(session.mlssearch.sortby)#">
<cfelse>
  <cfset SSsortby = "">
</cfif>

<cfif isdefined('session.mlssearch.FavoriteList')>
  <cfset SSFavoriteList = "&FavoriteList=#trim(session.mlssearch.FavoriteList)#">
<cfelse>
  <cfset SSFavoriteList = "">
</cfif>

<cfif isdefined('session.mlssearch.DaysOnMarket')>
  <cfset SSDaysOnMarket = "&DaysOnMarket=#trim(session.mlssearch.NumericalDaysOnMarket)#">
<cfelse>
  <cfset SSDaysOnMarket = "">
</cfif>

<cfif isdefined('session.mlssearch.SQFtMin')>
  <cfset SSSQFtMin = "&SQFtMin=#trim(session.mlssearch.SQFtMin)#">
<cfelse>
  <cfset SSSQFtMin = "">
</cfif>

<cfif isdefined('session.mlssearch.SQFtMax')>
  <cfset SSSQFtMax = "&SQFtMax=#trim(session.mlssearch.SQFtMax)#">
<cfelse>
  <cfset SSSQFtMax = "">
</cfif>

<cfif isdefined('session.mlssearch.WaterType')>
  <cfset SSWaterType = "&WaterType=#trim(session.mlssearch.WaterType)#">
<cfelse>
  <cfset SSWaterType = "">
</cfif>

<cfif isdefined('session.mlssearch.Amentities')>
  <cfset SSAmentities = "&Amentities=#trim(session.mlssearch.Amentities)#">
<cfelse>
  <cfset SSAmentities = "">
</cfif>

<cfif isdefined('session.mlssearch.association_fee')>
  <cfset SSassociation_fee = "&association_fee=#trim(session.mlssearch.association_fee)#">
<cfelse>
  <cfset SSassociation_fee = "">
</cfif>

<cfif isdefined('session.mlssearch.Property_Type')>
  <cfset SSProperty_Type = "&Property_Type=#trim(session.mlssearch.Property_Type)#">
<cfelse>
  <cfset SSProperty_Type = "">
</cfif>

<cfif isdefined('session.mlssearch.remarks')>
  <cfset SSremarks = "&remarks=#trim(session.mlssearch.remarks)#">
<cfelse>
  <cfset SSremarks = "">
</cfif>

<cfif isdefined('session.mlssearch.city')>
  <cfset SScity = "&city=#trim(session.mlssearch.city)#">
<cfelse>
  <cfset SScity = "">
</cfif>

<cfif isdefined('session.mlssearch.lot_description')>
  <cfset SSlot_description = "&lot_description=#trim(session.mlssearch.lot_description)#">
<cfelse>
  <cfset SSlot_description = "">
</cfif>



<cfset searchparameters = "1=1#SSwsid##SSPMin##SSPMax##SSBedrooms##SSBaths_Full##SSarea##SSmlsnumber##SSsubdivision##SSStreetAddress##SSshowlistings##SSKIND##SSstipulations##SSElementary_School##SSMiddle_school##SSHigh_School##SSsortby##SSFavoriteList##SSDaysOnMarket##SSSQFtMin##SSSQFtMax##SSWaterType##SSAmentities##SSassociation_fee##SSProperty_Type##SSremarks##SScity##SSlot_description#">
<!---END: ADDING ALL THE SESSION VALUES THAT COULD EXIST FOR A SAVED SEARCH--->



<cfif isdefined('howoften') and howoften is not "0">
  <cfset NextNotificationDate = "#dateformat(dateadd('d',howoften,now()),'yyyy-mm-dd')#">
</cfif>



<!---START: INSERT AND SAVE THIS SEARCH--->
<cfquery datasource="#application.settings.dsn#" dbtype="ODBC" result="insSrch">
  Insert
  Into cl_saved_searches

    (
    <cfif isdefined('cookie.loggedin') is "No">
       TheCFID, TheCFToken,
     <cfelse>
       clientid,
     </cfif>
     searchname,
     searchparameters,
     mlsid,
     wsid,
     <cfif session.mlssearch.pmin is not "">pmin,</cfif>
     <cfif session.mlssearch.pmax is not "">pmax,</cfif>
     <cfif session.mlssearch.bedrooms is not "">Bedrooms,</cfif>
     <cfif session.mlssearch.baths_full is not "">Baths_Full,</cfif>
     area,
     mlsnumber,
     subdivision,
     StreetAddress,
     KIND,
     stipulations,
     Elementary_School,
     Middle_School,
     High_School,
     DaysOnMarket,
     <cfif session.mlssearch.SQFtMin is not "">SQFtMin,</cfif>
     <cfif session.mlssearch.SQFtMax is not "">SQFtMax,</cfif>
     WaterType,
     Amentities,
     association_fee,
     Property_Type,
     NumberOfMatches,
     remarks,
     city
     <cfif isdefined('howoften')>,HowOften <cfif howoften is not "0">,NextNotificationDate</cfif></cfif> )
  Values
    (
    <cfif isdefined('cookie.loggedin') is "No">
       <cfqueryparam value="#CFID#" cfsqltype="CF_SQL_VARCHAR">,
       <cfqueryparam value="#CFTOKEN#" cfsqltype="CF_SQL_VARCHAR">,
     <cfelse>
       <cfqueryparam value="#cookie.LoggedIn#" cfsqltype="CF_SQL_VARCHAR">,
     </cfif>
     <cfif isdefined('form.searchname')>
       <cfqueryparam value="#form.searchname#" cfsqltype="CF_SQL_VARCHAR">,
     <cfelse>
       <cfqueryparam value="Tracking Purpose" cfsqltype="CF_SQL_VARCHAR">,
     </cfif>
     <cfqueryparam value="#searchparameters#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#settings.mls.mlsid#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.mlssearch.wsid#" cfsqltype="CF_SQL_VARCHAR">,
     <cfif session.mlssearch.pmin is not ""><cfqueryparam value="#session.mlssearch.pmin#" cfsqltype="CF_SQL_INTEGER">,</cfif>
     <cfif session.mlssearch.pmax is not ""><cfqueryparam value="#session.mlssearch.pmax#" cfsqltype="CF_SQL_INTEGER">,</cfif>
     <cfif session.mlssearch.bedrooms is not ""><cfqueryparam value="#session.mlssearch.Bedrooms#" cfsqltype="CF_SQL_INTEGER">,</cfif>
     <cfif session.mlssearch.baths_full is not ""><cfqueryparam value="#session.mlssearch.Baths_Full#" cfsqltype="CF_SQL_INTEGER">,</cfif>
     <cfqueryparam value="#session.mlssearch.area#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.mlssearch.mlsnumber#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.mlssearch.subdivision#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.mlssearch.StreetAddress#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.mlssearch.KIND#" cfsqltype="CF_SQL_VARCHAR"> ,
     <cfqueryparam value="#session.mlssearch.stipulations#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.mlssearch.Elementary_School#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.mlssearch.Middle_school#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.mlssearch.High_School#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.mlssearch.NumericalDaysOnMarket#" cfsqltype="CF_SQL_VARCHAR">,
     <cfif session.mlssearch.SQFTMin is not ""><cfqueryparam value="#session.mlssearch.SQFtMin#" cfsqltype="CF_SQL_INTEGER">,</cfif>
     <cfif session.mlssearch.SQFTMax is not ""><cfqueryparam value="#session.mlssearch.SQFtMax#" cfsqltype="CF_SQL_INTEGER">,</cfif>
     <cfqueryparam value="#session.mlssearch.WaterType#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.mlssearch.Amentities#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.mlssearch.association_fee#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.mlssearch.Property_Type#" cfsqltype="CF_SQL_VARCHAR">,
     <cfif isdefined('propertycount')>'#propertycount#'<cfelse>'#COUNTINFO.thecount#'</cfif>,
     <cfqueryparam value="#session.mlssearch.remarks#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.mlssearch.city#" cfsqltype="CF_SQL_longVARCHAR">
     <cfif isdefined('howoften')>,'#HowOften#'<cfif howoften is not "0">,'#NextNotificationDate#'</cfif></cfif>
    )
</cfquery>
<!---END: INSERT AND SAVE THIS SEARCH--->



<!---only save the properties of this search is the session isdefined and a human saved the search, this is used for the enotify scheduled task--->
<cfif isdefined('cookie.loggedin') and isdefined('processform') and howoften is not "0">

   <cfif isdefined('session.mls.qResults.query') and isQuery(session.mls.qResults.query) and isdefined('session.mls.qResults.query') and isQuery(session.mls.qResults.query)>

    <cfquery datasource="#application.dsn#">
      INSERT INTO cl_saved_searches_props_returned (NotifiedYet, mlsnumber, wsid, mlsid, clientid, searchid)
      VALUES
      <cfloop query="session.mls.qResults.query">
      (
        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="Yes">,
        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.mls.qResults.query.mlsnumber#">,
        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.mls.qResults.query.wsid#">,
        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.mls.qResults.query.mlsid#">,
        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cookie.loggedin#">,
        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#insSrch.generatedkey#">
      ) <cfif currentrow lt recordcount>,</cfif>
      </cfloop>
    </cfquery>

   </cfif>

</cfif>