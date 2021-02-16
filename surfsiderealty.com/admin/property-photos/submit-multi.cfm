<cfif not isDefined("form.strPropId")><cfabort></cfif>
<!--- On page variables --->
<cfset variables.e="">
<cfset allowed_file_types="jpg,gif,png,jpeg">
<cfset temp_host = cookie.tinymce_domain>
<cfset temp_host = replaceNoCase(temp_host,"www.","")>


<cfset temp_images_path="e:\inetpub\wwwroot\domains\#temp_host#\temp_files">

<cfset originalPath = expandPath('/uploaded')>






<cfoutput>
    <!--- Image Upload CF --->

	<cffile
    action = "uploadAll"
    destination = "#temp_images_path#"
    accept = "image/jpg,image/jpeg,image/gif,image/png"
    nameConflict = "MakeUnique"
    result = "upfilelist">
 <cfset cma=""/>
 {"files":[
    <cfloop array="#upfilelist#" index="i">

       <cfset newfilename="">

      <cfif i.filesize gt "10485760">
         <cfset variables.e = variables.e & "File must be less than 10MB in size.">
      </cfif>

      <cfif variables.e is "">
         <cfif listFindNoCase(allowed_file_types,i.serverfileext) is false>
            <cfset variables.e = variables.e & "Invalid File Type">
         </cfif>
      </cfif>

      <cfif variables.e is "">
        <cfset newfilename = "#Createuuid()#-#i.serverfile#">
        <cffile action="rename" source="#variables.temp_images_path#/#i.serverfile#" destination="#variables.temp_images_path#/#newFileName#">


         <cfimage source="#variables.temp_images_path#/#newFileName#" name="myImage">

		   <cfset info=ImageInfo(myImage)>

         <!---<cfdump var="#info#">--->

         <cfif info.width gt 2000>
            <cfset ImageResize(myImage,"2048","")>
            <cfimage source="#myImage#" action="write" destination="#originalPath#/#newfilename#" overwrite="yes">

            <!---<CF_GraphicsMagick
               action="ResizeWidth"
               infile="#variables.temp_images_path#/#newFileName#"
               outfile="#originalPath#/#newfilename#"
               width="2000"
               height=""
               debug="true"
               result="gmres">--->

         <cfelse>
            <cffile action = "copy" source = "#variables.temp_images_path#/#newFileName#" destination = "#originalPath#">
         </cfif>


        <cfimage action="resize" source="#originalPath#/#newFileName#" width="150" height="" destination="#originalPath#/thumbs/sm_#newFileName#" overwrite="Yes">
        <!---<CF_GraphicsMagick
               action="ResizeWidth"
               infile="#variables.temp_images_path#/#newFileName#"
               outfile="#originalPath#/thumbs/sm_#newFileName#"
               width="150"
               height=""
               debug="true"
               result="gmres">--->

		<cffile action="move" source="#variables.temp_images_path#/#newFileName#" destination="#originalPath#">

      </cfif>


		<!---GET NEXT SORT ID--->
		<CFQUERY DATASOURCE="#settings.dsn#" NAME="GetNextSort">
		  SELECT max(sort) as thesort
		  FROM prop_images
		  where strpropid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.strpropid#">
		</CFQUERY>

		<cfif isdefined('GetNextSort.thesort') and LEN(GetNextSort.thesort) and GetNextSort.thesort gt 0>
		  <cfset SortValue = "#GetNextSort.thesort#">
		<cfelse>
		  <cfset SortValue = "1">
		</cfif>

		<cfquery dataSource="#settings.dsn#">
			insert into prop_images (strpropid,image,sort)
			values(<cfqueryparam value="#form.strpropid#" cfsqltype="cf_sql_varchar">,<cfqueryparam value="#newFileName#" cfsqltype="cf_sql_varchar">,<cfqueryparam cfsqltype="cf_sql_integer" value="#SortValue#">
			)
		</cfquery>
 #cma#{
 	"name":"#i.serverfile#",
 	"size":"#i.filesize#",
 	"url":"/uploaded/#newfilename#",
 	"thumbnailUrl":"/uploaded/#newfilename#",
 	"deleteType":"DELETE"
 }
<cfset cma=",">
	</cfloop>
  ]}

  <cftry>
    <!--- TT-87698: Flush cache for _overview-tab.cfm --->
    <cfcache action="flush" key="overviewTab">
    <cfcatch></cfcatch>
  </cftry>

  <!---<cflocation addToken="no" url="index.cfm?success&strpropid=#form.strpropid#">--->

 </cfoutput>
