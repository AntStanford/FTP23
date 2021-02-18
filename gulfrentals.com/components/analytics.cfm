<cfif cgi.SCRIPT_NAME eq '/#settings.booking.dir#/book-now-confirm.cfm' and StructKeyExists(request,'reservationCode') and len(request.reservationCode)>
  <cftry>
    <cfset ga = application.bookingObject.setGoogleAnalytics(settings,form,request.reservationCode)>
    <cfoutput>#ga#</cfoutput>
    <cfcatch>
		<cfif isdefined("ravenClient")>
			<cfset ravenClient.captureException(cfcatch)>
		</cfif>
    </cfcatch>
  </cftry>
<cfelse>
  <cfoutput>
    <script type="text/javascript" defer="defer">
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
    ga('create', '#settings.googleAnalytics#', 'auto');
    ga('require', 'displayfeatures');
    ga('send', 'pageview');
    </script>
  </cfoutput>
</cfif>