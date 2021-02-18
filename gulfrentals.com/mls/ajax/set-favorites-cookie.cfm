<cftry>

<cfparam name="url.action" default="add">

<cfif structKeyExists(URL,"mlsnumber")>

   <cfif isDefined("cookie.loggedIn")>
      <cfset clientid = cookie.loggedIn>
   <cfelse>
      <Cfset clientid = 0>
   </cfif>

   <cfset variables.link = '<a href="#getPageContext().getRequest().getScheme()#://#cgi.server_name#/mls/results?wsid=#url.wsid#&mlsnumber=#url.mlsnumber#&clearsession=&dontcountsearch=" target="_blank">MLS #url.mlsnumber#</a>' />

   <cfif url.action eq 'add'>

      <cfset thecount = application.oMLS.addFavorite(settings.id,clientid,url.mlsnumber,url.mlsid,url.wsid,cfid,cftoken )>

      <cfif isdefined('application.settings.contactuallyClient') and application.settings.contactuallyClient is 'yes' 
            and isDefined('cookie.loggedInC') and len(cookie.loggedInC)>
         <!--- call contactually addNote - favorite --->   
         <cfset variables.argStruct = structNew() />
         <cfset variables.argStruct.contactId = cookie.loggedInC />
         <cfset variables.argStruct.note = 'ADD Favorite - #variables.link#' />
         <cfset variables.cResponse = application.contactually.addNote(argumentCollection = variables.argStruct) />
         <!--- end contactually addNote - favorite --->  
      </cfif>

   <cfelse>

      <cfset thecount = application.oMLS.removeFavorite(settings.id,clientid,url.mlsnumber,url.mlsid,url.wsid,cfid,cftoken )>

      <cfif isdefined('application.settings.contactuallyClient') and application.settings.contactuallyClient is 'yes' 
            and isDefined('cookie.loggedInC') and len(cookie.loggedInC)>
         <!--- call contactually addNote - favorite --->   
         <cfset variables.argStruct = structNew() />
         <cfset variables.argStruct.contactId = cookie.loggedInC />
         <cfset variables.argStruct.note = 'REMOVE Favorite - #variables.link#' />
         <cfset variables.cResponse = application.contactually.addNote(argumentCollection = variables.argStruct) />
         <!--- end contactually addNote - favorite --->  
      </cfif>

   </cfif>

   <cfset strFavorites = application.oMLS.getFavorites(clientid,settings.id,false, cfid, cftoken)>

   <cfcookie name="mlsfavorites" value="#strFavorites#" expires="NEVER">


</cfif>
<cfoutput>#listlen(cookie.mlsfavorites)#</cfoutput>

<cfcatch><cfdump var="#cfcatch#"></cfcatch>
</cftry>