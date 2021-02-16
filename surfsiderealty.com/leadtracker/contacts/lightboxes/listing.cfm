<link href="/admin/stylesheets/lightboxstyles.css" rel="stylesheet" type="text/css">


<div id="boxbody">

<cfif cgi.request_method eq "post" >


<cfif isdefined('form.id')>

	<cfquery datasource="#mls.dsn#" name="update">
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
	</cfquery>

	<div class="success">
	The listing has been updated.
	</div>

	<cfelse>
			<cfquery datasource="#mls.dsn#" name="create">
			insert into cl_listings(ADDRESS,AGENTID,CITY,EXPIRE_DATE,LIST_DATE,LIST_PRICE,MLSNUMBER,PROPTYPE,STATE,ZIP_CODE,notes,status,clientid)
				values(
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ADDRESS#">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#form.AGENTID#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.CITY#">,
							<cfqueryparam cfsqltype="CF_SQL_DATE" value="#form.EXPIRE_DATE#">,
							<cfqueryparam cfsqltype="CF_SQL_DATE" value="#form.LIST_DATE#">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#rereplace(form.LIST_PRICE, '/.|/$|,','','ALL')#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.MLSNUMBER#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PROPTYPE#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.STATE#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ZIP_CODE#">,
							<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.notes#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.status#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.clientid#">
					)
		</cfquery>

					
					

		<div class="success">
		The listing has been saved.
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

<cfquery datasource="#mls.dsn#" name="getAgents">
	select id,firstname,lastname
	from cl_agents
</cfquery>
<cfquery datasource="#mls.dsn#" name="getStates">
	select *
	from states
	order by state asc
</cfquery>


<h1><cfif parameterexists(url.id)>Edit<cfelse>New</cfif> Listing</h1>
<cfoutput>
<form action="#cgi.script_name#" method="post">
	<cfif parameterexists(url.id)><input type="hidden" name="id" value="#url.id#"></cfif>
	<cfif parameterexists(url.clientid)><input type="hidden" name="clientid" value="#url.clientid#"></cfif>
	<div class="create_activity">
		<div>
			<label for="proptype" style="margin-right:35px;">Property Type</label>
			<select name="proptype">
				<option <cfif parameterexists(url.id) and getinfo.proptype eq "Home">selected</cfif>>Home
				<option <cfif parameterexists(url.id) and getinfo.proptype eq "Villa">selected</cfif>>Villa
				<option <cfif parameterexists(url.id) and getinfo.proptype eq "Lot">selected</cfif>>Lot
			</select>
		</div>

		<div>
			<label for="listtype" style="margin-right:64px;">List Type</label>
			<select name="status">
				<option value="Active" <cfif parameterexists(url.id) and getinfo.status eq "Active">selected</cfif>>Active Listing
				<option value="Pending" <cfif parameterexists(url.id) and getinfo.status eq "Pending">selected</cfif>>Pending Purchase
				<option value="Past" <cfif parameterexists(url.id) and getinfo.status eq "Past">selected</cfif>>Past Purchase
			</select>
		</div>


		<div>
			<label for="address" style="margin-right:16px;">Property Address</label>
			<input type="text" name="address" value="<cfif parameterexists(url.id)>#getinfo.address#</cfif>">
		</div>
		<div>
			<label for="city" style="margin-right:96px;">City</label>
			<input type="text" name="city" value="<cfif parameterexists(url.id)>#getinfo.city#</cfif>">
		</div>
		<div>
			<label for="state" style="margin-right:89px;">State</label>
			<select name="state"><cfloop query="getStates"><option value="#abbreviation#" <cfif parameterexists(url.id) and getinfo.state eq "#abbreviation#">selected</cfif>>#state#</cfloop></select>
		</div>
		<div>
			<label for="zip_code" style="margin-right:65px;">Zip Code</label>
			<input type="text" name="zip_code" value="<cfif parameterexists(url.id)>#getinfo.zip_code#</cfif>">
		</div>
		<div>
			<label for="list_price" style="margin-right:66px;">List Price</label>
			<input type="text" name="list_price" value="<cfif parameterexists(url.id)>#getinfo.list_price#<cfelse>0.00</cfif>">
		</div>
		<div>
			<label for="mlsnumber" style="margin-right:44px;">MLS Number</label>
			<input type="text" name="mlsnumber" value="<cfif parameterexists(url.id)>#getinfo.mlsnumber#</cfif>">
		</div>
		<div>
			<label for="agentid" style="margin-right:84px;">Agent</label>
			<select name="agentid" style="font-size:12px;"><cfloop query="getAgents"><option value="#getAgents.id#" <cfif parameterexists(url.id) and getinfo.agentid eq "#getAgents.id#">selected</cfif>>#getAgents.firstname# #getAgents.lastname#</cfloop></select>
		</div>
		<div>
			<label for="list_date" style="margin-right:67px;">List Date</label>
			<input type="text" name="list_date" value="<cfif parameterexists(url.id)>#dateformat(getinfo.list_date, 'yyyy-mm-dd')#</cfif>">
		</div>
		<div>
			<label for="expire_date" style="margin-right:43px;">Expires Date</label>
			<input type="text" name="expire_date" value="<cfif parameterexists(url.id)>#dateformat(getinfo.expire_date, 'yyyy-mm-dd')#</cfif>">
		</div>
		<div>
			<label for="notes" class="notes">Notes</label>
			<textarea name="notes" style="width:240px;margin-top: 5px;"><cfif parameterexists(url.id)>#getinfo.notes#</cfif></textarea>
		</div>
		<input type="submit" name="submit" <cfif parameterexists(url.id)>value="Update"<cfelse>value="Save"</cfif> style="height: 36px;width: 81px;">
	</div>
</form>
</cfoutput>

</cfif>

</div>
