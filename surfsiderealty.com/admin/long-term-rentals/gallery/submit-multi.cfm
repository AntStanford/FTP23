<!--- On page variables --->
<cfset largePath = #ExpandPath('/images/longtermrentals')#>
<cfset largePathRSS='\/images\/longtermrentals\/'>
<cfset largeURLRSS='\/images\/longtermrentals\/'>
<cfset uploadGallery="">

<cfif isdefined('form.galleryName')>
	<cfset uploadGallery=form.galleryName>
</cfif>

<cfif isdefined('url.galleryName')>
	<cfset uploadGallery=url.galleryName>
</cfif>


<cfoutput>   
    <!--- Image Upload CF --->
    
	<cffile  
    action = "uploadAll" 
    destination = "#largePath#" 
    accept = "image/jpg,image/jpeg, image/gif, image/png" 
    nameConflict = "MakeUnique" 
    result = "upfilelist">

    <cfset cma="" />
	{"files": [
    <cfloop array=#upfilelist# index="i">
      
      <cfquery name="getSort" dataSource="#settings.dsn#">
         select max(sort) as maxSort from cms_assets where section = 'Long Term Rental' and foreignKey = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#uploadGallery#">
      </cfquery>
      
      <cfif getSort.recordcount gt 0 and len(getSort.maxSort)>
         <cfset sortValue = getSort.maxSort + 1> 
      <cfelse>
         <cfset sortValue = 1>
      </cfif>
      
		<cfquery dataSource="#settings.dsn#">
			insert into cms_assets(foreignKey,thefile,section,sort) 
			values(
			<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#uploadGallery#">, 
			<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#i.serverfile#">,
			'Long Term Rental',
			#sortValue#
			)
		</cfquery>
		#cma#
		{
			"name": "#i.serverfile#",
			"size": 902604,
			"url": "#largePathRSS##i.serverfile#",
			"thumbnailUrl": "#largeURLRSS##i.serverfile#",
			"deleteType": "DELETE"
		  }
		  <cfset cma="," />
	</cfloop>
	<!--- JSON end --->
	]}
 </cfoutput>   

  
  
 



       




