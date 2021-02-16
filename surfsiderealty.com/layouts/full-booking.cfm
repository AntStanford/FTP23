<cfset url.all_properties = 'true'>
<cfif page.customSearchJSON neq ''>
  <cfset form.camefromsearchform = ''>
  <cfset form.fieldnames = 'camefromsearchform' />
  <cfset data = deserializeJSON(page.customSearchJSON)>
  <cfset structure_key_list = structKeyList(data)>
  <cfloop list="#structure_key_list#" index="k">
    <cfset form[k] = data[k]>
    <cfset form.fieldnames = listAppend(form.fieldnames, k) />
  </cfloop>
</cfif>
<cfif IsDefined('page') AND page.id EQ 630> 
	<cfset request.resortContent = "">
</cfif>
<cfinclude template="/#settings.booking.dir#/results.cfm">