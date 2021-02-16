<cfif isdefined('url.display') and url.display eq "leadtracker">



<cfelseif isdefined('url.display') and url.display eq "history">

	<cfquery name="graybox" datasource="#mls.dsn#">
	select MessageBody,FromorTo,id,createdat,ContactType,privatepublic,MessageSubject,agentid,mlsnumber,BestTimeToContact
	from cl_leadtracker_response
	where clientid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#"> and privatepublic <> 'Private'
	Order by createdat DESC
	</cfquery>

<cfelseif isdefined('url.display') and url.display eq "allhistory">

	<cfquery name="graybox" datasource="#mls.dsn#">
	SELECT id,clientid,FromorTo,MessageBody,createdat,ContactType,privatepublic,agentid,mlsnumber,BestTimeToContact,MessageSubject
		FROM cl_leadtracker_response
		WHERE clientid= <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
		UNION
	SELECT id,clientid,callresult,callnotes,calldatetime,ContactType,NULL,agentid,NULL,NULL,NULL
		FROM cl_phonecalls
		WHERE clientid= <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
		ORDER BY CREATEDAT DESC
	</cfquery>

<cfelseif isdefined('url.display') and url.display eq "Phone">

	<cfquery name="graybox" datasource="#mls.dsn#">
		select *
		from cl_phonecalls
		where clientid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
		Order by calldatetime DESC
	</cfquery>


<cfelseif isdefined('url.display') and url.display eq "SavedSearches">

	<cfquery name="graybox" datasource="#mls.dsn#">
	SELECT *
	FROM cl_saved_searches
    where clientid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#"> <cfif isdefined('showallsaved') is "No">and searchname <> 'Tracking Purpose '</cfif> and searchname not like '%Agent Created%'
    order by createdat desc
	</cfquery>

<cfelseif isdefined('url.display') and url.display eq "AllSearches">

	<cfquery name="graybox" datasource="#mls.dsn#">
	SELECT *
	FROM cl_saved_searches
    where clientid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#"> and searchname like '%Tracking Purpose%' and searchname not like '%Agent Created%'
    order by createdat desc
	</cfquery>

<cfelseif isdefined('url.display') and url.display eq "Favorites">

	<cfquery name="graybox" datasource="#mls.dsn#">
		SELECT id,thedate,mlsnumber,wsid,mlsid
		FROM cl_favorites
        where clientid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
	    order by thedate desc
		<cfif isdefined('showallFavorites') is "No">limit 10;</cfif>
	</cfquery>


<cfelseif isdefined('url.display') and url.display eq "Activity">

	<cfquery name="graybox" datasource="#mls.dsn#">
		SELECT id,createdat,action,RefferingSite,mlsnumber
		FROM cl_activity
        where clientid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
	    order by createdat desc
	</cfquery>


<cfelseif isdefined('url.display') and url.display eq "notes">


	<cfif isdefined('url.deletenote')>
		<cfquery name="delnote" datasource="#mls.dsn#">
			delete from cl_leadtracker_response
			where clientid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#"> and id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.deletenote#"> and privatepublic = 'Private'
		</cfquery>
		
	</cfif>

	<cfquery name="graybox" datasource="#mls.dsn#">
		select createdat,messagebody,agentid,id,contacttype
		from cl_leadtracker_response
		where clientid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#"> and privatepublic = 'Private'
		Order by createdat DESC
	</cfquery>


<cfelseif isdefined('url.display') and url.display eq "Documents">

	<!--- START: delete ---> 
	<cfif isdefined('url.DeleteDocument')>
		<cfset uploadpath = #expandpath('/admin/contacts/clientdocs/')#>
		<cffile action="DELETE" file="#uploadpath#/#url.deletefilename#">
		<CFQUERY DATASOURCE="#mls.dsn#" NAME="delete">
			DELETE FROM cl_document_manager
			WHERE clientid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#"> and id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.DeleteDocument#">
			order by createdat desc
		</CFQUERY> 

		<cflocation url="contacts2.cfm?action=edit&id=#url.id#&display=Documents##LOC" addtoken="false">

	</cfif>
	<!--- END: delete ---> 

	<CFQUERY DATASOURCE="#mls.dsn#" NAME="graybox">
		SELECT id,createdat,documenttitle,filename
		FROM cl_document_manager
		where clientid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
		order by createdat desc
	</CFQUERY>


<cfelseif isdefined('url.display') and url.display eq "ListInfo">

	<!--- START: Update List Type  --->
	<cfif isdefined('url.ChangeType') and isdefined('url.ChangeType')>
		<CFQUERY DATASOURCE="#mls.dsn#" NAME="UpdateListing">
			Update cl_listings
			Set status = <cfqueryparam CFSQLType="cf_sql_varchar" value="#url.changetype#">
			WHERE id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.listing#"> and clientid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
		</CFQUERY>	
	</cfif>
	<!--- START: Update List Type  --->

	<CFQUERY DATASOURCE="#mls.dsn#" NAME="graybox">
		SELECT *
		FROM cl_listings
		WHERE status = 'Active' and clientid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
		order by createdat desc
	</CFQUERY>

<cfelseif isdefined('url.display') and url.display eq "PendPur">

	<!--- START: Update List Type  --->
	<cfif isdefined('url.ChangeType') and isdefined('url.ChangeType')>
		<CFQUERY DATASOURCE="#mls.dsn#" NAME="UpdateListing">
			Update cl_listings
			Set status = <cfqueryparam CFSQLType="cf_sql_varchar" value="#url.changetype#">
			WHERE id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.listing#">
		</CFQUERY>	
	</cfif>
	<!--- START: Update List Type  --->

	<CFQUERY DATASOURCE="#mls.dsn#" NAME="graybox">
		SELECT *
		FROM cl_listings
		WHERE status = 'Pending' and clientid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
		order by createdat desc
	</CFQUERY>


<cfelseif isdefined('url.display') and url.display eq "PastPur">

	<!--- START: Update List Type  --->
	<cfif isdefined('url.ChangeType') and isdefined('url.ChangeType')>
		<CFQUERY DATASOURCE="#mls.dsn#" NAME="UpdateListing">
			Update cl_listings
			Set status = <cfqueryparam CFSQLType="cf_sql_varchar" value="#url.changetype#">,
			datesold = '#dateformat(now(), 'yyyy-mm-dd')#'
			WHERE id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.listing#"> and clientid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
		</CFQUERY>	
	</cfif>
	<!--- START: Update List Type  --->

	<CFQUERY DATASOURCE="#mls.dsn#" NAME="graybox">
		SELECT *
		FROM cl_listings
		WHERE status = 'Past' and clientid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
		order by createdat desc
	</CFQUERY>	


<cfelseif isdefined('url.display') and url.display eq "SecContacts">
	
	<CFQUERY DATASOURCE="#mls.dsn#" NAME="graybox">
		SELECT id,birthday,spousefirstname,spouselastname,spouseemail,spousephone,children,facebook,twitter
		FROM cl_secondary_contacts
		where clientid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
	</CFQUERY>

<cfelseif isdefined('url.display') and url.display eq "Showing">
	
	<CFQUERY DATASOURCE="#mls.dsn#" NAME="graybox">
		  SELECT *
		  FROM cl_showings
		  where clientid = #id#
	</CFQUERY>


<cfelseif isdefined('url.display') and url.display eq "Drip">

	<CFQUERY DATASOURCE="#mls.dsn#" NAME="graybox">
		SELECT id,createdat,planname,status,lastsent,dripstartdate
		FROM drip_campaigns
        where clientid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
	    order by createdat desc	
	</CFQUERY>


<cfelseif isdefined('url.display') and url.display eq "Views">

	<CFQUERY DATASOURCE="#mls.dsn#" NAME="graybox">
		SELECT mlsnumber,mlsid,wsid,createdat
		FROM cl_properties_viewed
		WHERE clientid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
		ORDER BY createdat DESC
	</CFQUERY>

</cfif>