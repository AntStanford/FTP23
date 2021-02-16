<!--- Flush the cache if it exists --->
<cftry> 
     <cfcache action="flush" key="cms_condos">
     <cfcatch></cfcatch> 
</cftry>



<!--- On page variables --->
<cfset table = 'cms_condos'>

<cfset FilePath="/images/condos">

<cfif isDefined('picture1')>

  <cfif Len(Picture1) GT 0>
    <cffile action="upload" filefield="Picture1" destination="#ExpandPath(FilePath)#" nameconflict="makeunique">
    <cfSet Picture1 = "#File.ServerFile#">
  </cfif>
  <cfif Len(Picture2) GT 0>
    <cffile action="upload" filefield="Picture2" destination="#ExpandPath(FilePath)#" nameconflict="makeunique">
    <cfSet Picture2 = "#File.ServerFile#">
  </cfif>
  <cfif Len(Picture3) GT 0>
    <cffile action="upload" filefield="Picture3" destination="#ExpandPath(FilePath)#" nameconflict="makeunique">
    <cfSet Picture3 = "#File.ServerFile#">
  </cfif>
  <cfif Len(Picture4) GT 0>
    <cffile action="upload" filefield="Picture4" destination="#ExpandPath(FilePath)#" nameconflict="makeunique">
    <cfSet Picture4 = "#File.ServerFile#">
  </cfif>
  <cfif Len(Picture5) GT 0>
    <cffile action="upload" filefield="Picture5" destination="#ExpandPath(FilePath)#" nameconflict="makeunique">
    <cfSet Picture5 = "#File.ServerFile#">
  </cfif>

</cfif>


<!--- Deleting an uploaded photo --->
<cfif isdefined('url.resortID') and isdefined('url.delPhoto') and isdefined('url.photo')>
 
     
  <cfquery dataSource="#settings.dsn#">
    update #table# 
    set <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.photo#"> = ''
    where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.resortID#">
  </cfquery>
  
  <cflocation addToken="no" url="form.cfm?id=#url.resortID#&deletephoto">  
  
  

  <!--- Delete the entire record and photos --->
<cfelseif isdefined('url.id') and isdefined('url.delete')>
  
    
  
  <!--- Finally, delete the property ---> 
  <cfquery dataSource="#settings.dsn#">
    delete from #table# where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>
  
  
  <cflocation addToken="no" url="index.cfm?success">







<!--- Update Existing Record --->  
<cfelseif isdefined('form.id')>
  

    <cfquery dataSource="#settings.dsn#">
      update #table# set

    <cfif Len(picture1) GT 0>
      picture1 = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#picture1#">,
    </cfif>
    <cfif Len(picture2) GT 0>
      picture2 = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#picture2#">,
    </cfif>
    <cfif Len(picture3) GT 0>
      picture3 = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#picture3#">,
    </cfif>
    <cfif Len(picture4) GT 0>
      picture4 = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#picture4#">,
    </cfif>
    <cfif Len(picture5) GT 0>
      picture5 = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#picture5#">,
    </cfif>
      slug = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.slug#">,
      condoname = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.condoname#">,
      complex = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.complex#">,
      address = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.address#">,
      description = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.description#">,
      description2 = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.description2#">,
      amenities = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.amenities#">,
      metaTitle = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.metaTitle#">,
      metaDescription = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.metaDescription#">
      where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
    </cfquery>       
    
    <cflocation addToken="no" url="form.cfm?id=#id#&success"> 


<!--- Add New Record --->    
<cfelse>
    

     
    <cfquery dataSource="#settings.dsn#">
      insert into #table#(condoname) 
      values (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.condoname#">)
    </cfquery>
    
    <cfquery name="GetID" datasource="#settings.dsn#" maxrows="1">
      Select ID from #table# order by id desc
    </cfquery>
        

    <cfquery dataSource="#settings.dsn#">
      update #table# set

      <cfif Len(picture1) GT 0>
        picture1 = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#picture1#">,
      </cfif>
      <cfif Len(picture2) GT 0>
        picture2 = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#picture2#">,
      </cfif>
      <cfif Len(picture3) GT 0>
        picture3 = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#picture3#">,
      </cfif>
      <cfif Len(picture4) GT 0>
        picture4 = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#picture4#">,
      </cfif>
      <cfif Len(picture5) GT 0>
        picture5 = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#picture5#">,
      </cfif>
      slug = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.slug#">,
      condoname = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.condoname#">,
      complex = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.complex#">,
      address = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.address#">,
      description = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.description#">,
      description2 = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.description2#">,
      amenities = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.amenities#">,
      metaTitle = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.metaTitle#">,
      metaDescription = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.metaDescription#">
      where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#GetID.id#">
    </cfquery>    

    <cflocation addToken="no" url="form.cfm?success"> 
  
  
</cfif>  



       




