<cftry>
	<cfparam name="is_edit" default="false" />

	<cfset page.title = 'Blacklisted Guests' />

	<cfif structKeyExists( url, 'id' )>
		<cfset is_edit = true />

		<cfquery name="getinfo" datasource="#settings.dsn#">
		select *
		from black_list
		where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#val( url.id )#" />
		</cfquery>
	</cfif>

	<cfinclude template="/admin/components/header.cfm" />

	<div class="widget-box">
		<div class="widget-title">
			<span class="icon"><i class="icon-th"></i></span>
			<h5>Add / Edit Form</h5>
		</div>
	
		<div class="widget-content nopadding">
			<cfoutput>
			<form method="post" action="submit.cfm" class="form-horizontal">
				<cfif is_edit>
					<input type="hidden" name="id" value="#val( url.id )#" />
				</cfif>

				<div class="control-group">
					<label class="control-label">First Name</label>
					
					<div class="controls">
						<input name="firstname" type="text" <cfif is_edit>value="#getinfo.firstname#"</cfif> />
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">Last Name</label>
					
					<div class="controls">
						<input name="lastname" type="text" <cfif is_edit>value="#getinfo.lastname#"</cfif> />
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">Email</label>
					
					<div class="controls">
						<input name="email" type="text" <cfif is_edit>value="#getinfo.email#"</cfif> />
					</div>
				</div>

				<div class="form-actions">
					<input type="submit" value="Submit" id="btnSave" class="btn btn-primary" />
				</div>
			</form>
			</cfoutput>
		</div>
	</div>

	<cfinclude template="/admin/components/footer.cfm" />

	<cfcatch>
		<cfdump var="#cfcatch#" abort="true" />
	</cfcatch>
</cftry>