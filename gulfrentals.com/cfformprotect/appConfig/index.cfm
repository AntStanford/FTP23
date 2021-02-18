<!--- Determines the Root Folder --->
<cfset request.rootFolder = ListLast(ReplaceNoCase(ExpandPath('/'),'\htdocs\',''),'\')>

<!--- Saves the App Config Form Submit. --->
<cfinclude template="/cfformprotect/appConfig/appConfigSubmit.cfm">

<!--- Reads the appConfig file to pull in top level site variables. --->
<cftry>
	<cfsavecontent variable="request.appConfigFile"><cfinclude template="/appConfig.cfm"></cfsavecontent>
	<cfcatch type="any">
		<cfdump var="Error: The App Config File is missing">
		<cfabort>
	</cfcatch>
</cftry>

<!--- Parses the appConfig XML to save the top level site variables. --->
<cfif isXML(request.appConfigFile)>
	<cftry>
		<cfset request.appConfigXML = xmlparse(trim(request.appConfigFile))>
    <cfset request.appConfigData = StructNew()>
		<cfset request.appConfigData.rootFolder = request.appConfigXML.icnd.rootFolder.xmlText /> 
		<cfset request.appConfigData.name = request.appConfigXML.icnd.name.xmlText /> 
		<cfset request.appConfigData.settingsDSN = request.appConfigXML.icnd.settingsDSN.xmlText>
		<cfset request.appConfigData.clientsDSN = request.appConfigXML.icnd.clientsDSN.xmlText>
		<cfset request.appConfigData.PMS = request.appConfigXML.icnd.PMS.xmlText>  
		<cfset request.appConfigData.bookingDir = request.appConfigXML.icnd.bookingDir.xmlText>  
		<cfcatch type="any">
			<cfdump var="Error: The App Config File is missing required elements">
			<cfabort>
		</cfcatch>
	</cftry>
<cfelse>
	<cfdump var="Error: The App Config File is not proper XML">
	<cfabort>
</cfif>

<!--- Loads the App Config Form if the data is not yet entered --->
<cfif request.rootFolder NEQ request.appConfigData.rootFolder>
	<cfinclude template="/cfformprotect/appConfig/appConfigForm.cfm">
	<cfabort>
</cfif>
