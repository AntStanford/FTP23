
<cfif listFind("69.249.111.59",cgi.remote_addr)>
   <cfif structKeyExists(URL,"debug")>
      <cfif application.oHelpers.isAjax() eq false>
      <cfinclude template="icnd.cfm">
      </cfif>
   </cfif>
</cfif>