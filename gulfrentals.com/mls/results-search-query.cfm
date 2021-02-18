<!--- ADOUTE DEBUG ---><!--- PUTTING CODE HERE CAUSES WEIRD ISSUES - IT APPEARS BEFORE <doctype> ---><!--- <cfif cgi.remote_addr eq '70.40.111.48' or cgi.remote_addr eq '202.88.237.198'><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><cfdump var="#form#"></cfif> ---><!--- ADOUTE DEBUG --->
<!--- Clear the session if this is a new search --->
<cfif structKeyExists(form,"CAMEFROMSEARCHFORM") OR structKeyExists(url,"CAMEFROMSEARCHFORM")>

   <cfset structDelete(SESSION,"mlssearch")>

   <cfset variables.newSearch = true />

<cfelseif isdefined('session.mls.qResults.query') and isQuery(session.mls.qResults.query) and isdefined('url.page')>

   <cfset variables.newSearch = false />

<cfelse>

   <cfset structDelete(SESSION,"mlssearch")>

   <cfset variables.newSearch = true />

</cfif>

<cfif isdefined('form.logout')>
  <cfset structdelete(session,"USERFirstName",true)>
  <cfset structdelete(cookie,"USERFirstName",true)>
  <cfset structdelete(session,"USERLastName",true)>
  <cfset structdelete(cookie,"USERLastName",true)>
  <cfset structdelete(session,"USEREmail",true)>
  <cfset structdelete(cookie,"USEREmail",true)>
  <cfset structdelete(session,"USERPhone",true)>
  <cfset structdelete(cookie,"USERPhone",true)>
  <cfset structdelete(session,"LoggedIn",true)>
  <cfset structdelete(cookie,"LoggedIn",true)>
  <cfset structdelete(session,"LoggedInc",true)>
  <cfset structdelete(cookie,"LoggedInc",true)>
</cfif>

<!--- START: Pagination Code --->
<cfparam name="url.page" default="1">
<cfset page_links_shown = 4>
<cfparam name="variables.records_per_page" default = "12">
<cfparam name="start_page" default="1">
<cfparam name="start" DEFAULT="1">

<cfset nextpage = "/mls/results"><!--- removed .cfm --->


<cfif variables.newSearch>

  <!--- Init Session Variables --->
  <cfset initSessionVars()>

  <!--- Copy over any form and url variables --->
  <!---<cfset session.mlssearch['sortby'] = "">--->

  <cfloop collection="#URL#" item="theField">
      <cfset session.mlssearch[theField] = url[theField]>
  </cfloop>

  <cfloop collection="#form#" item="theField">

     <cfif theField is not "fieldNames">
         <cfset session.mlssearch[theField] = form[theField]>
     </cfif>
  </cfloop>

  <!--- Special if statement for days on market --->
  <cfif session.mlssearch.DaysOnMarket is not "">
    <cfset session.mlssearch.NumericalDaysOnMarket = session.mlssearch.daysonmarket>
    <cfset session.mlssearch.DaysOnMarket = DateAdd("d", Now(), session.mlssearch.DaysOnMarket)>
    <cfset session.mlssearch.DaysOnMarket = dateformat(session.mlssearch.DaysOnMarket,'yyyy-mm-dd')>
  </cfif>


  <!---START: USED TO CLOSE LIGHTBOX AND RELOAD PAGE--->
  <cfset session.RememberMePage = "#script_name#?#query_string#">
  <!---END: USED TO CLOSE LIGHTBOX AND RELOAD PAGE--->


  <cfif isDefined("url.page") eq false and isDefined("session.mlssearch.page") and session.mlssearch.page neq ''>
     <cfset url.page = session.mlssearch.page>
  </cfif>

  <cfif isDefined("url.rpp") and url.rpp neq ''>
  <cfset records_per_page = url.rpp>
  </cfif>

  <cfif cgi.request_method eq "GET" and session.mlssearch.status eq 6>
     <cfset session.mlssearch.sortby="solddate desc">
  </cfif>

  <cfset start_record = url.page * variables.records_per_page - variables.records_per_page>

  <cfset variables.loopStart = 1 />
  <cfset variables.loopEnd = variables.records_per_page />

<!--- ADOUTE DEBUG ---><cfif listFindNoCase('216.99.119.254,70.40.111.48', cgi.REMOTE_ADDR)><script><cfoutput>console.log('new query\nvariables.loopStart: #variables.loopStart#\nvariables.loopEnd: #variables.loopEnd#');</cfoutput></script></cfif><!--- ADOUTE DEBUG --->

<cfset mlsrecords=variables.records_per_page>
  <cfif isDefined ("showAllProps") and showAllProps eq 'Yes'>
    <cfset start_record=0>
    <cfset mlsrecords=500>
  </cfif>

  <cfif structKeyExists(form,"CAMEFROMSEARCHFORM") OR structKeyExists(url,"CAMEFROMSEARCHFORM")>
    <cfset start_record = 0 />
  </cfif>


<!--- ADOUTE DEBUG ---><cfif cgi.remote_addr eq '70.40.111.48x' <!---or cgi.remote_addr eq '202.88.237.198'--->><cfdump var="#form#"><cfdump var="#session.mlssearch#" ></cfif><!--- ADOUTE DEBUG --->

  <!--- <cfset qResults = application.oMLS.property_search(search = session.mlssearch, start_record = start_record, records_per_page = mlsrecords)> --->
  <cfset session.mls.qResults = application.oMLS.property_search(search = session.mlssearch)>

  <cfset CountInfo.TheCount=session.mls.qResults.total_properties>

  <cfset cookie.numResults = CountInfo.TheCount />

  <cfset total_pages = ceiling(COUNTinfo.thecount / variables.records_per_page)>
  <cfparam name="show_pages" default="#min(page_links_shown,total_pages)#">

  <cfset session.PrevNextMLSNumbers = "#valuelist(session.mls.qResults.query.mlsnumber)#">


  <!---
  Resetting the cookie list because of some weirdness.  not sure if it is because of dev / data tweaks or something else. We may be able to move
  this later
  --->
  <cfif isDefined("cookie.loggedIn") and cookie.loggedIn gt 0>
     <cfset clientid = cookie.loggedIn>
  <cfelse>
     <Cfset clientid = 0>
  </cfif>

  <cfset strFavorites = application.oMLS.getFavorites(clientid,settings.id,false, cfid, cftoken)>
  <cfcookie name="MLSfavorites" value="#strFavorites#" expires="NEVER">

<cfelse>

  <cfset variables.loopStart = max((url.page * variables.records_per_page) - variables.records_per_page + 1, 1) />

  <cfset variables.loopEnd = min(variables.loopStart+variables.records_per_page-1, session.mls.qResults.total_properties) />

  <cfset CountInfo.TheCount = session.mls.qResults.total_properties>
  <cfset total_pages = ceiling(COUNTinfo.thecount / variables.records_per_page)>

  <cfparam name="show_pages" default="#min(page_links_shown,total_pages)#">

<!--- ADOUTE DEBUG ---><cfif listFindNoCase('216.99.119.254,70.40.111.48', cgi.REMOTE_ADDR)><script><cfoutput>console.log('using session query\nurl.page: #url.page#\nvariables.loopStart: #variables.loopStart#\nvariables.loopEnd: #variables.loopEnd#\nshow_pages:#show_pages#');</cfoutput></script></cfif><!--- ADOUTE DEBUG --->
</cfif>

<cfif !isDefined('variables.saving_search')>
  <!---Saving all the searches for tracking purposes, except when being called from /mls/save-search_.cfm...  Infinite loops aren't good. This variables is set when a search is being saved. --->

  <!--- <cfinclude template="/mls/save-search_.cfm"> no need to store data... --->
</cfif>

<cfif cgi.remote_addr eq '70.40.104.83x' <!---or cgi.remote_addr eq '202.88.237.198'---> or cgi.remote_addr eq '45.42.5.230x'>

  <hr><hr><hr><hr><hr><hr><hr><hr><hr><hr><hr><hr><hr><hr><hr>

   <h1>DEBUG LINE HIDDEN BY IP</h1>
   <cfoutput>#session.mls.qResults.formatted_sql# <hr></cfoutput>
   <cfdump var="#session.mls.qResults.arguments#">
   <cfdump var="#session.mls.qresults.queryResult#">
</cfif>