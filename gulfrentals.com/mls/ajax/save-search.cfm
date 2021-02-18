<cfsetting enablecfoutputonly="true">
<cfprocessingdirective suppressWhitespace="true">
<!---START: check search name--->
<cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />

<cfif Cffp.testSubmission(form)>

  <cfquery datasource="#application.settings.dsn#" name="checkname">
    SELECT  searchname
    FROM    cl_saved_searches
    WHERE   clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#cookie.loggedin#">
    AND     searchname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.searchname#">
  </cfquery>

  <!--- Is there already a search with this name? --->
  <cfif checkname.recordcount is not 0>
    <cfoutput>duplicatename</cfoutput>
  <cfelse>
    <!--- Add the relevant search data to the querystring --->
    <!---START: ADDING ALL THE SESSION VALUES THAT COULD EXIST FOR A SAVED SEARCH--->
    <cfif isdefined('session.mlssearch.wsid')>
      <cfset variables.SSwsid = "&wsid=#session.mlssearch.wsid#">
    <cfelse>
      <cfset variables.SSwsid = "">   
    </cfif>         

    <cfif isdefined('session.mlssearch.pmin')>
      <cfset variables.SSPMin = "&pmin=#session.mlssearch.pmin#">
    <cfelse>
      <cfset variables.SSPMin = "">   
    </cfif>

    <cfif isdefined('session.mlssearch.pmax')>
      <cfset variables.SSPMax = "&pmax=#session.mlssearch.pmax#">
    <cfelse>
      <cfset variables.SSPMax = "">   
    </cfif>

    <cfif isdefined('session.mlssearch.Bedrooms')>
      <cfset variables.SSBedrooms = "&Bedrooms=#session.mlssearch.Bedrooms#">
    <cfelse>
      <cfset variables.SSBedrooms = "">   
    </cfif>

    <cfif isdefined('session.mlssearch.Baths_Full')>
      <cfset variables.SSBaths_Full = "&Baths_Full=#session.mlssearch.Baths_Full#">
    <cfelse>
      <cfset variables.SSBaths_Full = ""> 
    </cfif>

    <cfif isdefined('session.mlssearch.area')>
      <cfset variables.SSarea = "&area=#session.mlssearch.area#">
    <cfelse>
      <cfset variables.SSarea = ""> 
    </cfif>

    <cfif isdefined('session.mlssearch.mlsnumber')>
      <cfset variables.SSmlsnumber = "&mlsnumber=#session.mlssearch.mlsnumber#">
    <cfelse>
      <cfset variables.SSmlsnumber = "">  
    </cfif>

    <cfif isdefined('session.mlssearch.subdivision')>
      <cfset variables.SSsubdivision = "&subdivision=#session.mlssearch.subdivision#">
    <cfelse>
      <cfset variables.SSsubdivision = "">    
    </cfif>

    <cfif isdefined('session.mlssearch.StreetAddress')>
      <cfset variables.SSStreetAddress = "&StreetAddress=#session.mlssearch.StreetAddress#">
    <cfelse>
      <cfset variables.SSStreetAddress = "">  
    </cfif>

    <cfif isdefined('session.mlssearch.showlistings')>
      <cfset variables.SSshowlistings = "&showlistings=#session.mlssearch.showlistings#">
    <cfelse>
      <cfset variables.SSshowlistings = "">   
    </cfif>

    <cfif isdefined('session.mlssearch.KIND')>
      <cfset variables.SSKIND = "&KIND=#session.mlssearch.KIND#">
    <cfelse>
      <cfset variables.SSKIND = "">   
    </cfif>

    <cfif isdefined('session.mlssearch.stipulations')>
      <cfset variables.SSstipulations = "&stipulations=#session.mlssearch.stipulations#">
    <cfelse>
      <cfset variables.SSstipulations = "">   
    </cfif>

    <cfif isdefined('session.mlssearch.Elementary_School')>
      <cfset variables.SSElementary_School = "&Elementary_School=#session.mlssearch.Elementary_School#">
    <cfelse>
      <cfset variables.SSElementary_School = "">  
    </cfif>

    <cfif isdefined('session.mlssearch.Middle_school')>
      <cfset variables.SSMiddle_school = "&Middle_school=#session.mlssearch.Middle_school#">
    <cfelse>
      <cfset variables.SSMiddle_school = "">  
    </cfif>

    <cfif isdefined('session.mlssearch.High_School')>
      <cfset variables.SSHigh_School = "&High_School=#session.mlssearch.High_School#">
    <cfelse>
      <cfset variables.SSHigh_School = "">    
    </cfif>

    <cfif isdefined('session.mlssearch.sortby')>
      <cfset variables.SSsortby = "&sortby=#session.mlssearch.sortby#">
    <cfelse>
      <cfset variables.SSsortby = ""> 
    </cfif>

    <cfif isdefined('session.mlssearch.FavoriteList')>
      <cfset variables.SSFavoriteList = "&FavoriteList=#session.mlssearch.FavoriteList#">
    <cfelse>
      <cfset variables.SSFavoriteList = "">   
    </cfif>

    <cfif isdefined('session.mlssearch.DaysOnMarket')>
      <cfset variables.SSDaysOnMarket = "&DaysOnMarket=#session.mlssearch.NumericalDaysOnMarket#">
    <cfelse>
      <cfset variables.SSDaysOnMarket = "">   
    </cfif>

    <cfif isdefined('session.mlssearch.SQFtMin')>
      <cfset variables.SSSQFtMin = "&SQFtMin=#session.mlssearch.SQFtMin#">
    <cfelse>
      <cfset variables.SSSQFtMin = "">    
    </cfif>

    <cfif isdefined('session.mlssearch.SQFtMax')>
      <cfset variables.SSSQFtMax = "&SQFtMax=#session.mlssearch.SQFtMax#">
    <cfelse>
      <cfset variables.SSSQFtMax = "">    
    </cfif>

    <cfif isdefined('session.mlssearch.WaterType')>
      <cfset variables.SSWaterType = "&WaterType=#session.mlssearch.WaterType#">
    <cfelse>
      <cfset variables.SSWaterType = "">  
    </cfif>

    <cfif isdefined('session.mlssearch.Amentities')>
      <cfset variables.SSAmentities = "&Amentities=#session.mlssearch.Amentities#">
    <cfelse>
      <cfset variables.SSAmentities = ""> 
    </cfif>

    <cfif isdefined('session.mlssearch.association_fee')>
      <cfset variables.SSassociation_fee = "&association_fee=#session.mlssearch.association_fee#">
    <cfelse>
      <cfset variables.SSassociation_fee = "">    
    </cfif>

    <cfif isdefined('session.mlssearch.Property_Type')>
      <cfset variables.SSProperty_Type = "&Property_Type=#session.mlssearch.Property_Type#">
    <cfelse>
      <cfset variables.SSProperty_Type = "">  
    </cfif>

    <cfif isdefined('session.mlssearch.remarks')>
      <cfset variables.SSremarks = "&remarks=#session.mlssearch.remarks#">
    <cfelse>
      <cfset variables.SSremarks = "">  
    </cfif>

    <cfif isdefined('session.mlssearch.city')>
      <cfset variables.SScity = "&city=#session.mlssearch.city#">
    <cfelse>
      <cfset variables.SScity = ""> 
    </cfif>

    <cfif isdefined('session.mlssearch.Listing_Agent_Id')>
      <cfset variables.SSListing_Agent_Id = "&Listing_Agent_Id=#session.mlssearch.Listing_Agent_Id#">
    <cfelse>
      <cfset variables.SSListing_Agent_Id = ""> 
    </cfif>

    <cfif isdefined('session.mlssearch.style')>
      <cfset variables.SSstyle = "&style=#session.mlssearch.style#">
    <cfelse>
      <cfset variables.SSstyle = ""> 
    </cfif>

    <cfif isdefined('session.mlssearch.lot_description')>
      <cfset variables.SSlot_description = "&lot_description=#session.mlssearch.lot_description#">
    <cfelse>
      <cfset variables.SSlot_description = ""> 
    </cfif>

    <cfif isdefined('session.mlssearch.rentalname')>
      <cfset variables.SSrentalname = "&rentalname=#session.mlssearch.rentalname#">
    <cfelse>
      <cfset variables.SSrentalname = ""> 
    </cfif>

    <cfset variables.searchparameters = "1=1#variables.SSwsid##variables.SSPMin##variables.SSPMax##variables.SSBedrooms##variables.SSBaths_Full##variables.SSarea##variables.SSmlsnumber##variables.SSsubdivision##variables.SSStreetAddress##variables.SSshowlistings##variables.SSKIND##variables.SSstipulations##variables.SSElementary_School##variables.SSMiddle_school##variables.SSHigh_School##variables.SSsortby##variables.SSFavoriteList##variables.SSDaysOnMarket##variables.SSSQFtMin##variables.SSSQFtMax##variables.SSWaterType##variables.SSAmentities##variables.SSassociation_fee##variables.SSProperty_Type##variables.SSremarks##variables.SScity##variables.SSListing_Agent_Id##variables.SSstyle##variables.SSlot_description##variables.SSrentalname#">

    <cfif isdefined('form.howoften') and howoften is not "0">
      <cfset variables.NextNotificationDate = "#dateformat(dateadd('d',howoften,now()),'yyyy-mm-dd')#">
    </cfif>

    <!---START: INSERT AND SAVE THIS SEARCH--->
    <cfquery datasource="#application.settings.dsn#">
      INSERT INTO cl_saved_searches (
          <cfif isdefined('cookie.loggedin') is "No">TheCFID, TheCFToken,<cfelse>clientid,</cfif>
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
          city,
          Listing_Agent_Id,
          lot_description
          <cfif isdefined('form.howoften') and isnumeric(form.howoften)>,HowOften <cfif form.howoften is not "0">,NextNotificationDate</cfif></cfif>
        ) VALUES (
          <cfif isdefined('cookie.loggedin') is "No"><cfqueryparam value="#CFID#" cfsqltype="CF_SQL_VARCHAR">, <cfqueryparam value="#CFTOKEN#" cfsqltype="CF_SQL_VARCHAR">,<cfelse><cfqueryparam value="#cookie.LoggedIn#" cfsqltype="CF_SQL_VARCHAR">,</cfif>
          <cfif isdefined('form.searchname')><cfqueryparam value="#form.searchname#" cfsqltype="CF_SQL_VARCHAR">,<cfelse>'Tracking Purpose',</cfif>
          <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#variables.searchparameters#">,
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#application.settings.mls.mlsid#">,
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.mlssearch.wsid#">,
          <cfif session.mlssearch.pmin is not ""><cfqueryparam cfsqltype="cf_sql_integer" value="#session.mlssearch.pmin#">,</cfif>
          <cfif session.mlssearch.pmax is not ""><cfqueryparam cfsqltype="cf_sql_integer" value="#session.mlssearch.pmax#">,</cfif>
          <cfif session.mlssearch.bedrooms is not ""><cfqueryparam cfsqltype="cf_sql_integer" value="#session.mlssearch.Bedrooms#">,</cfif>
          <cfif session.mlssearch.baths_full is not ""><cfqueryparam cfsqltype="cf_sql_integer" value="#session.mlssearch.Baths_Full#">,</cfif>
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.mlssearch.area#">,
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.mlssearch.mlsnumber#">,
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.mlssearch.subdivision#">,
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.mlssearch.StreetAddress#">,
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.mlssearch.KIND#">,
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.mlssearch.stipulations#">,
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.mlssearch.Elementary_School#">,
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.mlssearch.Middle_school#">,
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.mlssearch.High_School#">,
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.mlssearch.NumericalDaysOnMarket#">,
          <cfif session.mlssearch.SQFTMin is not ""><cfqueryparam cfsqltype="cf_sql_integer" value="#session.mlssearch.SQFtMin#">,</cfif>
          <cfif session.mlssearch.SQFTMax is not ""><cfqueryparam cfsqltype="cf_sql_integer" value="#session.mlssearch.SQFtMax#">,</cfif>
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.mlssearch.WaterType#">,
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.mlssearch.Amentities#">,
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.mlssearch.association_fee#">,
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.mlssearch.Property_Type#">,
          <cfif isdefined('cookie.numresults') and isNumeric(cookie.numresults)><cfqueryparam cfsqltype="cf_sql_integer" value="#cookie.numresults#"><cfelse>NULL</cfif>,
          <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.mlssearch.remarks#">,
          <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#session.mlssearch.city#">,
          <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#SSListing_Agent_Id#">,
          <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#SSlot_description#">
          <cfif isdefined('form.howoften') and isnumeric(form.howoften)>,<cfqueryparam cfsqltype="cf_sql_integer" value="#HowOften#"><cfif form.howoften is not "0">,<cfqueryparam cfsqltype="cf_sql_date" value="#NextNotificationDate#"></cfif></cfif>
        )
    </cfquery>

    <cfif isdefined('application.settings.contactuallyClient') and application.settings.contactuallyClient is 'yes' and
          isDefined('cookie.loggedInC') and len(cookie.loggedInC)>
      <!--- call contactually addNote - save search --->   
      <cfset variables.argStruct = structNew() />
      <cfset variables.argStruct.contactId = cookie.loggedInC />
      <cfset variables.argStruct.note = 'SAVE Search - <a href="#getPageContext().getRequest().getScheme()#://#cgi.server_name#/mls/results#variables.searchparameters#&clearsession=&dontcountsearch=" target="_blank">View Search Results</a>' />
      <cfset variables.cResponse = application.contactually.addNote(argumentCollection = variables.argStruct) />
      <!--- end contactually addNote - save search --->  
    </cfif>

    <cfoutput>yes</cfoutput>
  </cfif>
<cfelse><!--- cfformprotect if --->
  <cfoutput>formprotectfail</cfoutput>
</cfif>
</cfprocessingdirective>