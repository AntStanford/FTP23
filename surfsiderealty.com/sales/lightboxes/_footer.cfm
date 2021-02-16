	<!---
	<cfif isdefined('returnlink')>
	  <cfif returnlink contains "?">
	    <cfset delimiter="&">
	  <cfelse>
	    <cfset delimiter="?">
	  </cfif>
	</cfif>

	<div align="center">
	  <cfif isdefined('cookie.loggedin') or (isdefined('ReferringPage') and ReferringPage contains "property-details.cfm")>
	    <cfif isdefined('returnlink')>
	      <cfoutput><a href="#returnlink##delimiter#dcr=" target="_parent" >Close Window</a></cfoutput>
	    <cfelse>
	      <a href="javascript:parent.$.fancybox.close();">Close Window</a>
	    </cfif>
	  <cfelse>
	    <a href="javascript:parent.$.fancybox.close();">Close Window</a>
	  </cfif>
	</div>
	--->

	</body>
</html>