<cfset LoginCookiePersist = 30>

<cfset request.cache_timeout = createtimespan(0,0,2,0)>

<cfif !structKeyExists(application.settings, "mls") OR structKeyExists(url,"init") OR !isdefined('settings.mls.propertydsn')>

   <cfset settings.mls = structNew()>

   <cfquery name="getclientinfo" dataSource="mlsv30master">
   select * from mls_clients where devURL = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#cgi.server_name#">
   or liveURL =<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#replacenocase(cgi.server_name,'www.','')#">
   </cfquery>

   <cfif getclientinfo.recordcount eq 0>
   No client record found. <cfabort>
   </cfif>

   <cfset settings.mls = queryRowToStruct(getclientinfo)>

   <!--- Struct is reinitialized so gets wiped out --->
   <cfset settings.mls.dir = application.mls.dir>

   <cfset settings.mls.propertydsn = "mlsv30master">

   <cfif !isdefined('session.ReferringSite')>
      <cfset session.ReferringSite = cgi.HTTP_REFERER>
   </cfif>

  <cfset application.settings.mls = settings.mls>
</cfif>

<cfif structKeyExists(application,"oMLS") eq false or structKeyExists(url,"init")>
   <cfset application.oMLS = createObject("component","mls").init(application.settings)>
</cfif>

<cfif structKeyExists(application,"oFields") eq false or structKeyExists(url,"init")>
   <cfset application.oFields = createObject("component","fields").init(application.settings)>

</cfif>

<cfif structKeyExists(application,"oHelpers") eq false or structKeyExists(url,"init") or 1 is 1>
   <cfset application.oHelpers = createObject("component","helpers").init()>
</cfif>

<cfif
   isdefined("application.settings.mls.EnableRoundRobin") eq false or
   isdefined("application.settings.mls.getMasterAreas") eq false or
   structKeyExists(url,"init")>

   <cflock scope="Application" timeout="30">

      <cfset application.settings.mls.EnableRoundRobin="Yes">
      <cfset application.settings.mls.getCities = application.oMLS.getCities()>
      <cfset application.settings.mls.getCommunityFeatures = application.oMLS.getCommunityFeatures()>
      <cfset application.settings.mls.getElementarySchools = application.oMLS.getElementarySchools()>
      <cfset application.settings.mls.getHighSchools = application.oMLS.getHighSchools()>
      <cfset application.settings.mls.getKinds = application.oMLS.getKinds()>
      <cfset application.settings.mls.getMasterAreas = application.oFields.getAreaSettings(application.settings.id)>
      <cfset application.settings.mls.getMasterCities = application.oFields.getCitySettings(application.settings.id)>
      <cfset application.settings.mls.getSubdivisions = application.oMLS.getSubdivisions()>

      <cfset application.settings.mls.getWaterViews = application.oMLS.getWaterViews()>
      <cfset application.settings.mls.getPools = application.oMLS.getPools()>
      <cfset application.settings.mls.getKinds = application.oMLS.getKinds()>

      <!---
      <cfset application.settings.mls.getAdvancedSearchAreas =  application.oFields.getSearchAreas("advanced")>
      <cfset application.settings.mls.getRefineSearchAreas =  application.oFields.getSearchAreas("refine")>
      <cfset application.settings.mls.getQuickSearchAreas =  application.oFields.getSearchAreas("quick")>
      --->

      <cfset application.settings.mls.getMiddleSchools = application.oMLS.getMiddleSchools()>
      <cfset application.settings.mls.getmlscoinfo = application.oMLS.getMLSFeeds()>
      <cfset application.settings.mls.getWaterTypes = application.oMLS.getWaterTypes()>
      <cfset application.settings.mls.getMarketTrend = application.oMLS.getMarketTrend()>
      <cfset application.settings.mls.minmaxes = application.oMLS.getMinMaxes()>
      <cfset application.settings.mls.fieldsettings = application.oFields.getFieldSettings(application.settings.id)> <!--- move to oFields if above on go live--->

      <cfquery name="listAgents" datasource="#settings.dsn#" >
        SELECT  firstname,lastname,agentMLSId
        FROM    cl_agents
        WHERE   agentmlsid IS NOT NULL
        AND     agentmlsid !=''
        <!--- AND     (firstname != 'Brandon' AND lastname != 'Sauls') --->
        ORDER BY firstname
      </cfquery>
      <cfset application.settings.mls.agents = listAgents />

      <cfif application.settings.mls.EnableRoundRobin is 'yes'>
        <cfquery datasource="#settings.dsn#" name="GetAgents">
          SELECT  *
          FROM    cl_agents
          WHERE   roundrobin = 'Yes'
          ORDER BY firstname
        </cfquery>
        <cfset application.settings.mls.rrAgents = GetAgents />
      </cfif>      

      <cfquery datasource="#application.settings.mls.propertydsn#" name="getareas">
        SELECT city,id
        FROM masterareas_cleaned
        where mlsid = '#application.settings.mls.MLSID#'
        and id in (
           Select masterareas_cleaned_id
           From fields_areas
           Where siteid = #settings.mls.id# and display_on_refine = 1
          )
        order by city
      </cfquery>

      <cfset application.settings.mls.getareas = getareas />

      <cfquery name="Watertype" datasource="#settings.mls.propertydsn#" >
        <!--- SELECT distinct concat_ws(',',TRIM(mastertable.waterfront_type),TRIM(mastertable.water_view_type)) as WaterTypes
        FROM mastertable
        where mlsid= '#settings.mls.mlsid#' --->
    <!--- changed by Jeno on 8/20/2018 for task http://pt.icnd.net/projects/view-task.cfm?projectID=538&taskid=26415 --->
    SELECT distinct concat_ws(',',TRIM(mastertable.waterfront_type),TRIM(mastertable.water_view_type)) as WaterTypes
    FROM mastertable  where mlsid= '#settings.mls.mlsid#'
    and mastertable.waterfront_type in ('Oceanfront','Oceanside','Soundfront','Semi-Soundfront','Soundside','Canalfront','Harborfront','Creekfront','Pondfront','Lakefront')
    UNION ALL
    SELECT distinct
    (case when city rlike 'Oceanside' then 'Oceanside' end) as WaterTypes FROM masterareas_cleaned
        where mlsid= '#settings.mls.mlsid#' and city rlike 'Oceanside'
      </cfquery>
      <cfset TheWaterTypes = '' />
      <cfif Watertype.recordcount gt 0 and Watertype.watertypes is not "">
        <cfset TheWaterTypes = #valuelist(Watertype.WaterTypes)#>
        <cfset TheWaterTypes = #listRemoveDuplicates(TheWaterTypes)#>
        <cfset TheWaterTypes = #listsort(TheWaterTypes,'text','asc',',')#>
      </cfif>
      <cfset application.settings.mls.watertypes = TheWaterTypes />

   </cflock>

</cfif>

<cfset settings = application.settings>

<cfif structKeyExists(COOKIE,"MLSFAVORITES") is false>
   <cfcookie name="MLSFAVORITES" value="" expires="NEVER">
</cfif>

<cfif structKeyExists(COOKIE,"MLSRECENT") is false>
   <cfcookie name="MLSRECENT" value="" expires="NEVER">
</cfif>

<cffunction name="initSessionVars">
   <cfif structKeyExists(SESSION,"mlssearch") is false>
      <cfset session.mlssearch =structNew()>
   </cfif>

   <!--- Create the default variables so we don't have to use structKeyExists all the time. --->
   <cfparam name="sesssion.mlssearch.listing_agent_id" default="">
   <cfparam name="session.mlssearch.Amentities" default=""> <!--- varchar --->
   <cfparam name="session.mlssearch.area" default=""> <!--- varchar --->
   <cfparam name="session.mlssearch.association_fee" default=""> <!--- varchar --->
   <cfparam name="session.mlssearch.Baths_Full" default=""> <!--- int --->
   <cfparam name="session.mlssearch.Bedrooms" default=""> <!--- int --->
   <cfparam name="session.mlssearch.city" default=""> <!--- text --->
   <cfparam name="session.mlssearch.DaysOnMarket" default=""> <!--- varchar --->
   <cfparam name="session.mlssearch.Elementary_School" default=""> <!--- varchar --->
   <cfparam name="session.mlssearch.enotifydate" default="">
   <cfparam name="session.mlssearch.enotifydatesearchid" default="">
   <cfparam name="session.mlssearch.FavoriteList" default="">
   <cfparam name="session.mlssearch.High_School" default=""> <!--- varchar --->
   <cfparam name="session.mlssearch.KIND" default=""> <!--- varchar --->
   <cfparam name="session.mlssearch.Middle_school" default=""> <!--- varchar --->
   <cfparam name="session.mlssearch.mlsnumber" default=""> <!--- varchar, check for int --->
   <cfparam name="session.mlssearch.NumericalDaysOnMarket" default=""> <!--- varchar --->
   <cfparam name="session.mlssearch.PMAX" default="999999999"> <!--- int --->
   <cfparam name="session.mlssearch.PMIN" default="0"> <!--- int --->
   <cfparam name="session.mlssearch.Property_Type" default=""> <!--- varchar --->
   <cfparam name="session.mlssearch.remarks" default=""> <!--- varchar --->
   <cfparam name="session.mlssearch.searchpage" default="1">
   <cfparam name="session.mlssearch.page" default="1">
   <cfparam name="session.mlssearch.showlistings" default=""><!--- Company ---> <!--- varchar --->
   <cfparam name="session.mlssearch.sortby" default="#settings.mls.defaultOrderBy#">
   <cfparam name="session.mlssearch.SQFtMax" default=""> <!--- int --->
   <cfparam name="session.mlssearch.SQFtMin" default=""> <!--- int --->
   <cfparam name="session.mlssearch.status" default="#settings.mls.statusesToIncludeInSearch#"> <!--- int --->
   <cfparam name="session.mlssearch.stipulations" default=""> <!--- varchar --->
   <cfparam name="session.mlssearch.StreetAddress" default=""> <!--- varchar --->
   <cfparam name="session.mlssearch.subdivision" default=""> <!--- varchar --->
   <cfparam name="session.mlssearch.WaterType" default=""> <!--- varchar --->
   <cfparam name="session.mlssearch.wsid" default=""> <!--- varchar --->
   <cfparam name="session.mlssearch.waterview" default=""> <!--- varchar --->
   <cfparam name="session.mlssearch.water" default="">
   <cfparam name="session.mlssearch.water_view_type" default=""> <!--- varchar --->
   <cfparam name="session.mlssearch.waterfront" default=""> <!--- varchar --->
   <cfparam name="session.mlssearch.mlsid" default="#settings.mls.mlsid#"> <!--- varchar --->

   <cfparam name="session.mlssearch.centralair" default="">
   <cfparam name="session.mlssearch.gasheat" default="">
   <cfparam name="session.mlssearch.garage" default="">
   <cfparam name="session.mlssearch.pool" default="">
   <cfparam name="session.mlssearch.fence" default="">
   <cfparam name="session.mlssearch.boatslip" default="">
   <cfparam name="session.mlssearch.waterviews" default="">
   <cfparam name="session.mlssearch.fireplace" default="">
   <cfparam name="session.mlssearch.patio" default="">
   <cfparam name="session.mlssearch.new_construction" default="">

</cffunction>


<!--- Function list --->

<cfinclude template="includes/user-tracking.cfm">

<cffunction name="EncryptID" hint="Encrypts information" output="true" returntype="string">
<cfargument name="A_ID" required="YES" type="string">
  <cfset var key = "$[_>}r<GE7[oIHGK-f&Jo">
  <cfset var V_ID = 0>
  <cfset var V_Values = 0>
  <cfset V_ID = ToBase64(encrypt(trim(ARGUMENTS.A_ID),key))>
  <cfset V_Values = #V_ID#>
<cfreturn  V_Values>
</cffunction>

<cffunction name="DecryptID" hint="Decrypts information" output="true" returntype="string">
<cfargument name="A_ID" required="YES" type="string">
  <cfset var key = "$[_>}r<GE7[oIHGK-f&Jo">
  <cfset var X_ID = decrypt(tostring(tobinary(ARGUMENTS.A_ID)),key)>
  <cfset var X_Values = 0>
  <cfset X_Values = #X_ID#>
<cfreturn  X_Values>
</cffunction>


<!--- START: Email Address Encryption for Auto-Login from Email --->
 <cffunction name="EncryptEmail" hint="Decrypts information" output="true" returntype="string">
    <cfargument name="email" required="YES" type="string">
      <cfset EmailEncoded = encrypt(email, "Pi/tQr2WHTKx3aGL8m3Gfw==", "AES/CBC/PKCS5Padding", "HEX")>
    <cfreturn  EmailEncoded>
  </cffunction>

 <cffunction name="DecryptEmail" hint="Decrypts information" output="true" returntype="string">
    <cfargument name="accesskey" required="YES" type="string">
      <cfset EmailEncoded = decrypt(accesskey, "Pi/tQr2WHTKx3aGL8m3Gfw==", "AES/CBC/PKCS5Padding", "HEX")>
    <cfreturn  EmailEncoded>
  </cffunction>
<!--- END: Email Address Encryption for Auto-Login from Email --->

<!--- START: OptimizeMyURL Function --->


<cfscript>
/**
* Remove duplicates from a list.
*
* @param lst      List to parse. (Required)
* @param delim      List delimiter. Defaults to a comma. (Optional)
* @return Returns a string.
* @author Keith Gaughan (keith@digital-crew.com)
* @version 1, August 22, 2005
*/
function listRemoveDuplicatesICND(lst) {
var i       = 0;
var delim   = ",";
var asArray = "";
var set     = StructNew();
if (ArrayLen(arguments) gt 1) delim = arguments[2];
  asArray = ListToArray(lst, delim);
for (i = 1; i LTE ArrayLen(asArray); i = i + 1) set[asArray[i]] = "";
return structKeyList(set, delim);
}
</cfscript>

<!--- Start: Makes the first letter uppercase and the rest lower --->
<cfscript>
/**
* Returns a string with words capitalized for a title.
* Modified by Ray Camden to include var statements.
*
* @param initText    String to be modified.
* @return Returns a string.
* @author Ed Hodder (ed.hodder@bowne.com)
* @version 2, July 27, 2001
*/
function capFirstTitle(initText){
var Words = "";
var j = 1; var m = 1;
var doCap = "";
var thisWord = "";
var excludeWords = ArrayNew(1);
var outputString = "";
initText = LCASE(initText);
//Words to never capitalize
excludeWords[1] = "an";
excludeWords[2] = "the";
excludeWords[3] = "at";
excludeWords[4] = "by";
excludeWords[5] = "for";
excludeWords[6] = "of";
excludeWords[7] = "in";
excludeWords[8] = "up";
excludeWords[9] = "on";
excludeWords[10] = "to";
excludeWords[11] = "and";
excludeWords[12] = "as";
excludeWords[13] = "but";
excludeWords[14] = "if";
excludeWords[15] = "or";
excludeWords[16] = "nor";
excludeWords[17] = "a";
//Make each word in text an array variable
Words = ListToArray(initText, " ");
//Check words against exclude list
for(j=1; j LTE (ArrayLen(Words)); j = j+1){
  doCap = true;
  //Word must be less that four characters to be in the list of excluded words
  if(LEN(Words[j]) LT 4 ){
    if(ListFind(ArrayToList(excludeWords,","),Words[j])){
      doCap = false;
    }
  }
  //Capitalize hyphenated words
  if(ListLen(Words[j],"-") GT 1){
    for(m=2; m LTE ListLen(Words[j], "-"); m=m+1){
      thisWord = ListGetAt(Words[j], m, "-");
      thisWord = UCase(Mid(thisWord,1, 1)) & Mid(thisWord,2, LEN(thisWord)-1);
      Words[j] = ListSetAt(Words[j], m, thisWord, "-");
    }
  }
  //Automatically capitalize first and last words
  if(j eq 1 or j eq ArrayLen(Words)){
    doCap = true;
  }
  //Capitalize qualifying words
  if(doCap){
    Words[j] = UCase(Mid(Words[j],1, 1)) & Mid(Words[j],2, LEN(Words[j])-1);
  }
}
outputString = ArrayToList(Words, " ");
return outputString;
}
</cfscript>
<!--- Here is the Sample: #CapFirstTitle(str)# code to call --->
<!--- End: Makes the first letter uppercase and the rest lower --->
