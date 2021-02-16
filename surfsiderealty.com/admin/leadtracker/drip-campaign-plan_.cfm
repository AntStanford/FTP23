<!--- This removes admin note about subject from it being submitted to email entry --->
<cffunction name="cleanSubject" returntype="Any">
	<cfargument name="thesubject" type="any" required="true">
		<cfset returnSubject = Rereplace(thesubject, '\(recommended\)|\(inactive\)','', 'ALL')>
	<cfreturn returnSubject>
</cffunction>

	<!--- To ensure certain fields  are accounted for --->
	<cfparam name="form.LIB_AUTOPAUSEEMAIL" default="0" type="any">
	<cfparam name="form.LIB_AUTOPAUSETALK" default="0" type="any">
	<cfparam name="form.LIB_TURNTOCOLD" default="0" type="any">
	<cfparam name="form.LIB_LEADSCORE" default="0" type="any">


<!--- If a Plan has been selected as a default, then clear previous default --->
<cfif cgi.request_method eq "Post" and isdefined('form.Lib_Default') and form.Lib_Default neq 0>
	<cfquery datasource="#mls.dsn#" name="ClearDefault"> 
		Update drip_library
		Set Lib_Default = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
		Where Lib_Default = <cfqueryparam value="#form.Lib_Default#" cfsqltype="cf_sql_integer">
	</cfquery>	
</cfif>


<!--- START: DELETE PLAN --->
<cfif isdefined('url.planid') and LEN(url.planid) and isdefined('url.deleteplan') and url.deleteplan eq "yes">
	<cfquery datasource="#mls.dsn#" name="update"> 
		delete from drip_library
		where Lib_PlanID = <cfqueryparam value="#url.planid#" cfsqltype="cf_sql_integer">
	</cfquery>
	<cflocation url="drip-library.cfm" addtoken="false">
</cfif>
<!--- END: DELETE PLAN --->


<cfif cgi.request_method eq "Post" and isdefined('form.Lib_PlanID') and LEN(form.Lib_PlanID)><!--- Update Plan --->


	<cfquery datasource="#mls.dsn#" name="update"> 
		Update drip_library 
		Set LIB_AGENTID = <cfqueryparam value="#form.LIB_AGENTID#" cfsqltype="cf_sql_integer">
			,Lib_UpdatedAt = <cfqueryparam value="#form.Lib_UpdatedAt#" cfsqltype="cf_sql_timestamp">
			,LIB_PLANNAME = <cfqueryparam value="#form.LIB_PLANNAME#" cfsqltype="cf_sql_varchar">
			,LIB_LEADSCORE = <cfqueryparam value="#form.LIB_LEADSCORE#" cfsqltype="cf_sql_integer">
			,LIB_PLANDESCRIPTION = <cfqueryparam value="#form.LIB_PLANDESCRIPTION#" cfsqltype="cf_sql_varchar">
			,LIB_AUTOPAUSEEMAIL = <cfqueryparam value="#form.LIB_AUTOPAUSEEMAIL#" cfsqltype="cf_sql_integer">
			,LIB_AUTOPAUSETALK = <cfqueryparam value="#form.LIB_AUTOPAUSETALK#" cfsqltype="cf_sql_integer">
			,LIB_1_WAITDAYS = <cfqueryparam value="#form.LIB_1_WAITDAYS#" cfsqltype="cf_sql_integer">
			,LIB_1_TEMPLATEID = <cfqueryparam value="#form.LIB_1_TEMPLATEID#" cfsqltype="cf_sql_integer">
			,LIB_1_SCHEDULEDTIME = <cfqueryparam value="#form.LIB_1_SCHEDULEDTIME#" cfsqltype="cf_sql_time">
			,LIB_1_SUBJECT = <cfqueryparam value="#cleanSubject(form.LIB_1_SUBJECT)#" cfsqltype="cf_sql_varchar">
			,LIB_1_MODIFIEDTEMPLATE = <cfqueryparam value="#form.LIB_1_MODIFIEDTEMPLATE#" cfsqltype="cf_sql_longvarchar">
			,LIB_2_WAITDAYS = <cfqueryparam value="#form.LIB_2_WAITDAYS#" cfsqltype="cf_sql_integer">
			,LIB_2_TEMPLATEID = <cfqueryparam value="#form.LIB_2_TEMPLATEID#" cfsqltype="cf_sql_integer">
			,LIB_2_SCHEDULEDTIME = <cfqueryparam value="#form.LIB_2_SCHEDULEDTIME#" cfsqltype="cf_sql_time">
			,LIB_2_SUBJECT = <cfqueryparam value="#cleanSubject(form.LIB_2_SUBJECT)#" cfsqltype="cf_sql_varchar">
			,LIB_2_MODIFIEDTEMPLATE = <cfqueryparam value="#form.LIB_2_MODIFIEDTEMPLATE#" cfsqltype="cf_sql_longvarchar">
			,LIB_3_WAITDAYS = <cfqueryparam value="#form.LIB_3_WAITDAYS#" cfsqltype="cf_sql_integer">
			,LIB_3_TEMPLATEID = <cfqueryparam value="#form.LIB_3_TEMPLATEID#" cfsqltype="cf_sql_integer">
			,LIB_3_SCHEDULEDTIME = <cfqueryparam value="#form.LIB_3_SCHEDULEDTIME#" cfsqltype="cf_sql_time">
			,LIB_3_SUBJECT = <cfqueryparam value="#cleanSubject(form.LIB_3_SUBJECT)#" cfsqltype="cf_sql_varchar">
			,LIB_3_MODIFIEDTEMPLATE = <cfqueryparam value="#form.LIB_3_MODIFIEDTEMPLATE#" cfsqltype="cf_sql_longvarchar">
			,LIB_4_WAITDAYS = <cfqueryparam value="#form.LIB_4_WAITDAYS#" cfsqltype="cf_sql_integer">
			,LIB_4_TEMPLATEID = <cfqueryparam value="#form.LIB_4_TEMPLATEID#" cfsqltype="cf_sql_integer">
			,LIB_4_SCHEDULEDTIME = <cfqueryparam value="#form.LIB_4_SCHEDULEDTIME#" cfsqltype="cf_sql_time">
			,LIB_4_SUBJECT = <cfqueryparam value="#cleanSubject(form.LIB_4_SUBJECT)#" cfsqltype="cf_sql_varchar">
			,LIB_4_MODIFIEDTEMPLATE = <cfqueryparam value="#form.LIB_4_MODIFIEDTEMPLATE#" cfsqltype="cf_sql_longvarchar">
			,LIB_5_WAITDAYS = <cfqueryparam value="#form.LIB_5_WAITDAYS#" cfsqltype="cf_sql_integer">
			,LIB_5_TEMPLATEID = <cfqueryparam value="#form.LIB_5_TEMPLATEID#" cfsqltype="cf_sql_integer">
			,LIB_5_SCHEDULEDTIME = <cfqueryparam value="#form.LIB_5_SCHEDULEDTIME#" cfsqltype="cf_sql_time">
			,LIB_5_SUBJECT = <cfqueryparam value="#cleanSubject(form.LIB_5_SUBJECT)#" cfsqltype="cf_sql_varchar">
			,LIB_5_MODIFIEDTEMPLATE = <cfqueryparam value="#form.LIB_5_MODIFIEDTEMPLATE#" cfsqltype="cf_sql_longvarchar">
			,LIB_REPEATCAMPAIGN = <cfqueryparam value="#form.LIB_REPEATCAMPAIGN#" cfsqltype="cf_sql_integer">
			,LIB_REPEATAFTER = <cfqueryparam value="#form.LIB_REPEATAFTER#" cfsqltype="cf_sql_integer">
			,LIB_TURNTOCOLD = <cfqueryparam value="#form.LIB_TURNTOCOLD#" cfsqltype="cf_sql_integer">
			<cfif isdefined('form.Lib_Default')>,Lib_Default = <cfqueryparam value="#form.Lib_Default#" cfsqltype="cf_sql_integer"></cfif>
		Where Lib_PlanID = <cfqueryparam value="#form.Lib_PlanID#" cfsqltype="cf_sql_integer">
	</cfquery>

		<cflocation url="/admin/leadtracker/drip-campaign-plan.cfm?planid=#form.Lib_PlanID#" addtoken="false">

	<!--- LIB_AGENTID,LIB_CREATEDAT,LIB_PLANNAME,LIB_LEADSCORE,LIB_PLANDESCRIPTION,LIB_AUTOPAUSEEMAIL,LIB_AUTOPAUSETALK,LIB_1_WAITDAYS,LIB_1_TEMPLATEID,LIB_1_SCHEDULEDTIME,LIB_1_SUBJECT,LIB_1_MODIFIEDTEMPLATE,LIB_2_WAITDAYS,LIB_2_TEMPLATEID,LIB_2_SCHEDULEDTIME,LIB_2_SUBJECT,LIB_2_MODIFIEDTEMPLATE,LIB_3_WAITDAYS,LIB_3_TEMPLATEID,LIB_3_SCHEDULEDTIME,LIB_3_SUBJECT,LIB_3_MODIFIEDTEMPLATE,LIB_4_WAITDAYS,LIB_4_TEMPLATEID,LIB_4_SCHEDULEDTIME,LIB_4_SUBJECT,LIB_4_MODIFIEDTEMPLATE,LIB_5_WAITDAYS,LIB_5_TEMPLATEID,LIB_5_SCHEDULEDTIME,LIB_5_SUBJECT,LIB_5_MODIFIEDTEMPLATE,LIB_REPEATCAMPAIGN,LIB_REPEATAFTER,LIB_TURNTOCOLD --->


<cfelseif cgi.request_method eq "Post" and NOT isdefined('form.Lib_PlanID')><!--- Insert Plan --->


	<cfquery datasource="#mls.dsn#" name="insert"> 
		Insert Into drip_library (LIB_AGENTID,LIB_CREATEDAT,LIB_PLANNAME,LIB_LEADSCORE,LIB_PLANDESCRIPTION,LIB_AUTOPAUSEEMAIL,LIB_AUTOPAUSETALK,LIB_1_WAITDAYS,LIB_1_TEMPLATEID,LIB_1_SCHEDULEDTIME,LIB_1_SUBJECT,LIB_1_MODIFIEDTEMPLATE,LIB_2_WAITDAYS,LIB_2_TEMPLATEID,LIB_2_SCHEDULEDTIME,LIB_2_SUBJECT,LIB_2_MODIFIEDTEMPLATE,LIB_3_WAITDAYS,LIB_3_TEMPLATEID,LIB_3_SCHEDULEDTIME,LIB_3_SUBJECT,LIB_3_MODIFIEDTEMPLATE,LIB_4_WAITDAYS,LIB_4_TEMPLATEID,LIB_4_SCHEDULEDTIME,LIB_4_SUBJECT,LIB_4_MODIFIEDTEMPLATE,LIB_5_WAITDAYS,LIB_5_TEMPLATEID,LIB_5_SCHEDULEDTIME,LIB_5_SUBJECT,LIB_5_MODIFIEDTEMPLATE,LIB_REPEATCAMPAIGN,LIB_REPEATAFTER,LIB_TURNTOCOLD<cfif isdefined('form.Lib_Default')>,Lib_Default</cfif>)
		Values (<cfqueryparam value="#form.LIB_AGENTID#" cfsqltype="cf_sql_integer">
				,<cfqueryparam value="#form.LIB_CREATEDAT#" cfsqltype="cf_sql_timestamp">
				,<cfqueryparam value="#form.LIB_PLANNAME#" cfsqltype="cf_sql_varchar">
				,<cfqueryparam value="#form.LIB_LEADSCORE#" cfsqltype="cf_sql_integer">
				,<cfqueryparam value="#form.LIB_PLANDESCRIPTION#" cfsqltype="cf_sql_varchar">
				,<cfqueryparam value="#form.LIB_AUTOPAUSEEMAIL#" cfsqltype="cf_sql_integer">
				,<cfqueryparam value="#form.LIB_AUTOPAUSETALK#" cfsqltype="cf_sql_integer">
				,<cfqueryparam value="#form.LIB_1_WAITDAYS#" cfsqltype="cf_sql_integer">
				,<cfqueryparam value="#form.LIB_1_TEMPLATEID#" cfsqltype="cf_sql_integer">
				,<cfqueryparam value="#form.LIB_1_SCHEDULEDTIME#" cfsqltype="cf_sql_time">
				,<cfqueryparam value="#cleanSubject(form.LIB_1_SUBJECT)#" cfsqltype="cf_sql_varchar">
				,<cfqueryparam value="#form.LIB_1_MODIFIEDTEMPLATE#" cfsqltype="cf_sql_longvarchar">
				,<cfqueryparam value="#form.LIB_2_WAITDAYS#" cfsqltype="cf_sql_integer">
				,<cfqueryparam value="#form.LIB_2_TEMPLATEID#" cfsqltype="cf_sql_integer">
				,<cfqueryparam value="#form.LIB_2_SCHEDULEDTIME#" cfsqltype="cf_sql_time">
				,<cfqueryparam value="#cleanSubject(form.LIB_2_SUBJECT)#" cfsqltype="cf_sql_varchar">
				,<cfqueryparam value="#form.LIB_2_MODIFIEDTEMPLATE#" cfsqltype="cf_sql_longvarchar">
				,<cfqueryparam value="#form.LIB_3_WAITDAYS#" cfsqltype="cf_sql_integer">
				,<cfqueryparam value="#form.LIB_3_TEMPLATEID#" cfsqltype="cf_sql_integer">
				,<cfqueryparam value="#form.LIB_3_SCHEDULEDTIME#" cfsqltype="cf_sql_time">
				,<cfqueryparam value="#cleanSubject(form.LIB_3_SUBJECT)#" cfsqltype="cf_sql_varchar">
				,<cfqueryparam value="#form.LIB_3_MODIFIEDTEMPLATE#" cfsqltype="cf_sql_longvarchar">
				,<cfqueryparam value="#form.LIB_4_WAITDAYS#" cfsqltype="cf_sql_integer">
				,<cfqueryparam value="#form.LIB_4_TEMPLATEID#" cfsqltype="cf_sql_integer">
				,<cfqueryparam value="#form.LIB_4_SCHEDULEDTIME#" cfsqltype="cf_sql_time">
				,<cfqueryparam value="#cleanSubject(form.LIB_4_SUBJECT)#" cfsqltype="cf_sql_varchar">
				,<cfqueryparam value="#form.LIB_4_MODIFIEDTEMPLATE#" cfsqltype="cf_sql_longvarchar">
				,<cfqueryparam value="#form.LIB_5_WAITDAYS#" cfsqltype="cf_sql_integer">
				,<cfqueryparam value="#form.LIB_5_TEMPLATEID#" cfsqltype="cf_sql_integer">
				,<cfqueryparam value="#form.LIB_5_SCHEDULEDTIME#" cfsqltype="cf_sql_time">
				,<cfqueryparam value="#cleanSubject(form.LIB_5_SUBJECT)#" cfsqltype="cf_sql_varchar">
				,<cfqueryparam value="#form.LIB_5_MODIFIEDTEMPLATE#" cfsqltype="cf_sql_longvarchar">
				,<cfqueryparam value="#form.LIB_REPEATCAMPAIGN#" cfsqltype="cf_sql_integer">
				,<cfqueryparam value="#form.LIB_REPEATAFTER#" cfsqltype="cf_sql_integer">
				,<cfqueryparam value="#form.LIB_TURNTOCOLD#" cfsqltype="cf_sql_integer">
				<cfif isdefined('form.Lib_Default')>,<cfqueryparam value="#form.Lib_Default#" cfsqltype="cf_sql_integer"></cfif>
				) 
	</cfquery>


	<cfquery datasource="#mls.dsn#" name="getLastInsert"> 
		Select Max(Lib_PlanID) as maxid
		From drip_library
		Where LIB_PLANNAME = <cfqueryparam value="#form.LIB_PLANNAME#" cfsqltype="cf_sql_varchar">
	</cfquery>

	<cflocation url="/admin/leadtracker/drip-campaign-plan.cfm?planid=#getLastInsert.maxid#" addtoken="false">


</cfif>





	<!--- Get Plan --->
	<cfif isdefined('url.planid') and LEN(url.planid)>
		<cfquery datasource="#mls.dsn#" name="getCampaign"> 
			Select *
			From drip_library
			Where Lib_PlanID = <cfqueryparam value="#url.planid#" cfsqltype="cf_sql_integer">
		</cfquery>
	</cfif>

	<!--- Get All Templates --->
	<cfquery datasource="#mls.dsn#" name="getTemplates">
		select id,subject,status,body,defaultentry
		from drip_templates
		order by subject ASC
	</cfquery>




