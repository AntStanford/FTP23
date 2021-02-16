<cfinclude template="drip-templates_.cfm">
<!--- leadtrackerdsn --->

<cfquery datasource="#mls.dsn#" name="getTemplates">
	select id,subject,status,lastModified,createdAt,defaultentry
	from drip_templates
	order by subject asc
</cfquery>

<cfinclude template="/admin/components/header.cfm">
<p><a hreflang="en" href="drip-template-form.cfm" class="add-new">Add New</a></p>
<h2>Drip Campaign Templates</h2>



<table>
	<tr>
		<th style="width:75px;">No.</th>
		<th>Subject</th>
		<th style="width:100px;">Active</th>
		<th style="width:100px;">Default</th>
		<th style="width:150px;">Last Modified</th>
		<th style="width:150px;">Created</th>
		<th style="width:100px;"></th>
		<th style="width:100px;"></th>
		<th style="width:100px;"></th>
	</tr>
	<cfoutput query="getTemplates">
		<tr>
			<td>#currentrow#</td>
			
			<td><a hreflang="en" href="drip-template-form.cfm?id=#id#">#subject#</a></td>
			<td><cfif status eq 1>Yes<cfelse>No</cfif></td>
			<td><cfif defaultentry gt 0>Step #defaultentry#</cfif></td>
			<td>#dateformat(lastModified, 'mm/dd/yy')# #timeFormat(lastModified, 'hh:mm TT')#</td>
			<td>#dateformat(createdAt, 'mm/dd/yy')# #timeFormat(createdAt, 'hh:mm TT')#</td>
			<td><a hreflang="en" href="drip-template-form.cfm?id=#id#" class="edit">view/edit</a></td>
			<td><cfif status eq 0 ><a hreflang="en" href="drip-templates.cfm?id=#id#&activate=" onclick="return confirm('Are you sure you wish to Activate this Template?')" class="edit">Activate</a><cfelse><a hreflang="en" href="drip-templates.cfm?id=#id#&deactivate=" onclick="return confirm('Are you sure you wish to Deactivate this Template?')" class="edit">Deactivate</a></cfif></td>
			<td><a hreflang="en" href="drip-templates.cfm?id=#id#&delete=" onclick="return confirm('Are you sure you wish to Delete this Template?')" class="delete">Delete</a></td>
		</tr>
	</cfoutput>
</table>




<cfinclude template="/admin/components/footer.cfm">