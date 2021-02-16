<cfset table = 'cms_checkout_addons'>
<cfset uppicture = #ExpandPath('/images/addons')#>

<cfif isdefined('url.id') and isdefined('url.delete')> <!--- delete statement --->
	
  <cfquery dataSource="#settings.dsn#">
  	delete from #table# where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#"> 
  </cfquery>
  
  <cflocation addToken="no" url="index.cfm?success">
  

<cfelseif isdefined('url.id') and isdefined('url.deletephoto')>
   
   <cfquery dataSource="#settings.dsn#">
    update #table# set 
    photo = ''
    where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>  
  
  <cflocation addToken="no" url="form.cfm?id=#url.id#&deletephoto">

  	
<cfelseif isdefined('form.id')> <!--- update statement --->
  
  <cfif isdefined('form.photo') and len(form.photo)>
   
      <cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>
      <cfset results=Obj.Check(uppicture,"photo")><cfif len(results.e)><cfoutput>#results.e#</cfoutput><cfabort></cfif>
      <cfset myfile = results.filename>
   
  </cfif>
  
  <cfquery dataSource="#settings.dsn#">
    update #table# set 
    title = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.title#">,
    amount = <cfqueryparam CFSQLType="CF_SQL_DOUBLE" value="#form.amount#">,
    tax = <cfqueryparam CFSQLType="CF_SQL_DOUBLE" value="#form.tax#">,
    maxAmount = <cfif IsNumeric(form.maxAmount)><cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.maxAmount#"><cfelse>10</cfif>,
    description = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.description#">
    <cfif isdefined('form.photo') and len(form.photo)>,photo = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#"></cfif>
    where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
  </cfquery>  
  
  <cflocation addToken="no" url="form.cfm?id=#form.id#&success">

<cfelse>  <!---insert statement--->
  
  <cfif isdefined('form.photo') and len(form.photo)>
   
      <cfif not isdefined('Obj')><cfset Obj = CreateObject("Component","Components.fileCheck").Init()></cfif>
      <cfset results=Obj.Check(uppicture,"photo")><cfif len(results.e)><cfoutput>#results.e#</cfoutput><cfabort></cfif>
      <cfset myfile = results.filename>
   
  <cfelse>
  
      <cfset myfile = ''> 

  </cfif>
  
  
  <cfquery dataSource="#settings.dsn#">
    insert into #table#(title,amount,tax,maxAmount,description,photo) 
    values(
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.title#">,
      <cfqueryparam CFSQLType="CF_SQL_DOUBLE" value="#form.amount#">,
      <cfqueryparam CFSQLType="CF_SQL_DOUBLE" value="#form.tax#">,
      <cfif IsNumeric(form.maxAmount)><cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.maxAmount#"><cfelse>10</cfif>,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.description#">,
      <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#myfile#">
      )
  </cfquery>
  
  <cflocation addToken="no" url="form.cfm?success">
  
</cfif>