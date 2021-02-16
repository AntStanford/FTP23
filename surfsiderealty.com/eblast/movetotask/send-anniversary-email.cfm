<cfquery name="getClientSettings" dataSource="booking_clients">
  select * from settings where dsn = 'surfsiderealty2018'
</cfquery>

<cfset settings.website = getClientSettings.website>

<cfif isDefined('url.today')>
	<cfset today = url.today> 
<cfelse>
	<cfset today = now()> 
</cfif>

<cfset lastyear = dateadd('yyyy',-1,today)>

<cfquery name="GetEmails" datasource="surfsiderealty2018">
select gr.strpropid, pi.cleanstrpropid, gr.dtCheckInDate, gr.dtCheckOutDate, gr.dtBookDate, gr.intQuoteNum, gr.strFirstName, gr.strLastName,  gr.stremail, rd.strMarketingCategory, rd.strmarketingsource, pi.strname propname, pi.seopropertyname,
	(	select count(strMarketingCategory)
		from cms_ota_reservations_types ota
		where ota.strMarketingCategory = rd.strMarketingCategory
		and ota.strmarketingsource = rd.strmarketingsource
	) as OTA
from pp_getbookinghistory bh, pp_getreservationdetails rd, pp_guestreservationinfo gr, pp_propertyinfo pi
where bh.intquotenum = rd.intquotenum
and bh.intquotenum = gr.intquotenum
and gr.strpropid = pi.strpropid
and bh.dtbookdate between <cfqueryparam cfsqltype="cf_sql_date" value="#lastyear#"> and <cfqueryparam cfsqltype="cf_sql_date" value="#dateadd('d',1,lastyear)#">
and gr.stremail is not NULL
and gr.stremail <> ''
<!--- REMOVE AFTER TESTING --->
and gr.stremail = 'cbarksdale@icoastalnet.com'
</cfquery>

<cfloop query="GetEmails">
	<!---<cfif ota eq 1>
		<cfset subject = "It's Time for Another Beach Vacation!">
	<cfelse>
		<cfset subject = 'Book Direct and Save Big with Us!'>
	</cfif>--->

	<cfset subject = '#strFirstName#, Book Direct and Save Big with Us!'>

	<!---
	<cfmail subject="#subject#" to="#stremail#" from="#getClientSettings.company# <#getClientSettings.cfmailusername#>" replyto="#getClientSettings.clientemail#" 
		server="#getClientSettings.cfmailserver#" username="#getClientSettings.cfmailusername#" password="#getClientSettings.cfmailpassword#" 
		port="#getClientSettings.cfmailport#" useSSL="#getClientSettings.cfmailSSL#" type="HTML" bcc="llashower@palmettovacationrentals.com,jlayton@palmettovacationrentals.com,lnewell@icnd.net,programmers@icoastalnet.com" cc="">--->
			<cfinclude template="common/template-top.cfm">

			<!---<cfif ota eq 1>
				<cfinclude template="_ota-template.cfm">
			<cfelse>--->
				<cfinclude template="_book-direct-template.cfm">
			<!---</cfif>--->

			<cfinclude template="common/template-bottom.cfm">
	<!---</cfmail>--->

	<!---<cfoutput>#ota# #intQuoteNum# #stremail# #strfirstname# #strlastname# #strpropid# #propname#<Br></cfoutput>--->
</cfloop>