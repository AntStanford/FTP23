<cfquery name="Delete" datasource="#settings.dsn#">
    Delete from cms_long_term_rentals_photos
    where id = <cfqueryparam value="#url.photoid#" cfsqltype="cf_sql_integer">
</cfquery>

<cflocation addToken="no" url="index.cfm?rental_id=#url.rental_id#&deletesuccess">