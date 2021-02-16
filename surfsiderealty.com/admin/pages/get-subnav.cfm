<cfquery name="getSubNav" dataSource="#settings.dsn#">
	select id,name from cms_pages where parentID = <cfqueryparam  CFSQLType="CF_SQL_INTEGER" value="#url.parentID#"> and subnavparentid = 0
</cfquery>

<cfif getSubNav.recordcount gt 0>

<label class="control-label">Sub-nav Parent</label>
<div class="controls">
	<select name="subnavParentID" style="width:200px">
		<option value="0">- Choose One -</option>
		<cfoutput query="getSubNav">
			<option value="#id#">#name#</option>
		</cfoutput>
	</select>
</div>

</cfif>