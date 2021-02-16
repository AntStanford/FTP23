<cfif isdefined('url.openclientid') and isnumeric(url.openclientid)>
  <cfset transGif = "#expandpath('/sales/images/dot.gif')#">
 
 <CFQUERY DATASOURCE="#mls.dsn#" NAME="CheckIfOpened">
SELECT * 
FROM cl_accounts
where id = <cfqueryparam value="#url.openclientid#" cfsqltype="CF_SQL_NUMERIC"> 
</CFQUERY>

 <cfif CheckIfOpened.AgentOpened is "No">
  <CFQUERY NAME="UpdateQuery" DATASOURCE="#mls.dsn#">
    UPDATE cl_accounts
    SET 
      AgentOpened='Yes',
      TimeAgentOpened = <cfqueryparam value="#now()#" cfsqltype="CF_SQL_TIMESTAMP">
    where id = <cfqueryparam value="#url.openclientid#" cfsqltype="CF_SQL_NUMERIC"> 
	 </cfquery>
	</cfif>
	
  <cfcontent type="image/gif" file="#transGif#">
</cfif>