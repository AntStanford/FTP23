<!--- <cfinclude template="/sales/lightboxes/_header.cfm"> --->
<cfparam name="session.RememberMePage" default="#SERVER_NAME#/sales/">

<cfset form.mlsnumber = form.MoreInfomlsNumber>
<cfset form.mlsid = form.MoreInfomlsID>
<cfset form.wsid = form.MoreInfowsid>

<div id="mls-wrapper">
<!---   <div align="right">
    <cfoutput><strong><a hreflang="en" href="#session.RememberMePage#" target="_parent" id="fancybox-close">X</a></strong></cfoutput>
  </div> --->
  <cfquery name="GetAddress" datasource="#DSNMLS#">
    SELECT street_number,street_name, city
    FROM mastertable
    where mlsid = <cfqueryparam value="#form.mlsid#" cfsqltype="cf_sql_integer"> and wsid = <cfqueryparam value="#form.wsid#" cfsqltype="cf_sql_integer"> and mlsnumber = <cfqueryparam value="#form.mlsnumber#" cfsqltype="cf_sql_numeric">
  </cfquery>
  <cfoutput>
    <!--- <h2>Request More Information<span>MLS ## #mlsnumber#, #CapFirstTitle(GetAddress.street_number)# #CapFirstTitle(GetAddress.street_name)#, #GetAddress.city#</span></h2> --->
  </cfoutput>
  <!---IF NOT LOGGED IN REDIRECT--->
  <!--- <cfif isdefined('session.LoggedIn') is "No">
    <cfparam name="mlsid" type="string">
    <cfparam name="mlsid" type="string">
    <cfparam name="mlsnumber" type="string">
    <cflocation url="/sales/lightboxes/create-account.cfm?action=#action#&wsid=#wsid#&mlsid=#mlsid#&mlsnumber=#mlsnumber#" addtoken="No">
  <cfelse> --->

  <cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />

  <cfif isdefined('processform') and isValid('email',form.email) and Cffp.testSubmission(form)>



    <!---START: PROCESSING FORM--->
    <cfif Cffp.testSubmission(form)>

      <!--- START: Check for blank fields --->
      <cfset e.variables = 'empty'>
      <cfif LEN(form.firstname) eq 0><cfset e.variables = e.variables & '~First Name'></cfif>
      <cfif LEN(form.lastname) eq 0><cfset e.variables = e.variables & '~Last Name'></cfif>
      <cfif LEN(form.email) eq 0><cfset e.variables = e.variables & '~Email'></cfif>

      <cfoutput>

      <cfif e.variables neq 'empty'>
        <a name="success"></a>
        <p>Please <a hreflang="en" href="Javascript:history.back(-1);">go back</a> and fill out the following fields:</p>
        <p>
          <cfset e.variables = replace(e.variables,'empty~','')>
          <cfloop list="#e.variables#" delimiters="~" index="errorfields">
            &raquo; #errorfields#<br>
          </cfloop>
        </p>
        <p><a hreflang="en" href="Javascript:history.back(-1);">Return to form</a>.</p>
         <cfabort>
      </cfif>

      </cfoutput>

      <!--- END: Check for blank fields --->

    <!---START: DB insert--->



      <!---START: DECIDED TO CREATE AN ACCOUNT, BUT NOT MAKE IT ACTIVE UNTIL THEY ACTUALLY CREATE THE ACCOUNT THEMSELVES--->
<!---       <cfset session.USERFirstName = "#firstname#">
      <cfcookie name="USERFirstName" value="#firstname#" expires="#LoginCookiePersist#">
      <cfset session.USERLastName = "#lastname#">
      <cfcookie name="USERLastName" value="#lastname#" expires="#LoginCookiePersist#">
      <cfset session.USEREmail = "#email#">
      <cfcookie name="USEREmail" value="#email#" expires="#LoginCookiePersist#">
      <cfset session.USERPhone = "#phone#">
      <cfcookie name="USERPhone" value="#phone#" expires="#LoginCookiePersist#">
       --->


        <!---START: INITIATING ROUND ROBIN IF ENABLED--->
        <!---has an account already been created with this email address--->
        <cfquery datasource="#mls.dsn#" name="Check">
        SELECT *
        FROM cl_accounts
        where email = <cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR">
        </cfquery>

        <cfif check.recordcount gt 0>

            <cfquery datasource="#mls.dsn#" name="GetExistingAgent">
                SELECT *
                FROM cl_agents
                where id = <cfqueryparam value="#Check.agentid#" cfsqltype="cf_sql_integer">
            </cfquery>

            <!--- Get Agent info from CMS instead --->
            <cfquery name = "getAgentFromCMS" datasource = "#settings.dsn#">
                SELECT id, name, email
                FROM cms_staff
                where 1=1
                and category = 'Real Estate Sales'
                AND email = <cfqueryparam value = "#GetExistingAgent.email#" CFSQLType = "CF_SQL_VARCHAR">
                LIMIT 1
            </cfquery>

            <cfif getAgentFromCMS.recordcount EQ 0>

                <cfquery name = "getAgentFromCMS" datasource = "#settings.dsn#">
                    SELECT id, name, email
                    FROM cms_staff
                    where 1=1
                    and category = 'Real Estate Sales'
                    ORDER BY RAND()
                    LIMIT 1
                </cfquery>

                <cfset AgentID = 12>
                <cfset AgentEmailAddress = "#getAgentFromCMS.email#">
                <cfset AgentName= "#getAgentFromCMS.name#">

            <cfelse>

                <cfset AgentID = "#GetExistingAgent.id#">
                <cfset AgentEmailAddress = "#getAgentFromCMS.email#">
                <cfset AgentName= "#getAgentFromCMS.name#">

            </cfif>

        <cfelse>

            <!--- Use Agent guest selected --->
            <cfquery name = "getAgentFromCMS" datasource = "#settings.dsn#">
                SELECT id, name, email
                FROM cms_staff
                where 1=1
                and category = 'Real Estate Sales'
                and name = <cfqueryparam value = "#form.existingAgentName#" CFSQLType = "CF_SQL_VARCHAR">
                LIMIT 1
            </cfquery>

            <cfif getAgentFromCMS.recordcount EQ 0>

                <!--- Randomize it --->
                <cfquery name = "getAgentFromCMS" datasource = "#settings.dsn#">
                    SELECT id, name, email
                    FROM cms_staff
                    where 1=1
                    and category = 'Real Estate Sales'
                    ORDER BY RAND()
                    LIMIT 1
                </cfquery>

            </cfif>

            <cfset AgentID = 12>
            <cfset AgentEmailAddress = "#getAgentFromCMS.email#">
            <cfset AgentName= "#getAgentFromCMS.name#">

        <!--- <cfelseif mls.EnableRoundRobin is "Yes">


            <cfinclude template="/sales/includes/round-robin.cfm">

        <cfelse>

            <!---this is to grab the one agent to get all the leads--->
            <cfquery datasource="#mls.dsn#" name="GetPrimaryAgent">
            SELECT *
            FROM cl_agents
            where `primary` = 'Yes'
            </cfquery>
            <cfset AgentID = "#GetPrimaryAgent.id#">
            <cfset AgentEmailAddress = "#GetPrimaryAgent.email#">
            <cfset AgentName= "#GetPrimaryAgent.FirstName# #GetPrimaryAgent.LastName#"> --->

        </cfif>
        <!---END: INITIATING ROUND ROBIN IF ENABLED--->



      <cfif check.recordcount eq 0>
        <cfquery datasource="#mls.dsn#" dbtype="ODBC">
          Insert
          Into cl_accounts
            (firstname,lastname,email,phone,camefrom,accountcreatedbyviewer,agentid,leadsource,AgentOpened)
          Values
            (<cfqueryparam value="#firstname#" cfsqltype="CF_SQL_VARCHAR">,<cfqueryparam value="#lastname#" cfsqltype="CF_SQL_VARCHAR">,<cfqueryparam value="#email#" cfsqltype="CF_SQL_VARCHAR">,<cfqueryparam value="#phone#" cfsqltype="CF_SQL_VARCHAR">,<cfqueryparam value="#processform#" cfsqltype="CF_SQL_VARCHAR">,'Not Yet',<cfqueryparam value="#AgentID#" cfsqltype="CF_SQL_VARCHAR">,'2','No' )
        </cfquery>
        <cfquery datasource="#mls.dsn#" name="GetID">
          SELECT max(id) as TheMaxId
          FROM cl_accounts
          where email = <cfqueryparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR">
        </cfquery>
      <cfelse>
        <cfset GetID.TheMaxId = "#Check.id#">
      </cfif>
      <!---END: DECIDED TO CREATE AN ACCOUNT, BUT NOT MAKE IT ACTIVE UNTIL THEY ACTUALLY CREATE THE ACCOUNT THEMSELVES--->



      <!---Stick the lead into the Lead Tracker DB--->
      <cfquery datasource="#mls.dsn#">
        INSERT INTO cl_leadtracker_response (agentid, clientid, MessageSubject, MessageBody, FromOrTo, PrivatePublic,BestTimeToContact,mlsid,wsid,mlsnumber)
        VALUES(
          <cfqueryparam value="#AgentID#" cfsqltype="CF_SQL_VARCHAR">,
          <cfif isdefined('cookie.LoggedIn')>
            <cfqueryparam value="#cookie.LoggedIn#" cfsqltype="CF_SQL_VARCHAR">,
          <cfelse>
            <cfqueryparam value="#GetID.TheMaxId#" cfsqltype="CF_SQL_VARCHAR">,
          </cfif>
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#mls.companyname# - Request More Information">,
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#comments#">,
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="Waiting on Agent's Response">,
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="Public">,
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#bestcontact#">,
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#mlsid#">,
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#wsid#">,
          <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#mlsnumber#">
        )
      </cfquery>
      <!---END: DB insert--->



      <!---update last request time--->
      <cfquery name="UpdateQuery" datasource="#mls.dsn#">
        UPDATE cl_accounts
        SET
          lastrequest = <cfqueryparam value="#now()#" cfsqltype="CF_SQL_TIMESTAMP">
        where id = <cfif isdefined('cookie.loggedin')><cfqueryparam value="#cookie.LoggedIn#" cfsqltype="CF_SQL_VARCHAR"><cfelse><cfqueryparam value="#GetID.TheMaxId#" cfsqltype="CF_SQL_VARCHAR"></cfif>
      </cfquery>



      <!---START: UPDATE PROPERTY VIEWS AND PROPERTY REQUESTS WITH YOUR CLIENTID, NOW THAT WE KNOW WHO YOU ARE--->
      <cfquery name="UpdateQuery" datasource="#mls.dsn#">
        UPDATE cl_properties_viewed
        SET
          clientid = <cfif isdefined('cookie.loggedin')><cfqueryparam value="#cookie.LoggedIn#" cfsqltype="CF_SQL_VARCHAR"><cfelse><cfqueryparam value="#GetID.TheMaxId#" cfsqltype="CF_SQL_VARCHAR"></cfif>
        where TheCFID = <cfqueryparam value="#cfid#" cfsqltype="CF_SQL_VARCHAR"> and TheCFTOKEN = <cfqueryparam value="#cftoken#" cfsqltype="CF_SQL_VARCHAR">
      </cfquery>
      <cfquery name="UpdateQuery" datasource="#mls.dsn#">
        UPDATE cl_leadtracker_response
        SET
          clientid = <cfif isdefined('cookie.loggedin')><cfqueryparam value="#cookie.LoggedIn#" cfsqltype="CF_SQL_VARCHAR"><cfelse><cfqueryparam value="#GetID.TheMaxId#" cfsqltype="CF_SQL_VARCHAR"></cfif>
        where TheCFID = <cfqueryparam value="#cfid#" cfsqltype="CF_SQL_VARCHAR"> and TheCFTOKEN = <cfqueryparam value="#cftoken#" cfsqltype="CF_SQL_VARCHAR">
      </cfquery>
      <cfquery name="UpdateQuery" datasource="#mls.dsn#">
        UPDATE cl_saved_searches
        SET
          clientid = <cfif isdefined('cookie.loggedin')><cfqueryparam value="#cookie.LoggedIn#" cfsqltype="CF_SQL_VARCHAR"><cfelse><cfqueryparam value="#GetID.TheMaxId#" cfsqltype="CF_SQL_VARCHAR"></cfif>
        where TheCFID = <cfqueryparam value="#cfid#" cfsqltype="CF_SQL_VARCHAR"> and TheCFTOKEN = <cfqueryparam value="#cftoken#" cfsqltype="CF_SQL_VARCHAR">
      </cfquery>
      <!---END: UPDATE PROPERTY VIEWS WITH YOUR CLIENTID, NOW THAT WE KNOW WHO YOU ARE--->



      <!---START NOTIFICATION EMAIL TO THE ADMINISTRATOR AND CUSTOMER--->
      <cfquery name="GetAgentInformation" datasource="#mls.dsn#">
        select *
        from cl_agents
        where id = <cfqueryparam cfsqltype="cf_sql_varchar" value='#AgentID#'>
      </cfquery>
      <cfquery datasource="#DSNMLS#" name="GetListings">
        SELECT *
        from mastertable
        where mlsnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#mlsnumber#'> and wsid = <cfqueryparam cfsqltype="cf_sql_varchar" value='#wsid#'> and mlsid = <cfqueryparam cfsqltype="cf_sql_varchar" value='#mlsid#'>
      </cfquery>
      <!---GETS IMAGE PATH--->
      <cfquery name="getmlscoinfo" datasource="#DSNMLS#">
        SELECT *
        FROM mlsfeeds
        where id = <cfqueryparam value="#mls.mlsid#" cfsqltype="cf_sql_integer">
      </cfquery>

	  <cfif isdefined('cookie.loggedin')>
	  		<cfset TheClientID = "#cookie.loggedin#">
		<cfelse>
			<cfset TheClientID = "#GetID.TheMaxId#">
	  </cfif>

        <cfset wasAgentEmailAddress = AgentEmailAddress> <!--- What the Agent email was in the old system --->

        <cfmail to="#AgentEmailAddress#" from="#form.email# <#cfmail.username#>" replyto="#form.email#"
        subject="#mls.companyname# - Property Request" type="HTML" server="#cfmail.server#"  username="#cfmail.username#" password="#cfmail.password#"
        port="#cfmail.port#" useSSL="#cfmail.useSSL#" cc="#cfmail.cc#" bcc="#cfmail.bcc#">
        <cfinclude template="/sales/emails/_header.cfm">
          <p>First Name: #form.firstname#</p>
          <p>Last Name: #form.lastname#</p>
          <p>Email: #form.email#</p>
          <p>Phone: #form.phone#</p>
          <p>Best Time To Contact: #form.bestcontact#</p>

          <!---
          <cfif ListFind("216.99.119.254", cgi.remote_host)>
              <p>ICND EYES ONLY</p>
              <p>wasAgentEmailAddress: #wasAgentEmailAddress#</p>
          </cfif>
          --->

          <p>Property: <a hreflang="en" href="http://#SERVER_NAME#/sales/property-details.cfm?mlsnumber=#mlsnumber#&mlsid=#mlsid#&wsid=#wsid#">#mlsnumber#</a></p>
          <table>
          <tr>
            <td>
              <strong>Property Request</strong><br>
              <cfloop query="GetListings">
                <cfinclude template="/sales/includes/image-handler.cfm">
                <cfif AddressDisplayYN is not "N">
                  <a hreflang="en" href="http://#SERVER_NAME#/sales/property-details.cfm?mlsnumber=#mlsnumber#&mlsid=#mlsid#&wsid=#wsid#">#street_number# #street_name# <cfif LEN(unit_number)>#unit_number#</cfif></a>
                </cfif>
                <a hreflang="en" href="http://#SERVER_NAME#/sales/property-details.cfm?mlsnumber=#mlsnumber#&mlsid=#mlsid#&wsid=#wsid#">
                  <cfif HowManyPhotos gt 0>
                    <img src="#thephoto#" width="200" border="0" alt="#mls.companyname# - MLS Number: #mlsnumber#">
                  <cfelse>
                    <img src="http://mls.icoastalnet.com/sales/images/not_avail.jpg" width="200" border="0" alt="#mls.companyname#- MLS Number: #mlsnumber#">
                  </cfif>
                </A><br>
                #dollarformat(list_price)#<br>
                <cfif bedrooms is not "">Bedroom(s): #bedrooms#  &nbsp;&nbsp;<br></cfif>
                <cfif baths_full is not "">Full Baths: #baths_full#  &nbsp;&nbsp;<br></cfif>
              </cfloop>
            </td>
          </tr>
          </table>
          <p>Comments: #comments#</p>
          <p>Existing Agent: #form.existingAgentName#</p>
          <cfif isdefined('session.ReferringSite')><p>Referring Site: #session.ReferringSite#</p></cfif>
          <cfquery datasource="#mls.dsn#" name="LastPropsViewed">
            SELECT *
            FROM cl_properties_viewed
            where clientid = <cfif isdefined('cookie.loggedin')><cfqueryparam value="#cookie.loggedin#" cfsqltype="cf_sql_numeric"><cfelse><cfqueryparam value="#GetID.TheMaxId#" cfsqltype="cf_sql_integer"></cfif>
            order by createdat desc
            limit 20
          </cfquery>
          <cfif LastPropsViewed.recordcount gt 0>
            <p>Lastest Properties Viewed</p>
            <table>
            <tr>
              <td>MLS ##</td>
              <td>Date</td>
            </tr>
            <cfloop query="LastPropsViewed">
              <tr>
                <td>
                  <a hreflang="en" href="http://#cgi.HTTP_HOST#/sales/property-details.cfm?mlsnumber=#mlsnumber#&wsid=#wsid#&mlsid=#mlsid#">#mlsnumber#</a>
                </td>
                <td>#dateformat(createdat,'mm/dd/yyyy')# #timeformat(createdat,'hh:mm tt')#</td>
              </tr>
            </cfloop>
            </table>
          </cfif>
          <cfquery datasource="#mls.dsn#" name="LastSearches">
            SELECT *
            FROM cl_saved_searches
            where clientid = <cfif isdefined('cookie.loggedin')><cfqueryparam value="#cookie.loggedin#" cfsqltype="cf_sql_numeric"><cfelse><cfqueryparam value="#GetID.TheMaxId#" cfsqltype="cf_sql_integer"></cfif>
            and searchname <> 'Tracking Purpose'
            group by searchparameters
            order by createdat desc
            limit 20
          </cfquery>
          <cfif LastSearches.recordcount gt 0>
            <p>Lastest Searches Made - Saved By Viewer</p>
            <table>
            <tr>
              <td>Search Name</td>
              <td>Date</td>
            </tr>
            <cfloop query="LastSearches">
              <tr>
                <td>
                  <a hreflang="en" href="http://#cgi.HTTP_HOST#/sales/search-results.cfm?#searchparameters#&clearsession=">#searchname#</a>
                </td>
                <td>#dateformat(createdat,'mm/dd/yyyy')# #timeformat(createdat,'hh:mm tt')#</td>
              </tr>
            </cfloop>
            </table>
          </cfif>
          <cfquery datasource="#mls.dsn#" name="LastSearches">
            SELECT *
            FROM cl_saved_searches
            where clientid = <cfif isdefined('cookie.loggedin')><cfqueryparam value="#cookie.loggedin#" cfsqltype="cf_sql_numeric"><cfelse><cfqueryparam value="#GetID.TheMaxId#" cfsqltype="cf_sql_integer"></cfif>
            and searchname = 'Tracking Purpose'
            group by searchparameters
            order by createdat desc
            limit 20
          </cfquery>
          <cfif LastSearches.recordcount gt 0>
            <p>Lastest Searches Made - Tracking</p>
            <table>
            <tr>
              <td>Search Name</td>
              <td>Date</td>
            </tr>
            <cfloop query="LastSearches">
              <tr>
                <td>
                  <a hreflang="en" href="http://#cgi.HTTP_HOST#/sales/search-results.cfm?#searchparameters#&clearsession=">#searchname#</a>
                </td>
                <td>#dateformat(createdat,'mm/dd/yyyy')# #timeformat(createdat,'hh:mm tt')#</td>
              </tr>
            </cfloop>
            </table>
          </cfif>
        <cfinclude template="/sales/emails/_footer.cfm">

		<!--this must stay for tracking-->
    <img src="http://#server_name#/sales/opened-lead-by-agent.cfm?openclientid=#TheClientID#" alt="" border="0">
    <!--this must stay for tracking-->

      </cfmail>


        <cfmail to="#form.email#" from="#AgentEmailAddress# <#cfmail.username#>" replyto="#AgentEmailAddress#"
        subject="#mls.companyname# - Property Information Request" type="HTML" server="#cfmail.server#"  username="#cfmail.username#" password="#cfmail.password#"
        port="#cfmail.port#" useSSL="#cfmail.useSSL#" cc="#cfmail.cc#" bcc="#cfmail.bcc#">
        <cfinclude template="/sales/emails/_header.cfm">
          <p>Hello #firstname#,</p>
          <p>Thank you for inquiring about a property with #mls.companyname#!  </p>



          <!---START: PROPERTY AND AGENT LAYOUT--->
          <table width="100%">
          <tr>
            <td valign="top">
              <strong>Contact Your Agent Today</strong><br>
              #GetAgentInformation.firstname# #GetAgentInformation.lastname#<br>
              <cfif GetAgentInformation.agentphoto is not ""><br><img src="http://#SERVER_NAME#/sales/images/agents/sm_#GetAgentInformation.agentphoto#" alt="" border="0"></cfif>
              <cfif GetAgentInformation.email is not ""><br><a hreflang="en" href="mailto:#GetAgentInformation.email#">#GetAgentInformation.email#</a></cfif>
              <cfif GetAgentInformation.cellphone is not ""><br>#GetAgentInformation.cellphone#</cfif>
              <cfif GetAgentInformation.phone is not ""><br>#GetAgentInformation.phone#</cfif>
            </td>
            <td valign="top">
              <strong>Property Request</strong><br>
              <cfloop query="GetListings">
                <cfinclude template="/sales/includes/image-handler.cfm">
                <cfif AddressDisplayYN is not "N"><a hreflang="en" href="http://#SERVER_NAME#/sales/property-details.cfm?mlsnumber=#mlsnumber#&mlsid=#mlsid#&wsid=#wsid#">#street_number# #street_name# <cfif LEN(unit_number)>#unit_number#</cfif></a><br></cfif><br>
                <a hreflang="en" href="http://#SERVER_NAME#/sales/property-details.cfm?mlsnumber=#mlsnumber#&mlsid=#mlsid#&wsid=#wsid#">
                  <cfif HowManyPhotos gt 0>
                    <img src="#thephoto#" width="200" border="0" alt="#mls.companyname# - MLS Number: #mlsnumber#">
                  <cfelse>
                    <img src="http://mls.icoastalnet.com/sales/images/not_avail.jpg" width="200" border="0" alt="#mls.companyname#- MLS Number: #mlsnumber#">
                  </cfif>
                </A><br>
                #dollarformat(list_price)#<br>
                <cfif bedrooms is not "">Bedroom(s): #bedrooms#  &nbsp;&nbsp;<br></cfif>
                <cfif baths_full is not "">Full Baths: #baths_full#  &nbsp;&nbsp;<br></cfif>
              </cfloop>
            </td>
          </tr>
          </table>
          <!---END: PROPERTY AND AGENT LAYOUT--->



          <p>
            Thank you,<br>
            #AgentName#<BR>
            #mls.companyname#
          </p>
        <cfinclude template="/sales/emails/_footer.cfm">
      </cfmail>
      <!---END NOTIFICATION EMAIL TO THE ADMINISTRATOR AND CUSTOMER--->



      <!---START: LOG ACTIVITY--->
      <cfquery datasource="#mls.dsn#" dbtype="ODBC">
        Insert
        Into cl_activity
          (clientid,RefferingSite,Action)
        Values
          (<cfif isdefined('cookie.loggedin')><cfqueryparam value="#cookie.loggedin#" cfsqltype="cf_sql_numeric"><cfelse><cfqueryparam value="#GetID.TheMaxId#" cfsqltype="cf_sql_integer"></cfif>,
           <cfif isdefined('session.referringsite')><cfqueryparam value="#session.referringsite#" cfsqltype="CF_SQL_LONGVARCHAR"><cfelse>'N/A'</cfif>,'Requested Property Information'
          )
      </cfquery>



      <!---START: LOG ACTIVITY--->

       <script type="text/javascript">
       $(document).ready(function()
        {
            $("#mlsModalMoreInfo").removeData();
               $("#success-moreinfo").show();
        });
       </script>

      <!---START: ON SCREEN NOTIFICATIONS--->
      <cfoutput>
        <div class="notice">
          <h3>Thank you!<br>We will be in contact very soon!<br>Close this window and continue to browser our properties!</h3>
        </div>
      </cfoutput>
      <!---END: ON SCREEN NOTIFICATIONS--->



    <cfelse>
      Spam Bot
      <cfabort>
    </cfif>
    <!---END: PROCESSING FORM--->



  <cfelse>


<script type="text/javascript">
  $(document).ready(function()
  {
   $("#success-moreinfo").show();
  });
</script>
    <!---START: FORM INPUTS--->
<!---     <cfparam name="cookie.USERFirstName" type="string" default="">
    <cfparam name="cookie.USERLastName" type="string" default="">
    <cfparam name="cookie.USEREmail" type="string" default="">
    <cfparam name="cookie.USERPhone" type="string" default="">
    <cfform action="#script_name#" method="post" class="form-horizontal" data-remote="true">
      <cfinclude template="/cfformprotect/cffp.cfm">
      <input type="hidden" name="processform" value="Request More Info">
      <div class="form-field"><label for="full_name">First Name</label><cfinput type="Text" name="firstname" value="#cookie.USERFirstName#" message="Please Enter Your First Name!" required="Yes" id="full_name"></div>
      <div class="form-field"><label for="full_name">Last Name</label><cfinput type="Text" name="lastname" value="#cookie.USERLastName#" message="Please Enter Your Last  Name!" required="Yes" id="full_name"></div>
      <div class="form-field"><label for="phone">Phone Number</label><cfinput id="phone" name="phone"  type="text" value="#cookie.USERPhone#"/></div>
      <div class="form-field"><label for="email">Email Address</label><cfinput type="Text" name="email" value="#cookie.USEREmail#" message="You Must Enter A Valid Email!" validate="email" required="Yes" id="email"></div>
      <div class="form-field large"><label for="bestcontact">Best Time to Call</label><cfinput id="bestcontact" name="bestcontact"  type="text" value=""/></div>
      <div class="form-field large"><label for="comments">Comments</label><textarea id="comments" name="comments"></textarea></div> --->
                  <cfoutput>
               <table id="mlsMoreInfoTable" width="100%">
                  <tr>
                    <td>First Name:<br><input type="Text" name="firstname" style="width:80%;" <cfif isdefined('cookie.USERFirstName')>value="#cookie.USERFirstName#"></cfif></td>
                    <td>Last Name:<br><input type="Text" name="lastname" style="width:80%;" <cfif isdefined('cookie.USERLastName')>value="#cookie.USERLastName#"></cfif></td>
                  </tr>
                  <tr>
                    <td>Phone:<br><input type="text" name="Phone" style="width:80%;" <cfif isdefined('cookie.USERPhone')>value="#cookie.USERPhone#"></cfif></td>
                    <td>Email:<br><input type="Text" name="email" style="width:80%;" <cfif isdefined('cookie.USEREmail')>value="#cookie.USEREmail#"></cfif></td>
                  </tr>
                  <tr>
                    <td colspan="2">Best Time to Call:<br><input type="text" name="bestcontact" style="width:80%;"></td>
                  </tr>
                  <tr>
                    <td colspan="2">Comments/Questions:<br><textarea name="comments" style="width:80%;height:200px;"></textarea></td>
                  </tr>
            </table>
        </cfoutput>

	   <cfif isdefined('cookie.loggedin')>

				<cfquery datasource="#mls.dsn#" name="GetAgentID">
                    SELECT *
                    FROM cl_accounts
                    where id = <cfqueryparam value="#cookie.loggedin#" cfsqltype="cf_sql_numeric">
                </cfquery>

		<cfoutput>
		<input type="hidden" name="agentid" value="#GetAgentID.agentid#">
		</cfoutput>

		<cfelseif mls.EnableRoundRobin is "Yes">
		<input type="hidden" name="agentid" value="No">
	   <!---  <div class="form-field largest" style="width:74%">
                    <cfquery datasource="#mls.dsn#" name="GetAgents">
                      SELECT *
                      FROM cl_agents
                      where roundrobin = 'Yes'
                    </cfquery>
                    <label>Are you working with an existing agent?</label>
                    <select name="agentid" style="width:100%">
                      <option value="No" SELECTED>No</option>
                      <cfoutput query="GetAgents">
                        <option value="#id#">Yes - #firstname# #lastname#</option>
                      </cfoutput>
                    </select>
		</div> --->

        <cfelse>
                    <input type="hidden" name="agentid" value="No">
        </cfif>

 <!---      <cfoutput>
        <input id="mlsNumber" name="mlsNumber" type="hidden" value="#MLSNUMBER#"/>
        <input id="mlsID" name="mlsID" type="hidden" value="#mlsid#"/>
        <input id="mlsID" name="wsid" type="hidden" value="#wsid#"/>
      </cfoutput><br>
      <cfinput type="submit" name="submit" value="Submit Inquiry" class="button">
    </cfform>--->
    <!---END: FORM INPUTS--->



  </cfif>
  <!--- </cfif> --->
</div>

<!--- <cfinclude template="/sales/lightboxes/_footer.cfm"> --->
