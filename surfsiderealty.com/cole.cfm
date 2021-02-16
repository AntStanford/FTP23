<cfif cgi.remote_host eq '75.87.66.209' or cgi.remote_host eq '99.1.177.220'>
	<cftry>
		<!---
		<!--- Mail Chimp settings --->
		<cfset variables.chimpAPIKey = '75217dd2cfb37bd959d2e94b6e70b1d7-us10' />
		<cfset variables.ChimpListID = '3fccf8943f' />
		<cfset variables.mc_server = right( variables.chimpAPIKey, 4 ) />
		<cfset variables.serviceURL = 'https://' & variables.mc_server & '.api.mailchimp.com/3.0' />

		<cfhttp url="#variables.serviceURL#/lists/#variables.ChimpListID#/members?apikey=#variables.chimpAPIKey#" method="GET">

		<cfdump var="#cfhttp.filecontent#" />
		--->
		<!---
		<div style="margin-bottom:10px;">
			<cfoutput>
				#variables.serviceURL#
			</cfoutput>
		</div>

		<cfset variables.contact_json = {} />
		<cfset variables.contact_json['merge_vars'] = {} />
		<cfset variables.contact_json.merge_vars['GROUPINGS'] = {} />
		<cfset variables.contact_json.merge_vars['FNAME'] = 'Cole' />
		<cfset variables.contact_json.merge_vars['LNAME'] = 'Barksdale' />
		<cfset variables.contact_json['email_address'] = 'test123@icoastalnet.com' />
		<cfset variables.contact_json['status'] = 'subscribed' />
		<!--- this will be in the lists loop --->
		<cfset variables.contact_json.merge_vars['GROUPINGS'][1]['name'] = {} />
		<cfset variables.contact_json.merge_vars['GROUPINGS'][1]['groups'] = {} />
		
		<cfdump var="#variables.contact_json#" abort="true" />

		<cfhttp url="#variables.serviceURL#/lists/#variables.ChimpListID#/members" method="POST">
			<cfhttpparam type="header" name="content-type" value="application/json" />
			<cfhttpparam type="header" name="Authorization" value="apikey #variables.chimpAPIKey#" />
			<cfhttpparam type="body" name="data" value="#serializeJSON( variables.contact_json )#" />
		</cfhttp>

		<cfdump var="#deserializeJSON( cfhttp.filecontent )#" abort="true" />
		--->
		<!--- 
		MailChimp Component USAGE:

		On initial setup, you need to get a list id, the list call below is used to get the list id to use in the listSubscribe functio
		<cfset lists = chimp.lists()>
		the id returned was place in application.ChimpListID variable

		<cfset chimp = createObject("component","components.MailChimp").init(application.chimpAPIKey)>
		<cfset result = chimp.listSubscribe(application.ChimpListID, email)>
		
		<cfif isDefined("form.theemail") and isValid('email', form.theemail)>
			<cfset variables.email = form.theemail />
		<cfelseif isDefined("form.email") and isValid('email', form.email)>
			<cfset variables.email = form.email />
		<cfelse>
			<cfset variables.email = 'cbarksdale@icoastalnet.com' />
		</cfif>

		<cfdump var="#variables.email#" />

		<cfif isValid("email", variables.email)>
			<cfset variables.chimp = createObject("component","components.MailChimp3").init( variables.chimpAPIKey, variables.ChimpListID ) />
			<cfset variables.result = chimp.listSubscribe( variables.ChimpListID, variables.email ) />

			<cfdump var="#variables.result#" />
		</cfif>
		--->
		<cfcatch>
			<cfdump var="#cfcatch#" abort="true" />

			<cfmail subject="MailChimp error #cgi.http_host#" to="cbarksdale@icoastalnet.com" from="#cfmail.company# <#cfmail.username#>" server="#cfmail.server#" username="#cfmail.username#" password="#cfmail.password#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" type="HTML">
				<cfdump var="#cfcatch#" />
			</cfmail>
		</cfcatch>
	</cftry>
</cfif>