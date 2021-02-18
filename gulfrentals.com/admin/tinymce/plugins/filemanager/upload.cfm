<cfprocessingdirective pageencoding="utf-8">
<!--- ************************************************************************************ --->
<!--- Add User Authentication here                                                         --->
<!---<cfif not StructKeyExists(session,'userid')><cfabort></cfif>                          --->
<!--- ************************************************************************************ --->

<cfparam name="form.path" default="">
<cfparam name="form.file" default="">
<cfinclude template="settings.cfm">

<!--- ************************************************************ --->
<!--- path first position is a friendly name, like [home]. ignore  --->
<!--- ************************************************************ --->
<cfset form.path	= "/#ListDeleteAt(form.path,1,'/\')#">

<!--- ************************************************************ --->
<!--- thumb / medium and full size images saved in three folders   --->
<!--- ************************************************************ --->
<cfset filepath		= "#settings.UserFiles##form.path#">
<cfset midpath		= "#settings.UserFiles#/_middle#form.path#">
<cfset thumbpath	= "#settings.UserFiles#/_thumb#form.path#">

<!--- ************************************************************ --->
<!--- check & create system folders. these store image versions    --->
<!--- ************************************************************ --->
<cfif not DirectoryExists(filepath)>
	<cfdirectory action	="create" mode = "#settings.chomd#" directory ="#filepath#">
</cfif>
<cfif not DirectoryExists(midpath)>
	<cfdirectory action	="create" mode = "#settings.chomd#" directory ="#midpath#">
</cfif>
<cfif not DirectoryExists(thumbpath)>
	<cfdirectory action	="create" mode = "#settings.chomd#" directory ="#thumbpath#">
</cfif>

<cfif listfirst(server.coldfusion.productversion) gte 8>
	<cfparam name="types"	default="JPG,GIF,PNG,BMP">
<cfelse>
	<cfparam name="types"	default="jpg">
</cfif>


<cfif len(form.file)>

	<cffile
		action 			= "upload"
		filefield 		= "form.file"
		nameconflict	= "makeunique"
		mode			= "#settings.chomd#"
		destination 	= "#filepath#"
		result			= "fileUploadName"
		>

	<!--- Check filename against regex;  rename if required --->
	<cfset regexpMatch = ReMatchNoCase(settings.excludeRegExp, fileUploadName.clientfile)>

	<cfset cleanedFilename = ArrayToList(regexpMatch,"")>

	<cfif fileUploadName.clientfile NEQ cleanedFilename OR LEN(cleanedFilename) GT settings.maxFileNameLength>

		<cfset fileTypeRegexp = '.' & replace(types, ',','$|.','All') & '$'>
		<cfset fileExtension = ReMatchNoCase(settings.fileExtensionRegExp, fileUploadName.clientfile)[1]>

		<cfset filenameReconstituted = ArrayToList(regexpMatch,'')>
		<cfset filenameReconstitutedLEN = LEN(filenameReconstituted)>

	    <cfif filenameReconstitutedLEN GT settings.maxFileNameLength>

	        <cfset fileSizeDiff = LEN(filenameReconstituted) - settings.maxFileNameLength>

			<cfset filenameReconstituted =
			Mid(filenameReconstituted, 1, filenameReconstitutedLEN - (fileSizeDiff + LEN(fileExtension)))
			& fileExtension>

	    </cfif>

		<cfif filenameReconstitutedLEN LTE LEN(fileExtension) OR FileExists("#fileUploadName.serverdirectory#/#filenameReconstituted#")>
			<cfset filenameReconstituted = MID(Replace(CreateUUID(), '-','','All'),1,21) & fileExtension>
		</cfif>

		<cffile action="rename" source="#fileUploadName.serverdirectory#/#fileUploadName.clientfile#" destination="#fileUploadName.serverdirectory#/#filenameReconstituted#" attributes="normal">

		<cfset fileUploadName.serverFile = filenameReconstituted>

	</cfif>

	<!--- ************************************************************ --->
	<!--- Remove Disabled File Extensions                              --->
	<!--- ************************************************************ --->
	<cfif ListFindNoCase(settings.disfiles,fileUploadName.clientFileExt)>
		<cffile action="delete" file="#filepath#/#fileUploadName.serverFile#">
	</cfif>

	<!--- ************************************************************ --->
	<!--- images - make thumbnail and medium size images               --->
	<!--- ************************************************************ --->
	<cfif ListFindNoCase(types,fileUploadName.clientFileExt)>
		<cfif listfirst(server.coldfusion.productversion) gte 8>
			<cfset myImage	= ImageRead('#filepath#/#fileUploadName.serverFile#')>
			<cfset imginfo	= ImageInfo(myImage)>
			<cfif imginfo.width gt settings.middleSize OR imginfo.height gt settings.middleSize>
				<cfset ImageScaleToFit(myImage,settings.middleSize,settings.middleSize)>
				<cfset ImageWrite(myImage,'#midpath#/#fileUploadName.serverFile#')>
			</cfif>
			<cfif imginfo.width gt settings.thumbSize OR imginfo.height gt settings.thumbSize>
				<cfset ImageScaleToFit(myImage,settings.thumbSize,settings.thumbSize)>
				<cfset ImageWrite(myImage,'#thumbpath#/#fileUploadName.serverFile#')>
			</cfif>
		<cfelse>
			<cfset myImage = CreateObject("Component", "iedit")>
			<cfset myImage.SelectImage("#filepath#/#fileUploadName.serverFile#")>
			<cfif myImage.getWidth() gt settings.middleSize OR myImage.getHeight() gt settings.middleSize>
				<cfset myImage.ScaletoFit(settings.middleSize,settings.middleSize)>
				<cfset myImage.output("#midpath#/#fileUploadName.serverFile#", "jpg",100)>
			</cfif>
			<cfif myImage.getWidth() gt settings.thumbSize OR myImage.getHeight() gt settings.thumbSize>
				<cfset myImage.ScaletoFit(settings.thumbSize,settings.thumbSize)>
				<cfset myImage.output("#thumbpath#/#fileUploadName.serverFile#", "jpg",100)>
			</cfif>
		</cfif>
	</cfif>
</cfif>

<script type="text/javascript">
	parent.fm.fmreturnhome()
</script>
