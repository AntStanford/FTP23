<cfquery name="GetPosts" datasource="#settings.dsn#">
  Select * from seasiderentalsexport order by id
</cfquery>

<cfoutput query="GetPosts">

  <cfset alias = post_title>
  <cfset alias = replace(alias,'&amp;','','all')>
  <cfset alias = replace(alias,'&apos;','','all')>
  <cfset alias = replace(alias,"'",'','all')>
  <cfset alias = replace(alias,':','','all')>
  <cfset alias = replace(alias,'!','','all')>
  <cfset alias = replace(alias,'?','','all')>
  <cfset alias = replace(alias,',','','all')>
  <cfset alias = replace(alias,'&','','all')>
  <cfset alias = replace(alias,'.','','all')>
  <cfset alias = replace(alias,'%','','all')>
  <cfset alias = replace(alias,' ','-','all')>

  <cfset body = post_content>
  <cfset body = replace(body,'seasiderentalsonline.com/blog/wp-content/uploads/','surfsiderealty.com/userfiles/blogimages/','all')>
  <cfset body = replace(body,'/n','','all')>

  <cfquery name="AddPost" datasource="#settings.dsn#">
    Insert into tblblogentries (id,username,posted,body,title,alias,blog,allowcomments,views,released)
    values(
      <cfqueryparam value="#createuuid()#" cfsqltype="cf_sql_varchar">,
      'blogadmin',
      <cfqueryparam value="#post_date#" cfsqltype="cf_sql_date">,
      <cfqueryparam value="#body#" cfsqltype="cf_sql_clob">,
      <cfqueryparam value="#post_title#" cfsqltype="cf_sql_varchar">,
      <cfqueryparam value="#alias#" cfsqltype="cf_sql_varchar">,
      'Default',
      1,
      0,
      1
      )
  </cfquery>


</cfoutput>