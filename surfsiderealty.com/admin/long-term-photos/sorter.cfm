

<cfdump var="#url#">

<cfset counter = 1>
<cfloop list="#url.sortOrder#" index="i">
	<cfquery dataSource="#settings.dsn#">
		UPDATE cms_long_term_rentals_photos
		SET sort = <cfqueryparam value="#counter#" cfsqltype="cf_sql_integer">
		WHERE id = <cfqueryparam value="#i#" cfsqltype="cf_sql_integer">
	</cfquery>
	<cfset counter = counter + 1>
	
</cfloop>




<!--- 
<cfset firstCouplet = listgetat(url.sortOrder,1)>
<cfset secondCouplet = listgetat(url.sortOrder,2)>

<Cfoutput>
	#firstCouplet# #secondCouplet#<br>
</Cfoutput>

<cfset newFirstCouplet = listgetat(firstCouplet,1,'-') & ',' & listgetat(secondCouplet,2,'-')>
<cfset newSecondCouplet = listgetat(secondCouplet,1,'-') & ',' & listgetat(firstCouplet,2,'-')>

<Cfoutput>
	#newFirstCouplet# #newSecondCouplet#<br>
</Cfoutput>

<cfquery dataSource="#settings.dsn#">
	UPDATE cms_long_term_rentals_photos
	SET sort = <cfqueryparam value="#listgetat(newFirstCouplet,1)#" cfsqltype="cf_sql_integer">
	WHERE id = <cfqueryparam value="#listgetat(newFirstCouplet,2)#" cfsqltype="cf_sql_integer">
</cfquery>

<cfquery dataSource="#settings.dsn#">
	UPDATE cms_long_term_rentals_photos
	SET sort = <cfqueryparam value="#listgetat(newSecondCouplet,1)#" cfsqltype="cf_sql_integer">
	WHERE id = <cfqueryparam value="#listgetat(newSecondCouplet,2)#" cfsqltype="cf_sql_integer">
</cfquery>
 --->