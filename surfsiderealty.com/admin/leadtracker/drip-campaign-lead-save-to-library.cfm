<cftry>


<!---START: Check ClientID and Campaign to continue --->
<cfif isdefined('url.clientid') is "No" or 
		isDefined('url.campaignid') is "No" or
		isdefined('url.clientid') and LEN(url.clientid) is '0' or
		isdefined('url.campaignid') and LEN(url.campaignid) is '0'>
	A Campaign and Client must be selected.
	<cfabort>
</cfif>
<!--- END: Check ClientID and Campaign to continue --->

<!--- START: Get Campaign --->
<cfquery datasource="#mls.dsn#" name="getCampaign">
	Select *
	From drip_campaigns
	Where id = <cfqueryparam value="#url.campaignid#" cfsqltype="cf_sql_integer">
</cfquery>
<!--- END: Get Campaign --->

<!--- START: Get All Entries --->
<cfquery datasource="#mls.dsn#" name="getOne">
	Select *
	From drip_entries
	Where StepNum = <cfqueryparam value="1" cfsqltype="cf_sql_integer"> and CampaignID = <cfqueryparam value="#url.campaignid#" cfsqltype="cf_sql_integer">
	limit 1
</cfquery>
<cfquery datasource="#mls.dsn#" name="getTwo">
	Select *
	From drip_entries
	Where StepNum = <cfqueryparam value="2" cfsqltype="cf_sql_integer"> and CampaignID = <cfqueryparam value="#url.campaignid#" cfsqltype="cf_sql_integer">
	limit 1
</cfquery>
<cfquery datasource="#mls.dsn#" name="getThree">
	Select *
	From drip_entries
	Where StepNum = <cfqueryparam value="3" cfsqltype="cf_sql_integer"> and CampaignID = <cfqueryparam value="#url.campaignid#" cfsqltype="cf_sql_integer">
	limit 1
</cfquery>
<cfquery datasource="#mls.dsn#" name="getFour">
	Select *
	From drip_entries
	Where StepNum = <cfqueryparam value="4" cfsqltype="cf_sql_integer"> and CampaignID = <cfqueryparam value="#url.campaignid#" cfsqltype="cf_sql_integer">
	limit 1
</cfquery>
<cfquery datasource="#mls.dsn#" name="getFive">
	Select *
	From drip_entries
	Where StepNum = <cfqueryparam value="5" cfsqltype="cf_sql_integer"> and CampaignID = <cfqueryparam value="#url.campaignid#" cfsqltype="cf_sql_integer">
	limit 1
</cfquery>
<!--- END: Get All Entries --->

<!--- INSERT INTO LIBRARY --->
 <cfquery datasource="#mls.dsn#" name="insert">
	Insert Into drip_library(LIB_AGENTID
			,LIB_AUTOPAUSEEMAIL
			,LIB_AUTOPAUSETALK
			,LIB_CREATEDAT
			,LIB_PLANDESCRIPTION
			,LIB_PLANNAME
			,LIB_REPEATAFTER
			,LIB_REPEATCAMPAIGN
			,LIB_TURNTOCOLD
			<cfif getOne.recordcount eq 1>
			,LIB_1_MODIFIEDTEMPLATE
			,LIB_1_SCHEDULEDTIME
			,LIB_1_SUBJECT
			,LIB_1_TEMPLATEID
			,LIB_1_WAITDAYS
			</cfif>
			<cfif getTwo.recordcount eq 1>
			,LIB_2_MODIFIEDTEMPLATE
			,LIB_2_SCHEDULEDTIME
			,LIB_2_SUBJECT
			,LIB_2_TEMPLATEID
			,LIB_2_WAITDAYS
			</cfif>
			<cfif getThree.recordcount eq 1>
			,LIB_3_MODIFIEDTEMPLATE
			,LIB_3_SCHEDULEDTIME
			,LIB_3_SUBJECT
			,LIB_3_TEMPLATEID
			,LIB_3_WAITDAYS
			</cfif>
			<cfif getFour.recordcount eq 1>
			,LIB_4_MODIFIEDTEMPLATE
			,LIB_4_SCHEDULEDTIME
			,LIB_4_SUBJECT
			,LIB_4_TEMPLATEID
			,LIB_4_WAITDAYS
			</cfif>
			<cfif getFive.recordcount eq 1>
			,LIB_5_MODIFIEDTEMPLATE
			,LIB_5_SCHEDULEDTIME
			,LIB_5_SUBJECT
			,LIB_5_TEMPLATEID
			,LIB_5_WAITDAYS
			</cfif>
			)
	Values(
			<cfqueryparam value="#getCampaign.AGENTID#" cfsqltype="cf_sql_integer">
			,<cfqueryparam value="#getCampaign.AUTOPAUSEEMAIL#" cfsqltype="cf_sql_integer">
			,<cfqueryparam value="#getCampaign.AUTOPAUSETALK#" cfsqltype="cf_sql_integer">
			,<cfqueryparam value="#dateformat(now(), 'yyyy-mm-dd')# #timeformat(now(), 'hh:mm:ss')#" cfsqltype="cf_sql_timestamp">
			,<cfqueryparam value="#getCampaign.PLANDESCRIPTION#" cfsqltype="cf_sql_varchar">
			,<cfqueryparam value="#getCampaign.PLANNAME#" cfsqltype="cf_sql_varchar">
			,<cfqueryparam value="#getCampaign.REPEATAFTER#" cfsqltype="cf_sql_integer">
			,<cfqueryparam value="#getCampaign.REPEATCAMPAIGN#" cfsqltype="cf_sql_integer">
			,<cfqueryparam value="#getCampaign.TURNTOCOLD#" cfsqltype="cf_sql_integer">
			<cfif getOne.recordcount eq 1>
			,<cfqueryparam value="#getOne.MODIFIEDTEMPLATE#" cfsqltype="cf_sql_longvarchar">
			,<cfqueryparam value="#getOne.SCHEDULEDTIME#" cfsqltype="cf_sql_time">
			,<cfqueryparam value="#getOne.EMAILSUBJECT#" cfsqltype="cf_sql_varchar">
			,<cfqueryparam value="#getOne.ORIGINALTEMPLATEID#" cfsqltype="cf_sql_integer">
			,<cfqueryparam value="#getOne.WAITDAYS#" cfsqltype="cf_sql_integer">
			</cfif>
			<cfif getTwo.recordcount eq 1>
			,<cfqueryparam value="#getTwo.MODIFIEDTEMPLATE#" cfsqltype="cf_sql_longvarchar">	
			,<cfqueryparam value="#getTwo.SCHEDULEDTIME#" cfsqltype="cf_sql_time">
			,<cfqueryparam value="#getTwo.EMAILSUBJECT#" cfsqltype="cf_sql_varchar">
			,<cfqueryparam value="#getTwo.ORIGINALTEMPLATEID#" cfsqltype="cf_sql_integer">	
			,<cfqueryparam value="#getTwo.WAITDAYS#" cfsqltype="cf_sql_integer">
			</cfif>
			<cfif getThree.recordcount eq 1>
			,<cfqueryparam value="#getThree.MODIFIEDTEMPLATE#" cfsqltype="cf_sql_longvarchar">	
			,<cfqueryparam value="#getThree.SCHEDULEDTIME#" cfsqltype="cf_sql_time">
			,<cfqueryparam value="#getThree.EMAILSUBJECT#" cfsqltype="cf_sql_varchar">	
			,<cfqueryparam value="#getThree.ORIGINALTEMPLATEID#" cfsqltype="cf_sql_integer">
			,<cfqueryparam value="#getThree.WAITDAYS#" cfsqltype="cf_sql_integer">
			</cfif>
			<cfif getFour.recordcount eq 1>
			,<cfqueryparam value="#getFour.MODIFIEDTEMPLATE#" cfsqltype="cf_sql_longvarchar">	
			,<cfqueryparam value="#getFour.SCHEDULEDTIME#" cfsqltype="cf_sql_time">
			,<cfqueryparam value="#getFour.EMAILSUBJECT#" cfsqltype="cf_sql_varchar">
			,<cfqueryparam value="#getFour.ORIGINALTEMPLATEID#" cfsqltype="cf_sql_integer">
			,<cfqueryparam value="#getFour.WAITDAYS#" cfsqltype="cf_sql_integer">
			</cfif>
			<cfif getFive.recordcount eq 1>
			,<cfqueryparam value="#getFive.MODIFIEDTEMPLATE#" cfsqltype="cf_sql_longvarchar">	
			,<cfqueryparam value="#getFive.SCHEDULEDTIME#" cfsqltype="cf_sql_time">
			,<cfqueryparam value="#getFive.EMAILSUBJECT#" cfsqltype="cf_sql_varchar">		
			,<cfqueryparam value="#getFive.ORIGINALTEMPLATEID#" cfsqltype="cf_sql_integer">
			,<cfqueryparam value="#getFive.WAITDAYS#" cfsqltype="cf_sql_integer">
			</cfif>
			)
</cfquery>


<!---START: Get Plan ID of above --->
<cfquery datasource="#mls.dsn#" name="getLastCampaign">
	select Lib_PlanID
	from drip_library
	where LIB_AGENTID = <cfqueryparam cfsqltype="cf_sql_integer" value="#getCampaign.AGENTID#"> and Lib_PlanName = <cfqueryparam value="#getCampaign.PLANNAME#" cfsqltype="cf_sql_varchar">
	order by Lib_PlanID desc
	limit 1
</cfquery>
<!---END: Get Plan ID of above --->


<cflocation url="/admin/leadtracker/drip-campaign-plan.cfm?planid=#getLastCampaign.Lib_PlanID#" addtoken="false">

		

		


<cfcatch>

An error has occurred while creating the campaign and a notification has been sent to Support. Please check Drip Campaigns to check if it was created.

<cfmail to="icnderrors@gmail.com" from="#mls.adminemail# <#cfmail.username#>" replyto="#mls.adminemail#" bcc="#cfmail.bcc#" 
username="#cfmail.username#" password="#cfmail.password#" server="#cfmail.server#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" 
subject="HHH Error Drip Create From Library"  type="html">
	Campaign = url.campaignid
	Clientid = #url.ClientID#<br>

	#cfcatch.message#
</cfmail>

</cfcatch>
</cftry>




	
	



	
	
	


	
	
	
	
