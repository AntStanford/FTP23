<cfif isdefined('form.clear')>
	<cfset session.FIRSTNAME = ''>
	<cfset session.LASTNAME = ''>
	<cfset session.EMAIL = ''>
	<cfset session.AGENTID = ''>
	<cfset session.RATING = ''>
	<cfset session.STARTDATE = ''>
	<cfset session.ENDDATE = ''>
	<cfset session.DATESEARCH = 'profile'>
	<cfset session.WSID  = 'any'>
	<cfset session.AREA = 'all'>
	<cfset session.PMIN = ''>
	<cfset session.PMAX = ''>
	<cfset session.BEDMIN = ''>
	<cfset session.BEDMAX = ''>
	<cfset session.BATHMIN = ''>
	<cfset session.BATHMAX = ''>
	<cfset session.AGENTKEYWORD = ''>
<!--- 	<cfset session.SAVEDSEARCH = ''> --->
	<cfset session.PURCHASES = ''>
	<cfset session.WATERTYPE = ''>
	<cfset session.joinsearch = 0>
</cfif>


<cfparam name="session.FIRSTNAME" default="">
<cfparam name="session.LASTNAME" default="">
<cfparam name="session.EMAIL" default="">
<cfparam name="session.AGENTID" default="">
<cfparam name="session.RATING" default="">
<cfparam name="session.STARTDATE" default="">
<cfparam name="session.ENDDATE" default="">
<cfparam name="session.DATESEARCH" default="profile">
<cfparam name="session.WSID" default="any">
<cfparam name="session.AREA" default="all">
<cfparam name="session.PMIN" default="">
<cfparam name="session.PMAX" default="">
<cfparam name="session.BEDMIN" default="">
<cfparam name="session.BEDMAX" default="">
<cfparam name="session.BATHMIN" default="">
<cfparam name="session.BATHMAX" default="">
<cfparam name="session.AGENTKEYWORD" default="">
<!--- <cfparam name="session.SAVEDSEARCH" default=""> --->
<cfparam name="session.PURCHASES" default="">
<cfparam name="session.WATERTYPE" default="">
<cfset session.joinsearch = 0>

<cfif cgi.request_method eq 'post' and NOT isdefined('form.clear')>
	<cfset session.FIRSTNAME = form.FIRSTNAME>
	<cfset session.LASTNAME = form.LASTNAME>
	<cfset session.EMAIL = form.EMAIL>
	<cfset session.AGENTID = form.AGENTID>
	<cfset session.RATING = form.RATING>
	<cfset session.STARTDATE = form.STARTDATE>
	<cfset session.ENDDATE = form.ENDDATE>
	<cfset session.DATESEARCH = form.DATESEARCH>
	<cfset session.WSID = form.WSID>
	<cfset session.AREA = form.AREA>
	<cfset session.PMIN = form.PMIN>
	<cfset session.PMAX = form.PMAX>
	<cfset session.BEDMIN = form.BEDMIN>
	<cfset session.BEDMAX = form.BEDMAX>
	<cfset session.BATHMIN = form.BATHMIN>
	<cfset session.BATHMAX = form.BATHMAX>
	<cfset session.AGENTKEYWORD = form.AGENTKEYWORD>
<!--- 	<cfset session.SAVEDSEARCH = form.SAVEDSEARCH> --->
	<cfset session.PURCHASES = form.PURCHASES>
	<cfset session.WATERTYPE = form.WATERTYPE>
</cfif>


<!--- Check to see if a Join query is necessary --->
<cfif session.area neq 'all' or LEN(session.bathmax) or LEN(session.bathmin) or LEN(session.bedmax) or LEN(session.bedmin) or LEN(session.pmin) or LEN(session.pmax) or LEN(session.watertype) or session.wsid neq 'any'  or session.datesearch eq 'search' and session.agentkeyword eq '' and session.purchases eq ''>
	<cfset session.joinsearch = 1>
</cfif>



<cfquery datasource="#mls.dsn#" name="getInfo">
	Select cl_accounts.firstname,cl_accounts.lastname,cl_accounts.email,cl_accounts.agentid,cl_accounts.thedate,cl_accounts.id,cl_accounts.phone,cl_accounts.rating
	<cfif session.joinsearch eq 1>,cl_saved_searches.createdat as ssdate</cfif>
	<cfif LEN(session.agentkeyword)>,cl_leadtracker_response.messagebody</cfif>
	<cfif LEN(session.purchases)>,cl_listings.address</cfif>
	From cl_accounts


		<cfif LEN(session.agentkeyword)>
			Inner Join cl_leadtracker_response on cl_accounts.id = cl_leadtracker_response.clientid

		<cfelseif LEN(session.purchases)>
			Inner Join cl_listings on cl_accounts.id = cl_listings.clientid


		<cfelseif session.joinsearch eq 1>
			Left Join cl_saved_searches on cl_accounts.id = cl_saved_searches.clientid
		</cfif>

	Where 1 = 1

	<cfif isdefined('cookie.LoggedInAgentID')>
		and cl_accounts.agentid = <cfqueryparam value="#cookie.LoggedInAgentID#" cfsqltype="cf_sql_integer">
	</cfif>


 	<cfif LEN(session.firstname)>
 		and cl_accounts.firstname LIKE <cfqueryparam value="%#session.firstname#%" cfsqltype="cf_sql_varchar">
 	</cfif>

 	<cfif LEN(session.lastname)>
 		and cl_accounts.lastname LIKE <cfqueryparam value="%#session.lastname#%" cfsqltype="cf_sql_varchar">
 	</cfif>

 	<cfif LEN(session.email)>
 		and cl_accounts.email LIKE <cfqueryparam value="%#session.email#%" cfsqltype="cf_sql_varchar">
 	</cfif>

 	<cfif LEN(session.agentid) and session.agentid neq 'all'>
 		and cl_accounts.agentid = <cfqueryparam value="#session.agentid#" cfsqltype="cf_sql_integer">
 	</cfif>

  	<cfif LEN(session.rating) and session.rating neq 'all' and session.rating neq '12'>
 		and cl_accounts.rating = <cfqueryparam value="#session.rating#" cfsqltype="cf_sql_integer">
 	</cfif>

 	<cfif session.datesearch eq 'profile' and LEN(session.startdate) and session.enddate eq ''>
 		and Date(cl_accounts.thedate) = <cfqueryparam value="#session.startdate#" cfsqltype="cf_sql_date">
  	<cfelseif session.datesearch eq 'profile' and LEN(session.startdate) and LEN(session.enddate)>
 		and Date(cl_accounts.thedate) >= <cfqueryparam value="#session.startdate#" cfsqltype="cf_sql_date">
 		and Date(cl_accounts.thedate) <= <cfqueryparam value="#session.enddate#" cfsqltype="cf_sql_date">
 	</cfif>


 	<cfif LEN(session.agentkeyword)>
 		and cl_leadtracker_response.messagebody LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#session.agentkeyword#%"> 
		and (cl_leadtracker_response.ContactType = 'Email' or cl_leadtracker_response.ContactType = 'Note')

	 	<cfif session.datesearch eq 'email' and LEN(session.startdate) and session.enddate eq ''>
	 		and Date(cl_leadtracker_response.createdat) = <cfqueryparam value="#session.startdate#" cfsqltype="cf_sql_date">
	  	<cfelseif session.datesearch eq 'email' and LEN(session.startdate) and LEN(session.enddate)>
	 		and Date(cl_leadtracker_response.createdat) >= <cfqueryparam value="#session.startdate#" cfsqltype="cf_sql_date">
	 		and Date(cl_leadtracker_response.createdat) <= <cfqueryparam value="#session.enddate#" cfsqltype="cf_sql_date">
	 	</cfif>

	<cfelseif LEN(session.purchases)>
		and cl_listings.address LIKE <cfqueryparam value="%#session.purchases#%" cfsqltype="cf_sql_varchar">
	</cfif>

	<cfif session.joinsearch eq 1>

		<cfif isdefined('session.pmin') and LEN(session.pmin)>
			and cl_saved_searches.pmin >= <cfqueryparam value="#session.pmin#" cfsqltype="cf_sql_numeric">
		</cfif>

		<cfif isdefined('session.pmax') and LEN(session.pmax)>
			and cl_saved_searches.pmax <= <cfqueryparam value="#session.pmax#" cfsqltype="cf_sql_numeric">
		</cfif>

		<cfif isdefined('session.wsid') and LEN(session.wsid) and session.wsid neq 'any'>
			and cl_saved_searches.wsid = <cfqueryparam value="#session.wsid#" cfsqltype="cf_sql_integer">
		</cfif> 

		<cfif isdefined('session.area') and LEN(session.area) and session.area neq 'all'>
			and cl_saved_searches.area in (<cfqueryparam value="#session.area#" cfsqltype="cf_sql_varchar">)
		</cfif> 

		<cfif isdefined('session.bedmin') and LEN(session.bedmin)>
			and cl_saved_searches.bedrooms >= <cfqueryparam value="#session.bedmin#" cfsqltype="cf_sql_integer">
		</cfif> 

		<cfif isdefined('session.bedmax') and LEN(session.bedmax)>
			and cl_saved_searches.bedrooms <= <cfqueryparam value="#session.bedmax#" cfsqltype="cf_sql_integer">
		</cfif>

		<cfif isdefined('session.bathmin') and LEN(session.bathmin)>
			and cl_saved_searches.baths_full >= <cfqueryparam value="#session.bathmin#" cfsqltype="cf_sql_integer">
		</cfif> 

		<cfif isdefined('session.bathmax') and LEN(session.bathmax)>
			and cl_saved_searches.baths_full <= <cfqueryparam value="#session.bathmax#" cfsqltype="cf_sql_integer">
		</cfif> 


	 	<cfif session.datesearch eq 'search' and LEN(session.startdate) and session.enddate eq ''>
	 		and Date(cl_saved_searches.createdat) = <cfqueryparam value="#session.startdate#" cfsqltype="cf_sql_date">
	  	<cfelseif session.datesearch eq 'search' and LEN(session.startdate) and LEN(session.enddate)>
	 		and Date(cl_saved_searches.createdat) >= <cfqueryparam value="#session.startdate#" cfsqltype="cf_sql_date">
	 		and Date(cl_saved_searches.createdat) <= <cfqueryparam value="#session.enddate#" cfsqltype="cf_sql_date">
	 	</cfif>

		<cfif isdefined('session.watertype') and LEN(session.watertype)>
			and cl_saved_searches.watertype = <cfqueryparam value="#session.watertype#" cfsqltype="cf_sql_varchar">
		</cfif>

		Order by ssdate desc
	<cfelse>

		Order by cl_accounts.thedate desc

	</cfif>

</cfquery>




<cfquery datasource="#mls.dsn#" name="getAgents">
	select id,firstname,lastname
	from cl_agents
	Order by firstname asc
</cfquery>

<cfquery datasource="#mls.dsn#" name="getRatings">
	select id,rating
	from cl_ratings
	Order by rating asc
</cfquery>

<cfquery name="getmlscoinfo" datasource="#dsnmls#" >
	select *
	from mlsfeeds
	where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">
</cfquery>

<cfquery datasource="#dsnmls#" NAME="getareas">
	select *
	from masterareas_cleaned
	where mlsid = <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.MLSID#">
	order by city asc
</cfquery>

<cfquery name="Watertype" datasource="#dsnmls#" >
	select distinct concat_ws(',',mastertable.waterfront_type,mastertable.water_view_type) as WaterTypes
	from mastertable
	where mlsid= <cfqueryparam cfsqltype="cf_sql_integer" value="#mls.mlsid#">
</cfquery>

<cfset TheWaterTypes = #valuelist(Watertype.WaterTypes)#>
<cfset TheWaterTypes = #listRemoveDuplicates(TheWaterTypes)#>
<cfset TheWaterTypes = #listsort(TheWaterTypes,'text','asc',',')#>

