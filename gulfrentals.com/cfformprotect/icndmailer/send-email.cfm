<cffunction name="sendEmail">
	
	<cfargument name="to" required="true">
	<cfargument name="emailbody" required="true">
	<cfargument name="subject" required="true">
   <cfargument name="replyto" required="false">
   <cfargument name="cc" required="false">
   <cfargument name="bcc" required="false">
   			
	<cfhttp url="https://api.mailgun.net/v3/#settings.mailgunAPIDomain#/messages" method="POST" timeout="60" result="httpResult"> 
		<cfhttpparam type="header" name="Authorization" value="Basic #ToBase64('api:key-#settings.mailgunAPIKey#')#" />	 
		<cfhttpparam type="formfield" name="to" value="#arguments.to#"/> 
		<cfhttpparam type="formfield" name="from" value="#settings.company# <mailer@#settings.mailgunAPIDomain#>"/>	 
		<cfhttpparam type="formfield" name="html" value="#arguments.emailbody#"/>	 
		<cfhttpparam type="formfield" name="subject" value="#arguments.subject#"/>	
		<cfif isdefined('arguments.replyto') and len(replyto)>
			<cfhttpparam type="formfield" name="h:Reply-To" value="#arguments.replyto#">
		</cfif>	 
		<cfif isdefined('arguments.cc') and len(arguments.cc)>
			<cfhttpparam type="formfield" name="cc" value="#arguments.cc#"/> 
		</cfif>
		<cfif isdefined('arguments.bcc') and len(arguments.bcc)>
			<cfhttpparam type="formfield" name="bcc" value="#arguments.bcc#"/>
		</cfif>
	</cfhttp>
	
	<!--- <cfdump var="#httpResult#"> --->
		
</cffunction>