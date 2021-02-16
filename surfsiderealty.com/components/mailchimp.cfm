<cftry>
  <!--- Mail Chimp settings --->
  <cfset variables.chimpAPIKey = '75217dd2cfb37bd959d2e94b6e70b1d7-us10' />
  <cfset variables.ChimpListID = '3fccf8943f' />
  <!--- 
    MailChimp Component USAGE:
    
    On initial setup, you need to get a list id, the list call below is used to get the list id to use in the listSubscribe functio
    <cfset lists = chimp.lists()>
    the id returned was place in application.ChimpListID variable
    
    <cfset chimp = createObject("component","components.MailChimp").init(application.chimpAPIKey)>
    <cfset result = chimp.listSubscribe(application.ChimpListID, email)>
   --->
  <cfif isDefined("form.theemail") and isValid('email', form.theemail)>
    <cfset email = form.theemail />
  <cfelseif isDefined("form.email") and isValid('email', form.email)>
    <cfset email = form.email />
  <cfelse>
    <cfset email = email />
  </cfif>

  <cfif isValid("email", email)>
  	<cfset chimp = createObject("component","components.MailChimp3").init(variables.chimpAPIKey,variables.ChimpListID)>
  	<cfset result = chimp.listSubscribe(variables.ChimpListID, email)>
    <!---
    <cfmail subject="MailChimp results #cgi.http_host#" to="cbarksdale@icoastalnet.com" from="#cfmail.company# <#cfmail.username#>" server="#cfmail.server#" username="#cfmail.username#" password="#cfmail.password#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" type="HTML">
      <cfdump var="#result#" />
    </cfmail>
    --->
  </cfif>

  <cfcatch>
    <cfmail subject="MailChimp error #cgi.http_host#" to="cbarksdale@icoastalnet.com" from="#cfmail.company# <#cfmail.username#>" server="#cfmail.server#" username="#cfmail.username#" password="#cfmail.password#" port="#cfmail.port#" useSSL="#cfmail.useSSL#" type="HTML">
      <cfdump var="#cfcatch#" />
    </cfmail>
  </cfcatch>
</cftry>