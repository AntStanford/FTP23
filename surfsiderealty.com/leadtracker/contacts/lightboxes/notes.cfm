<link href="/admin/stylesheets/lightboxstyles.css" rel="stylesheet" type="text/css">


<div id="boxbody">

<cfif cgi.request_method eq "post" >


<cfif isdefined('form.id')>

<!--- 	<cfquery datasource="#mls.dsn#" name="update">
		update cl_listings
			set 
			ADDRESS = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ADDRESS#">,
			AGENTID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.AGENTID#">,
			CITY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.CITY#">,
			EXPIRE_DATE = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#form.EXPIRE_DATE#">,
			LIST_DATE = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#form.LIST_DATE#">,
			LIST_PRICE = <cfqueryparam cfsqltype="cf_sql_integer" value="#rereplace(form.LIST_PRICE, '/.|/$|,','','ALL')#">,
			status = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.status#">,
			MLSNUMBER = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.MLSNUMBER#">,
			PROPTYPE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PROPTYPE#">,
			STATE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.STATE#">,
			ZIP_CODE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ZIP_CODE#">,
			notes = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.notes#">
		where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.id#">
	</cfquery> --->

	<div class="success">
	The Note has been updated.
	</div>

	<cfelse>
			<cfquery datasource="#mls.dsn#" name="create">
		insert into cl_leadtracker_response(messagebody,clientid,agentid,privatepublic,FromOrTo,MessageSubject,ContactType)
			values(

						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.messagebody#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.clientid#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agentid#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="Private">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="Private Note - No Action Needed">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="Note Posted">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="Note">
				)
	</cfquery>

					

		<div class="success">
		The Note has been posted.
		</div>

</cfif>




<cfelse>
<cfif parameterexists(url.id)>
	<cfquery datasource="#mls.dsn#" name="getinfo">
	select *
	from cl_listings
	where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
</cfquery>
</cfif>


<h1>Add Note</h1>
<cfoutput>
<form action="#cgi.script_name#" method="post">
	<cfif parameterexists(url.id)>
		<input type="hidden" name="clientid" value="#url.id#">
		<input type="hidden" name="agentid" value="<cfif parameterexists(cookie.LoggedInAgentID)>#cookie.LoggedInAgentID#<cfelse>#cookie.LoggedInAdminID#</cfif>">
	</cfif>
	<div class="create_activity">
		<div>
			<textarea name="messagebody" style="width:100%;height:300px;margin-top: 5px;"><cfif parameterexists(url.id)>#getinfo.notes#</cfif></textarea>
		</div>
		<input type="submit" style="margin-top:5px;width:100px;" name="submit" <cfif parameterexists(url.id)>value="Update"<cfelse>value="Save"</cfif>>
	</div>
</form>
</cfoutput>

</cfif>

</div>
