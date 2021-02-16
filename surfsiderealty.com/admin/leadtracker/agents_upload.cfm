	<cfset photosize_small = 200>

	<!---START: IMAGE UPLOAD CODE--->
	<cfif form.AgentPhoto is not ''>
	
	 	<cfif not isdefined('Obj')>
			<cfset Obj = CreateObject("Component","Components.fileCheck").Init()>
		</cfif>
		
 		 <cfset results=Obj.Check(UploadPathAgents,"AgentPhoto")>
		 <cfif len(results.e)>
		 
		 	<cfoutput><H4>#results.e#</H4></cfoutput>
		 	<cfabort>
		 </cfif>
		 
     <cfset myfile = results.filename>
	 
	 <!---start resize--->
	 
	 <cfimage action="info" source="#UploadPathAgents#/#myfile#" structName="photoInfo">

		<cfif photoInfo.width GT "#photosize_small#">
            <CFX_IMAGE action="resize" source="#UploadPathAgents#/#myfile#" destination="#UploadPathAgents#/sm_#myfile#" width="#photosize_small#"  overwrite="yes" >

		<cfelse>
            <cfimage action="write" source="#UploadPathAgents#/#myfile#" destination="#UploadPathAgents#/sm_#myfile#" overwrite="yes" >
		</cfif>
	<!---end resize--->
	 <cfelse>
	   <cfset myfile = ''>
	</cfif>
	<!---END: IMAGE UPLOAD CODE--->