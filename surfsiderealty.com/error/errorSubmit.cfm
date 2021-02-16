<cfif IsDefined('form') AND NOT StructIsEmpty(form)>
    <cfmail to="support@icoastalnet.com" from="Error Template <#cfmail.username#>" server="#cfmail.server#"  username="#cfmail.username#" password="#cfmail.password#" subject="Error Occured for #cgi.http_host#" type="HTML" port="#cfmail.port#" useSSL="#cfmail.useSSL#" >
        <cfdump var="#form#">	
        <h3>Please visit the Sentry for more details</h3>
    </cfmail>
</cfif>

<cfinclude template="/components/header.cfm">
<p>Thank you for submitting the error report.</p> <p>Our support team has been notified!</p>
<cfinclude template="/components/footer.cfm">