<link href="/admin/stylesheets/lightboxstyles.css" rel="stylesheet" type="text/css">
<cfset uploadpath = #expandpath('/admin/contacts/clientdocs/')#>

<div id="boxbody">

<cfif cgi.request_method eq "post" >




  <cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>
  <cfset results=Obj.Check(uploadpath,"filename")><cfif len(results)><cfoutput><H4>#results#</H4></cfoutput><cfabort></cfif>
  <cfset myfile = results.filename>
 
    <cfquery datasource="#mls.dsn#" dbtype="ODBC">
    insert into cl_document_manager
    (filename,documenttitle,clientid) 
    values 
    ('#myfile#','#documenttitle#','#id#')
  </cfquery>

          
          

    <div class="success">
    The Document has been uploaded.
    </div>





<cfelse>




<h1>New  Document</h1>
<cfoutput>
<form action="#cgi.script_name#" method="post" enctype="multipart/form-data">
<input type="hidden" name="id" value="#url.id#">
  <div class="create_activity">

    <div>
      <label for="DocumentTitle" style="margin-right:16px;">Document Title</label>
      <input type="text" name="DocumentTitle">
    </div>
    <div style="margin-top:5px;">
      <!--- <label for="filename" style="margin-right:96px;">File</label> --->
      <input maxlength="255" name="filename" size="40" type="file"/>
    </div>
    <div style="margin-top:10px;">
      <input type="submit" name="submit" style="width: 119px;">
    </div>

  </div>
</form>
</cfoutput>

</cfif>

</div>
