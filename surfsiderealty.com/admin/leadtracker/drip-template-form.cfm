<cfinclude template="drip-template-form_.cfm">

<cfinclude template="/admin/components/header.cfm">

<cfif isdefined('url.id') and LEN(url.id)>

	<cfquery datasource="#mls.dsn#" name="getTemplate">
		select id,subject,status,body,defaultentry
		from drip_templates
		where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
	</cfquery>
	
</cfif>
 
<p><a hreflang="en" href="drip-templates.cfm">&laquo; Return to Drip Templates</a></p>

<h2><cfif isdefined('url.id') and LEN(url.id)>Edit<cfelse>New</cfif> Template</h2>

<cfoutput>

<cfif isdefined('url.action') and url.action eq 'Added'>
	<p style="color:red;">This template has been added. <span style="color:blue;">Edit below</span> or <a hreflang="en" href="#cgi.script_name#">Add Another</a>.</p>
<cfelseif isdefined('url.action') and url.action eq 'Updated'>
	<p style="color:red;">This template has been updated.</p>
</cfif>

	<form name="thisform" onsubmit="return validateForm()" method="Post">
		

		<cfif isdefined('url.id') and LEN(url.id)>
			<!--- For Editing a Template --->
			<input type="hidden" name="id" value="#url.id#">
			<input type="hidden" name="lastModified" value="#CreateODBCDateTime(now())#">
		<cfelse>
			<!--- For Adding a Template --->
			<input type="hidden" name="createdAt" value="#CreateODBCDateTime(now())#">
			<input type="hidden" name="lastModified" value="#CreateODBCDateTime(now())#">
		</cfif>

		<table style="width:700px;">
		<tr>
			<th style="width:100%">Subject</th>
			<td><input type="text" name="subject" size="80" <cfif isdefined('url.id') and LEN(url.id)>value="#getTemplate.subject#"</cfif>></td>
		</tr>
		<tr>
			<th>Body</th>
			<td><textarea name="body" style="width:96%;height:300px;"><cfif isdefined('url.id') and LEN(url.id)>#getTemplate.body#</cfif></textarea><br>You Can Dynamically Input Client Information By Using The Following Syntax:
First Name = {{Firstname}}
Last Name = {{Lastname}}
Email = {{Email}}
Password = {{Password}}
Site Web Address = {{Fulllink}}
Agent Signature = {{Agentsignature}} .</td>
		</tr>
		<tr>
			<th>Status</th>
			<td>
				<select name="status">
					<option value="1">Active</option>
					<option value="0" <cfif isdefined('url.id') and LEN(url.id) and getTemplate.status eq '0'>selected</cfif>>Not Active</option>
				</select>
			</td>
		</tr>

		<tr>
			<th>Default </th>
			<td>
				<select name="defaultentry">
					<option value="0"> not selected</option>
					<option value="1" <cfif isdefined('url.id') and LEN(url.id) and getTemplate.defaultentry eq '1'>selected</cfif>>Step One</option>
					<option value="2" <cfif isdefined('url.id') and LEN(url.id) and getTemplate.defaultentry eq '2'>selected</cfif>>Step Two</option>
					<option value="3" <cfif isdefined('url.id') and LEN(url.id) and getTemplate.defaultentry eq '3'>selected</cfif>>Step Three</option>
					<option value="4" <cfif isdefined('url.id') and LEN(url.id) and getTemplate.defaultentry eq '4'>selected</cfif>>Step Four</option>
					<option value="5" <cfif isdefined('url.id') and LEN(url.id) and getTemplate.defaultentry eq '5'>selected</cfif>>Step Five</option>
				</select>
			</td> 
		</tr>


		<tr><td colspan="2"><input type="submit" value="Save"></td></tr>
		</table>

<style>
.templatedelete{color:red;}
.templatedelete:hover{text-decoration:underline;}
</style>


		<div style="width:700px;">
			<div align="center"><a hreflang="en" href="drip-templates.cfm?id=#id#&delete=" onclick="return confirm('Are you sure you wish to Delete this Template?')" class="templatedelete">Delete This Template</a></div>
		</div>
	</form>
</cfoutput>

<cfinclude template="/admin/components/footer.cfm">

<!--- Simple Form Validation --->
<script type="text/javascript">
	function validateForm()
	{
	var x=document.forms["thisform"]["subject"].value;
	if (x==null || x=="")
	  {
	  alert("Template Name is required.");
	  return false;
	  }
	  
	  var x=document.forms["thisform"]["body"].value;
	if (x==null || x=="")
	  {
	  alert("Template Body is required.");
	  return false;
	  }
	}
</SCRIPT>
