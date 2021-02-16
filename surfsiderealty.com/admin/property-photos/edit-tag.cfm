<cfset page.title ="Multi-Upload image Gallery Edit Image Tag">
<cfinclude template="/admin/components/header.cfm">

<style type="text/css">
   .files .preview img{width:100px}
</style>

<cfif isdefined("form.submit")>
	
	
		<cfloop from="1" to="#listlen(form.fieldnames)#" index="i">
			<cfif isnumeric(listgetat(form.fieldnames,i))>
				<cfquery datasource="#settings.dsn#">
					update prop_images
					set tag = <cfqueryparam cfsqltype="cf_sql_varchar" value="#structfind(form,listgetat(form.fieldnames,i))#">
					where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#listgetat(form.fieldnames,i)#">
				</cfquery>
			
			
			</cfif>
		</cfloop>
		
	
   
	<cflocation url="index.cfm?strpropid=#form.propid#" addtoken="false" >
 
</cfif>
<cfif isdefined("url.strpropid")>
<cfquery name="qimages" datasource="#settings.dsn#" >
	select id,strpropid,image,tag from prop_images
	where strpropid = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.strpropid#">
	order by sort
</cfquery>
<cfset filefolder = '/uploaded'>
<cfoutput>
<form method="post" action="#cgi.sCRIPT_NAME#">
	
	
	<input type="hidden" name="propid" value="#url.strpropid#">
	
	<table>
		<tr><th>&nbsp;</th><th>Tag</th></tr>
		
		<cfloop query="qimages">
			<tr valign="top"><td><img src="#filefolder#/#image#" style="height:135px;"></td><td>#image#<br><input type="text" name="#id#" id="#id#" value="#tag#"></td></tr>
			
		</cfloop>
		<tr><td>&nbsp;</td><td><button type="submit" name="submit" >Submit	</button></td></tr>
	</table>
	
</form>
</cfoutput>
</cfif>
<cfinclude template="/admin/components/footer.cfm" >