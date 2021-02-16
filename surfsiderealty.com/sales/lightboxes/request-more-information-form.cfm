<!--- <cfinclude template="/mls/lightboxes/_header.cfm"> --->

<!--- <div id="mls-wrapper"> --->
<!---   <div align="right">
    <cfoutput><strong><a hreflang="en" href="#session.RememberMePage#" target="_parent" id="fancybox-close">X</a></strong></cfoutput>
  </div> --->
  <cfquery name="GetAddress" datasource="#DSNMLS#">
    SELECT street_number,street_name, city
    FROM mastertable
    where mlsid = <cfqueryparam cfsqltype="cf_sql_varchar" value='#mlsid#'> and wsid = <cfqueryparam cfsqltype="cf_sql_varchar" value='#wsid#'> and mlsnumber = <cfqueryparam cfsqltype="cf_sql_varchar" value='#mlsnumber#'>
  </cfquery>
  <cfoutput>
    <h2 style="line-height:31px">Request More Information <br><span>MLS ## #mlsnumber#, #GetAddress.street_number# #GetAddress.street_name#, #GetAddress.city#</span></h2>
  </cfoutput>
  <!---IF NOT LOGGED IN REDIRECT--->
  <!--- <cfif isdefined('session.LoggedIn') is "No">
    <cfparam name="mlsid" type="string">
    <cfparam name="mlsid" type="string">
    <cfparam name="mlsnumber" type="string">
    <cflocation url="/sales/lightboxes/create-account.cfm?action=#action#&wsid=#wsid#&mlsid=#mlsid#&mlsnumber=#mlsnumber#" addtoken="No">
  <cfelse> --->
  <cfset Cffp = CreateObject("component","cfformprotect.cffpVerify").init() />
  <cfif isdefined('processform')>

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
      <cfset session.USERFirstName = "#firstname#">
      <cfcookie name="USERFirstName" value="#firstname#" expires="#LoginCookiePersist#">
      <cfset session.USERLastName = "#lastname#">
      <cfcookie name="USERLastName" value="#lastname#" expires="#LoginCookiePersist#">
      <cfset session.USEREmail = "#email#">
      <cfcookie name="USEREmail" value="#email#" expires="#LoginCookiePersist#">
      <cfset session.USERPhone = "#phone#">
      <cfcookie name="USERPhone" value="#phone#" expires="#LoginCookiePersist#">



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
        <cfset AgentID = "#GetExistingAgent.id#">
        <cfset AgentEmailAddress = "#GetExistingAgent.email#">
        <cfset AgentName= "#GetExistingAgent.FirstName# #GetExistingAgent.LastName#">
      <cfelseif mls.EnableRoundRobin is "Yes">
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
        <cfset AgentName= "#GetPrimaryAgent.FirstName# #GetPrimaryAgent.LastName#">
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



        <cfmail to="#AgentEmailAddress#" from="#form.email# <#cfmail.username#>" replyto="#form.email#"
        subject="#mls.companyname# - Property Request" type="HTML" server="#cfmail.server#"  username="#cfmail.username#" password="#cfmail.password#"
        port="#cfmail.port#" useSSL="#cfmail.useSSL#" cc="#cfmail.cc#" bcc="#cfmail.bcc#">
        <cfinclude template="/sales/emails/_header.cfm">

          <p>First Name: #form.firstname#</p>
          <p>Last Name: #form.lastname#</p>
          <p>Email: #form.email#</p>
          <p>Phone: #form.phone#</p>
          <p>Best Time To Contact: #form.bestcontact#</p>
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
          <cfif isdefined('session.ReferringSite')><p>Referring Site: #session.ReferringSite#</p></cfif>
          <cfquery datasource="#mls.dsn#" name="LastPropsViewed">
            SELECT *
            FROM cl_properties_viewed
            where clientid = <cfif isdefined('cookie.loggedin')><cfqueryparam value="#cookie.LoggedIn#" cfsqltype="CF_SQL_VARCHAR"><cfelse><cfqueryparam value="#GetID.TheMaxId#" cfsqltype="CF_SQL_VARCHAR"></cfif>
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
            where clientid = <cfif isdefined('cookie.loggedin')><cfqueryparam value="#cookie.loggedin#" cfsqltype="CF_SQL_VARCHAR"><cfelse><cfqueryparam value="#GetID.TheMaxId#" cfsqltype="CF_SQL_VARCHAR"></cfif>
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
            where clientid = <cfif isdefined('cookie.loggedin')><cfqueryparam value="#cookie.loggedin#" cfsqltype="CF_SQL_VARCHAR"><cfelse><cfqueryparam value="#GetID.TheMaxId#" cfsqltype="CF_SQL_VARCHAR"></cfif>
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
          (<cfif isdefined('cookie.loggedin')><cfqueryparam value="#cookie.loggedin#" cfsqltype="CF_SQL_VARCHAR"><cfelse><cfqueryparam value="#GetID.TheMaxId#" cfsqltype="CF_SQL_VARCHAR"></cfif>,
           <cfif isdefined('session.referringsite')><cfqueryparam value="#session.referringsite#" cfsqltype="CF_SQL_LONGVARCHAR"><cfelse>'N/A'</cfif>,'Requested Property Information'
          )
      </cfquery>



      <!---START: LOG ACTIVITY--->



      <!---START: ON SCREEN NOTIFICATIONS--->
      <cfoutput>
        <div class="notice"><a name="success">
          <h3>Thank you!<br>We will be in contact very soon!</h3>
        </div>
      </cfoutput>
      <!---END: ON SCREEN NOTIFICATIONS--->



    <cfelse>
      Spam Bot
      <cfabort>
    </cfif>
    <!---END: PROCESSING FORM--->



  <cfelse>



    <!---START: FORM INPUTS--->
    <cfparam name="cookie.USERFirstName" type="string" default="">
    <cfparam name="cookie.USERLastName" type="string" default="">
    <cfparam name="cookie.USEREmail" type="string" default="">
    <cfparam name="cookie.USERPhone" type="string" default="">
    <cfform action="#script_name###success" method="post" class="form-horizontal" <!---data-remote="true"--->>
      <cfinclude template="/cfformprotect/cffp.cfm">
      <input type="hidden" name="processform" value="Request More Info">
      <div class="form-field"><label for="first_name">First Name</label><cfinput type="Text" name="firstname" value="#cookie.USERFirstName#" message="Please Enter Your First Name!" required="Yes" id="first_name"></div>
      <div class="form-field"><label for="last_name">Last Name</label><cfinput type="Text" name="lastname" value="#cookie.USERLastName#" message="Please Enter Your Last  Name!" required="Yes" id="last_name"></div>
      <div class="form-field"><label for="phone">Phone Number</label><cfinput type="Text" name="phone" value="#cookie.USERPhone#" message="You must enter a valid phone number!" required="Yes" id="phone"></div>
      <div class="form-field"><label for="email">Email Address</label><cfinput type="Text" name="email" value="#cookie.USEREmail#" message="You Must Enter A Valid Email!" validate="email" required="Yes" id="email"></div>
      <div class="form-field large"><label for="bestcontact">Best Time to Call</label><cfinput id="bestcontact" name="bestcontact"  type="text" value=""/></div>
      <div class="form-field large"><label for="comments">Comments</label><textarea id="comments" name="comments"></textarea></div>

	   <cfif isdefined('cookie.loggedin')>

				<cfquery datasource="#mls.dsn#" name="GetAgentID">
                    SELECT *
                    FROM cl_accounts
                    where id = <cfqueryparam value="#cookie.loggedin#" cfsqltype="CF_SQL_VARCHAR">
                </cfquery>

		<cfoutput>
		<input type="hidden" name="agentid" value="#GetAgentID.agentid#">
		</cfoutput>

		<cfelseif mls.EnableRoundRobin is "Yes">

		<input type="hidden" name="agentid" value="No">


<!--- 	    <div class="form-field largest" style="width:74%">
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

      <cfoutput>
        <input id="mlsNumberRequestInfo" name="mlsNumber" type="hidden" value="#MLSNUMBER#"/>
        <input id="mlsIDRequestInfo" name="mlsID" type="hidden" value="#mlsid#"/>
        <input id="wsIDRequestInfo" name="wsid" type="hidden" value="#wsid#"/>
      </cfoutput>
      <div class="form-field">
        <div id="requestinfocaptcha"></div><br />
        <div class="g-recaptcha-error"></div>
      </div>
      <cfinput type="submit" name="submit" value="Submit Inquiry" class="button" style="position:relative;top:0;" onClick="ga('send', 'event', { eventCategory: 'lead', eventAction: 'submitted', eventLabel: 'real-estate-request-more-info'});">
      <br><br><br><br><br>
    </cfform>
    <!---END: FORM INPUTS--->



  </cfif>
  <!--- </cfif> --->
<!--- </div> --->

<!--- <cfinclude template="/sales/lightboxes/_footer.cfm"> --->
