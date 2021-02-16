<!--- Here is the code used to generate the navigation --->
<cfquery name="getTopLevelNav" dataSource="#settings.dsn#">
  select id,name,slug,externalLink,triggerOnly
  from cms_pages where parentID = 0 and showinnavigation='Yes' order by sort
</cfquery>

<cfset logodone = 'no'>
<ul class="header-nav">
  <cfoutput query="getTopLevelNav">
    <cfif recordcount/2 lt currentrow and logodone eq 'no'>
      <cfif cgi.script_name contains '/#settings.booking.dir#' OR (isdefined('page.partial') and page.partial eq 'results.cfm') OR (StructKeyExists(request,'resortContent')) OR (isdefined('page') and page.isCustomSearchPage eq 'Yes') OR (cgi.script_name eq '/layouts/special.cfm')>

      <cfelse>
        <li class="logo"><a hreflang="en" href="/">Surfside Realty Company</a></li>
        <cfset logodone = 'yes'>
      </cfif>
    </cfif>

    <cfquery name="getSubNav" dataSource="#settings.dsn#">
      select id,name,slug,externalLink,triggerOnly
      from cms_pages
      where parentID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#getTopLevelNav.id#">
      and subnavparentid = 0
      and showinnavigation = 'Yes'
      order by subsort
    </cfquery>

    <cfif getSubNav.recordcount gt 0>
      <li>
        <cfif getTopLevelNav.triggerOnly eq 'Yes'>
          <a hreflang="en" href="javascript:;" class="text-white site-color-3-hover">#name#</a>
        <cfelse>
          <cfif len(getTopLevelNav.externalLink)>
            <a hreflang="en" href="#getTopLevelNav.externalLink#" target="_blank" class="text-white site-color-3-hover">#name#</a>
          <cfelse>
            <a hreflang="en" href="/#getTopLevelNav.slug#" class="text-white site-color-3-hover">#name#</a>
          </cfif>
        </cfif>

        <i class="fa fa-chevron-down text-white"></i>
        <ul>
          <cfloop query="getSubNav">
            <li>
              <cfif getSubNav.triggerOnly eq 'Yes'>
                <a hreflang="en" href="javascript:;">#name#</a>
              <cfelse>
                <cfif len(getSubNav.externalLink)>
                  <a hreflang="en" href="#getSubNav.externalLink#" target="_blank" class="text-white site-color-3-hover">#name#</a>
                <cfelse>
                  <a hreflang="en" href="/#getSubNav.slug#" class="text-white site-color-3-hover">#name#</a>
                </cfif>
              </cfif>

              <cfquery name="subsubCheck" dataSource="#settings.dsn#">
                select *
                from cms_pages
                where subNavParentID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#getSubNav.id#">
                and showInNavigation = 'Yes'
                order by subsubsort
              </cfquery>

              <cfif subsubCheck.recordcount gt 0>
                <i class="fa fa-chevron-down text-white"></i>
                <ul>
                  <cfloop query="subsubCheck">
                    <cfif len(subsubCheck.externalLink)>
                      <li><a class="text-white site-color-3-hover" hreflang="en" href="#subsubCheck.externalLink#" target="_blank">#name#</a></li>
                    <cfelse>
                      <li><a class="text-white site-color-3-hover" hreflang="en" href="/#subsubCheck.slug#">#name#</a></li>
                    </cfif>
                  </cfloop>
                </ul>
              </cfif>
            </li>
          </cfloop>
        </ul>
      </li>
    <cfelse>
      <cfif len(getTopLevelNav.externalLink)>
        <li><a hreflang="en" href="#getTopLevelNav.externalLink#" target="_blank" class="text-white site-color-3-hover">#name#</a></li>
      <cfelseif getTopLevelNav.slug eq 'index'>
        <li><a hreflang="en" href="/" class="text-white site-color-3-hover">#name#</a></li>
      <cfelse>
        <li><a hreflang="en" href="/#getTopLevelNav.slug#" class="text-white site-color-3-hover">#name#</a></li>
      </cfif>
    </cfif>
  </cfoutput>
</ul>