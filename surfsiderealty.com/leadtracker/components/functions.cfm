<cfif isdefined('ID')>
  <cfquery datasource="#mls.dsn#" name="AllResponses">
    SELECT id,createdat,ContactType,clientid
    FROM cl_leadtracker_response
    WHERE clientid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
    Order By createdat DESC
  </cfquery>
</cfif>



<!--- For Agent Note --->
<cffunction name="GetLastNote" returntype="string" output="true">

	<cfargument name="id" type="numeric" required="true">

	<cfquery datasource="#mls.dsn#" name="thenote">
		select createdat,messagebody,agentid,id
		from cl_leadtracker_response
		where clientid = #id# and privatepublic = 'Private' and messagesubject = 'Note Posted'
		Order by createdat DESC
		LIMIT 1
	</cfquery>	

	<cfset lastnote = thenote.messagebody>

	<cfreturn lastnote>

</cffunction>

<!--- For Agent Note --->
<cffunction name="GetLastNoteDate" returntype="string" output="true">

	<cfargument name="id" type="numeric" required="true">

	<cfquery datasource="#mls.dsn#" name="thenotedate">
		select createdat
		from cl_leadtracker_response
		where clientid = #id# and privatepublic = 'Private' and messagesubject = 'Note Posted'
		Order by createdat DESC
		LIMIT 1
	</cfquery>	

	<cfset lastnotedate = thenotedate.createdat>

	<cfreturn lastnotedate>

</cffunction>

<!--- For Favorites --->
<cffunction name="GetFavs" returntype="string" output="true">

	<cfargument name="id" type="numeric" required="true">

	<cfquery datasource="#mls.dsn#" name="theFcount" cachedwithin="#CreateTimeSpan(0, 0, 5, 0)#">
		select Count(mlsnumber) as mlscounts
		from cl_favorites
		where clientid = #id#
	</cfquery>	

	<cfset numberoffavorites = #theFcount.mlscounts#>

	<cfreturn numberoffavorites>

</cffunction>




<!--- For Saved Searches --->
<cffunction name="GetSaves" returntype="string" output="true">

	<cfargument name="id" type="numeric" required="true">

	<cfquery datasource="#mls.dsn#" name="theSScount" cachedwithin="#CreateTimeSpan(0, 0, 3, 0)#">
		SELECT Count(clientid) as resultcount
		FROM cl_saved_searches
	    where clientid = '#id#' and searchname <> 'Tracking Purpose ' and searchname not like '%Agent Created%'
	    order by createdat desc
	</cfquery>	

	<cfset numberoffavorites = #theSScount.resultcount#>

	<cfreturn numberoffavorites>

</cffunction>


<!--- For Saved Searches --->
<cffunction name="GetEAlerts" returntype="string" output="true">

	<cfargument name="id" type="numeric" required="true">

	<cfquery datasource="#mls.dsn#" name="theSSAcount" cachedwithin="#CreateTimeSpan(0, 0, 3, 0)#">
		SELECT Count(id) as resultcount
		FROM cl_saved_searches
	    where clientid = '#id#' and howoften <> '' and howoften <> '0'
	    order by createdat desc
	</cfquery>	

	<cfset numofalerts = #theSSAcount.resultcount#>

	<cfreturn numofalerts>

</cffunction>



<!--- For Contacts Name --->
<cffunction name="GetClientName" returntype="string" output="true">

	<cfargument name="id" type="numeric" required="true">

	<cfquery datasource="#mls.dsn#" name="theFcount" cachedwithin="#CreateTimeSpan(0, 0, 10, 0)#">
		select firstname,lastname
		from cl_accounts
		where id = #id#
	</cfquery>	

	<cfset thisclientname = "#theFcount.firstname# #theFcount.lastname#">

	<cfreturn thisclientname>

</cffunction>

<!--- For test Name --->
<cffunction name="GetAgentName" returntype="string" output="true">

	<cfargument name="id" type="numeric" required="true">

	<cfquery datasource="#mls.dsn#" name="theagentname" cachedwithin="#CreateTimeSpan(0, 1, 0, 0)#">
		select firstname,lastname
		from cl_agents
		where id = #id#
	</cfquery>	

	<cfif theagentname.recordcount eq 0>

	<cfquery datasource="#mls.dsn#" name="theadminname" cachedwithin="#CreateTimeSpan(0, 0, 5, 0)#">
		select name
		from cl_passwords
		where id = #id#
	</cfquery>	
		<cfset thisagentname = "#theadminname.name#">
	<cfelse>
		<cfset thisagentname = "#theagentname.firstname# #theagentname.lastname#">
	</cfif>

	<cfreturn thisagentname>

</cffunction>



<!--- Get Logins --->
<cffunction name="GetLogins" returntype="string" output="true">

	<cfargument name="id" type="numeric" required="true">

	<cfquery datasource="#mls.dsn#" name="theLcount">
		select Count(login) as resultcount
		from cl_logins
		where id = #id#
	</cfquery>	

	<cfset numberoflogins = #theLcount.resultcount#>

	<cfreturn numberoflogins>

</cffunction>


<!--- Get Last Login --->
<cffunction name="GetLastLogin" returntype="any" output="true">

	<cfargument name="id" type="numeric" required="true">

	<cfquery datasource="#mls.dsn#" name="getlogin" cachedwithin="#CreateTimeSpan(0, 0, 5, 0)#">
		select createdat
		from cl_activity
		where clientid = #id# and action = 'login'
		Order By Createdat DESC
		limit 1
	</cfquery>	

	<cfset thelastlogin = "#dateformat(getlogin.createdat, 'mm/dd/yy')# #timeformat(getlogin.createdat, 'h:mm:ss tt')#">

	<cfif getlogin.recordcount eq 0>
		<cfquery datasource="#mls.dsn#" name="getAcctCreation" cachedwithin="#CreateTimeSpan(0, 0, 5, 0)#">
			select createdat
			from cl_activity
			where clientid = #id# and action = 'Create Account'
			Order By Createdat DESC
			limit 1
		</cfquery>	

		<cfset thelastlogin = "#dateformat(getAcctCreation.createdat, 'mm/dd/yy')# #timeformat(getAcctCreation.createdat, 'h:mm:ss tt')#">
	</cfif>

	<cfquery datasource="#mls.dsn#" name="getlogin2" cachedwithin="#CreateTimeSpan(0, 0, 5, 0)#">
		select login
		from cl_logins
		where clientid = #id#
		Order By login DESC
		limit 1
	</cfquery>	

	<cfif getlogin2.login GT thelastlogin>
		<cfset thelogin = "#dateformat(getlogin2.login, 'mm/dd/yy')# #timeformat(getlogin2.login, 'h:mm:ss tt')#">
	<cfelse>
		<cfset thelogin = thelastlogin>
	</cfif>

	<cfreturn thelogin>

</cffunction>


<!--- Get Last Login --->
<cffunction name="GetLastAction" returntype="any" output="true">

	<cfargument name="id" type="numeric" required="true">
	<cfargument name="thedate" type="date" required="true">

	<cfquery datasource="#mls.dsn#" name="getaction">
		select ACTION
		from cl_activity
		where clientid = '#id#' and createdat > '#thedate#'
		ORDER BY createdat DESC
		LIMIT 1
	</cfquery>	

	<cfset thelastlaction = #getaction.action#>

	<cfreturn thelastlaction>

</cffunction>


<!--- Get Last Activity --->
<cffunction name="GetLastActivity" returntype="any" output="true">

	<cfargument name="id" type="numeric" required="true">

	<cfquery datasource="#mls.dsn#" name="getaction">
		select ACTION
		from cl_activity
		where clientid = '#id#'
		ORDER BY createdat ASC
		LIMIT 1
	</cfquery>	

	<cfset thelastlaction = #getaction.action#>

	<cfreturn thelastlaction>

</cffunction>


<!--- Get Number of Calls --->
<cffunction name="GetCalls" returntype="string" output="true">

	<cfargument name="clientid" type="numeric" required="true">

	<cfquery datasource="#mls.dsn#" name="callcount">
		select Count(id) as resultcount
		from cl_phonecalls
		where clientid = #clientid#
	</cfquery>	

	<cfset numberofcalls = #callcount.resultcount#>

	<cfreturn numberofcalls>

</cffunction>

<!--- Get Number of Answered Calls --->
<cffunction name="GetAnsweredCalls" returntype="string" output="true">

	<cfargument name="clientid" type="numeric" required="true">

	<cfquery datasource="#mls.dsn#" name="answeredcount">
		select Count(id) as resultcount
		from cl_phonecalls
		where clientid = #clientid# and callresult = 'Answered'
	</cfquery>	

	<cfset numberofanswered = #answeredcount.resultcount#>

	<cfreturn numberofanswered>

</cffunction>

<!--- Get Phone Validation --->
<cffunction name="GetPhoneValidation" returntype="string" output="true">

	<cfargument name="phonenumber" type="any" required="true">

	<cfquery datasource="#mls.dsn#" name="phonever">
		select verified
		from phone_verification
		where phonenumber = <cfqueryparam value="#phonenumber#" cfsqltype="cf_sql_varchar">
		Order by ID DESC
	</cfquery>	

	<cfset callverification = #phonever.verified#>

	<cfreturn callverification>

</cffunction>


<!--- Get Phone Data --->
<cffunction name="GetPhoneData" returntype="string" output="true">

	<cfargument name="phonenumber" type="any" required="true">

	<cfquery datasource="#mls.dsn#" name="numdata">
		select numberdata
		from phone_verification
		where phonenumber = <cfqueryparam value="#phonenumber#" cfsqltype="cf_sql_varchar">
	</cfquery>	

	<cfset phonedata = #numdata.numberdata#>

	<cfreturn phonedata>

</cffunction>


<!--- Get Viewed Property --->
<cffunction name="GetLastProperty" returntype="any" output="true">

	<cfargument name="id" type="numeric" required="true">

	<cfquery datasource="#mls.dsn#" name="LastProperty">
		SELECT mlsnumber,mlsid
		FROM cl_properties_viewed
		WHERE clientid = '#id#' 
		ORDER BY createdat DESC
		LIMIT 1
	</cfquery>	

	<cfset lastproperty = "#LastProperty.mlsnumber#,#LastProperty.mlsid#">

	<cfreturn lastproperty>

</cffunction>

<!--- Get All Viewed Properties --->
<cffunction name="GetAllProperties" returntype="any" output="true">

	<cfargument name="id" type="numeric" required="true">

	<cfquery datasource="#mls.dsn#" name="LastProperty" cachedwithin="#CreateTimeSpan(0, 0, 5, 0)#">
		SELECT mlsnumber,mlsid
		FROM cl_properties_viewed
		WHERE clientid = '#id#' 
		ORDER BY createdat DESC
	</cfquery>	

	<cfset LastPropertycount = "#LastProperty.recordcount#">

	<cfreturn LastPropertycount>

</cffunction>


<!--- Get Mean of Saved Searches --->
<cffunction name="GetSSMean" returntype="any" output="true">

	<cfargument name="id" type="numeric" required="true">

	<cfquery datasource="#mls.dsn#" name="CountSearches" cachedwithin="#CreateTimeSpan(0, 0, 5, 0)#">
		SELECT pmax
		FROM cl_saved_searches
		WHERE clientid = '#id#' and PMIN <> '0' and PMAX < '99999999'
		ORDER BY createdat DESC
	</cfquery>	

	<cfquery datasource="#mls.dsn#" name="SearchesSum" cachedwithin="#CreateTimeSpan(0, 0, 5, 0)#">
		SELECT SUM(pmax) as pmaxtotal
		FROM cl_saved_searches
		WHERE clientid = '#id#' and PMIN <> '0' and PMAX < '99999999'
		ORDER BY createdat DESC
	</cfquery>	

<cfif CountSearches.recordcount neq 0 and isdefined('SearchesSum.pmaxtotal')>
	<cfset returnSSmean = (SearchesSum.pmaxtotal / CountSearches.recordcount)>
<cfelse>
	<cfset returnSSmean = 0>
</cfif>

	<cfreturn returnSSmean>

</cffunction>


<!--- Get Mean of Saved Searches --->
<cffunction name="GetSSMinMax" returntype="any" output="true">

	<cfargument name="id" type="numeric" required="true">

	<cfset themin ="No Min">
	<cfset themax ="No Max">

	<cfquery datasource="#mls.dsn#" name="CountMin" cachedwithin="#CreateTimeSpan(0, 0, 5, 0)#">
		SELECT pmin
		FROM cl_saved_searches
		WHERE clientid = '#id#' and PMIN <> '' and PMIN > '0'
		ORDER BY pmin ASC
		limit 1
	</cfquery>	

	<cfquery datasource="#mls.dsn#" name="CountMax" cachedwithin="#CreateTimeSpan(0, 0, 5, 0)#">
		SELECT pmax
		FROM cl_saved_searches
		WHERE clientid = '#id#' and PMAX <> '' and PMAX < '99999999'
		ORDER BY pmax DESC
		limit 1
	</cfquery>	

	<cfif CountMin.recordcount eq 1><cfset themin = dollarformat(CountMin.pmin)></cfif>
	<cfif CountMax.recordcount eq 1><cfset themax = dollarformat(CountMax.pmax)></cfif>

	<cfset returnMinMax = themin & ' - ' & themax>

	<cfreturn returnMinMax>

</cffunction>



<!--- Get Property INFO --->
<cffunction name="GetPropertyInfo" returntype="any" output="true">

	<cfargument name="mlsnumber" type="numeric" required="true">
	<cfargument name="mlsid" type="numeric" required="true">

	<cfquery datasource="#dsnmls#" name="propdetail">
		SELECT list_price,area,subdivision 
		FROM mastertable
		WHERE mlsnumber = '#mlsnumber#' and mlsid = #mlsid#
		LIMIT 1
	</cfquery>	

	<cfset propdetail = "#propdetail.list_price#,#propdetail.area#,#propdetail.subdivision#">

	<cfreturn propdetail>

</cffunction>

<!--- Get Saved Searches --->
<cffunction name="GetSearches" returntype="string" output="true">

	<cfargument name="id" type="numeric" required="true">

	<cfquery datasource="#mls.dsn#" name="savedsearches" cachedwithin="#CreateTimeSpan(0, 0, 3, 0)#">
		select Count(searchname) as resultcount
		from cl_saved_searches
		where clientid = #id#
	</cfquery>	

	<cfset numberofsearches = #savedsearches.resultcount#>

	<cfreturn numberofsearches>

</cffunction>


<!--- Format Phone Numbers --->
<cffunction name="FormatPhone" returntype="string" output="true">

	<cfargument name="phone" type="any" required="true">

	<cfset formatthis = rereplace(phone,'\)|\(|\.| |-','','ALL')>

	<cfif LEN(formatthis) eq 10>
		<cfset areacode = left(formatthis, 3)>
		<cfset firstthree = mid(formatthis, 4, 3)>
		<cfset lastfour = right(formatthis, 4)>
		<cfset returnphonenumber = '(' & areacode & ')' & ' ' & firstthree & '-' & lastfour>
	<cfelseif LEN(formatthis) eq 7>
		<cfset firstthree = left(formatthis, 3)>
		<cfset lastfour = right(formatthis, 4)>
		<cfset returnphonenumber = firstthree & '-' & lastfour>
	<cfelseif LEN(formatthis) eq 11>
		<cfset firstdigit = left(formatthis, 1)>
		<cfset areacode = mid(formatthis, 2, 3)>
		<cfset firstthree = mid(formatthis, 5, 3)>
		<cfset lastfour = right(formatthis, 4)>
		<cfset returnphonenumber = firstdigit & ' ' & '(' & areacode & ')' & ' ' & firstthree & '-' & lastfour>
	<cfelse>
		<cfset returnphonenumber = formatthis>
	</cfif>

	<cfreturn returnphonenumber>

</cffunction>

<!--- Return Phone Validation CSS Class --->
<cffunction name="getPhoneClass" returntype="string" output="true">
	<cfargument name="phoneValidate" type="any" required="true">
		<cfif phoneValidate eq 5>
			<cfset phoneClass = "phone-talking">
		<cfelseif phoneValidate eq 6>
			<cfset phoneClass = "phone-valid">
		<cfelseif phoneValidate eq 7>
			<cfset phoneClass = "phone-donotcall">
		<cfelseif phoneValidate eq 3>
			<cfset phoneClass = "phone-wrong">
		<cfelse>
			<cfset phoneClass = "phone-unknown">
		</cfif>
	<cfreturn phoneClass>
</cffunction>

<!--- Get Emails --->
<cffunction name="GetEmails" returntype="string" output="true">

	<cfargument name="id" type="numeric" required="true">

	<cfquery datasource="#mls.dsn#" name="emailsto" cachedwithin="#CreateTimeSpan(0, 0, 3, 0)#">
		select Count(id) as resultcount
		from cl_leadtracker_response
		where clientid = '#id#' and FromOrTo = <cfqueryparam cfsqltype="cf_sql_varchar" value="Waiting on Agent's Response"> and PrivatePublic = 'Public'
	</cfquery>	

	<cfset numberofemails = #emailsto.resultcount#>

	<cfreturn numberofemails>

</cffunction>

<!--- Get Number of Visits --->
<!--- <cffunction name="GetVisits" returntype="string" output="true">

	<cfargument name="id" type="numeric" required="true">

	<cfquery datasource="#mls.dsn#" name="getlogins">
		select Count(login) as logincount
		from cl_logins
		where clientid = #id#
	</cfquery>	

	<cfset numberofvisits = #getlogins.logincount#>

	<cfreturn numberofvisits>

</cffunction> --->
<cffunction name="GetVisits" returntype="string" output="true">

	<cfargument name="id" type="numeric" required="true">

	<cfquery datasource="#mls.dsn#" name="getlogins">
		select count(cl_activity.createdat) as activitycount
		from cl_activity 
		where cl_activity.clientid = #id#
		and (cl_activity.action = 'login' or cl_activity.action = 'Create Account')
		UNION
		select Count(login) as activitycount
		from cl_logins
		where cl_logins.clientid = #id#
	</cfquery>	

	<cfset actlogcount = 0>

	<cfloop query="getlogins">
		<cfset actlogcount = actlogcount + activitycount>
	</cfloop>
 
	<cfset numberofvisits = #actlogcount#>

	<cfreturn numberofvisits>

</cffunction>



<!--- Get Sub Section Title  --->
<cffunction name="GetSubSection" returntype="string" output="true">

	<cfargument name="abbr" type="any" required="true">

	<cfswitch expression="#abbr#">
		<cfcase value="LeadTracker">
			<cfset SubSection = "Compose An Email">
		</cfcase>
		<cfcase value="Notes">
			<cfset SubSection = "Notes">
		</cfcase>
		<cfcase value="History">
			<cfset SubSection = "Emails">
		</cfcase>
		<cfcase value="Insight">
			<cfset SubSection = "Insight">
		</cfcase>
		<cfcase value="PastPur">
			<cfset SubSection = "Past Purchases">
		</cfcase>
		<cfcase value="PendPur">
			<cfset SubSection = "Pending Purchases">
		</cfcase>
		<cfcase value="ListInfo">
			<cfset SubSection = "Listing Information">
		</cfcase>
		<cfcase value="SecContacts">
			<cfset SubSection = "Secondary Contacts">
		</cfcase>
		<cfcase value="Documents">
			<cfset SubSection = "Documents">
		</cfcase>
<!--- Insight dropdown --->
		<cfcase value="Favorites">
			<cfset SubSection = "Favorites">
		</cfcase>
		<cfcase value="SavedSearches">
			<cfset SubSection = "SavedSearches">
		</cfcase>
		<cfcase value="AllSearches">
			<cfset SubSection = "All Searches">
		</cfcase>
		<cfcase value="Activity">
			<cfset SubSection = "Activity">
		</cfcase>
		<cfcase value="Drip">
			<cfset SubSection = "Drip">
		</cfcase>
		<cfcase value="Bulk">
			<cfset SubSection = "Bulk">
		</cfcase>
		<cfcase value="Views">
			<cfset SubSection = "Views">
		</cfcase>
		<cfcase value="Showing">
			<cfset SubSection = "Showings">
		</cfcase>
		<cfcase value="Phone">
			<cfset SubSection = "Phone Calls">
		</cfcase>
		<cfcase value="allhistory">
			<cfset SubSection = "All History">
		</cfcase>
	</cfswitch>

	<cfreturn SubSection>

</cffunction>


<!--- Check for Data Function --->

<cffunction name="GetInsideData" returntype="string" output="true">
<cfargument name="abbrv" type="any" required="true">
<cfswitch expression="#abbrv#">
<!--- 		<cfcase value="LeadTracker">

		</cfcase> --->
		<cfcase value="Notes">
			<cfsavecontent variable="thequery">
				select id
				from cl_leadtracker_response
				where clientid = #url.id# and privatepublic = "Private"
			</cfsavecontent>
		</cfcase>
		<cfcase value="History">
			<cfsavecontent variable="thequery">
				select id
				from cl_leadtracker_response
				where clientid = #url.id# and privatepublic <> "Private"
				Order by createdat DESC
			</cfsavecontent>
		</cfcase>
		<cfcase value="Phone">
			<cfsavecontent variable="thequery">
				select id
				from cl_phonecalls
				where clientid = #url.id#
				Order by calldatetime DESC
			</cfsavecontent>
		</cfcase>
<!--- 		<cfcase value="Insight">
			<cfsavecontent variable="thequery">
				
			</cfsavecontent>
		</cfcase> --->
		<cfcase value="PastPur">
			<cfsavecontent variable="thequery">
				SELECT id
				FROM cl_listings
				WHERE status = "Past" and clientid = #url.id#
				order by createdat desc
			</cfsavecontent>
		</cfcase>
		<cfcase value="PendPur">
			<cfsavecontent variable="thequery">
				SELECT id
				FROM cl_listings
				WHERE status = "Pending" and clientid = #url.id#
				order by createdat desc
			</cfsavecontent>
		</cfcase>
		<cfcase value="ListInfo">
			<cfsavecontent variable="thequery">
				SELECT id
				FROM cl_listings
				WHERE status = "Active" and clientid = #url.id#
				order by createdat desc			
			</cfsavecontent>
		</cfcase>
		<cfcase value="SecContacts">
			<cfsavecontent variable="thequery">
				SELECT id
				FROM cl_secondary_contacts
				where clientid = "#url.id#"				
			</cfsavecontent>
		</cfcase>
		<cfcase value="Documents">
			<cfsavecontent variable="thequery">
					SELECT id
				FROM cl_document_manager
				where clientid = "#url.id#"
				order by createdat desc			
			</cfsavecontent>
		</cfcase>
		<cfcase value="Favorites">
			<cfsavecontent variable="thequery">
				SELECT id
				FROM cl_favorites
		        where clientid = "#url.id#"
			    order by thedate desc
				<cfif isdefined('showallFavorites') is "No">limit 10;</cfif>
			</cfsavecontent>
		</cfcase>
		<cfcase value="SavedSearches">
			<cfsavecontent variable="thequery">
				SELECT id
				FROM cl_saved_searches
				where clientid = "#url.id#" <cfif isdefined('showallsaved') is "No">and searchname <> "Tracking Purpose" </cfif> and searchname not like "%Agent Created%"
				order by createdat desc
			</cfsavecontent>
		</cfcase>
		<cfcase value="AllSearches">
			<cfsavecontent variable="thequery">
				SELECT id
				FROM cl_saved_searches
				where clientid = "#url.id#" and searchname like "%Tracking Purpose%"  and searchname not like "%Agent Created%"
				order by createdat desc
			</cfsavecontent>
		</cfcase>
		<cfcase value="Activity">
			<cfsavecontent variable="thequery">
				SELECT id
				FROM cl_activity
		        where clientid = "#url.id#"
			    order by createdat desc
			</cfsavecontent>
		</cfcase>
		<cfcase value="Drip">
			<cfsavecontent variable="thequery">
				SELECT id
				FROM drip_campaigns
		        where clientid = "#url.id#"
			    order by createdat desc	
			</cfsavecontent>
		</cfcase>
		<cfcase value="Views">
			<cfsavecontent variable="thequery">
				SELECT mlsnumber,mlsid
				FROM cl_properties_viewed
				WHERE clientid = #url.id# 
				ORDER BY createdat DESC
			</cfsavecontent>
		</cfcase>
		<cfcase value="shows">
			<cfsavecontent variable="thequery">
				  SELECT *
				  FROM cl_showings
				  where clientid = #id#
			</cfsavecontent>
		</cfcase>
<!--- 		<cfcase value="Bulk">
			<cfsavecontent variable="thequery">
				
			</cfsavecontent>
		</cfcase> --->
	</cfswitch>

	<cfquery datasource="#mls.dsn#" name="getinside">
		#thequery#
	</cfquery>

	<cfset datacount = "#getinside.recordcount#">

	<cfreturn datacount>

</cffunction>


<!--- Get Area Name --->
<cffunction name="GetAreaName" returntype="string" output="true">

	<cfargument name="areaid" type="numeric" required="true">

		<cfquery datasource="#dsnmls#" name="getarea" cachedwithin="#CreateTimeSpan(0, 0, 5, 0)#">	
		  SELECT city
		  FROM masterareas_cleaned
		  where mlsid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#mls.MLSID#">  and areashidden in (#areaid#)
		</cfquery>

	<cfset areaname = #getarea.city#>

	<cfreturn areaname>

</cffunction>


<!--- Get WSID Name --->
<cffunction name="GetPType" returntype="string" output="true">

	<cfargument name="wsid" type="numeric" required="true">
	<cfset ptypes = ''>

	<cfloop index="w" list="#wsid#">
		<cfif w eq "1">
			<cfset ptypes = ptypes & ',' & 'Single Family'>
		<cfelseif w eq "2">
			<cfset ptypes = ptypes & ',' & 'Home Sites/Lots'>
		<cfelseif w eq "3">
			<cfset ptypes = ptypes & ',' & 'Commercial'>
		<cfelseif w eq "5">
			<cfset ptypes = ptypes & ',' & 'Condos/Villas'>
		<cfelseif w eq "7">
			<cfset ptypes = ptypes & ',' & 'Boat Slips'>
		</cfif>
	</cfloop>

	<cfset ptypes = replace(ptypes, ',','','one')>

	<cfreturn ptypes>

</cffunction>


<!--- Get Drip Campaign Name --->
<cffunction name="GetDripName" returntype="string" output="true">

	<cfargument name="id" type="numeric" required="true">

		<cfquery datasource="#mls.dsn#" name="getdrip">
		  SELECT subject
		  FROM cl_drip_campaigns
		  where id = #id#
		</cfquery>

	<cfset dripname = #getdrip.subject#>

	<cfreturn dripname>

</cffunction>



<!--- Get Drip Campaign Name --->
<cffunction name="gotDripCampaign" returntype="string" output="false">

	<cfargument name="theclientid" type="numeric" required="true">

	<!--- Gray =  No Campaign, Green = Active Campaign, Red ba0000 = Finished, Orange e4800b = Paused --->
	<cfset HasDrip = "<span style='color:gray;'>0</span>">

	<!--- Find Active Campaigns --->

	<cfquery datasource="#mls.dsn#" name="getDrips">
	  SELECT id,nextstep
	  FROM drip_campaigns
	  where clientid = <cfqueryparam value="#arguments.theclientid#" cfsqltype="cf_sql_integer"> and status = <cfqueryparam value="Active" cfsqltype="cf_sql_varchar">
	  Order by CreatedAt desc
	</cfquery>

		<cfif getDrips.recordcount eq 1>

			<!--- Set default of 1 // Number stands for what number email step they are on --->
	<cfset HasDrip = "<span style='color:green;'>1</span>">

			<cfif LEN(getDrips.nextstep) and getDrips.nextstep gt 2>
				<cfset HasDrip = '<span style="color:Green;">' & getDrips.nextstep - 1 & '</span>'>
			</cfif>

		<cfelse> 
			<!--- Doesn't have any Active campaigns, Check for Paused or Finished --->

			<cfquery datasource="#mls.dsn#" name="getMore">
			  SELECT id,nextstep,Status
			  FROM drip_campaigns
			  Where clientid = <cfqueryparam value="#theclientid#" cfsqltype="cf_sql_integer"> and status <> <cfqueryparam value="" cfsqltype="cf_sql_varchar">
			  Order by CreatedAt desc
			  limit 1
			</cfquery>

			<cfif getMore.recordcount eq 1 and getMore.Status eq "Paused">

				<cfset HasDrip = "<span style='color:##e4800b;'>1</span>">

				<cfif LEN(getMore.nextstep) and getMore.nextstep gt 2>
					<cfset HasDrip = '<span style="color:##e4800b;">' & getMore.nextstep - 1 & '</span>'>
				</cfif>

			<cfelseif getMore.recordcount eq 1 and getMore.Status eq "Finished">

				<cfset HasDrip = "<span style='color:##ba0000;'>1</span>">

				<cfif LEN(getMore.nextstep) and getMore.nextstep gt 2>
					<cfset HasDrip = '<span style="color:##ba0000;">' & getMore.nextstep - 1 & '</span>'>
				</cfif>

			</cfif>

		</cfif>

	<cfreturn HasDrip>

</cffunction>





<!--- Get MLS information from Favs --->
<cffunction name="GetFavInfo" returntype="string" output="true">

	<cfargument name="mlsnumber" type="numeric" required="true">
	<cfargument name="mlsid" type="numeric" required="true">

	<cfquery datasource="#dsnmls#" name="favsmls" cachedwithin="#CreateTimeSpan(0, 0, 3, 0)#">
		select List_Price,Street_Number,Street_Name,City,Zip_Code
		from mastertable
		where mlsnumber = #mlsnumber# and mlsid = #mlsid#
	</cfquery>	

	<cfset mlsinfo = "#dollarformat(favsmls.List_Price)# - #favsmls.Street_Number# #favsmls.Street_Name#, #favsmls.City# #favsmls.Zip_Code#">

	<cfreturn mlsinfo>

</cffunction>


<!--- For Agent Note --->
<cffunction name="CheckNewLead" returntype="string" output="true">

	<cfargument name="clientid" required="true" type="string">

	<cfquery datasource="#mls.dsn#" name="newlead">
		select clientid
		from cl_leadtracker_response
		where clientid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#clientid#">
		limit 2
	</cfquery>	

	<cfif newlead.recordcount eq 1><cfset isitnew = "yes"><cfelse><cfset isitnew = "no"></cfif>

	<cfreturn isitnew>

</cffunction>



<!--- Get Lead Status --->
<cffunction name="GetLeadStatus" returntype="string" output="true">

	<cfargument name="id" type="numeric" required="true">

		<cfquery datasource="#mls.dsn#" name="statusname">
		  SELECT status
		  FROM cl_lead_statuses
		  where id = #id#
		</cfquery>

	<cfset lstatus = #statusname.status#>

	<cfreturn lstatus>

</cffunction>



<!--- Get Lead Status --->
<cffunction name="GetLeadRating" returntype="string" output="true">

	<cfargument name="id" type="numeric" required="true">

		<cfquery datasource="#mls.dsn#" name="ratingName">
		  SELECT rating
		  FROM cl_ratings
		  where id = #id#
		</cfquery>

	<cfset lrating = #ratingName.rating#>

	<cfreturn lrating>

</cffunction>


<!--- Get  Showings --->
<cffunction name="GetShowings" returntype="string" output="true">

	<cfargument name="id" type="numeric" required="true">

		<cfquery datasource="#mls.dsn#" name="showings">
		  SELECT Count(id) as resultcount
		  FROM cl_showings
		  where clientid = #id#
		</cfquery>

	<cfset showcount = #showings.resultcount#>

	<cfreturn showcount>

</cffunction>





<!--- Get  GetFollowUps --->
<cffunction name="GetFollowUps" returntype="string" output="true">

	<cfargument name="id" type="numeric" required="true">

		<cfquery datasource="#mls.dsn#" name="reminders">
		  SELECT FollowUpDate,FollowUpTime
		  FROM cl_followup_reminder
		  where clientid = #id#
		  Order by FollowUpDate DESC
		  Limit 1
		</cfquery>

	<cfset showdate = Dateformat(reminders.FollowUpDate, 'mm/dd/yyyy') & ' ' & timeformat(reminders.FollowUpTime, 'h:mm tt')>

	<cfreturn showdate>

</cffunction>



<!--- For Visits --->
<cffunction name="GetLastVisit" returntype="string" output="true">

	<cfargument name="id" type="numeric" required="true">

	<cfset thelastvisit ="">

    <cfquery datasource="#mls.dsn#" name="getvisit">
      SELECT thedate,thetime
      FROM cl_visits
      WHERE clientid = <cfqueryparam value="#id#" cfsqltype="cf_sql_integer">
      ORDER BY thedate DESC
      LIMIT 1
    </cfquery>

    <!--- If a visit is found, display if not check logins --->
    <cfif getvisit.recordcount gt 0>

		<cfset thelastvisit =  Dateformat(getvisit.thedate, 'mm/dd/yyyy') & ' ' & timeformat(getvisit.thetime, 'h:mm tt')>

	<cfelse>

	    <cfquery datasource="#mls.dsn#" name="getlogin">
	      SELECT login
	      FROM cl_logins
	      WHERE clientid = <cfqueryparam value="#id#" cfsqltype="cf_sql_integer">
	      ORDER BY login DESC
	      LIMIT 1
	    </cfquery>


    <!--- If a login is found, display if not check activity --->
	    <cfif getvisit.recordcount gt 0>

	    	<cfset thelastvisit =  Dateformat(getlogin.login, 'mm/dd/yyyy') & ' ' & timeformat(getlogin.login, 'h:mm tt')>

	    <cfelse>

		    <cfquery datasource="#mls.dsn#" name="getactivity">
		      SELECT createdat
		      FROM cl_activity
		      WHERE clientid = <cfqueryparam value="#id#" cfsqltype="cf_sql_varchar">
		      ORDER BY createdat DESC
		      LIMIT 1
		    </cfquery>

	    	<cfset thelastvisit =  Dateformat(getactivity.createdat, 'mm/dd/yyyy') & ' ' & timeformat(getactivity.createdat, 'h:mm tt')>

	    </cfif>


	</cfif>

	<cfreturn thelastvisit>

</cffunction>