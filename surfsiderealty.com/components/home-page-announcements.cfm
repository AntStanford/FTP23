<cfquery name="GetHPAnnouncements" dataSource="#settings.dsn#">
  select * from cms_homepage_announcements
  where active = 'Yes'
  AND now() BETWEEN start_date AND end_date
  order by createdAt desc
</cfquery>

<cfoutput query="GetHPAnnouncements">
  <cfif GetHPAnnouncements.type eq 'Regular'>
    <cfset theClass = 'regularMessage'>
  <cfelseif GetHPAnnouncements.type eq 'Emergency'>
    <cfset theClass = 'emergencyMessage'>
  <cfelseif GetHPAnnouncements.type eq 'Special'>
    <cfset theClass = 'specialMessage'>
  </cfif>
  <div id="homepage-announcement">
    <div class="#theClass#">
      <h2 class="title">#title#</h2>
      <div class="description">#description#</div>
    </div>
  </div>
</cfoutput>