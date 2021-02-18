<cfif StructKeyExists(form,'siteSettingsSubmit') AND form.siteSettingsSubmit EQ 1>

  <cfif request.appConfigData.PMS NEQ "None">
		<!--- Inserts into Booking_Clients.Clients table --->
    <cfquery name="qryCreateClient" datasource="booking_clients">
    INSERT INTO clients (customer, 
                         website, 
                         pms,
                         dsn,
                         sitedir,
												 <cfif request.appConfigData.PMS EQ "365 villas">
                           account,
                           scriptsVersion,
                         <cfelseif request.appConfigData.PMS EQ "Barefoot">
                           username, 
                           password, 
                           account, 
                           rezTypeId, 
                           scriptsVersion, 
                           barefootSoapURL,
                         <cfelseif request.appConfigData.PMS EQ "Ciirus">
                           username, 
                           password, 
                           scriptsVersion,
                         <cfelseif request.appConfigData.PMS EQ "Escapia">
                           username, 
                           password, 
                           StateCodeList,
                           scriptsVersion, 
                         <cfelseif request.appConfigData.PMS EQ "Homeaway">
                           strCOID,
                           v12Client,
                           strUserID,
                           strPassword,
                           hapiTokenClientID,
                           hapiTokenApiKey,
                           hapiTokenURL,
                           ppDownloadLatLongFromAPI,
                         <cfelseif request.appConfigData.PMS EQ "Homhero">
                           username, 
                           password, 
                           account, 
                           scriptsVersion, 
                         <cfelseif request.appConfigData.PMS EQ "Real Time Rentals">
                           rtr_key,
                           scriptsVersion, 
                         <cfelseif request.appConfigData.PMS EQ "RMS">
                           username, 
                           password, 
                           scriptsVersion, 
                         <cfelseif request.appConfigData.PMS EQ "RNS">
                           rnsEndpoint,
                           rnsAccessKey,
                           rnsCompanyID,
                           scriptsVersion,
                         <cfelseif request.appConfigData.PMS EQ "Streamline">
                           streamlineTokenKey,
                           streamlineTokenSecret,
                           streamlineTokenExpDate,
                           streamlineEndPoint,
                         <cfelseif request.appConfigData.PMS EQ "Track">
                           username, 
                           password, 
                           track_api_endpoint,
                           scriptsVersion,
                         <cfelseif request.appConfigData.PMS EQ "Vreasy">
                           vreasy_client_api_key,
                           vreasy_client_user_id,
                           vreasy_parse_email,
                           vreasy_client_listor_id,
                           vreasy_client_account_id,
                           vreasy_api_url,
                           vreasy_icnd_master_api_key,
                           vreasy_pci_proxy_code,
                           vreasy_pci_proxy_url,
                           scriptsVersion,
                         <cfelseif request.appConfigData.PMS EQ "VRM">
                           vrmEndPoint,
                           vrmImagePath,
                           vrmAPIKey,
                           vrmXMLNS,
                           scriptsVersion,
                         </cfif>
                         environment, 
                         status)
    VALUES (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.companyName#">,
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.prodURL#">,
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#request.appConfigData.PMS#">,
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#request.appConfigData.clientsDSN#">,
            <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#request.appConfigData.clientsDSN#">,
						<cfif request.appConfigData.PMS EQ "365 villas">
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.365VillasAPIAccountNumber#">,
              'v1', 
            <cfelseif request.appConfigData.PMS EQ "Barefoot">
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.barefootApiUsername#">, 
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.barefootApiPassword#">, 
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.barefootApiAccountNumber#">, 
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.barefootApiRezTypeId#">, 
              'v4', 
              'https://portals.barefoot.com/barefootwebservice/BarefootService.asmx',
            <cfelseif request.appConfigData.PMS EQ "Ciirus">
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.ciirusApiUsername#">, 
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.ciirusApiPassword#">, 
              'v1', 
            <cfelseif request.appConfigData.PMS EQ "Escapia">
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.escapiaApiUsername#">, 
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.escapiaApiPassword#">, 
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.escapiaClientState#">, 
              'v4', 
            <cfelseif request.appConfigData.PMS EQ "Homeaway">
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.homeawayCOID#">,
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.homeawayV12#">,
              'Icoastal',
              'ICNd2896',
              'c6aa16c0-41fb-4ab3-b300-50f6c9d6e889',
              '0393fd9e12af45e5b14196750e29063c',
              'https://payments.homeaway.com'
              'Yes',
            <cfelseif request.appConfigData.PMS EQ "Homhero">
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.homheroApiUsername#">, 
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.homheroApiPassword#">, 
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.homheroApiAccountNumber#">, 
              'v1', 
            <cfelseif request.appConfigData.PMS EQ "Real Time Rentals">
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.rtrAPIKey#">,
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.rtrScriptsVersion#">, 
            <cfelseif request.appConfigData.PMS EQ "RMS">
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.rmsApiUsername#">, 
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.rmsApiPassword#">, 
              'v1', 
            <cfelseif request.appConfigData.PMS EQ "RNS">
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.rnsEndPoint#">,
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.rnsAccessKey#">,
              <cfqueryparam CFSQLType="cf_sql_integer" value="#form.rnsCompanyID#">,
              'v1', 
            <cfelseif request.appConfigData.PMS EQ "Streamline">
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.streamlineTokenKey#">,
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.streamlineTokenSecret#">,
              <cfqueryparam CFSQLType="cf_sql_date" value="#form.streamlinetokenExpDate#">,
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.streamlineEndPoint#">,
            <cfelseif request.appConfigData.PMS EQ "Track">
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.trackApiUsername#">, 
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.trackApiPassword#">, 
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.trackApiEndPoint#">,
              'v1', 
            <cfelseif request.appConfigData.PMS EQ "Vreasy">
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.vreasyApiKey#">,
              <cfqueryparam CFSQLType="cf_sql_integer" value="#form.vreasyApiUserID#">,
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.vreasyParseEmail#">,
              426,
              10228,
              'https://api.vreasy.com',
              '755znysyv4ow88g4k44wk8gwggsc8okw0wcg0',
              'f0621bd59cab9abc',
              'https://api.pci-proxy.com/v1/push',
              'v1', 
            <cfelseif request.appConfigData.PMS EQ "VRM">
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.vrmEndPoint#">,
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.vrmImagePath#">,
              <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.vrmAPIKey#">,
              'http://24.199.244.121/VRMWebServiceOSDev/OLB',
              'v3', 
            </cfif>
            'Dev',
            'On')
    </cfquery>
    <cfquery name="qryFindID" datasource="booking_clients">
    SELECT id
    FROM clients
    WHERE dsn = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#request.appConfigData.clientsDSN#">
    ORDER BY id DESC
    LIMIT 1
    </cfquery>
  </cfif>
  
	<!--- Inserts into Booking_Clients.Settings table --->
  <cfquery name="qryCreateSetting" datasource="booking_clients">
  INSERT INTO settings (company,
                        dsn,
                        devURL,
                        devEmail,
                        website,
                        wp_dsn,
                        google_recaptcha_sitekey,
                        google_recaptcha_secretkey,
                        <cfif request.appConfigData.PMS NEQ "None">clientID,</cfif>
                        cfmailUsername,
                        cfmailPassword,
                        cfmailServer,
                        cfmailPort,
                        cfmailSSL,
                        mailgunAPIDomain,
                        mailgunAPIKey,
                        prefooter_left,
                        prefooter_right,
                        city,
                        state,
                        tollFree,
                        phone)
  VALUES (<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.companyName#">,
          <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#request.appConfigData.settingsDSN#">,
          <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.devURL#">,
          <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.devEmail#">,
          <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.prodURL#">,
          <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.wpBlogDSN#">,
          <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.googleReCaptchaSiteKey#">,
          <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#form.googleReCaptchaSecretKey#">,
          <cfif request.appConfigData.PMS NEQ "None"><cfqueryparam CFSQLType="cf_sql_integer" value="#qryFindID.id#">,</cfif>
          'icndtestaccount@rs10928.mailgun.org',
          'PASS4321word!',
          'smtp.mailgun.org',
          '465',
          'true',
          'mg.icoastalnet.com',
          '5zw1zgrvuu54wi8bvvumr9kt9zarh4a6',
          'lc_testimony',
          'rc_event',
          'Ocean Isle Beach',
          'NC',
          '1-800-555-5555',
          '910-575-6095')
  </cfquery>

	<!--- Creates PMS tables --->
	<cfif request.appConfigData.PMS EQ "365 villas">
  	<cfinclude template="/cfformprotect/appConfig/tableSetup/365villas.cfm">
	<cfelseif request.appConfigData.PMS EQ "Barefoot">
  	<cfinclude template="/cfformprotect/appConfig/tableSetup/barefoot.cfm">
	<cfelseif request.appConfigData.PMS EQ "Ciirus">
  	<cfinclude template="/cfformprotect/appConfig/tableSetup/ciirus.cfm">
	<cfelseif request.appConfigData.PMS EQ "Escapia">
  	<cfinclude template="/cfformprotect/appConfig/tableSetup/escapia.cfm">
	<cfelseif request.appConfigData.PMS EQ "Homeaway">
  	<cfinclude template="/cfformprotect/appConfig/tableSetup/homeaway.cfm">
	<cfelseif request.appConfigData.PMS EQ "Homhero">
  	<cfinclude template="/cfformprotect/appConfig/tableSetup/homhero.cfm">
	<cfelseif request.appConfigData.PMS EQ "ICND">
  	<cfinclude template="/cfformprotect/appConfig/tableSetup/icnd.cfm">
	<cfelseif request.appConfigData.PMS EQ "Real Time Rentals">
  	<cfinclude template="/cfformprotect/appConfig/tableSetup/rtr.cfm">
	<cfelseif request.appConfigData.PMS EQ "RMS">
  	<cfinclude template="/cfformprotect/appConfig/tableSetup/rms.cfm">
	<cfelseif request.appConfigData.PMS EQ "RNS">
  	<cfinclude template="/cfformprotect/appConfig/tableSetup/rns.cfm">
	<cfelseif request.appConfigData.PMS EQ "Streamline">
  	<cfinclude template="/cfformprotect/appConfig/tableSetup/streamline.cfm">
	<cfelseif request.appConfigData.PMS EQ "Track">
  	<cfinclude template="/cfformprotect/appConfig/tableSetup/track.cfm">
	<cfelseif request.appConfigData.PMS EQ "Vreasy">
  	<cfinclude template="/cfformprotect/appConfig/tableSetup/vreasy.cfm">
	<cfelseif request.appConfigData.PMS EQ "VRM">
  	<cfinclude template="/cfformprotect/appConfig/tableSetup/vrm.cfm">
  </cfif>

</cfif>