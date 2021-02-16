<cfset page.title = 'Blacklisted Guests' />

<cfquery name="getinfo" datasource="#settings.dsn#">
select *
from black_list
order by lastname
</cfquery>

<cfinclude template="/admin/components/header.cfm" />

<cfif isdefined('url.successdelete')>
  <div class="alert alert-success">
    <button class="close" data-dismiss="alert">&times;</button>
    <strong>Record deleted!</strong>
  </div>
</cfif>

<cfif isdefined('url.success')>
  <div class="alert alert-success">
    <button class="close" data-dismiss="alert">&times;</button>
    <strong>Record saved!</strong>
  </div>
</cfif>

<p><a href="form.cfm" class="btn btn-success"><i class="icon-plus icon-white"></i> Add Guest</a></p>

<div class="widget-box">
	<div class="widget-content nopadding">
		<table class="table table-bordered table-striped">
			<tr>
				<th width="30">No.</th>
				<th>Guest</th>
				<th>Email</th>
				<th>Date</th>
				<th></th>
				<th></th>
			</tr>

			<cfif getinfo.recordcount gt 0>
				<cfoutput query="getinfo">
					<tr>
						<td>#currentrow#.</td>
						<td>#firstname# #lastname#</td>
						<td>#email#</td>
						<td>#dateformat( dtcreated, 'mm/dd/yyyy' )#</td>
						<td width="50"><a href="form.cfm?id=#id#" class="btn btn-mini btn-primary"><i class="icon-pencil icon-white"></i> Edit</a></td>
						<td width="65"><a href="submit.cfm?id=#id#&delete" class="btn btn-mini btn-danger" data-confirm="Are you sure you want to delete this guest?"><i class="icon-remove icon-white"></i> Delete</a></td>
					</tr>
				</cfoutput>
			</cfif>
		</table>
	</div>
</div>

<cfinclude template="/admin/components/footer.cfm" />