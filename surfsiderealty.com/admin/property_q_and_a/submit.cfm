<!--- Flush the cache if it exists --->
<cftry> 
     <cfcache action="flush" key="be_questions_and_answers_properties">
     <cfcatch></cfcatch> 
</cftry>

<cfset table = 'be_questions_and_answers_properties'>

<cfif isdefined('url.id') and isdefined('url.delete')> <!--- delete statement --->
	
  <cfquery dataSource="#settings.dsn#">
  	delete from #table# where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#"> 
  </cfquery>
  
  <cflocation addToken="no" url="index.cfm?success">
  	
<cfelseif isdefined('form.id')> <!--- update statement --->
  
  <cfquery dataSource="#settings.dsn#">
      update #table# set 
      answer = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.answer#">,
      approved = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.approved#">,
      dateanswered = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#now()#">
      where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.id#">
  </cfquery>  
  
  <cfif form.Notify is "Yes">
  
            
            <cfquery name="getPropertyInfo" dataSource="#settings.dsn#">
               select unitshortname from escapia_properties where unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.propertyid#">
            </cfquery>
         
     
         <cfsavecontent variable="emailbody">
         	<cfoutput>
            <p>Thank you for asking your question concerning property - #getPropertyInfo.unitshortname#</p>
            <p>Your Question: #question#</p>
            <p>Our Response: #answer#</p>
            <p>If you have any further questions don't hesitate to contact us at #cfmail.clientEmail#</p>
            <p>Thank you!</p>
					</cfoutput>
         </cfsavecontent>   
                   
     
     		<cfset sendEmail(form.email,emailbody,"Your Question for #getPropertyInfo.unitshortname# has been answered - #cgi.http_host#")>
     
   </cfif>
  
   <cflocation addToken="no" url="form.cfm?id=#form.id#&success">

<cfelse>  <!---insert statement--->
    
  <cfquery dataSource="#settings.dsn#">
    insert into #table#(firstname,lastname,email,question,answer,dateanswered,propertyid,approved) 
    values(
	'Staff',
	'Submission',
	<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#cfmail.clientEmail#">,
    <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#question#">,
    <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#answer#">,
	<cfqueryparam cfsqltype="CF_SQL_DATE" value="#now()#">,
	<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#propertyid#">,
	<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#approved#">
      )
  </cfquery>
  
  <cflocation addToken="no" url="form.cfm?success">
  
</cfif>