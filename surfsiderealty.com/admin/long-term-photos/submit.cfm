<!--- Upload the pic to our temp file --->
<cfset uppicture = #ExpandPath('/images/long-term')#>

<cfif len(form.photo)>
  <cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>
  <cfset results=Obj.Check(uppicture,"photo")><cfif len(results.e)><cfoutput>#results.e#</cfoutput><cfabort></cfif>
  <cfset myfile = results.FILENAME>  
</cfif>
<cfset fullFilePath = uppicture & '\' & myfile>
<cfset lg_fullFilePath = uppicture & '\lg_' & myfile>
<cfset md_fullFilePath = uppicture & '\md_' & myfile>
<cfset th_fullFilePath = uppicture & '\th_' & myfile>
<!--- /Upload the pic to our temp file --->


<cffile action="copy" source="#fullFilePath#" destination="#lg_fullFilePath#">
<cffile action="copy" source="#fullFilePath#" destination="#md_fullFilePath#">
<cffile action="copy" source="#fullFilePath#" destination="#th_fullFilePath#">

<!--- On page variables --->
<cfset table = 'cms_long_term_rentals_photos'>

<cfquery name="GetMaxSort" datasource="#settings.dsn#">
	Select max(sort) as maxsort from #table#
</cfquery>

<cfif GetMaxSort.maxsort eq ''>
	<cfset newSort = 1>
<cfelse>
	<cfset newSort = 1 + GetMaxSort.maxsort>
</cfif>

<cfquery dataSource="#settings.dsn#">
	insert into #table# (rental_id,photo,sort)	  
	values( <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.rental_id#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#myfile#">,#newSort#)     
</cfquery>

<cflocation addToken="no" url="index.cfm?rental_id=#form.rental_id#&addsuccess">









