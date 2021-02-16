<cfif StructKeyExists(form,'appConfigSubmit') AND form.appConfigSubmit EQ 1>
	<!--- Saves the appConfig.xml file --->
	<cfsavecontent variable="variables.newAppConfigXML"><cfoutput><?xml version="1.0" encoding="UTF-8"?>
<icnd>
	<rootfolder>#form.rootFolder#</rootfolder>
  <name>#form.appName#</name>
  <settingsdsn>#form.dsn#</settingsdsn>
  <clientsdsn>#form.dsn#</clientsdsn>
  <pms>#form.pms#</pms>
  <bookingdir>#form.bookingDir#</bookingdir>  
</icnd> 
		</cfoutput>
  </cfsavecontent>
  <cffile action="write" file="#ExpandPath('/')#/appConfig.cfm" output="#variables.newAppConfigXML#" nameconflict="overwrite">
</cfif>