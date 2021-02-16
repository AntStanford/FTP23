<cfoutput>
  <cfif cgi.script_name eq '/rentals/property.cfm'> <!--- property detail page --->
    <cfset metadata = application.bookingObject.setPropertyMetaData(property,settings)>
    #metadata#
  <cfelseif cgi.script_name eq '/layouts/long-term-rental.cfm' and isdefined('getLongTermRental') and getLongTermRental.recordcount gt 0><!--- Long term rentals detail page --->   
  		<title>#getLongTermRental.metaTitle#</title>
  		<meta name="description" content="#stripHTML(getLongTermRental.metaDescription)#">
  <cfelseif cgi.script_name eq '/layouts/condo.cfm' and isdefined('getinfo') and getinfo.recordcount gt 0><!--- resort detail page --->   
  		<title>#getinfo.metaTitle#</title>  		
  		<meta name="description" content="#stripHTML(getinfo.metaDescription)#">
  <cfelseif cgi.script_name eq '/layouts/thingstodo-categories.cfm' and isdefined('getCategory') and getCategory.recordcount gt 0><!--- things to do for one category page --->   
  		<title>#getCategory.title#</title> 
  <cfelseif cgi.script_name eq '/layouts/special.cfm' and isdefined('getSpecial') and getSpecial.recordcount gt 0>
  		<title>#getSpecial.title#</title> 	
  		<meta name="description" content="#stripHTML(getSpecial.description)#">	
  <cfelseif cgi.script_name eq '/layouts/staff.cfm' and isdefined('getStaff') and getStaff.recordcount gt 0>
  		<title>#getStaff.name#</title> 	
  		<meta name="description" content="#stripHTML(getStaff.description)#">	
  <cfelseif cgi.script_name eq '/layouts/event.cfm' and isdefined('getEvent') and getEvent.recordcount gt 0>
  		<title>#getEvent.event_title#</title> 	
  		<meta name="description" content="#stripHTML(getEvent.details_long)#">	
  <cfelseif cgi.script_name eq '/#settings.booking.dir#/results.cfm'>

     <cfquery dataSource="#settings.dsn#" name="page">
       select * from cms_pages where id = 670
     </cfquery>

    <cfif isdefined('page.metatitle') and len(page.metatitle)>
      <title>#page.metatitle#</title>
    <cfelseif isdefined('page.name') and len(page.name)>
      <title>#page.name# - #settings.company#</title>
    </cfif>
    <cfif isdefined('page.metadescription') and len(page.metadescription)>
      <meta name="description" content="#page.metadescription#">
    <cfelseif isdefined('page.body') and len(page.body)>
      <cfset tempBody = striphtml(mid(page.body,1,155))>
      <meta name="description" content="#tempBody#">
    </cfif>
    <cfif cgi.https eq 'off'>
      <link rel="canonical" href="http://#cgi.server_name#/#settings.booking.dir#/results">
    <cfelse>
      <link rel="canonical" href="https://#cgi.server_name#/#settings.booking.dir#/results">
    </cfif>
  <cfelse>
    <cfif isdefined('page.metatitle') and len(page.metatitle)>
      <title>#page.metatitle#</title>
    <cfelseif isdefined('page.name') and len(page.name)>
      <title>#page.name# - #settings.company#</title>
    <cfelse>
      <title>#settings.company#</title>
    </cfif>
    <cfif isdefined('page.metadescription') and len(page.metadescription)>
      <meta name="description" content="#page.metadescription#">
    <cfelseif isdefined('page.body') and len(page.body)>
      <cfset tempBody = striphtml(mid(page.body,1,155))>
      <meta name="description" content="#tempBody#">
    <cfelse>
      <meta name="description" content="#settings.metaDescription#">
    </cfif>
  </cfif>
</cfoutput>
<meta name="referrer" content="unsafe-url">