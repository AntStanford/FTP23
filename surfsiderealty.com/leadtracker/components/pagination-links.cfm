<!--- <nav>
   <ul class="pagination">
		<li><a hreflang="en" href="#">&laquo;</a></li>
		<li><a hreflang="en" href="#">1</a></li>
		<li><a hreflang="en" href="#">2</a></li>
		<li><a hreflang="en" href="#">3</a></li>
		<li><a hreflang="en" href="#">4</a></li>
		<li><a hreflang="en" href="#">5</a></li>
		<li><a hreflang="en" href="#">&raquo;</a></li>
	</ul>
</nav> --->


<cfif isdefined('getInfo.recordcount') and getInfo.recordcount gt 0>
	<cfoutput>
		<nav>
		   <ul class="pagination">


						Viewing: #tracker.startRow# - #tracker.endRow# of #tracker.totalResults#<br>

						<cfif tracker.resultPages gt 1>
							<cfif url.pg gte 4 and tracker.resultPages gt 6>
								<li><a hreflang="en" href="#cgi.script_name#?pg=1<cfif cgi.script_name contains 'dashboard.cfm'>&qry=#session.tracker.mainqry#&status=#url.status#</cfif>">Start</a></li>
								<li><a hreflang="en" href="#cgi.script_name#?pg=#tracker.navPrevLink#<cfif cgi.script_name contains 'dashboard.cfm'>&qry=#session.tracker.mainqry#&status=#url.status#</cfif>">&laquo;</a></li>
							</cfif>

							<!--- Display page links --->

							<cfloop from="#tracker.navLoopFrom#" to="#tracker.navLoopto#" index="i">
							 	<li><a hreflang="en" href="#cgi.script_name#?pg=#i#<cfif cgi.script_name contains 'dashboard.cfm'>&qry=#session.tracker.mainqry#&status=#url.status#</cfif>" <cfif url.pg eq i>style="font-weight:bold;text-decoration:none;"</cfif>>#i#</a>
							</cfloop>



							<!--- Next Page link --->
							<cfif url.pg lt tracker.resultPages and tracker.resultPages gt tracker.navShowPageLinks>
								 <li><a hreflang="en" href="#cgi.script_name#?pg=#tracker.navNextLink#<cfif cgi.script_name contains 'dashboard.cfm'>&qry=#session.tracker.mainqry#&status=#url.status#</cfif>">&raquo;</a></li>
							</cfif> 

							<cfif tracker.resultPages gt tracker.navShowPageLinks>
								<li><a hreflang="en" href="#cgi.script_name#?pg=#tracker.resultPages#<cfif cgi.script_name contains 'dashboard.cfm'>&qry=#session.tracker.mainqry#&status=#url.status#</cfif>">#tracker.resultPages#</a></li>
							</cfif>
						</cfif>

			</ul>
		</nav>
	</cfoutput>
</cfif>


