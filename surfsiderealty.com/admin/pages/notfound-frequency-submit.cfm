
<CFQUERY NAME="UpdateQuery" DATASOURCE="#settings.dsn#">
UPDATE notfound
SET 
notes = '#notes#'
where id = #id#
</cfquery>



 <cflocation addToken="no" url="notfound-frequency.cfm?&success">
