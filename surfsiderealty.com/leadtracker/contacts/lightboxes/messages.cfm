<link href="/admin/stylesheets/lightboxstyles.css" rel="stylesheet" type="text/css">

<cfquery datasource="#mls.dsn#" name="getmessage">
SELECT messagesubject,messagebody,clientid,mlsnumber,createdat
FROM cl_leadtracker_response
WHERE clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#"> 

<cfif dash eq "agent">
	and FromOrTo = "Waiting on Agent's Response"
<cfelseif dash eq "contact">
	and FromOrTo = "Waiting on Customer's Response"
</cfif>

Order By createdat DESC
limit 1
</cfquery>

<div id="boxbody">
<cfif getmessage.recordcount gt 0>

	<cfoutput query="getmessage">
		<h1>#messagesubject#</h1>
		<h4>#dateformat(createdat, 'dddd')#, #dateformat(createdat, 'mm/dd/yyyy')# @ #timeformat(createdat, 'hh:mm TT')#</h4><hr>
		<cfif LEN(MLSNUMBER)><p>In regards to property: <a href="/mls/search-results.cfm?mlsnumber=#mlsnumber#" target="_new">#mlsnumber#</a></p></cfif>
		#messagebody#
		<cfif dash eq "agent">
		<br>
		<a href="http://www.hiltonheadhomes.com/admin/contacts/contacts2.cfm?action=Edit&id=#clientid#&display=LeadTracker##LOC" target="_parent">Reply to Email</a>
		</cfif>
	</cfoutput>

<cfelse>
	<h1>No message available.</h1>

</cfif>
</div>