<cfinclude template="search_.cfm">
<cfinclude template="components/functions.cfm">

<!--- <cfcontent type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=export-contact-#dateformat(now(), 'mm_dd_yy')#.xls"> --->
<table>
	<tr>
		<th>Name</th>
		<th>Email</th>
		<th>Phone</th>
		<th>Rating</th>
		<cfif isdefined('cookie.LoggedInAdminID')><th>Agent</th></cfif>
		<cfif session.joinsearch eq 1><th>Search Date</th></cfif>
		<th>Created</th>
	</tr>
</thead>
<tbody>
	<cfoutput query="getInfo">
	<tr>
		<td>#capFirstTitle(firstname)# #capFirstTitle(lastname)#</td>
		<td>#email#</td>
		<td>#phone#</td>
		<td><cfif LEN(rating)>#GetLeadRating(rating)#<cfelse>Qualify</cfif></td>
		<cfif isdefined('cookie.LoggedInAdminID')><td>#GetAgentName(agentid)#</td></cfif>
		<cfif session.joinsearch eq 1><td>#dateformat(ssdate, 'mm/dd/yyyy')#<br>#timeformat(ssdate, 'hh:mm TT')#</td></cfif>
		<td>#dateformat(thedate, 'mm/dd/yyyy')#</td>
	</tr>
	</cfoutput>
</tbody>
</table>