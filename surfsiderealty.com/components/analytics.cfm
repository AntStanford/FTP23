<cfif cgi.SCRIPT_NAME eq '/rentals/book-now-confirm.cfm' and isdefined('request.reservationCode') and len(request.reservationCode)>
  <cftry>
    <cfset ga = application.bookingObject.setGoogleAnalytics(settings,form,request.reservationCode)>
    <cfoutput>#ga#</cfoutput>
    <cfcatch>
      <cfmail to="bellefson@icoastalnet.com" from="#cfmail.username# <#cfmail.username#>" subject="Error from #cgi.http_host#" server="#cfmail.server#" username="#cfmail.username#" password="#cfmail.password#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" type="HTML" bcc="" cc="">
        <p>File: components/analytics.cfm</p>
        <cfdump var="#cfcatch#">
      </cfmail>
    </cfcatch>
  </cftry>
<cfelse>
  <cfoutput>
   <script type="text/javascript">
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
    ga('create', 'UA-15116429-1', 'auto', 'nativeTracker');
    ga('nativeTracker.require', 'displayfeatures');
    ga('nativeTracker.send', 'pageview');
    </script>
  </cfoutput>
</cfif>