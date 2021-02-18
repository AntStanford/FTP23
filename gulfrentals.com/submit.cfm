<cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />

<cfif Cffp.testSubmission(form)>

  <cfif isdefined('form.contactform')>
        
        <!--- Google reCaptcha starts ---->
      <cfset recaptcha = "">
      <cfif structKeyExists(FORM,"g-recaptcha-response")>
        <cfset recaptcha = FORM["g-recaptcha-response"]>
      </cfif>
	   <cfset isHuman = false>

		<cfif len(recaptcha)>
	
			<!--- POST to google and verify submission --->
			<cfset googleUrl = "https://www.google.com/recaptcha/api/siteverify">
			<cfset secret = settings.google_recaptcha_secretkey>
			<cfset ipaddr = CGI.REMOTE_ADDR>
			<cfset request_url = googleUrl & "?secret=" & secret & "&response=" & recaptcha & "&remoteip" & ipaddr>
	
			<cfhttp url="#request_url#" method="get" timeout="10">
	
			<cfset response = deserializeJSON(cfhttp.filecontent)>
			<cfif response.success eq "true">
				<cfset isHuman = true>
			</cfif>
		</cfif>
		<!--- Google reCaptcha ends --->
		
		<cfif isHuman>
		
	        <cfsavecontent variable="emailbody">
	        	<cfoutput>
	        	<cfinclude template="/components/email-template-top.cfm">        
	          <p>First Name: #firstname#</p>
	          <p>Last Name: #lastname#</p>
	          <p>Email: #email#</p>
	          <p>Phone Number: #phone#</p>
	          <p>Comments: #comments#</p>
	          <cfif isdefined('form.resort') and len(form.resort)>
	          	<p>This user has a question about: #form.resort#</p>
	          </cfif>
	          <cfif isdefined('form.longtermrental') and len(form.longtermrental)>
	          	<p>This user is interested in the following long term rental: #form.longtermrental#</p>
	          </cfif>
	          <cfif isdefined('form.optin') and form.optin eq 'Yes'>
	          	<p>Opt-in: Yes</p>
	          <cfelse>
	          	<p>Opt-in: No</p>
	          </cfif>
	          <cfinclude template="/components/email-template-bottom.cfm">
		     	</cfoutput>
	        </cfsavecontent>
	        
	        <cfset sendEmail(settings.clientEmail,emailbody,"New contact from #cgi.http_host#")> 
	        
	        <cfif isdefined('form.optin') and form.optin eq 'Yes'>
	                
				<cfif len(email)>
					<cfset variables.encEmail = encrypt(email, application.contactInfoEncryptKey, 'AES')>
				<cfelse>
					<cfset variables.encEmail = ''>
				</cfif>
				<cfif len(phone)>
					<cfset variables.encPhone = encrypt(phone, application.contactInfoEncryptKey, 'AES')>
				<cfelse>
					<cfset variables.encPhone = ''>
				</cfif>

		        <cfquery dataSource="#settings.dsn#">
		          insert into cms_contacts(firstname,lastname,email,comments,phone,camefrom,optin) 
		          values(
		            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#firstname#">,
		            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#lastname#">,
		            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#variables.encEmail#">,
		            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#comments#">,
		            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#variables.encPhone#">,
		            'Contact Page',
		            'Yes'
		          )
		        </cfquery>
		        
		         <cfif settings.ListrakEnabled is "Yes">
						<cfinclude template="/components/listrak.cfm">
					</cfif>
				
		        <cfif settings.hasLeadtracker eq 'yes'>
				  		<cfinclude template="/components/leadtracker.cfm">
				  </cfif>
	        
	        </cfif>								
				
			  <cfoutput>success</cfoutput>
        
       </cfif>
  
  </cfif>
    
  <cfif isdefined('form.newsletterform')>
        
         <!--- Google reCaptcha starts ---->
      <cfset recaptcha = "">
      <cfif structKeyExists(FORM,"g-recaptcha-response")>
        <cfset recaptcha = FORM["g-recaptcha-response"]>
      </cfif>
	   <cfset isHuman = false>

		<cfif len(recaptcha)>
	
			<!--- POST to google and verify submission --->
			<cfset googleUrl = "https://www.google.com/recaptcha/api/siteverify">
			<cfset secret = settings.google_recaptcha_secretkey>
			<cfset ipaddr = CGI.REMOTE_ADDR>
			<cfset request_url = googleUrl & "?secret=" & secret & "&response=" & recaptcha & "&remoteip" & ipaddr>
	
			<cfhttp url="#request_url#" method="get" timeout="10">
	
			<cfset response = deserializeJSON(cfhttp.filecontent)>
			<cfif response.success eq "true">
				<cfset isHuman = true>
			</cfif>
		</cfif>
		<!--- Google reCaptcha ends --->
		
		<cfif isHuman>
		
	        <cfsavecontent variable="emailbody">
	        <cfoutput>
	        <cfinclude template="/components/email-template-top.cfm">       
	          <p>First Name: #form.firstname#</p>
	          <p>Last Name: #form.lastname#</p>
			  <p>Email: #form.email#</p> 
			  <p>Phone: #form.phone#</p>
			  <p>City: #form.city#</p>
			  <p>State: #form.state#</p>
			  <p>Zip: #form.zip#</p>
			  <p>Lists to join: #form.liststojoin#</p>
	          <!---<cfif isdefined('form.optin') and form.optin eq 'Yes'>
	          	<p>Opt-in: Yes</p>
	          <cfelse>
	          	<p>Opt-in: No</p>
	          </cfif>--->
	          <cfinclude template="/components/email-template-bottom.cfm">
	        </cfoutput>
	        </cfsavecontent>
	        
	        <cfset sendEmail(form.email,emailbody,"New contact from #cgi.http_host#")><!--- settings.clientEmail --->
			  
			  <!---<cfif isdefined('form.optin') and form.optin eq 'Yes'>--->
			  	        
				<cfif len(form.email)>
					<cfset variables.encEmail = encrypt(form.email, application.contactInfoEncryptKey, 'AES')>
				<cfelse>
					<cfset variables.encEmail = ''>
				</cfif>
				<cfif len(form.phone)>
					<cfset variables.encPhone = encrypt(form.phone, application.contactInfoEncryptKey, 'AES')>
				<cfelse>
					<cfset variables.encPhone = ''>
				</cfif>

		        <cfquery dataSource="#settings.dsn#">
		          insert into cms_contacts(email,phone,city,state,zip,liststojoin,camefrom,firstname,lastname,optin) 
		          values(                        
		            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#variables.encEmail#">,     
					<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#variables.encPhone#">,
					<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.city#">,
					<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.state#">,
					<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.zip#">,
					<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.liststojoin#">,       
		            'Newsletter Form',
		            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.firstname#">, 
		            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.lastname#">,
		            'Yes'
		          )
		        </cfquery>
				
		   		<cfif settings.ListrakEnabled is "Yes">
		   			<cfinclude template="/components/listrak.cfm">
		   		</cfif>
		   		
		   		<cfif settings.hasLeadtracker eq 'yes'>
				    <cfinclude template="/components/leadtracker.cfm">
		        </cfif>
	       
	       <!---</cfif>--->
	       
	       <cfoutput>success</cfoutput>
       
       </cfif>
          
  </cfif>
  
  <cfif isdefined('form.propertymanagementform')>
        
	<!--- Google reCaptcha starts ---->
	<cfset recaptcha = "">
	<cfif structKeyExists(FORM,"g-recaptcha-response")>
	<cfset recaptcha = FORM["g-recaptcha-response"]>
	</cfif>
	<cfset isHuman = false>

	<cfif len(recaptcha)>

		<!--- POST to google and verify submission --->
		<cfset googleUrl = "https://www.google.com/recaptcha/api/siteverify">
		<cfset secret = settings.google_recaptcha_secretkey>
		<cfset ipaddr = CGI.REMOTE_ADDR>
		<cfset request_url = googleUrl & "?secret=" & secret & "&response=" & recaptcha & "&remoteip" & ipaddr>

		<cfhttp url="#request_url#" method="get" timeout="10">

		<cfset response = deserializeJSON(cfhttp.filecontent)>
		<cfif response.success eq "true">
			<cfset isHuman = true>
		</cfif>
	</cfif>
	<!--- Google reCaptcha ends --->
	
	<cfif isHuman>
	
		<cfsavecontent variable="emailbody">
		<cfoutput>
		<cfinclude template="/components/email-template-top.cfm">       
			<p>Name: #form.name#</p>
			<p>Email: #form.email#</p> 
			<p>Phone: #form.phone#</p>
			<p>I own an existing home: #form.own_home#</p>
			<p>Property Address and Name: #form.address#</p>
			<p>I am interested in learning about: #form.interested#</p>
			<p>I would like to take advantage of the following complimentary services: #form.complimentary#</p>
			<p>Subject: #form.subject#</p>
			<p>Message: #form.message#</p>
			<!---<cfif isdefined('form.optin') and form.optin eq 'Yes'>
				<p>Opt-in: Yes</p>
			<cfelse>
				<p>Opt-in: No</p>
			</cfif>--->
			<cfinclude template="/components/email-template-bottom.cfm">
		</cfoutput>
		</cfsavecontent>
		
		<cfset sendEmail(form.email,emailbody,"New contact from #cgi.http_host#")><!--- settings.clientEmail --->
			
			<!---<cfif isdefined('form.optin') and form.optin eq 'Yes'>--->
						
			<cfif len(form.email)>
				<cfset variables.encEmail = encrypt(form.email, application.contactInfoEncryptKey, 'AES')>
			<cfelse>
				<cfset variables.encEmail = ''>
			</cfif>
			<cfif len(form.phone)>
				<cfset variables.encPhone = encrypt(form.phone, application.contactInfoEncryptKey, 'AES')>
			<cfelse>
				<cfset variables.encPhone = ''>
			</cfif>

			<cfquery dataSource="#settings.dsn#">
				insert into cms_contacts(firstname,email,phone,existinghome,address1,interestedin,complimentaryservices,subject,comments,camefrom,optin) 
				values(  
				<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.name#">,                      
				<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#variables.encEmail#">,     
				<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#variables.encPhone#">,
				<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.own_home#">,
				<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.address#">,
				<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.interested#">,
				<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.complimentary#">,       
				<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.subject#">,
				<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.message#">,
				'Property Management Form',
				'Yes'
				)
			</cfquery>
			
				<cfif settings.ListrakEnabled is "Yes">
					<cfinclude template="/components/listrak.cfm">
				</cfif>
				
				<cfif settings.hasLeadtracker eq 'yes'>
				<cfinclude template="/components/leadtracker.cfm">
			</cfif>
		
		<!---</cfif>--->
		
		<cfoutput>success</cfoutput>
	
	</cfif>
		
	</cfif>
    
    
</cfif> <!--- end of <cfif Cffp.testSubmission(form)> --->


<!--- add form processing for blog footer form here --->
