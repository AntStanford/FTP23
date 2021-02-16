<cfset blogname = 'Default'>
<cfset application.blog = createObject("component","org.camden.blog.blog").init(blogname)>

<!--- <cfdump var="#application.blog#" abort="true"> --->

<cfmodule template="/vacation-rental-blog/tags/getmode.cfm" r_params="arguments.params"/>

  <Cfset instance.name = 'Default'>
  <Cfset instance.BLOGDBTYPE = 'MYSQL'>
  <Cfset instance.offset = 3>
  

    <cfquery name="getIds" datasource="surfsiderealty2018" username="Admin" password="surf$side">
    select  tblblogentries.id
    from  tblblogentries, tblusers
      <cfif structKeyExists(arguments.params,"byCat")>,tblblogentriescategories</cfif>
      where   1=1
            and tblblogentries.blog = <cfqueryparam value="#instance.name#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
            and tblblogentries.username = tblusers.username
      <cfif structKeyExists(arguments.params,"lastXDays")>
        and tblblogentries.posted >= <cfqueryparam value="#dateAdd("d",-1*arguments.params.lastXDays,blogNow())#" cfsqltype="CF_SQL_DATE">
      </cfif>
      <cfif structKeyExists(arguments.params,"byDay")>
        <cfif instance.blogDBType is "MSSQL">
          and day(dateAdd(hh, #instance.offset#, tblblogentries.posted)) 
        <cfelseif  instance.blogDBType is "MSACCESS">
          and day(dateAdd('h', #instance.offset#, tblblogentries.posted)) 
        <cfelseif instance.blogDBType is "MYSQL">
          and dayOfMonth(date_add(posted, interval #instance.offset# hour))
        <cfelseif instance.blogDBType is "ORACLE">
          and to_number(to_char(tblblogentries.posted + (#instance.offset#/24), 'dd'))  
        </cfif>
          <cfif instance.blogDBType is not "ORACLE">
          = <cfqueryparam value="#arguments.params.byDay#" cfsqltype="CF_SQL_NUMERIC">
          <cfelse>
          = <cfqueryparam value="#arguments.params.byDay#" cfsqltype="CF_SQL_integer">
          </cfif>
        
      </cfif>
      <cfif structKeyExists(arguments.params,"byMonth")>
        <cfif instance.blogDBType is "MSSQL">
          and month(dateAdd(hh, #instance.offset#, tblblogentries.posted)) = <cfqueryparam value="#arguments.params.byMonth#" cfsqltype="CF_SQL_NUMERIC">
        <cfelseif instance.blogDBType is "MSACCESS">
          and month(dateAdd('h', #instance.offset#, tblblogentries.posted)) = <cfqueryparam value="#arguments.params.byMonth#" cfsqltype="CF_SQL_NUMERIC">
        <cfelseif instance.blogDBType is "MYSQL">
          and month(date_add(posted, interval #instance.offset# hour)) = <cfqueryparam value="#arguments.params.byMonth#" cfsqltype="CF_SQL_NUMERIC">
        <cfelseif instance.blogDBType is "ORACLE">
          and to_number(to_char(tblblogentries.posted + (#instance.offset#/24), 'MM')) = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.params.byMonth#"> 
        </cfif>
      </cfif>
      <cfif structKeyExists(arguments.params,"byYear")>
        <cfif instance.blogDBType is "MSSQL">
          and year(dateAdd(hh, #instance.offset#, tblblogentries.posted)) = <cfqueryparam value="#arguments.params.byYear#" cfsqltype="CF_SQL_NUMERIC">
        <cfelseif instance.blogDBType is "MSACCESS">
          and year(dateAdd('h', #instance.offset#, tblblogentries.posted)) = <cfqueryparam value="#arguments.params.byYear#" cfsqltype="CF_SQL_NUMERIC">
        <cfelseif instance.blogDBType is "MYSQL">
          and year(date_add(posted, interval #instance.offset# hour)) = <cfqueryparam value="#arguments.params.byYear#" cfsqltype="CF_SQL_NUMERIC">
        <cfelseif instance.blogDBType is "ORACLE">
          and to_number(to_char(tblblogentries.posted + (#instance.offset#/24), 'YYYY')) = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.params.byYear#">  
        </cfif>         
      </cfif>
      <cfif structKeyExists(arguments.params,"byTitle")>
        and tblblogentries.title = <cfqueryparam value="#arguments.params.byTitle#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">
      </cfif>
      <cfif structKeyExists(arguments.params,"byCat")>
        and tblblogentriescategories.entryidfk = tblblogentries.id
        and tblblogentriescategories.categoryidfk in (<cfqueryparam value="#arguments.params.byCat#" cfsqltype="CF_SQL_VARCHAR" maxlength="35" list=true>)
      </cfif>
      <cfif structKeyExists(arguments.params,"searchTerms")>
        <cfif not structKeyExists(arguments.params, "dontlogsearch")>
          <cfset logSearch(arguments.params.searchTerms)>
        </cfif>
        <cfif instance.blogDBType is not "ORACLE">
          and (tblblogentries.title like '%#arguments.params.searchTerms#%' OR tblblogentries.body like '%#arguments.params.searchTerms#%' or tblblogentries.morebody like '%#arguments.params.searchTerms#%')
        <cfelse>
        and (lower(tblblogentries.title) like '%#lcase(arguments.params.searchTerms)#%' OR lower(tblblogentries.body) like '%#lcase(arguments.params.searchTerms)#%' or lower(tblblogentries.morebody) like '%#lcase(arguments.params.searchTerms)#%')
        </cfif>
      </cfif>
      <cfif structKeyExists(arguments.params,"byEntry")>
        and tblblogentries.id = <cfqueryparam value="#arguments.params.byEntry#" cfsqltype="CF_SQL_VARCHAR" maxlength="35">
      </cfif>
      <cfif structKeyExists(arguments.params,"byAlias")>
        and tblblogentries.alias = <cfqueryparam value="#left(arguments.params.byAlias,100)#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">
      </cfif>
      <!--- Don't allow future posts unless logged in. --->
      <cfif not isUserInRole("admin") or (structKeyExists(arguments.params, "releasedonly") and arguments.params.releasedonly)>
        <cfif instance.blogDBType IS "ORACLE">
           and      to_char(tblblogentries.posted + (#instance.offset#/24), 'YYYY-MM-DD HH24:MI:SS') <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:mm:ss')#"> 
        <cfelse>
          and     posted < <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">
        </cfif>
        and     released = 1
      </cfif>
      
      <cfif structKeyExists(arguments.params, "released")>
      and released = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.params.released#">
      </cfif>
      
      
    </cfquery>

    <Cfdump var="#getIds#">