<cfif isdefined('url.unitcode') AND isdefined('url.favAdded')> <!--- We are adding or removing an item from our favorites --->
	<cfset favIndex = ListFind(cookie.favorites,url.unitcode)>
  <cfif favIndex gt 0 AND url.favAdded EQ 0>
    <cfset cookie.favorites = ListDeleteAt(cookie.favorites,favIndex)>  <!--- delete fav --->
    <cfcookie name="favorites" expires="never" value="#cookie.favorites#">
  <cfelseif favIndex EQ 0 AND url.favAdded EQ 1>
    <cfcookie name="favorites" expires="never" value="#url.unitcode#,#cookie.favorites#">
  </cfif>
</cfif> 
<cfoutput>#listlen(cookie.favorites)#</cfoutput>