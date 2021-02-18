<cftry>

<cfif settings.hasCartAbandonment eq 'Yes'>

   <cfif isDefined("url.numAdults")>
      <cfset na = url.numAdults />
   <cfelse>
      <cfset na = url.num_adults />
   </cfif>

   <cfif isDefined("url.numChildren")>
      <cfset nc = url.numChildren />
   <cfelse>
      <cfset nc = url.num_children />
   </cfif>

   <cfparam name="key" type="string" default="">
   <cfparam name="firstname" default="">
   <cfparam name="lastname" default="">
   <cfparam name="email" default="">
   <cfparam name="phone" default="">
   <cfparam name="total" default="" />

   <cfif isDefined("url.bookingTotal")>
      <cfset total = url.bookingTotal />
   </cfif>

   <cfquery name="getinfo" datasource="#settings.bcdsn#">
   select id,thekey
   from cart_abandonment
   where thekey = '#key#'
   and siteid = <cfqueryparam cfsqltype="cf_sql_integer" value="#settings.id#">
   </cfquery>

   <cfif isdefined('url.strpropid')>
      <cfset mypropertyid = url.strpropid>
   <cfelseif isdefined('url.unitcode')>
      <cfset mypropertyid = url.unitcode>
   <cfelseif isdefined('url.propertyid')>
      <cfset mypropertyid = url.propertyid>
   <cfelseif isdefined('url.property_id')>
      <cfset mypropertyid = url.property_id>
   <cfelseif isdefined('url.unitid')>
      <cfset mypropertyid = url.unitid>
   <cfelse>

      <cfmail subject="error from #cgi.http_host#" to="adoute.icnd@gmail.com,jmathewicnd@gmail.com" from="#cfmail.company# <#cfmail.username#>" server="#cfmail.server#" username="#cfmail.username#" password="#cfmail.password#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" type="HTML" bcc="" cc="">
         <p>File: receiver-book-now-page.cfm</p>
         <p>No property ID defined?</p>
      </cfmail>

   </cfif>

   <cfif getinfo.recordcount eq 0>

      <!--- User does not exist, insert new row --->
      <cfquery dataSource="#settings.bcDSN#">
         insert into cart_abandonment(firstname,lastname,email,phone,thekey,unitcode,siteID,property,startdate,enddate,totalamount,ipaddress)
         values(
         <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#firstname#">,
         <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#lastname#">,
         <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#email#">,
         <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#phone#">,
         '#key#',
         <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.propertyid#">,
         <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#settings.id#">,
         <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#propertyname#">,
         <cfqueryparam CFSQLType="CF_SQL_DATE" value="#url.strcheckin#">,
         <cfqueryparam CFSQLType="CF_SQL_DATE" value="#url.strcheckout#">,
         <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#total#">,
         <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#cgi.REMOTE_ADDR#">
         )
      </cfquery>

   <cfelse> <!--- We are here, we found the user --->
         <cfquery NAME="UpdateQuery" DATASOURCE="#settings.bcDSN#">
            update cart_abandonment
            set firstname = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#firstname#">,
               lastname = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#lastname#">,
               email = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#email#">,
               phone = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#phone#">,
               unitcode = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.propertyid#">,
               siteID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#settings.id#">,
               property = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#propertyname#">,
               startdate = <cfqueryparam CFSQLType="CF_SQL_DATE" value="#url.strcheckin#">,
               enddate = <cfqueryparam CFSQLType="CF_SQL_DATE" value="#url.strcheckout#">,
               followupemailsent = "No",
               followUpEmailTimestamp = <cfqueryparam CFSQLType="CF_SQL_TIMESTAMP" value="" null="Yes">,
               totalamount = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#total#">,
               ipaddress = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#cgi.REMOTE_ADDR#">
            where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#getinfo.id#">
         </cfquery>

   </cfif>

</cfif>

<cfcatch>
   <cfdump var="#cfcatch#" abort="true" />
</cfcatch>

</cftry>