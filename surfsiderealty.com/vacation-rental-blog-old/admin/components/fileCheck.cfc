
<cfcomponent displayname="fileCheck">

 <cffunction name="Init">
     <cfset variables.e="">
     <cfset variables.temp_photos_path="e:\inetpub\wwwroot\domains\surfsiderealty.com\temp_files">
	 <cfif not DirectoryExists(temp_photos_path)> <cfdirectory action="create" directory="#temp_photos_path#"> </cfif>
   <cfreturn this>
 </cffunction>


<cffunction name="Check">
 <cfargument name="filedestination">
 <cfargument name="picFieldName">
  
   <cfset fileDest=arguments.filedestination>
   <cfset FileField = arguments.picFieldName>   
   <cffile action="upload" filefield="#FileField#" nameconflict="makeunique" destination="#temp_photos_path#">
    <cfset source_file = cffile.serverfile>

    <cfif cffile.filesize gt "5097152">
       <cfset variables.e = variables.e & "<li>File must be less than 5MB in size.">
    </cfif>
    
	<cfif variables.e is "">
      <cfif listFindNoCase("jpg,gif,png,pdf,doc,docx,xls,xlsx",cffile.serverfileext) is false>
         <cfset variables.e = variables.e & "Incorrect filetype.">
      </cfif> 
    </cfif>
 
    <cfif variables.e is "">
	   
	   <cffile action="move" source="#variables.temp_photos_path#/#source_file#" destination="#fileDest#">
	
	<cfelse>
	
	  <cffile action="delete" file="#variables.temp_photos_path#/#source_file#"> 
	
	</cfif>
	
   <cfreturn variables.e >
   
</cffunction>

</cfcomponent>