<cfif ListFind("216.99.119.254,98.121.170.115", cgi.remote_host)><p>ICND EYES ONLY</p>

<cfoutput>
<cfif isDefined('settings.booking.crlf')>
    <p>yep: #settings.booking.crlf#</p>
<cfelse>
    <p>nope</p>
</cfif>
</cfoutput>

<<!--- cfif isDefined('session.booking.getResults')>

    <cftry>

        <cfif isDefined('booking.getResults.price')>

            <cfquery name="priceCheck" dbtype="query">
                select
                    min(price) as min_price,
                    max(price) as max_price
                from
                    session.booking.getResults
            </cfquery>

            <cfoutput>
                <p>priceCheck.min_price: #priceCheck.min_price#</p>
                <p>priceCheck.max_price: #priceCheck.max_price#</p>
            </cfoutput>
        </cfif>

    <cfcatch>
        <cfdump var="#cfcatch#">
    </cfcatch>
    </cftry>

</cfif> --->

</cfif>