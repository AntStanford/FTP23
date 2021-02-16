<cfabort>
<cfparam name="url.start" default="1">
<cfset temp = url.start + 9>
<cfparam name="url.end" default="#temp#">
<cfset folderName = 'uploaded_test'>

<cfdirectory action="list" directory="#ExpandPath('/#folderName#')#" name="imageQuery">

<cfset photoList = ValueList(imageQuery.name)>

<cfoutput>

<p>There are #listlen(photoList)# photos that need to be optimized.</p>

<cfif url.end gt listlen(photoList)>
	<cfset url.end = listlen(photoList)>
</cfif>

<cfloop from="#url.start#" to="#url.end#" index="i">

	<p>#i#. #listGetAt(photoList,i)#</p>
	
	<cfset name = listGetAt(photoList,i)>
	
		<cftry>
			
			<cfif name contains ' - '>
				
				<!--- remove extra spacing and leave the hyphen --->
				<cfset TempFileName = replacenocase(name,' ','','all')>
				
				<cffile 
					action="RENAME" 
					source="#ExpandPath('/#folderName#')#\#name#" 
					destination="#ExpandPath('/#folderName#')#\#TempFileName#"
					nameconflict="overwrite">
				
				<!--- compress the renamed image --->	
				<CF_GraphicsMagick 
			     action="Optimize" 
			     infile="#ExpandPath('/#folderName#')#\#TempFileName#" 
			     outfile="#ExpandPath('/#folderName#')#\#TempFileName#" 
			     compress="JPEG"
			     debug="true"
			     result="result">
				     
				  <!--- add the spaces back --->
			     <cffile 
				     	action="RENAME" 
				     	source="#ExpandPath('/#folderName#')#\#TempFileName#" 
				     	destination="#ExpandPath('/#folderName#')#\#name#" 
				     	nameconflict="overwrite">
				     	
				  <p>#name# had to be renamed before being compressed</p>
		
			<cfelse>
				
				<CF_GraphicsMagick 
			     action="Optimize" 
			     infile="#ExpandPath('/#folderName#')#\#name#" 
			     outfile="#ExpandPath('/#folderName#')#\#name#" 
			     compress="JPEG"
			     debug="true"
			     result="result">
		     
			</cfif>

			
	          
	    <cfcatch>
	    	
	    	<cfdump var="#cfcatch#">	
	    	
	    	<cfabort>    	
	    
	    </cfcatch> 
	    
	    </cftry>
    
	     
</cfloop>

<cfif url.end eq listlen(photoList)>
	<p>We are done!</p>	
	<!---

	<cfmail to="#dev.clientEmail#" from="#dev.username#" subject="Compress Images Script" server="#dev.server#" username="#dev.username#" password="#dev.password#" port="#dev.port#" useSSL="#dev.useSSL#" type="HTML" bcc="" cc="">
	  <p>The image compression script has completed running.</p>
	</cfmail>
--->
		
	
	<cfabort>
</cfif>

<cfset url.start = url.start + 10>
<cfset url.end = url.end + 10>

<script type="text/javascript">
	<cfoutput>window.location.href = 'run.cfm?start=#url.start#&end=#url.end#';</cfoutput>
</script>
	
</cfoutput>
