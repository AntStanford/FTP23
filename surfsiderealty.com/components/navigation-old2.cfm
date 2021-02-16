<!--- Here is the code used to generate the navigation --->
<cfquery name="getTopLevelNav" dataSource="#settings.dsn#">
  select id,name,slug,externalLink,triggerOnly
  from cms_pages where parentID = 0 and showinnavigation='Yes' order by sort
</cfquery>

<cfset logodone = 'no'>
<ul class="header-nav">
  <cfoutput query="getTopLevelNav">

<cfif recordcount/2 lt currentrow and logodone eq 'no'>
  <li class="logo"><a hreflang="en" href="/">Surfside Realty Company</a></li>
  <cfset logodone = 'yes'>
</cfif>

    <cfquery name="getSubNav" dataSource="#settings.dsn#">
      select id,name,slug,externalLink,triggerOnly
      from cms_pages where parentID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#getTopLevelNav.id#"> and subnavparentid = 0
      and showinnavigation='Yes'
      order by sort
    </cfquery>
    <cfif getSubNav.recordcount gt 0>
      <li>
        <cfif getTopLevelNav.triggerOnly eq 'Yes'>
          <a hreflang="en" href="javascript:;" class="site-color-3 site-color-1-hover">#name#</a>
        <cfelse>
          <cfif len(getTopLevelNav.externalLink)>
            <a hreflang="en" href="#getTopLevelNav.externalLink#" target="_blank" class="site-color-3 site-color-1-hover">#name#</a>
          <cfelse>
            <a hreflang="en" href="/#getTopLevelNav.slug#" class="site-color-3 site-color-1-hover">#name#</a>
          </cfif>
        </cfif>
        <ul>
          <cfloop query="getSubNav">
            <cfif len(getSubNav.externalLink)>
              <li><a hreflang="en" href="#getSubNav.externalLink#" target="_blank" class="site-color-1 site-color-1-hover">#name#</a></li>
            <cfelse>
              <li><a hreflang="en" href="/#getSubNav.slug#" class="site-color-1 site-color-1-hover">#name#</a></li>
            </cfif>
          </cfloop>
        </ul>
      </li>
    <cfelse>
      <cfif len(getTopLevelNav.externalLink)>
        <li><a hreflang="en" href="#getTopLevelNav.externalLink#" target="_blank" class="site-color-3 site-color-1-hover">#name#</a></li>
      <cfelseif getTopLevelNav.slug eq 'index'>
        <li><a hreflang="en" href="/" class="site-color-3 site-color-1-hover">#name#</a></li>
      <cfelse>
        <li><a hreflang="en" href="/#getTopLevelNav.slug#" class="site-color-3 site-color-1-hover">#name#</a></li>
      </cfif>
    </cfif>
  </cfoutput>
</ul>
