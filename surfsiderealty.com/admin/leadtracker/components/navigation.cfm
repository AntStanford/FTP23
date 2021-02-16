<cfset currentpage = cgi.script_name>

<nav class="navbar main navbar-inverse" role="navigation">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">


                <li <cfif currentpage contains "dashboard">class='active'</cfif>><a hreflang="en" href="/admin/leadtracker/dashboard.cfm">Dashboard</a></li>

                <li <cfif currentpage contains "search.cfm">class='active'</cfif>><a hreflang="en" href="/admin/leadtracker/search.cfm" >Contacts</a></li>

                <cfif isdefined('cookie.LoggedInAdminID')>

                       <!---  <cfif isdefined('cookie.LoggedInAdminName')>
                            <li><a hreflang="en" href="/admin/recent-activity.cfm" <cfif currentpage contains "recent-activity.cfm">class='active'</cfif>>Activity</a></li>
                        </cfif> --->

                        <li <cfif currentpage contains "pages.cfm">class='active'</cfif>><a hreflang="en" href="/admin/leadtracker/pages.cfm" >Pages</a></li>

                        <li <cfif currentpage contains "agents">class='active'</cfif>><a hreflang="en" href="/admin/leadtracker/agents.cfm">Agents</a></li>
      
                        <li <cfif currentpage contains "users.cfm">class='active'</cfif>><a hreflang="en" href="/admin/leadtracker/users.cfm">Users</a></li>

                        <li class='dropdown  <cfif currentpage contains "lead-ratings.cfm" or  currentpage contains "lead-statuses.cfm" or  currentpage contains "lead-sources.cfm" or currentpage contains "contact-types.cfm">active</cfif>'>
                            <a hreflang="en" href="#" class="dropdown-toggle" data-toggle="dropdown">Lead Settings <span class="caret"></span></a>
                            <ul class="dropdown-menu" role="menu">

                                <li><a hreflang="en" href="/admin/leadtracker/lead-ratings.cfm">Lead Ratings</a></li>
                                <li><a hreflang="en" href="/admin/leadtracker/lead-statuses.cfm">Lead Statuses</a></li>
                                <li><a hreflang="en" href="/admin/leadtracker/lead-sources.cfm">Lead Sources</a></li>
                                <li><a hreflang="en" href="/admin/leadtracker/contact-types.cfm">Contact Types</a></li>
                                <li><a hreflang="en" href="/admin/leadtracker/agent-on-duty.cfm">Agent on Duty</a></li>

                            </ul>
                        </li>

                        <li <cfif currentpage contains "tracking-links.cfm">class='active'</cfif>><a hreflang="en" href="/admin/leadtracker/tracking-links.cfm">Tracking Links</a></li>

                 </cfif>

                <cfif isdefined('cookie.LOGGEDINAGENTID')> 
                    <cfoutput><li <cfif currentpage contains "leadtracker/agents-">class='active'</cfif>><a hreflang="en" href="/admin/leadtracker/agents-edit.cfm?id=#cookie.LoggedInAgentID#">Agent Profile</a></li></cfoutput>
                </cfif>

                  
                        <li class="dropdown <cfif currentpage contains 'leadtracker/drip-'>active</cfif>">
                            <a hreflang="en" href="#" class="dropdown-toggle" data-toggle="dropdown">Drip Campaigns <span class="caret"></span></a>
                            <ul class="dropdown-menu" role="menu">
  
                                <li><a hreflang="en" href="/admin/leadtracker/drip-campaigns.cfm">Campaigns</a></li>
                                  <li><a hreflang="en" href="/admin/leadtracker/drip-library.cfm">Library</a></li>
                                  <cfif isdefined('cookie.LoggedInAdminID')> 
                                        <li><a hreflang="en" href="/admin/leadtracker/drip-campaign-templates.cfm">Templates</a></li>
                                  </cfif>

                            </ul>
                        </li>


                <li><a hreflang="en" href="/admin/login.cfm?logout=">Log Out</a></li>



            </ul>

        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container-fluid -->
</nav>
