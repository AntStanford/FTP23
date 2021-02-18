<!---START: UPDATE PROPERTY VIEWS AND PROPERTY REQUESTS WITH YOUR CLIENTID, NOW THAT WE KNOW WHO YOU ARE--->
    <cfquery name="UpdateQuery" datasource="#application.settings.dsn#">
      UPDATE cl_properties_viewed
      SET
        clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#TheClientID#">
      where TheCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFID#">
      and TheCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFTOKEN#">
    </cfquery>

    <cfquery name="UpdateQuery" datasource="#application.settings.dsn#">
      UPDATE cl_leadtracker_response
      SET
        clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#TheClientID#">
      where TheCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFID#">
      and TheCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFTOKEN#">
    </cfquery>

    <cfquery name="UpdateQuery" datasource="#application.settings.dsn#">
      UPDATE cl_saved_searches
      SET
        clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#TheClientID#">
      where TheCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFID#">
      and TheCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFTOKEN#">
    </cfquery>
    <cfquery name="UpdateQuery" datasource="#application.settings.dsn#">
      UPDATE cl_activity
      SET
        clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#TheClientID#">
      where TheCFID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFID#">
      and TheCFTOKEN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFTOKEN#">
    </cfquery>
    <!---END: UPDATE PROPERTY VIEWS WITH YOUR CLIENTID, NOW THAT WE KNOW WHO YOU ARE--->