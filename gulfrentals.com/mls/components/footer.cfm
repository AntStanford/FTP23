  <div class="mls-footer-wrap
    <cfif cgi.script_name eq '/#settings.mls.dir#/results.cfm' OR (isdefined('page.partial') and page.partial eq 'results.cfm') OR (isdefined('page.isCustomSearchPage') and page.isCustomSearchPage eq 'yes')>
      results-footer-wrap
    <cfelseif cgi.script_name eq '/#application.settings.mls.dir#/property.cfm'>
      property-footer-wrap
    <cfelseif cgi.script_name eq '/#application.settings.mls.dir#/compare-favs.cfm'>
      compare-footer-wrap
    </cfif> site-color-3-bg">
    <cfoutput>
      <ul class="mls-footer-quick-links">
        <!---<li><a href="javascript:;"><i class="fa fa-comments"></i><span>Click to Chat (Optional)</span></a></li>--->
        <li><a href="tel:#settings.tollFree#"><i class="fa fa-phone"></i><span>#application.settings.tollFree#</span></a></li>
        <li><a href="/contact"><i class="fa fa-envelope"></i><span>Get In Touch</span></a></li>
      </ul>
      <span class="mls-footer-copyright">
        <span>Copyright &copy; #dateformat(now(),'YYYY')# <a href="">#application.settings.company#</a>.</span> All Rights Reserved.
      </span>
    </cfoutput>
  </div><!-- END mls-footer-wrap -->
</div><!-- END wrapper -->

<!--- Output all scripts here --->
<cf_htmlfoot output="true" />

<cfinclude template="footer-javascripts.cfm">
<!--- Shared.js is a Shared Sitewide JS file --->
<!---<script src="/javascripts/shared.js" defer></script>--->
<!--- global.js made last on Purpose --->
<script src="/<cfoutput>#application.settings.mls.dir#</cfoutput>/javascripts/global.js" defer></script>

<cfinclude template="footer-modals.cfm">

</body>
</html>