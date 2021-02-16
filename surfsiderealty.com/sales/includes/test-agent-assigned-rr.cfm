<cfset timenow = "#now()#">
<cfset Time9am = "#dateformat(now(),'mm/dd/yyyy')# 09:00:00">
<cfset Time1pm = "#dateformat(now(),'mm/dd/yyyy')# 13:00:00">


<cfif timenow gt "#Time9am#" and timenow lt "#Time1pm#">
		<cfset dutytime = "9am - 1pm">
	<cfelse>
		<cfset dutytime = "1pm - 9am">
</cfif>


 <cfquery datasource="#mls.dsn#" name="GetAgent">
	select agentid
	from cl_agent_on_duty
	where thedate = <cfqueryparam cfsqltype="CF_SQL_Date" value="#timenow#"> and DutyTime = <cfqueryparam cfsqltype="cf_sql_varchar" value="#dutytime#">
</cfquery>

<cfdump var="#GetAgent#">