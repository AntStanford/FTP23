<cfif isdefined('url.id') and isDefined('form.rowID')> <!--- update statement --->

    <cfset variables.rowsSubmitted = ListLen(form.rowID)>

    <cfquery name="Delete" datasource="#application.dsn#">
        Delete from cms_rates
        Where propertyid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.id#">
    </cfquery>

    <cfloop from="1" to="#variables.rowsSubmitted#" index="i">

        <cftry>
        <cfquery dataSource="#application.dsn#">
            insert into cms_rates (propertyid,<cfif i IS NOT variables.rowsSubmitted AND i IS NOT (variables.rowsSubmitted -1)>startdate,enddate,<cfelse>startdate,</cfif>rent)
            values(
                <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.id#">,
                <cfif i eq variables.rowsSubmitted> <!--- Monthly --->
                    <cfqueryparam CFSQLType="CF_SQL_DATE" value="3122-12-31">,
                <cfelseif i eq (variables.rowsSubmitted -1)> <!--- Holiday --->
                    <cfqueryparam CFSQLType="CF_SQL_DATE" value="3022-12-31">,
                <cfelse>
                    <cfif isDefined('form["startdate_#i#"]') AND LEN(form["startdate_#i#"])>
                        <cfqueryparam CFSQLType="CF_SQL_DATE" value="#DateFormat(form["startdate_#i#"],'mm-dd-yyyy')#">,
                    <cfelse>
                        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="0000-00-00">,
                    </cfif>

                    <cfif isDefined('form["enddate_#i#"]') AND LEN(form["enddate_#i#"])>
                        <cfqueryparam CFSQLType="CF_SQL_DATE" value="#DateFormat(form["enddate_#i#"],'mm-dd-yyyy')#">,
                    <cfelse>
                        <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="0000-00-00">,
                    </cfif>
                </cfif>
                <cfif isDefined('form["rent_#i#"]') AND LEN(form["rent_#i#"])>
                    <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form["rent_#i#"]#">
                <cfelse>
                    <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="">
                </cfif>
            )
        </cfquery>
        <cfcatch><cfdump var="#cfcatch#"></cfcatch>
        </cftry>
    </cfloop>

    <cflocation addToken="no" url="form.cfm?id=#url.id#&name=#url.name#&success">

</cfif>
