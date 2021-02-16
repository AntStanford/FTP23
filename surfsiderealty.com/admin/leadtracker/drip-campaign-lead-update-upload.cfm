<cfset dripFilePath = #ExpandPath('/files')#>
<cfset dripPublicPath = "http://www.hiltonheadhomes.com/files">
<cfset dripMimes =  "image/jpeg,image/pjpeg,image/gif,image/png,application/pdf,application/msword">

<cfif isdefined('getLastCampaign.ID')>
	<cfset thiscampaignid = getLastCampaign.ID>
<cfelse>
		<cfset thiscampaignid = form.CampaignID>
</cfif>


<!--- Upload file for Step 1 --->
<cftry>

	<cfif isdefined('form.StepOneFile') and LEN(form.StepOneFile)>

		<cffile fileField = "StepOneFile" action = "upload" destination = "#dripFilePath#"  accept = "#dripMimes#" nameConflict = "MakeUnique">

			<cfif LEN(cffile.serverfile)>

				<cfquery datasource="#mls.dsn#" name="UpdatedStep1">
					Update drip_entries
					Set AttachedFileURL = <cfqueryparam value="#dripPublicPath#/#cffile.serverfile#" cfsqltype="cf_sql_longvarchar">,
						FileLinkText = <cfqueryparam value="#cffile.serverfile#" cfsqltype="cf_sql_varchar">
					Where StepNum = <cfqueryparam value="1" cfsqltype="cf_sql_integer"> and clientid = <cfqueryparam value="#form.ClientID#" cfsqltype="cf_sql_integer"> and campaignid = <cfqueryparam value="#thiscampaignid#" cfsqltype="cf_sql_integer">
				</cfquery>

			</cfif>

	</cfif>

	<cfcatch>
		  <cfmail to="icnderrors@gmail.com" from="#mls.AdminEmailNonAcctHolders# <#cfmail.username#>" username="#cfmail.username#" 
		  password="#cfmail.password#" server="#cfmail.server#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" subject="Drip Campaign Upload Error Step 1" type="html">
	        #cfcatch.message#<hr>
	        <cfdump var="#form#">
	       </cfmail>
	</cfcatch>

</cftry>


<!--- Upload file for Step 2 --->
<cftry>

	<cfif isdefined('form.StepTwoFile') and LEN(form.StepTwoFile)>

		<cffile fileField = "StepTwoFile" action = "upload" destination = "#dripFilePath#"  accept = "#dripMimes#" nameConflict = "MakeUnique">

			<cfif LEN(cffile.serverfile)>

				<cfquery datasource="#mls.dsn#" name="UpdatedStep2">
					Update drip_entries
					Set AttachedFileURL = <cfqueryparam value="#dripPublicPath#/#cffile.serverfile#" cfsqltype="cf_sql_longvarchar">,
						FileLinkText = <cfqueryparam value="#cffile.serverfile#" cfsqltype="cf_sql_varchar">
					Where StepNum = <cfqueryparam value="2" cfsqltype="cf_sql_integer"> and clientid = <cfqueryparam value="#form.ClientID#" cfsqltype="cf_sql_integer"> and campaignid = <cfqueryparam value="#thiscampaignid#" cfsqltype="cf_sql_integer">
				</cfquery>

			</cfif>

	</cfif>

	<cfcatch>
		  <cfmail to="icnderrors@gmail.com" from="#mls.AdminEmailNonAcctHolders# <#cfmail.username#>" username="#cfmail.username#" 
		  password="#cfmail.password#" server="#cfmail.server#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" subject="Drip Campaign Upload Error Step 2" type="html">
	        #cfcatch.message#<hr>
	        <cfdump var="#form#">
	       </cfmail>
	</cfcatch>

</cftry>


<!--- Upload file for Step 3 --->
<cftry>

	<cfif isdefined('form.StepThreeFile') and LEN(form.StepThreeFile)>

		<cffile fileField = "StepThreeFile" action = "upload" destination = "#dripFilePath#"  accept = "#dripMimes#" nameConflict = "MakeUnique">

			<cfif LEN(cffile.serverfile)>

				<cfquery datasource="#mls.dsn#" name="UpdatedStep3">
					Update drip_entries
					Set AttachedFileURL = <cfqueryparam value="#dripPublicPath#/#cffile.serverfile#" cfsqltype="cf_sql_longvarchar">,
						FileLinkText = <cfqueryparam value="#cffile.serverfile#" cfsqltype="cf_sql_varchar">
					Where StepNum = <cfqueryparam value="3" cfsqltype="cf_sql_integer"> and clientid = <cfqueryparam value="#form.ClientID#" cfsqltype="cf_sql_integer"> and campaignid = <cfqueryparam value="#thiscampaignid#" cfsqltype="cf_sql_integer">
				</cfquery>

			</cfif>

	</cfif>

	<cfcatch>
		  <cfmail to="icnderrors@gmail.com" from="#mls.AdminEmailNonAcctHolders# <#cfmail.username#>" username="#cfmail.username#" 
		  password="#cfmail.password#" server="#cfmail.server#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" subject="Drip Campaign Upload Error Step 3" type="html">
	        #cfcatch.message#<hr>
	        <cfdump var="#form#">
	       </cfmail>
	</cfcatch>

</cftry>


<!--- Upload file for Step 4 --->
<cftry>

	<cfif isdefined('form.StepFourFile') and LEN(form.StepFourFile)>

		<cffile fileField = "StepFourFile" action = "upload" destination = "#dripFilePath#"  accept = "#dripMimes#" nameConflict = "MakeUnique">

			<cfif LEN(cffile.serverfile)>

				<cfquery datasource="#mls.dsn#" name="UpdatedStep4">
					Update drip_entries
					Set AttachedFileURL = <cfqueryparam value="#dripPublicPath#/#cffile.serverfile#" cfsqltype="cf_sql_longvarchar">,
						FileLinkText = <cfqueryparam value="#cffile.serverfile#" cfsqltype="cf_sql_varchar">
					Where StepNum = <cfqueryparam value="4" cfsqltype="cf_sql_integer"> and clientid = <cfqueryparam value="#form.ClientID#" cfsqltype="cf_sql_integer"> and campaignid = <cfqueryparam value="#thiscampaignid#" cfsqltype="cf_sql_integer">
				</cfquery>

			</cfif>

	</cfif>

	<cfcatch>
		  <cfmail to="icnderrors@gmail.com" from="#mls.AdminEmailNonAcctHolders# <#cfmail.username#>" username="#cfmail.username#" 
		  password="#cfmail.password#" server="#cfmail.server#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" subject="Drip Campaign Upload Error Step 4" type="html">
	        #cfcatch.message#<hr>
	        <cfdump var="#form#">
	       </cfmail>
	</cfcatch>

</cftry>



<!--- Upload file for Step 5 --->
<cftry>

	<cfif isdefined('form.StepFiveFile') and LEN(form.StepFiveFile)>

		<cffile fileField = "StepFiveFile" action = "upload" destination = "#dripFilePath#"  accept = "#dripMimes#" nameConflict = "MakeUnique">

			<cfif LEN(cffile.serverfile)>

				<cfquery datasource="#mls.dsn#" name="UpdatedStep4">
					Update drip_entries
					Set AttachedFileURL = <cfqueryparam value="#dripPublicPath#/#cffile.serverfile#" cfsqltype="cf_sql_longvarchar">,
						FileLinkText = <cfqueryparam value="#cffile.serverfile#" cfsqltype="cf_sql_varchar">
					Where StepNum = <cfqueryparam value="5" cfsqltype="cf_sql_integer"> and clientid = <cfqueryparam value="#form.ClientID#" cfsqltype="cf_sql_integer"> and campaignid = <cfqueryparam value="#thiscampaignid#" cfsqltype="cf_sql_integer">
				</cfquery>

			</cfif>

	</cfif>

	<cfcatch>
		  <cfmail to="icnderrors@gmail.com" from="#mls.AdminEmailNonAcctHolders# <#cfmail.username#>" username="#cfmail.username#" 
		  password="#cfmail.password#" server="#cfmail.server#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" subject="Drip Campaign Upload Error Step 5" type="html">
	        #cfcatch.message#<hr>
	        <cfdump var="#form#">
	       </cfmail>
	</cfcatch>

</cftry>