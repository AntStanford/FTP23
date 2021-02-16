<cftry>

<cfset uppicture = ExpandPath('/images/popups')>

<cfif isdefined('url.delete') and isdefined('url.id')>

  <cfquery dataSource="#settings.dsn#">
    DELETE FROM cms_popups
    WHERE id = <cfqueryparam value="#url.id#" cfsqltype="integer">
  </cfquery>

 <cflocation url="index.cfm" addtoken="false">

<cfelseif isdefined('url.removePhoto') and len(url.removePhoto)>

  <cfquery name="getPhoto" dataSource="#settings.dsn#">
    select photo from cms_popups where id = <cfqueryparam value="#url.removePhoto#" cfsqltype="integer"> limit 1
  </cfquery>

  <cfquery dataSource="#settings.dsn#">
    Update cms_popups 
    Set photo = ''
    Where id = <cfqueryparam value="#url.removePhoto#" cfsqltype="integer">
  </cfquery>

  <cfif getPhoto.recordcount eq 1>
  	<cftry>
  	<cfset photoPath = ("#uppicture#\#getPhoto.photo#")>	

	<cfscript>
		FileDelete(#photoPath#);		
	</cfscript>

  	<cfcatch></cfcatch>
  	</cftry>
  </cfif>

 <cflocation url="form.cfm?id=#url.removePhoto#" addtoken="false">

<cfelseif isdefined('form.id') and len(form.id)>
  <cfif isdefined('form.photo') and len(form.photo)>
    <cfif !isdefined( 'Obj' )>
      <cfset Obj = new Components.fileCheck().init() />
    </cfif>
    
    <cfset results = Obj.Check(uppicture,"photo")>

    <cfif len( results.e )>
      <cfoutput>#results.e#</cfoutput><cfabort>
    </cfif>
    
    <cfset myfile = results.filename>

	  <cfimage action = "info" source = "#uppicture#/#myfile#" structname = "imgInfo">
	  <cfif imgInfo.width gt 400>
		<CF_GraphicsMagick 
		     action="ResizeWidth" 
		     infile="#uppicture#/#myfile#" 
		     outfile="#uppicture#/#myfile#" 
		     width="400" 
		     height="" 
		     debug="true"> 
	  </cfif>
  </cfif>

  <cfquery dataSource="#settings.dsn#">
    UPDATE cms_popups
    SET title = <cfqueryparam value="#form.title#" cfsqltype="varchar">
		,message = <cfqueryparam value="#form.message#" cfsqltype="varchar">
		,link = <cfqueryparam value="#form.link#" cfsqltype="varchar">
    ,linkText = <cfqueryparam value="#form.linkText#" cfsqltype="varchar">
		,isActive = <cfqueryparam value="#form.isActive#" cfsqltype="tinyint">
		,captureEmail = <cfqueryparam value="#form.captureEmail#" cfsqltype="tinyint">
    ,showCompanyBox = <cfqueryparam value="1" cfsqltype="tinyint">
		<cfif isdefined('myfile') and LEN(myfile)>,photo = <cfqueryparam value="#myfile#" cfsqltype="varchar"></cfif>
    WHERE id = <cfqueryparam value="#form.id#" cfsqltype="integer">
  </cfquery>

  <cflocation url="form.cfm?id=#form.id#&success=yes" addtoken="false">

<cfelse>

  <cfif isdefined('form.photo') and len(form.photo)>
    <cfif !isdefined( 'Obj' )>
      <cfset Obj = new Components.fileCheck().init() />
    </cfif>
    
    <cfset results = Obj.Check(uppicture,"photo")>

    <cfif len( results.e )>
      <cfoutput>#results.e#</cfoutput><cfabort>
    </cfif>
    
    <cfset myfile = results.filename>

	  <cfimage action = "info" source = "#uppicture#/#myfile#" structname = "imgInfo">
	  <cfif imgInfo.width gt 400>
		<CF_GraphicsMagick 
		     action="ResizeWidth" 
		     infile="#uppicture#/#myfile#" 
		     outfile="#uppicture#/#myfile#" 
		     width="400" 
		     height="" 
		     debug="true"> 
	  </cfif>
  </cfif>

  <cfquery dataSource="#settings.dsn#">
    INSERT INTO cms_popups(title,message,link,linkText,isActive,captureEmail,showCompanyBox<cfif isdefined('myfile') and LEN(myfile)>,photo</cfif>) 
    VALUES(
    	<cfqueryparam value="#form.title#" cfsqltype="varchar">,
    	<cfqueryparam value="#form.message#" cfsqltype="varchar">,
    	<cfqueryparam value="#form.link#" cfsqltype="varchar">,
      <cfqueryparam value="#form.linkText#" cfsqltype="varchar">,
    	<cfqueryparam value="#form.isActive#" cfsqltype="tinyint">,
    	<cfqueryparam value="#form.captureEmail#" cfsqltype="tinyint">,
      <cfqueryparam value="1" cfsqltype="tinyint">
    	<cfif isdefined('myfile') and LEN(myfile)>,<cfqueryparam value="#myfile#" cfsqltype="varchar"></cfif>
    	)
  </cfquery>

  <cflocation url="form.cfm?success=yes" addtoken="false">

</cfif>



<cfcatch><cfdump var="#cfcatch#"></cfcatch>
</cftry>