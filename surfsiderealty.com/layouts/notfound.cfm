<cfif LEN(page.slug) eq 0>
	<style>
  #header, #content { display: none; }
	</style>
</cfif>

<cfheader statusCode = "404" statusText = "Page Not Found">

<!--- PAGE LAYOUT HERE --->
<div class="container mainContent">
	<div class="row">
		<div id="left" class="col-xs-12">
      <h1>Page Not Found</h1>
      <p>Sorry, the page you were looking for could not be found. <a hreflang="en" href="/">Continue browsing</a> the rest of the site.</p>
      <br><br>
		</div>
	</div>
</div>
<!--- END PAGE LAYOUT HERE --->

<cfif
      cgi.HTTP_USER_AGENT contains 'Chrome' or
      cgi.HTTP_USER_AGENT contains 'MSIE' or
      cgi.HTTP_USER_AGENT contains 'Firefox' or
      cgi.HTTP_USER_AGENT contains 'Opera' or
      cgi.HTTP_USER_AGENT contains 'Safari' or
      cgi.HTTP_USER_AGENT contains 'Mozilla'>

<cfquery dataSource="#settings.dsn#">
	insert into notfound(thepage,thereferer,remoteip)
	values(
	<cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#slug#">,
	<cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#cgi.HTTP_REFERER#" >,
	<cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#cgi.REMOTE_ADDR#">
	)
</cfquery>
</cfif>