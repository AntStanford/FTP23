<cfinclude template="/mls/includes/session-killer.cfm">

<cfparam name="amentities" default="">
<cfparam name="area" default=""> 
<cfparam name="association_fee" default=""> 
<cfparam name="baths_full" default="">
<cfparam name="bedrooms" default=""> 
<cfparam name="daysonmarket" default="">
<cfparam name="elementary_school" default=""> 
<cfparam name="enotifydate" default="">
<cfparam name="enotifydatesearchid" default=""> 
<cfparam name="favoritelist" default=""> 
<cfparam name="foreclosure" default=""> 
<cfparam name="high_school" default=""> 
<cfparam name="kind" default=""> 
<cfparam name="lot_description" default=""> 
<cfparam name="middle_school" default=""> 
<cfparam name="mlsid" default=""> 
<cfparam name="mlsnumber" default=""> 
<cfparam name="numericaldaysonmarket" default=""> 
<cfparam name="pmax" default=""> 
<cfparam name="pmin" default=""> 
<cfparam name="property_type" default="">
<cfparam name="referringsite" default=""> 
<cfparam name="remembermepage" default=""> 
<cfparam name="searchpage" default="">
<cfparam name="shortsale" default=""> 
<cfparam name="showlistings" default=""> 
<cfparam name="sortby" default="">
<cfparam name="sqftmax" default=""> 
<cfparam name="sqftmin" default=""> 
<cfparam name="stipulations" default="">
<cfparam name="streetaddress" default=""> 
<cfparam name="subdivision" default=""> 
<cfparam name="watertype" default=""> 
<cfparam name="wsid" default="">
<cfparam name="session.NumericalDaysOnMarket" default="">


<cfinclude template="/mls/includes/parse-search-parameters.cfm">
<cfinclude template="/mls/search-results_query.cfm">








<!---START: ADDING ALL THE SESSION VALUES THAT COULD EXIST FOR A SAVED SEARCH--->
<cfif isdefined('session.wsid')>
  <cfset SSwsid = "&wsid=#session.wsid#">
<cfelse>
  <cfset SSwsid = "">	
</cfif>			

<cfif isdefined('session.pmin')>
  <cfset SSPMin = "&pmin=#session.pmin#">
<cfelse>
  <cfset SSPMin = "">	
</cfif>

<cfif isdefined('session.pmax')>
  <cfset SSPMax = "&pmax=#session.pmax#">
<cfelse>
  <cfset SSPMax = "">	
</cfif>

<cfif isdefined('session.Bedrooms')>
  <cfset SSBedrooms = "&Bedrooms=#session.Bedrooms#">
<cfelse>
  <cfset SSBedrooms = "">	
</cfif>

<cfif isdefined('session.Baths_Full')>
  <cfset SSBaths_Full = "&Baths_Full=#session.Baths_Full#">
<cfelse>
  <cfset SSBaths_Full = "">	
</cfif>

<cfif isdefined('session.area')>
  <cfset SSarea = "&area=#session.area#">
<cfelse>
  <cfset SSarea = "">	
</cfif>

<cfif isdefined('session.mlsnumber')>
  <cfset SSmlsnumber = "&mlsnumber=#session.mlsnumber#">
<cfelse>
  <cfset SSmlsnumber = "">	
</cfif>

<cfif isdefined('session.subdivision')>
  <cfset SSsubdivision = "&subdivision=#session.subdivision#">
<cfelse>
  <cfset SSsubdivision = "">	
</cfif>

<cfif isdefined('session.StreetAddress')>
  <cfset SSStreetAddress = "&StreetAddress=#session.StreetAddress#">
<cfelse>
  <cfset SSStreetAddress = "">	
</cfif>

<cfif isdefined('session.showlistings')>
  <cfset SSshowlistings = "&showlistings=#session.showlistings#">
<cfelse>
  <cfset SSshowlistings = "">	
</cfif>

<cfif isdefined('session.KIND')>
  <cfset SSKIND = "&KIND=#session.KIND#">
<cfelse>
  <cfset SSKIND = "">	
</cfif>

<cfif isdefined('session.stipulations')>
  <cfset SSstipulations = "&stipulations=#session.stipulations#">
<cfelse>
  <cfset SSstipulations = "">	
</cfif>

<cfif isdefined('session.Elementary_School')>
  <cfset SSElementary_School = "&Elementary_School=#session.Elementary_School#">
<cfelse>
  <cfset SSElementary_School = "">	
</cfif>

<cfif isdefined('session.Middle_school')>
  <cfset SSMiddle_school = "&Middle_school=#session.Middle_school#">
<cfelse>
  <cfset SSMiddle_school = "">	
</cfif>

<cfif isdefined('session.High_School')>
  <cfset SSHigh_School = "&High_School=#session.High_School#">
<cfelse>
  <cfset SSHigh_School = "">	
</cfif>

<cfif isdefined('session.sortby')>
  <cfset SSsortby = "&sortby=#session.sortby#">
<cfelse>
  <cfset SSsortby = "">	
</cfif>

<cfif isdefined('session.FavoriteList')>
  <cfset SSFavoriteList = "&FavoriteList=#session.FavoriteList#">
<cfelse>
  <cfset SSFavoriteList = "">	
</cfif>

<cfif isdefined('session.DaysOnMarket') and LEN(session.DaysOnMarket)>
  <cfset SSDaysOnMarket = "&DaysOnMarket=#session.NumericalDaysOnMarket#">
<cfelse>
  <cfset SSDaysOnMarket = "">	
</cfif>

<cfif isdefined('session.SQFtMin')>
  <cfset SSSQFtMin = "&SQFtMin=#session.SQFtMin#">
<cfelse>
  <cfset SSSQFtMin = "">	
</cfif>

<cfif isdefined('session.SQFtMax')>
  <cfset SSSQFtMax = "&SQFtMax=#session.SQFtMax#">
<cfelse>
  <cfset SSSQFtMax = "">	
</cfif>

<cfif isdefined('session.WaterType')>
  <cfset SSWaterType = "&WaterType=#session.WaterType#">
<cfelse>
  <cfset SSWaterType = "">	
</cfif>

<cfif isdefined('session.Amentities')>
  <cfset SSAmentities = "&Amentities=#session.Amentities#">
<cfelse>
  <cfset SSAmentities = "">	
</cfif>

<cfif isdefined('session.association_fee')>
  <cfset SSassociation_fee = "&association_fee=#session.association_fee#">
<cfelse>
  <cfset SSassociation_fee = "">	
</cfif>

<cfif isdefined('session.Property_Type')>
  <cfset SSProperty_Type = "&Property_Type=#session.Property_Type#">
<cfelse>
  <cfset SSProperty_Type = "">	
</cfif>

<cfif isdefined('session.lot_description')>
  <cfset lot_description = "&lot_description=#session.lot_description#">
<cfelse>
  <cfset lot_description = "">	
</cfif>

<cfif isdefined('session.shortsale')>
  <cfset shortsale = "&shortsale=#session.shortsale#">
<cfelse>
  <cfset shortsale = "">  
</cfif>

<cfif isdefined('session.foreclosure')>
  <cfset foreclosure = "&foreclosure=#session.foreclosure#">
<cfelse>
  <cfset foreclosure = "">  
</cfif>

<cfset searchparameters = "1=1#SSwsid##SSPMin##SSPMax##SSBedrooms##SSBaths_Full##SSarea##SSmlsnumber##SSsubdivision##SSStreetAddress##SSshowlistings##SSKIND##SSstipulations##SSElementary_School##SSMiddle_school##SSHigh_School##SSsortby##SSFavoriteList##SSDaysOnMarket##SSSQFtMin##SSSQFtMax##SSWaterType##SSAmentities##SSassociation_fee##SSProperty_Type##lot_description##shortsale##foreclosure#">
<!---END: ADDING ALL THE SESSION VALUES THAT COULD EXIST FOR A SAVED SEARCH--->



<cfif isdefined('howoften') and howoften is not "0">
  <cfset NextNotificationDate = "#dateformat(dateadd('d',howoften,now()),'yyyy-mm-dd')#">
</cfif>

<cfquery datasource="#DSNMLS#" name="COUNTINFO">
  SELECT COUNT(mastertable.mlsnumber) as thecount
  FROM mastertable
  Inner Join property_dates
  where mastertable.MLSNumber =  property_dates.mlsnumber and mastertable.mlsid = <cfqueryparam value="#mls.mlsid#" cfsqltype="CF_SQL_VARCHAR">  and property_dates.mlsid = <cfqueryparam value="#mls.mlsid#" cfsqltype="CF_SQL_VARCHAR">	
  #preservesinglequotes(querycode)#
</cfquery>


<!---START: INSERT AND SAVE THIS SEARCH--->
<cfquery datasource="#mls.dsn#" dbtype="ODBC">
  Insert 
  Into cl_saved_searches
    (clientid,
     searchname,
     searchparameters,
     lot_description,									 	 
     mlsid,
     wsid,
     <cfif session.pmin is not "">pmin,</cfif>
     <cfif session.pmax is not "">pmax,</cfif>
     <cfif session.bedrooms is not "">Bedrooms,</cfif>
     <cfif session.baths_full is not "">Baths_Full,</cfif>
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
     <cfif session.SQFtMin is not "">SQFtMin,</cfif>
     <cfif session.SQFtMax is not "">SQFtMax,</cfif>
     WaterType,
     Amentities,
     shortsale,
     foreclosure,
     association_fee,
     Property_Type,										 
     NumberOfMatches
     <cfif isdefined('howoften')>,HowOften <cfif howoften is not "0">,NextNotificationDate</cfif></cfif> ) 
  Values 
    (<cfqueryparam value="#form.clientid#" cfsqltype="CF_SQL_VARCHAR">,
     <cfif isdefined('form.searchname')>
       <cfqueryparam value="#form.searchname#" cfsqltype="CF_SQL_VARCHAR">,		
     <cfelse>
       <cfqueryparam value="Tracking Purpose" cfsqltype="CF_SQL_VARCHAR">,
     </cfif>
     '#searchparameters#',
     <cfqueryparam value="#session.lot_description#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#mls.mlsid#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.wsid#" cfsqltype="CF_SQL_VARCHAR">,
     <cfif session.pmin is not ""><cfqueryparam value="#session.pmin#" cfsqltype="CF_SQL_INTEGER">,</cfif>
     <cfif session.pmax is not ""><cfqueryparam value="#session.pmax#" cfsqltype="CF_SQL_INTEGER">,</cfif>
     <cfif session.bedrooms is not "" and isdefined('ParsedBedrooms')>
          <cfqueryparam value="#ParsedBedrooms#" cfsqltype="CF_SQL_VARCHAR">,
        <cfelseif session.bedrooms is not "" and NOT isdefined('ParsedBedrooms')>
          <cfqueryparam value="#session.bedrooms#" cfsqltype="CF_SQL_VARCHAR">,
      </cfif>
     <cfif session.baths_full is not ""><cfqueryparam value="#session.Baths_Full#" cfsqltype="CF_SQL_INTEGER">,</cfif>
     <cfqueryparam value="#session.area#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.mlsnumber#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.subdivision#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.StreetAddress#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.KIND#" cfsqltype="CF_SQL_VARCHAR"> ,
     <cfqueryparam value="#session.stipulations#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.Elementary_School#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.Middle_school#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.High_School#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.NumericalDaysOnMarket#" cfsqltype="CF_SQL_VARCHAR">,
     <cfif session.SQFTMin is not ""><cfqueryparam value="#session.SQFtMin#" cfsqltype="CF_SQL_INTEGER">,</cfif>
     <cfif session.SQFTMax is not ""><cfqueryparam value="#session.SQFtMax#" cfsqltype="CF_SQL_INTEGER">,</cfif>
     <cfqueryparam value="#session.WaterType#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.Amentities#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.shortsale#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.foreclosure#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.association_fee#" cfsqltype="CF_SQL_VARCHAR">,
     <cfqueryparam value="#session.Property_Type#" cfsqltype="CF_SQL_VARCHAR">,
     <cfif isdefined('propertycount')>'#propertycount#'<cfelse>'#COUNTINFO.thecount#'</cfif>
     <cfif isdefined('howoften')>,'#HowOften#'<cfif howoften is not "0">,'#NextNotificationDate#'</cfif></cfif>
    )
</cfquery>
<!---END: INSERT AND SAVE THIS SEARCH--->



<!---only save the properties of this search is the session isdefined and a human saved the search, this is used for the enotify scheduled task--->
<cfif isdefined('cookie.loggedin') and isdefined('processform') and howoften is not "0">

  <cfquery datasource="#mls.dsn#" name="GetSavedSearchID">
    SELECT max(id) as MaxSavedID
    from cl_saved_searches
    where clientid = <cfqueryparam value="#form.clientid#" cfsqltype="CF_SQL_VARCHAR">	
  </cfquery>
  <cfquery datasource="#DSNMLS#" name="GetAllListings">
    SELECT 
      mastertable.*,
      property_dates.created_at
    FROM mastertable
    Inner Join property_dates
    where mastertable.MLSNumber =  property_dates.mlsnumber and mastertable.mlsid = <cfqueryparam value="#mls.mlsid#" cfsqltype="CF_SQL_VARCHAR"> and property_dates.mlsid = <cfqueryparam value="#mls.mlsid#" cfsqltype="CF_SQL_VARCHAR">		 
    #preservesinglequotes(querycode)#		
  </cfquery>
 <cfloop query="GetAllListings">
     <cfquery datasource="#mls.dsn#">
      INSERT INTO cl_saved_searches_props_returned (NotifiedYet, mlsnumber, wsid, mlsid, clientid, searchid) 
      VALUES(
        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="Yes">,
        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#mlsnumber#">,
        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#wsid#">,
        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#mlsid#">,
        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.clientid#">,
        <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetSavedSearchID.MaxSavedID#">			
      )
    </cfquery>
  </cfloop>
</cfif>



<h3 style="color:red;">Custom Search has been saved and Notification has been scheduled.</h3>

