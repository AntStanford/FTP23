  <div class="booking-footer-wrap
    <cfif cgi.script_name eq '/#settings.booking.dir#/results.cfm' OR (isdefined('page.partial') and page.partial eq 'results.cfm') OR (StructKeyExists(request,'resortContent')) OR (isdefined('page') and page.isCustomSearchPage eq 'Yes') OR (cgi.script_name eq '/layouts/special.cfm')> 
      results-footer-wrap
    <cfelseif cgi.script_name eq '/#settings.booking.dir#/property.cfm'> 
      property-footer-wrap
    <cfelseif cgi.script_name eq '/#settings.booking.dir#/compare-favs.cfm'> 
      compare-footer-wrap
    <cfelseif cgi.script_name eq '/#settings.booking.dir#/book-now.cfm'> 
      booknow-footer-wrap
    <cfelseif cgi.script_name eq '/#settings.booking.dir#/book-now-confirm.cfm'> 
      booknow-confirm-footer-wrap
    </cfif> site-color-3-bg">
    <cfoutput>
      <ul class="booking-footer-quick-links">
        <!---<li><a href="javascript:;"><i class="fa fa-comments"></i><span>Click to Chat (Optional)</span></a></li>--->
        <li><a href="tel:#settings.tollFree#"><i class="fa fa-phone"></i><span>#settings.tollFree#</span></a></li>
        <li><a href="/contact"><i class="fa fa-envelope"></i><span>Get In Touch</span></a></li>
      </ul>
      <span class="booking-footer-copyright">
        <span>Copyright &copy; #dateformat(now(),'YYYY')# <a href="">#settings.company#</a>.</span> All Rights Reserved.
      </span>
    </cfoutput>
  </div><!-- END booking-footer-wrap -->
</div><!-- END wrapper -->

<!--- Output all scripts here --->
<cf_htmlfoot output="true" />

<cfinclude template="footer-javascripts.cfm">
<!--- Shared.js is a Shared Sitewide JS file --->
<!---<script src="/javascripts/shared.js" defer></script>--->
<!--- global.js made last on Purpose --->
<script src="/<cfoutput>#settings.booking.dir#</cfoutput>/javascripts/global.js" defer></script>

</body>
</html>