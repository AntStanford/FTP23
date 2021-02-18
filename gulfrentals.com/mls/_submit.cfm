
<cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />

<cfif Cffp.testSubmission(form)>

<cfif settings.environment eq 'dev'>
  <cfset cfmail.clientEmail = settings.devEmail>
<cfelse>
  <cfset cfmail.clientEmail = settings.clientEmail>
</cfif>

  <!--- Contact form on property detail page --->
  <cfif isdefined('form.requestMoreInfoForm')>

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
      
      <cfset AddressDisplayYN = 'Y' />

      <!---START: DECIDED TO CREATE AN ACCOUNT, BUT NOT MAKE IT ACTIVE UNTIL THEY ACTUALLY CREATE THE ACCOUNT THEMSELVES--->
      <cfset session.USERFirstName = "#form.firstname#">
      <cfcookie name="USERFirstName" value="#form.firstname#" expires="#LoginCookiePersist#">
      <cfset session.USERLastName = "#form.lastname#">
      <cfcookie name="USERLastName" value="#form.lastname#" expires="#LoginCookiePersist#">
      <cfset session.USEREmail = "#form.email#">
      <cfcookie name="USEREmail" value="#form.email#" expires="#LoginCookiePersist#">
      <cfset session.USERPhone = "#form.phone#">
      <cfcookie name="USERPhone" value="#form.phone#" expires="#LoginCookiePersist#">

      <!---START: INITIATING ROUND ROBIN IF ENABLED--->
      <!---has an account already been created with this email address--->
      <cfquery datasource="#application.settings.dsn#" name="Check">
        SELECT *
        FROM cl_accounts
        where email = '#form.email#'
      </cfquery>
      <!---<cfif check.recordcount gt 0>
        <cfquery datasource="#application.settings.dsn#" name="GetExistingAgent">
          SELECT *
          FROM cl_agents
          where id = '#Check.agentid#'
        </cfquery>
        <cfset AgentID = "#GetExistingAgent.id#">
        <cfset AgentEmailAddress = "#GetExistingAgent.email#">
        <cfset AgentName= "#GetExistingAgent.FirstName# #GetExistingAgent.LastName#">
      <cfelseif application.settings.mls.EnableRoundRobin is "Yes">
        <cfinclude template="/mls/includes/round-robin.cfm">
      <cfelse>
        <!---this is to grab the one agent to get all the leads--->
        <cfquery datasource="#application.settings.dsn#" name="GetPrimaryAgent">
          SELECT *
          FROM cl_agents
          where `primary` = 'Yes'
        </cfquery>
        <cfset AgentID = "#GetPrimaryAgent.id#">
        <cfset AgentEmailAddress = "#GetPrimaryAgent.email#">
        <cfset AgentName= "#GetPrimaryAgent.FirstName# #GetPrimaryAgent.LastName#">
      </cfif>--->
      <!---END: INITIATING ROUND ROBIN IF ENABLED--->
      <cfset AgentID = 1>
        <cfset AgentEmailAddress = "jmathewicnd@gmail.com">
        <cfset AgentName= "ICND">
      
      <cfif check.recordcount eq 0>
        <cfquery datasource="#application.settings.dsn#" dbtype="ODBC">
          Insert
          Into cl_accounts
            (firstname,lastname,email,phone,camefrom,accountcreatedbyviewer,agentid,leadsource,AgentOpened)
          Values
            (<cfqueryparam value="#form.firstname#" cfsqltype="CF_SQL_VARCHAR">,<cfqueryparam value="#form.lastname#" cfsqltype="CF_SQL_VARCHAR">,<cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR">,<cfqueryparam value="#form.phone#" cfsqltype="CF_SQL_VARCHAR">,<cfqueryparam value="#form.processform#" cfsqltype="CF_SQL_VARCHAR">,'Not Yet',<cfqueryparam value="#AgentID#" cfsqltype="CF_SQL_VARCHAR">,'2','No' )
        </cfquery>
        <cfquery datasource="#application.settings.dsn#" name="GetID">
          SELECT max(id) as TheMaxId
          FROM cl_accounts
          where email = '#form.email#'
        </cfquery>
      <cfelse>
        <cfset GetID.TheMaxId = "#Check.id#">
      </cfif>
      <!---END: DECIDED TO CREATE AN ACCOUNT, BUT NOT MAKE IT ACTIVE UNTIL THEY ACTUALLY CREATE THE ACCOUNT THEMSELVES--->

      <cfparam name="form.calltime" default="">

      <!---Stick the lead into the Lead Tracker DB--->
      <cfquery datasource="#application.settings.dsn#">
        INSERT INTO cl_leadtracker_response (agentid, clientid, MessageSubject, MessageBody, FromOrTo, PrivatePublic,BestTimeToContact,mlsid,wsid,mlsnumber)
        VALUES(
          <cfqueryparam value="#AgentID#" cfsqltype="CF_SQL_VARCHAR">,
          <cfif isdefined('cookie.LoggedIn') and cookie.loggedin gt 0>
            <cfqueryparam value="#cookie.LoggedIn#" cfsqltype="CF_SQL_VARCHAR">,
          <cfelse>
            <cfqueryparam value="#GetID.TheMaxId#" cfsqltype="CF_SQL_VARCHAR">,
          </cfif>
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#application.settings.company# Contact Form">,
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.comments#">,
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="Waiting on Agent's Response">,
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="Public">,
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.callTime#">,
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.mlsid#">,
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.wsid#">,
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.mlsnumber#">
        )
      </cfquery>
      <!---END: DB insert--->

      <!---update last request time--->
      <cfquery name="UpdateQuery" datasource="#application.settings.dsn#">
        UPDATE cl_accounts
        SET
          lastrequest = <cfqueryparam value="#now()#" cfsqltype="CF_SQL_TIMESTAMP">
        where id = <cfif isdefined('cookie.loggedin') and cookie.loggedin gt 0><cfqueryparam value="#cookie.LoggedIn#" cfsqltype="CF_SQL_VARCHAR"><cfelse><cfqueryparam value="#GetID.TheMaxId#" cfsqltype="CF_SQL_VARCHAR"></cfif>
      </cfquery>

      <!---START: UPDATE PROPERTY VIEWS AND PROPERTY REQUESTS WITH YOUR CLIENTID, NOW THAT WE KNOW WHO YOU ARE--->
      <cfquery name="UpdateQuery" datasource="#application.settings.dsn#">
        UPDATE cl_properties_viewed
        SET
          clientid = <cfif isdefined('cookie.loggedin') and cookie.loggedin gt 0><cfqueryparam value="#cookie.LoggedIn#" cfsqltype="CF_SQL_VARCHAR"><cfelse><cfqueryparam value="#GetID.TheMaxId#" cfsqltype="CF_SQL_VARCHAR"></cfif>
        where TheCFID = <cfqueryparam value="#cfid#" cfsqltype="CF_SQL_VARCHAR"> and TheCFTOKEN = <cfqueryparam value="#cftoken#" cfsqltype="CF_SQL_VARCHAR">
      </cfquery>
      <cfquery name="UpdateQuery" datasource="#application.settings.dsn#">
        UPDATE cl_leadtracker_response
        SET
          clientid = <cfif isdefined('cookie.loggedin') and cookie.loggedin gt 0><cfqueryparam value="#cookie.LoggedIn#" cfsqltype="CF_SQL_VARCHAR"><cfelse><cfqueryparam value="#GetID.TheMaxId#" cfsqltype="CF_SQL_VARCHAR"></cfif>
        where TheCFID = <cfqueryparam value="#cfid#" cfsqltype="CF_SQL_VARCHAR"> and TheCFTOKEN = <cfqueryparam value="#cftoken#" cfsqltype="CF_SQL_VARCHAR">
      </cfquery>
      <cfquery name="UpdateQuery" datasource="#application.settings.dsn#">
        UPDATE cl_saved_searches
        SET
          clientid = <cfif isdefined('cookie.loggedin') and cookie.loggedin gt 0><cfqueryparam value="#cookie.LoggedIn#" cfsqltype="CF_SQL_VARCHAR"><cfelse><cfqueryparam value="#GetID.TheMaxId#" cfsqltype="CF_SQL_VARCHAR"></cfif>
        where TheCFID = <cfqueryparam value="#cfid#" cfsqltype="CF_SQL_VARCHAR"> and TheCFTOKEN = <cfqueryparam value="#cftoken#" cfsqltype="CF_SQL_VARCHAR">
      </cfquery>
      <!---END: UPDATE PROPERTY VIEWS WITH YOUR CLIENTID, NOW THAT WE KNOW WHO YOU ARE--->

      <!---START NOTIFICATION EMAIL TO THE ADMINISTRATOR AND CUSTOMER--->
      <cfquery name="GetAgentInformation" datasource="#application.settings.dsn#">
        select *
        from cl_agents
        where id = '#AgentID#'
      </cfquery>
      <cfquery datasource="#application.settings.mls.propertydsn#" name="GetListings">
        SELECT *
        from mastertable
        where mlsnumber = '#form.mlsnumber#' and wsid = '#form.wsid#' and mlsid = '#form.mlsid#'
      </cfquery>
      <!---GETS IMAGE PATH--->
      <cfquery name="getmlscoinfo" datasource="#application.settings.mls.propertydsn#">
        SELECT *
        FROM mlsfeeds
        where id = '#application.settings.mls.mlsid#'
      </cfquery>

      <cfif isdefined('cookie.loggedin') and cookie.loggedin gt 0>
          <cfset TheClientID = "#cookie.loggedin#">
      <cfelse>
        <cfset TheClientID = "#GetID.TheMaxId#">
      </cfif>
      
      <cfset thisProp = application.oMLS.getListing(form.mlsid,form.mlsnumber,form.wsid) />

      <!--- <cfmail to="adoute.icnd@gmail.com" from="#form.email# <#application.settings.cfmailUsername#>" replyto="#form.email#"
          subject="#application.settings.company# - Property Request" type="HTML" server="#application.settings.cfmailServer#"  username="#application.settings.cfmailUsername#" password="#application.settings.cfmailPassword#" port="#application.settings.cfmailPort#" useSSL="#application.settings.cfmailSSL#" cc="#application.settings.cfmailCC#" bcc="#application.settings.cfmailBCC#"> ---><!--- was to: #AgentEmailAddress# --->
      <cfsavecontent variable="emailBody">
        <cfoutput>
          <!---<cfinclude template="/mls/emails/_header.cfm">--->
          <cfinclude template="../components/email-template-top.cfm">
          <p>First Name: #form.firstname#</p>
          <p>Last Name: #form.lastname#</p>
          <p>Email: #form.email#</p>
          <p>Phone: #form.phone#</p>
          <p>Best Time To Contact: #form.callTime#</p>
          <p>Property: <a href="http://#SERVER_NAME#/mls/#thisProp.propLink#">#mlsnumber#</a></p>
          <table>
            <tr>
              <td>
                <strong>Property Request</strong><br>
                <!--- <cfinclude template="/mls/includes/image-handler.cfm"> --->
                <cfif AddressDisplayYN is not "N">
                  <a href="http://#SERVER_NAME#/mls/#thisProp.propLink#">#thisProp.street_number# #thisProp.street_name# <cfif LEN(thisProp.unit_number)>#thisProp.unit_number#</cfif></a>
                </cfif>
                <a href="http://#SERVER_NAME#/mls/#thisProp.propLink#">
                  <cfif len(thisProp.photo_link) gt 0>
                    <cfif application.settings.mls.getmlscoinfo.imageurl eq "">
                      <cfset mapPhoto = <!---application.oMLS.firstPhoto(thisProp.photo_link)---> thisProp.prop_photo>
                    <cfelse>
                      <cfset mapPhoto = settings.mls.getmlscoinfo.imageurl & '/' & thisProp.wsid & '/' & <!---application.oMLS.firstPhoto(thisProp.photo_link)--->thisProp.prop_photo>
                    </cfif>
                    <img src="#mapPhoto#" width="200" border="0" alt="#application.settings.company# - MLS Number: #thisProp.mlsnumber#">
                  <cfelse>
                    <img src="http://mls.icoastalnet.com/mls/images/not_avail.jpg" width="200" border="0" alt="#application.settings.company#- MLS Number: #form.mlsnumber#">
                  </cfif>
                </a><br>
                #dollarformat(thisProp.list_price)#<br>
                <cfif thisProp.bedrooms is not "">Bedroom(s): #thisProp.bedrooms#  &nbsp;&nbsp;<br></cfif>
                <cfif thisProp.baths_full is not "">Full Baths: #thisProp.baths_full#  &nbsp;&nbsp;<br></cfif>
              </td>
            </tr>
          </table>
          <p>Comments: #form.comments#</p>
          <cfif isdefined('session.ReferringSite')><p>Referring Site: #session.ReferringSite#</p></cfif>
          <cfquery datasource="#application.settings.dsn#" name="LastPropsViewed">
            SELECT *
            FROM cl_properties_viewed
            where clientid = <cfif isdefined('cookie.loggedin') and cookie.loggedin gt 0>'#cookie.loggedin#'<cfelse>'#GetID.TheMaxId#'</cfif>
            order by createdat desc
            limit 20
          </cfquery>
          <cfif LastPropsViewed.recordcount gt 0>
            <p>Latest Properties Viewed</p>
            <table>
            <tr>
              <td>MLS ##</td>
              <td>Date</td>
            </tr>
            <cfloop query="LastPropsViewed">
              <tr>
                <td>
                  <a href="http://#cgi.HTTP_HOST#/mls/property-details.cfm?mlsnumber=#LastPropsViewed.mlsnumber#&wsid=#LastPropsViewed.wsid#&mlsid=#LastPropsViewed.mlsid#">#LastPropsViewed.mlsnumber#</a>
                </td>
                <td>#dateformat(LastPropsViewed.createdat,'mm/dd/yyyy')# #timeformat(LastPropsViewed.createdat,'hh:mm tt')#</td>
              </tr>
            </cfloop>
            </table>
          </cfif>
          <cfquery datasource="#application.settings.dsn#" name="LastSearches">
            SELECT *
            FROM cl_saved_searches
            where clientid = <cfif isdefined('cookie.loggedin') and cookie.loggedin gt 0>'#cookie.loggedin#'<cfelse>'#GetID.TheMaxId#'</cfif>
            and searchname <> 'Tracking Purpose'
            group by searchparameters
            order by createdat desc
            limit 20
          </cfquery>
          <cfif LastSearches.recordcount gt 0>
            <p>Latest Searches Made - Saved By Viewer</p>
            <table>
              <tr>
                <td>Search Name</td>
                <td>Date</td>
              </tr>
              <cfloop query="LastSearches">
                <tr>
                  <td>
                    <!---<a href="http://#cgi.HTTP_HOST#/mls/search-results.cfm?#LastSearches.searchparameters#&clearsession=">#LastSearches.searchname#</a>--->
                    #LastSearches.searchname#
                  </td>
                  <td>#dateformat(LastSearches.createdat,'mm/dd/yyyy')# #timeformat(LastSearches.createdat,'hh:mm tt')#</td>
                </tr>
              </cfloop>
            </table>
          </cfif>
          <cfquery datasource="#application.settings.dsn#" name="LastSearches">
            SELECT *
            FROM cl_saved_searches
            where clientid = <cfif isdefined('cookie.loggedin') and cookie.loggedin gt 0>'#cookie.loggedin#'<cfelse>'#GetID.TheMaxId#'</cfif>
            and searchname = 'Tracking Purpose'
            group by searchparameters
            order by createdat desc
            limit 20
          </cfquery>
          <cfif LastSearches.recordcount gt 0>
            <p>Latest Searches Made - Tracking</p>
            <table>
            <tr>
              <td>Search Name</td>
              <td>Date</td>
            </tr>
            <cfloop query="LastSearches">
              <tr>
                <td>
                  <!---<a href="http://#cgi.HTTP_HOST#/mls/search-results.cfm?#LastSearches.searchparameters#&clearsession=">#LastSearches.searchname#</a>--->
                  #LastSearches.searchname#
                </td>
                <td>#dateformat(LastSearches.createdat,'mm/dd/yyyy')# #timeformat(LastSearches.createdat,'hh:mm tt')#</td>
              </tr>
            </cfloop>
            </table>
          </cfif>
          <!---<cfinclude template="/mls/emails/_footer.cfm">--->
          <cfinclude template="../components/email-template-bottom.cfm">

          <!--this must stay for tracking-->
          <!---<img src="http://#server_name#/mls/opened-lead-by-agent.cfm?openclientid=#TheClientID#" alt="" border="0">--->
          <!--this must stay for tracking-->
        </cfoutput>
      </cfsavecontent>
      <!--- </cfmail> --->
      <cfset variables.argStruct = structNew()/>
      <cfset variables.argStruct.to = settings.mls.email /><!--- was to: #AgentEmailAddress# --->
      <cfset variables.argStruct.emailbody = emailBody />
      <cfset variables.argStruct.subject = "#application.settings.company# - Property Request" />
      <cfset variables.argStruct.replyTo = form.email />
      <cfset variables.argStruct.cc = application.settings.cfmailCC />
      <cfset variables.argStruct.bcc = application.settings.cfmailBCC />
      <cfset sendEmail(argumentCollection = variables.argStruct)>

      <!--- <cfmail to="#form.email#" from="#AgentEmailAddress# <#application.settings.cfmailUsername#>" replyto="#AgentEmailAddress#"
          subject="#application.settings.company# - Property Information Request" type="HTML"server="#application.settings.cfmailServer#"  username="#application.settings.cfmailUsername#" password="#application.settings.cfmailPassword#" port="#application.settings.cfmailPort#" useSSL="#application.settings.cfmailSSL#" cc="#application.settings.cfmailCC#" bcc="#application.settings.cfmailBCC#"> --->
      <cfsavecontent variable="emailBody">
        <cfoutput>
          <!---<cfinclude template="/mls/emails/_header.cfm">--->
          <cfinclude template="../components/email-template-top.cfm">
          <p>Hello #form.firstname#,</p>
          <p>Thank you for inquiring about a property with #application.settings.company#!  </p>
          <!---START: PROPERTY AND AGENT LAYOUT--->
          <table width="100%">
            <tr>
              <td valign="top">
                <strong>Contact Your Agent Today</strong><br>
                #GetAgentInformation.firstname# #GetAgentInformation.lastname#<br>
                <cfif GetAgentInformation.agentphoto is not ""><br><img src="http://#SERVER_NAME#/mls/images/agents/sm_#GetAgentInformation.agentphoto#" alt="" border="0"></cfif>
                <cfif GetAgentInformation.email is not ""><br><a href="mailto:#GetAgentInformation.email#">#GetAgentInformation.email#</a></cfif>
                <cfif GetAgentInformation.cellphone is not ""><br>#GetAgentInformation.cellphone#</cfif>
                <cfif GetAgentInformation.phone is not ""><br>#GetAgentInformation.phone#</cfif>
              </td>
              <td valign="top">
                <strong>Property Request</strong><br>
                <!--- <cfinclude template="/mls/includes/image-handler.cfm"> --->
                <cfif AddressDisplayYN is not "N"><a href="http://#SERVER_NAME#/mls/#thisProp.propLink#">#thisProp.street_number# #thisProp.street_name# <cfif LEN(thisProp.unit_number)>#thisProp.unit_number#</cfif></a><br></cfif><br>
                <a href="http://#SERVER_NAME#/mls/#thisProp.propLink#">
                  <cfif len(thisProp.photo_link) gt 0>
                    <cfif application.settings.mls.getmlscoinfo.imageurl eq "">
                      <cfset mapPhoto = <!---application.oMLS.firstPhoto(thisProp.photo_link)---> thisProp.prop_photo>
                    <cfelse>
                      <cfset mapPhoto = settings.mls.getmlscoinfo.imageurl & '/' & thisProp.wsid & '/' & <!---application.oMLS.firstPhoto(thisProp.photo_link)--->thisProp.prop_photo>
                    </cfif>
                    <img src="#mapPhoto#" width="200" border="0" alt="#application.settings.company# - MLS Number: #mlsnumber#">
                  <cfelse>
                    <img src="http://mls.icoastalnet.com/mls/images/not_avail.jpg" width="200" border="0" alt="#application.settings.company#- MLS Number: #mlsnumber#">
                  </cfif>
                </a><br>
                #dollarformat(thisProp.list_price)#<br>
                <cfif thisProp.bedrooms is not "">Bedroom(s): #thisProp.bedrooms#  &nbsp;&nbsp;<br></cfif>
                <cfif thisProp.baths_full is not "">Full Baths: #thisProp.baths_full#  &nbsp;&nbsp;<br></cfif>
              </td>
            </tr>
          </table>
          <!---END: PROPERTY AND AGENT LAYOUT--->
          <p>
              Thank you,<br>
              #AgentName#<br>
              #application.settings.company#
          </p>
          <!---<cfinclude template="/mls/emails/_footer.cfm">--->
          <cfinclude template="../components/email-template-bottom.cfm">
        </cfoutput>
      </cfsavecontent>
      <!--- </cfmail> --->
      <cfset variables.argStruct = structNew()/>
        <cfset variables.argStruct.to = form.email />
        <cfset variables.argStruct.emailbody = emailBody />
        <cfset variables.argStruct.subject = "#application.settings.company# - Property Information Request" />
        <cfset variables.argStruct.replyTo = settings.mls.email />
        <cfset variables.argStruct.cc = application.settings.cfmailCC />
        <cfset variables.argStruct.bcc = application.settings.cfmailBCC />
        <cfset variables.argStruct.from = settings.mls.email />

      <!---<cfset sendEmail(argumentCollection = variables.argStruct)>--->

      <!--- <cfmail to="#form.email#" from="#AgentEmailAddress# <#application.settings.cfmailUsername#>" replyto="#AgentEmailAddress#"
          subject="#application.settings.company# - Property Information Request" type="HTML"server="#application.settings.cfmailServer#"  username="#application.settings.cfmailUsername#" password="#application.settings.cfmailPassword#" port="#application.settings.cfmailPort#" useSSL="#application.settings.cfmailSSL#" cc="#application.settings.cfmailCC#" bcc="#application.settings.cfmailBCC#"> --->

      <!---END NOTIFICATION EMAIL TO THE ADMINISTRATOR AND CUSTOMER--->
      <!---START: LOG ACTIVITY--->
      <cfquery datasource="#application.settings.dsn#" dbtype="ODBC">
          Insert
          Into cl_activity
            (clientid,RefferingSite,Action)
          Values
            (<cfif isdefined('cookie.loggedin') and cookie.loggedin gt 0>'#cookie.loggedin#'<cfelse>'#GetID.TheMaxId#'</cfif>,
             <cfif isdefined('session.referringsite')><cfqueryparam value="#session.referringsite#" cfsqltype="CF_SQL_LONGVARCHAR"><cfelse>'N/A'</cfif>,'Requested Property Information'
            )
      </cfquery>

      <cfoutput>success</cfoutput>

      <!--- end un-tested code from old live site --->
    <cfelse>
      ReCaptcha failed
    </cfif>
  </cfif>

      <!--- OLD CODE --->
      <!--- <cfif isdefined('form.requestMoreInfoForm')>
       <cfquery name="getProperty" dataSource="#settings.mls.propertydsn#">
		   select mlsnumber,street_name, street_number, unit_number, photo_link, city, zip_code, mlsid,wsid, list_price
		   from mastertable where mlsnumber = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.mlsnumber#">
		   </cfquery>

         <cfset mapPhoto = settings.mls.getmlscoinfo.imageurl & '/' & application.oMLS.firstPhoto(getProperty.photo_link)>
         <cfif listlen(getProperty.photo_link) gte 1><cfset map_photo = listgetat(getProperty.photo_link,1)></cfif>
         <cfset detailPage = application.oHelpers.optimizeMyURL(getProperty.street_number,
                                        getProperty.street_name,
                                        getProperty.city,
                                        getProperty.zip_code,
                                        getProperty.mlsnumber,
                                        getProperty.mlsid,
                                        getProperty.wsid)>


      <!--- email client and insert contact into db --->
      <cfmail to="#cfmail.clientEmail#" from="#settings.cfmailUsername# <#settings.cfmailUsername#>" subject="New contact from #cgi.http_host#" server="#settings.cfmailServer#" username="#settings.cfmailUsername#" password="#settings.cfmailPassword#" port="#settings.cfmailPort#" useSSL="#settings.cfmailSSL#" type="HTML" bcc="#settings.cfmailBCC#" cc="#settings.cfmailCC#">




         <cfinclude template="/components/email-template-top.cfm">

          <cfif isDefined('form.mlsnumber') and LEN(form.mlsnumber)><p><a href="http://#cgi.server_name#/#detailpage#">Click here to view #getProperty.street_number# #getProperty.Street_Name# #form.mlsnumber#</a></p></cfif>

          <p>First Name: #firstname#</p>
          <p>Last Name: #lastname#</p>
          <p>Email: #email#</p>
          <p>Phone: #phone#</p>
          <p>Best Time to Call: #callTime#</p>
          <p>Comments: #comments#</p>



          <cfinclude template="/components/email-template-bottom.cfm">

      </cfmail>


      <cfquery dataSource="#settings.dsn#">
         insert into cms_contacts(firstname,lastname,email,comments,camefrom,property,unitcode)
         values(
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.firstname#">,
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.lastname#">,
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.email#">,
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.comments#">,
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="Request for More Info">,
			   <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#getProperty.street_number# #getProperty.Street_Name#">,
			   <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.mlsnumber#">
         )
      </cfquery>

	  <!---START: THIS IS TO CLEAN UP THE RECEIVER--->

		<!---
      <CFQUERY DATASOURCE="#settings.bcDSN#" NAME="GetInfo">
			delete
			FROM cart_abandonment_detail_page
			where email =  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.email#">
			and siteID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#settings.id#">
		</CFQUERY>

		<!---END: THIS IS TO CLEAN UP THE RECEIVER--->

	   <cfinclude template="/booking/_user-tracking.cfm">
      <cfset form.message = 'Request for More Info'>
      <cfinclude template="/booking/api/EVRN_UnitInquiryRQ.cfm">

      <cfif settings.listrakEnabled is "Yes">
			<cfinclude template="/components/listrak.cfm">
		</cfif>

		<cfif settings.hasLeadtracker eq 'yes'>
		    <cfinclude template="/components/leadtracker.cfm">
       </cfif>
       --->

   </cfif>

 --->

   <!--- Review form on property detail page --->
   <cfif isdefined('form.submitReview')>

      <!--- email client and insert contact into db --->
      <cfmail to="#cfmail.clientEmail#" from="#settings.cfmailUsername# <#settings.cfmailUsername#>" subject="New review from #cgi.http_host#" server="#settings.cfmailServer#" username="#settings.cfmailUsername#" password="#settings.cfmailPassword#" port="#settings.cfmailPort#" useSSL="#settings.cfmailSSL#" type="HTML" bcc="#settings.cfmailBCC#" cc="#settings.cfmailCC#">

         <cfinclude template="/components/email-template-top.cfm">
         <p>#firstname# #lastname# has submitted a new review for #form.property#</p>
         <p><a href="http://#cgi.http_host#/admin/login.cfm">Log into your admin area</a> to approve the review.</p>
         <cfinclude template="/components/email-template-bottom.cfm">

      </cfmail>

      <cfquery dataSource="#settings.bcDSN#">
         insert into be_reviews(firstname,lastname,email,checkInDate,checkOutDate,title,review,unitcode,rating,hometown,siteID)
         values(
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.firstname#">,
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.lastname#">,
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.email#">,
            <cfqueryparam CFSQLType="CF_SQL_DATE" value="#form.checkInDate#">,
            <cfqueryparam CFSQLType="CF_SQL_DATE" value="#form.checkOutDate#">,
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.title#">,
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.review#">,
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.unitcode#">,
            <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#form.rating#">,
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.hometown#">,
            <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#settings.id#">
         )
      </cfquery>

	  <cfinclude template="/booking/_user-tracking.cfm">

   </cfif>




   <!--- Q and A form on property detail page --->
   <cfif isdefined('form.submitQandA')>


      <cfmail to="#cfmail.clientEmail#" from="#settings.cfmailUsername# <#settings.cfmailUsername#>" subject="New Q and A for #property# - #cgi.http_host#" server="#settings.cfmailServer#" username="#settings.cfmailUsername#" password="#settings.cfmailPassword#" port="#settings.cfmailPort#" useSSL="#settings.cfmailSSL#" type="HTML" bcc="#settings.cfmailBCC#" cc="#settings.cfmailCC#">

         <cfinclude template="/components/email-template-top.cfm">
         <p>Property: #form.property#</p>
         <p>First Name: #firstname#</p>
         <p>First Name: #lastname#</p>
         <p>Email: #email#</p>
         <p>Question: #question#</p>
         <cfinclude template="/components/email-template-bottom.cfm">

      </cfmail>

      <cfquery dataSource="#settings.bcDSN#">
         insert into be_questions_and_answers_properties (firstname,lastname,email,question,property,propertyid,siteID)
         values(
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.firstname#">,
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.lastname#">,
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.email#">,
            <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#form.question#">,
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.property#">,
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.unitcode#">,
            <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#settings.id#">
         )
      </cfquery>

	  <cfinclude template="/booking/_user-tracking.cfm">
	  <cfinclude template="/booking/api/EVRN_UnitInquiryRQ.cfm">

	  <cfif settings.listrakEnabled is "Yes">
			<cfinclude template="/components/listrak.cfm">
		</cfif>

		<cfif settings.hasLeadtracker eq 'yes'>
		    <cfinclude template="/components/leadtracker.cfm">
       </cfif>

   </cfif>






   <!--- Send to Friend form on property detail page --->
   <cfif isdefined('form.sendtofriendForm')>

      <!--- Just in case a spammer tries to put more than one email in the form field --->
      <cfset string = form.friendsemail>
      <cfset substring = '@'>

      <cfset occurrences = ( Len(string) - Len(Replace(string,substring,'','all'))) / Len(substring)>

      <cfif occurrences eq 1>

         <cfquery name="getProperty" dataSource="#settings.mls.propertydsn#">
		   select mlsnumber,street_name, street_number, unit_number, photo_link, city, zip_code, mlsid,wsid, list_price
		   from mastertable where mlsnumber = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.mlsnumber#"> and mlsid=<cfqueryparam cfsqltype="cf_sql_integer" value="#settings.mls.mlsid#">
		   </cfquery>

         <cfset mapPhoto = settings.mls.getmlscoinfo.imageurl & '/' & thisProp.wsid & '/' & <!---application.oMLS.firstPhoto(thisProp.photo_link)--->thisProp.prop_photo>
         <cfset detailPage = application.oHelpers.optimizeMyURL(getProperty.street_number,
                                        getProperty.street_name,
                                        getProperty.city,
                                        getProperty.zip_code,
                                        getProperty.mlsnumber,
                                        getProperty.mlsid,
                                        getProperty.wsid)>



            <cfmail to="#form.friendsemail#" from="#form.firstname# #form.lastname# <#form.youremail#>" subject="Check out this property I found on #cgi.http_host#" server="#settings.cfmailServer#" username="#settings.cfmailUsername#" password="#settings.cfmailPassword#" port="#settings.cfmailPort#" useSSL="#settings.cfmailSSL#" type="HTML" bcc="#settings.cfmailBCC#" cc="#settings.cfmailCC#">

               <cfinclude template="/components/email-template-top.cfm">
               <p>#form.friendsfirstname#,</p>
   				<p>I was browsing the #cgi.http_host# website today and wanted to share this property with you. Click the link below to view the property.</p>
   				<img src="#mapPhoto#" align="left" width="200" height="150" border="0" style="padding-right:25px">
   				<p><a href="http://#cgi.server_name#/#detailpage#">Click here to view #getProperty.street_number# #getProperty.Street_Name#</a></p>
   				<p>Message from your friend: #comments#</p>
   				<p>#form.firstname#</p>
               <cfinclude template="/components/email-template-bottom.cfm">

            </cfmail>


      	  <cfquery dataSource="#settings.dsn#">
               insert into cms_contacts(firstname,lastname,email,friendsfirstname,friendslastname,friendsemail,comments,camefrom,property,unitcode)
               values(
                     <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.firstname#">,
                     <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.lastname#">,
                     <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.youremail#">,
                     <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.friendsfirstname#">,
                     <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.friendslastname#">,
                     <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.friendsemail#">,
                     <cfqueryparam CFSQLType="CF_SQL_LONGVARCHAR" value="#form.comments#">,
                     <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="Send To A Friend">,
                     <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#getProperty.street_number# #getProperty.Street_Name#">,
                     <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.mlsnumber#">
               )
            </cfquery>

      	  <cfset form.email = "#form.youremail#">
      	  <!--- <cfinclude template="/booking/_user-tracking.cfm">--->

      </cfif>

   </cfif>


   <cfset counter = 0>
   <!--- Send to Friend form on the compare favs page --->
   <cfif isdefined('form.sendToFriendCompare')>

      <!--- Just in case a spammer tries to put more than one email in the form field --->
      <cfset string = form.friendsemail>
      <cfset substring = '@'>

      <cfset occurrences = ( Len(string) - Len(Replace(string,substring,'','all'))) / Len(substring)>

      <cfif occurrences eq 1>

         <cfif isDefined("cookie.loggedIn")>
            <cfset clientid = cookie.loggedIn>
         <cfelse>
            <Cfset clientid = 0>
         </cfif>

         <!--- Init Session Variables --->
         <cfset strFavorites = application.oMLS.getFavorites(clientid,settings.id,false, cfid, cftoken)>
         <cfset qResults = application.oMLS.getFavoriteProperties(strFavorites, settings.mls.mlsid)>


         <cfmail replyto="#form.youremail#" to="#form.friendsemail#" from="#form.youremail#" subject="Check out these properties I found on #cgi.http_host#" server="#settings.cfmailServer#" username="#settings.cfmailUsername#" password="#settings.cfmailPassword#" port="#settings.cfmailPort#" useSSL="#settings.cfmailSSL#" type="HTML" bcc="#settings.cfmailBCC#" cc="#settings.cfmailCC#">

            <cfinclude template="/components/email-template-top.cfm">
            <table>


                  <cfloop query="qResults">


                        <cfset ThePhoto = settings.mls.getmlscoinfo.imageurl & '/' & thisProp.wsid & '/' & <!---application.oMLS.firstPhoto(thisProp.photo_link)---> thisProp.prop_photo>
	                     <cfset detailPage = application.oHelpers.optimizeMyURL(qResults.street_number,
                                        qResults.street_name,
                                        qResults.city,
                                        qResults.zip_code,
                                        qResults.mlsnumber,
                                        qResults.mlsid,
                                        qResults.wsid)>



            	   		   <tr>
            	   		     <td align="left" valign="top"><img src="#thephoto#" align="left" width="200" height="150" border="0" style="padding-right:10px"></td>
            		 				 <td valign="top">
            		 				 	 <p style="font-family:'Helvetica Neue', helvetica, alrial, sans-serif; font-size:20px; color:##878a93;"><a href="http://#cgi.http_host##detailPage#">Click here to view #street_number# #street_name# <cfif LEN(unit_number)>#application.oHelpers.FormatUnit(unit_number)#</cfif></a></p>
            		 				 	 <p style="font-family:'Helvetica Neue', helvetica, alrial, sans-serif; font-size:20px; color:##878a93;">Message from your friend: #Evaluate('comments_for_'&currentrow)#</p>
            		 				 </td>
            	   		   </tr>



                  </cfloop>

            </table>
            <cfinclude template="/components/email-template-bottom.cfm">

         </cfmail>

         <!--- We also want to save the email address of the person who sent the form --->
         <cftry>

            <cfquery dataSource="#settings.dsn#">
               insert into cms_contacts(email,camefrom,friendsemail)
               values(
                  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.youremail#">,
                  'Send to A Friend Compare',
                  <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.friendsemail#">
                  )
            </cfquery>

            <cfcatch>
               <cfdump var="#cfcatch#">
            </cfcatch>

         </cftry>
		success
      <cfelse>
         You are spam, go away
      </cfif>

   </cfif>


</cfif> <!--- end of <cfif Cffp.testSubmission(form)> --->
