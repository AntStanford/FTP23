<cfquery name="getProperty" datasource="mlsv30Master">
    Select mlsid, wsid, street_number, street_name, zip_code
    from mastertable
    where mlsnumber = <cfqueryparam value="#url.mlsnumber#" cfsqltype="CF_SQL_INTEGER">

    <cfif isDefined('settings.mls.mlsid') AND LEN(settings.mls.mlsid)>
        AND mlsid IN ( <cfqueryparam value="#settings.mls.mlsid#" cfsqltype="CF_SQL_INTEGER" List="Yes"> )
    </cfif>
</cfquery>


<cfif getProperty.recordcount eq 0>

    <cfheader statusCode = "404" statusText = "Page Not Found">

<cfelse>



    <cfheader statusCode = "301" statusText = "Moved permanently">

    <cfoutput>

        <cfif getProperty.street_number neq ''>
            <cfset seoAddress = lcase(trim(getProperty.street_number) & ' ' & trim(getProperty.street_name))>
        <cfelse>
            <cfset seoAddress = lcase(trim(getProperty.street_name))>
        </cfif>
        <cfset seoAddress = replace(seoAddress, ' ', '-', 'all')>
        <cfset seoAddress = replace(seoAddress, '&', '', 'all')>
        <cfset seoAddress = replace(seoAddress, "'", '', 'all')>
        <cfset seoAddress = replace(seoAddress, ".", '', 'all')>

        <cflocation url="/mls/#url.mlsnumber#-#getProperty.wsid#-#getProperty.mlsid#/#seoAddress#" addtoken="false" statuscode="301">


    </cfoutput>

</cfif>
