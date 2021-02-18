<cfsilent>

<cfif structKeyExists(cookie,"tinymce_domain")>

   <cfset temp_host = cookie.tinymce_domain>

<cfelse>

   <cfset temp_host = cgi.http_host>

</cfif>

<!--- remove any www in the domain name --->
<cfset temp_host = replaceNoCase(temp_host,"www.","")>

<cfif temp_host eq 'myrtlebeachseasideresorts.com'>

   <cfset settings.UserFiles 		= "E:\inetpub\wwwroot\domains\#temp_host#\htdocs\shared">

   <!---this exception is put into place b/c the site is not SSL, but uses an editor in the Emailer module.  Email clients don't like //--->
   <cfif cgi.http_host is "www.kingfishcup.com" or cgi.http_host is "www.sloanevacations.com">
   	<cfset settings.UserFilesURL	= "http://#cgi.http_host#/shared">
   <cfelse>

   <cfif cgi.https is "On">
   	<cfset settings.UserFilesURL	= "//#cgi.http_host#/shared">
   		<cfelse>
    <cfset settings.UserFilesURL	= "http://#cgi.http_host#/shared">
   </cfif>

   </cfif>




<cfelse>

   <!--- absolute path to User's File storage folder  --->
   <cfset settings.UserFiles 		= "E:\inetpub\wwwroot\domains\#temp_host#\htdocs\UserFiles">
   <!--- URL to user's file storage folder  --->
   <cfif !isDefined("cookie.UserFilesURL") and !isdefined("cookie.UserFiles")>

   <cfif cgi.http_host is "www.kingfishcup.com" or cgi.http_host is "www.sloanevacations.com">
     <cfset settings.UserFilesURL  = "http://#cgi.http_host#/userfiles">
   <cfelse>

   <cfif cgi.https is "On">
   	<cfset settings.UserFilesURL  = "//#cgi.http_host#/userfiles">
   		<cfelse>
    <cfset settings.UserFilesURL  = "http://#cgi.http_host#/userfiles">
   </cfif>

   </cfif>

       <!--- like : //myste.com/UserFiles --->
   <cfelse>
      <cfset settings.UserFilesURL = cookie.UserFilesURL>
      <cfset settings.UserFiles = cookie.UserFiles>
   </cfif>

</cfif>

<!---  --->
<!--- absolute path to User's File temp folder  --->
<cfset settings.TempFiles 		= "E:\inetpub\wwwroot\domains\#temp_host#\temp_files">

<!--- image size for thubnail images    --->
<cfset settings.thumbSize		= 120>

<!--- image size for medium size images --->
<cfset settings.middleSize		= 250>

<!--- Permision for linux               --->
<cfset settings.chomd			= "777">

<!--- disallowed file types             --->
<cfset settings.disfiles		= "cfc,exe,php,asp,cfm,cfml,aspx">

<cfset settings.excludeRegExp = '([^!@$##%\^\(\)&\s\*]+)'>
<cfset settings.fileExtensionRegExp = '\.(\w{3})$'>
<cfset settings.maxFileNameLength = 25>

</cfsilent>

<!--- Authentication --->

<cfif
      cgi.http_referer does not contain "#cgi.http_host#"
      or

      (
         !isdefined('cookie.LoggedInID')
         AND
         !isdefined('cookie.LoggedInAgentID')
         AND
         !isdefined('cookie.LoggedInAdminID')
          AND
         !isDefined("cookie.accessid")
      )
         >error code 17897

         <!---<cfoutput>#cgi.http_referer#|#cgi.http_host#|#(cgi.http_referer contains cgi.http_host)# | #structKeyExists(COOKIE,"loggedInID")#</cfoutput>--->

         <cfabort></cfif>
