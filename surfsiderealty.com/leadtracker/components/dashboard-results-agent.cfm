<cfset clientlist2 = '~'>


<!--- To display message to user after action select box changed --->
<tr><td colspan="16" id="searchresultsActionChange" style="display: none;" Onclick="javascript:hidemessage(document.getElementById('searchresultsActionChange'))" title="Click to close message."></td></tr>


<cfoutput query="getinfo"> 

<cfif ListFind(clientlist2, clientid) eq 0>
   <cfset clientlist2 = clientlist2 & "," & clientid>

<CFQUERY DATASOURCE="#mls.dsn#" NAME="GetLastContact">
  SELECT FromOrTo,clientid,createdat
  FROM cl_leadtracker_response
  where clientid = <cfqueryparam value="#getinfo.clientid#" cfsqltype="cf_sql_integer"> 
       <cfif isdefined('cookie.LoggedInAgentID') and cookie.LoggedInAgentID neq "50">
          and cl_leadtracker_response.agentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cookie.LoggedInAgentID#">
        </cfif>
  order by createdat desc
  limit 1
</CFQUERY>



    <CFQUERY DATASOURCE="#mls.dsn#" NAME="GetAcctInfo">
      SELECT cl_accounts.*, cl_agents.firstname as agentFName, cl_agents.lastname as agentLName 
      FROM cl_accounts
      LEFT JOIN cl_agents 
      ON cl_accounts.agentid = cl_agents.id
      WHERE cl_accounts.id = <cfqueryparam value="#getinfo.clientid#" cfsqltype="cf_sql_integer"> 

        <cfif isdefined('cookie.LoggedInAgentID') and cookie.LoggedInAgentID neq "50">
          and cl_accounts.agentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cookie.LoggedInAgentID#">
        </cfif>
        
    </CFQUERY>


<cfif GetLastContact.FromOrTo eq "Waiting on Agent's Response" and GetAcctInfo.recordcount gt 0>

  <!--- SET lastlogin --->
  <cfif GetLastLogin(GetLastContact.clientid) gt 0>
    <cfset thelastlogin = GetLastLogin(GetLastContact.clientid)>
  <cfelse>
    <cfset thelastlogin = "#GetAcctInfo.thedate#">
  </cfif>

  <cfset lastprop = "#GetLastProperty(GetLastContact.clientid)#">
  <cfif LISTLEN(lastprop) GTE 1><cfset propnum = "#ListGetAt(lastprop,1)#"></cfif>
  <cfif LISTLEN(lastprop) GTE 2>
    <cfset propmlsid = "#ListGetAt(lastprop,2)#">
    <cfset propertydetails = "#GetPropertyInfo(propnum,propmlsid)#">
  </cfif>

  <cfif isdefined('propertydetails') and LISTLEN(propertydetails) GTE 2>
    <cfset areaid = "#ListGetAt(propertydetails,2)#">
  </cfif>

  <cfset getallpropdata = #GetAllProperties(GetLastContact.clientid)#>
  <cfset allproperties = #GetAllProperties(GetLastContact.clientid)#>
  <cfset allfavs = #GetFavs(GetLastContact.clientid)#>
  <cfset allemails = #GetEmails(GetLastContact.clientid)#>
  <cfset allcalls = #GetCalls(GetLastContact.clientid)#>
  <cfset answeredcalls = #GetAnsweredCalls(GetLastContact.clientid)#>
  <cfset allshowings = #GetShowings(GetLastContact.clientid)#>
  <cfset newleads = #CheckNewLead(GetLastContact.clientid)#>

  <cfset stripphone = rereplace(GetAcctInfo.phone,'\)|\(|\.|-|\##','','ALL')>
  <cfset getphoneval = #GetPhoneValidation(stripphone)#>
  <cfset getnumberdata = #GetPhoneData(stripphone)#>

  <cfif getphoneval eq 1>
    <cfset phoneimg = "/admin/images/icon-checkmark.gif">
    <cfset phoneinfo = "Phone Data: #getnumberdata#">
  <cfelseif getphoneval eq 3>
    <cfset phoneimg = "/admin/images/icon-checkmark-red.gif">
    <cfset phoneinfo = "Phone Data: #getnumberdata#">
  <cfelse>
    <cfset phoneimg = "/admin/images/icon-checkmark-grey.gif">
    <cfset phoneinfo = "No Phone Data">
  </cfif>
 
<!--- start: Determine class for rating --->
<cfset ratingClass = 'new'>
<cfif GetAcctInfo.rating eq '4'>
<cfset ratingClass = "cold">
<cfelseif GetAcctInfo.rating eq '10'>
<cfset ratingClass = "nurture">
<cfelseif GetAcctInfo.rating eq '9'>
<cfset ratingClass = "watch">
<cfelseif GetAcctInfo.rating eq '2'>
<cfset ratingClass = "hot">
<cfelseif GetAcctInfo.rating eq '8'>
<cfset ratingClass = "pending">
<cfelseif GetAcctInfo.rating eq '7'>
<cfset ratingClass = "trash">
<cfelseif GetAcctInfo.rating eq ''>
<cfset ratingClass = "qualify">
</cfif>
<!--- end: Determine class for rating --->


              <!--- Determine Phone Verification --->
              <cfparam name="phoneValidate" default="0">
              <cfparam name="phoneClass" default="phone-unknown">
              <cfif isdefined('phone') and LEN(phone)>
                <!--- Strip Phone Number of characters --->
                <cfset stripPhone = rereplace(phone,'\)|\(|\.| |-','','ALL')>
                <!--- Get Validation number --->
                <cfset phoneValidate = GetPhoneValidation(stripPhone)>
                <!--- Use Validation number to set CSS class to change icon --->
                <cfset phoneClass = getPhoneClass(phoneValidate)>
              </cfif>
              <!--- End: Phone Verification --->

                    <tr>
                      <td class="status #ratingClass#"><cfif LEN(GetAcctInfo.rating)>#GetLeadRating(GetAcctInfo.rating)#<cfelse>Qualify</cfif></td>
                      <td class="agent">#capFirstTitle(GetAcctInfo.agentFName)# #capFirstTitle(GetAcctInfo.agentLName)#</td>
                      <td class="contact"><a hreflang="en" href="contact-details.cfm?id=#clientid#"><cfif LEN(GetAcctInfo.firstname) and LEN(GetAcctInfo.lastname)>#capFirstTitle(GetAcctInfo.firstname)# #capFirstTitle(GetAcctInfo.lastname)#<cfelse>Name Unavailable</cfif></a><br>#GetAcctInfo.phone#</td>
                      <td class="action">
                        <select class="selectpicker" onChange="ActionSelector(this.value);javascript:hideshow(document.getElementById('searchresultsActionChange'))">
                          
						  					<option value="#clientid#~none">Change Status</option>
														<cfloop query="getRating">
														<option value="#getinfo.clientid#~#rating#">#rating#</option>
													</cfloop>
						  
                           <!---  <option value="#clientid#~none">Change Status</option>
                            <option value="#clientid#~hot">- to Hot</option>
                            <option value="#clientid#~nurture">- to Nurture</option>
                            <option value="#clientid#~watch">- to Watch</option>
                            <option value="#clientid#~cold">- to Cold</option>
                            <option value="#clientid#~pending">- to Pending</option>
                            <option value="#clientid#~closed">- to Closed</option>
                             <option value="#clientid#~startdrip">Start Drip Campaign</option> --->
                        
                            <!--- <option value="##" disabled selected>#action#</option> --->
                        </select>
                        
                      </td>
                      <td class="calls talking">
                       <i href="/admin/contacts/lightboxes/phonecall.cfm?clientid=#clientid#" class="fb_phoneadd #phoneClass#"></i> <!--- <i href="/admin/contacts/lightboxes/phoneupdate.cfm?phonenumber=#rereplace(GetAcctInfo.phone,'\)|\(|\.|-|\##','','ALL')#" class="fb_listing #phoneClass#"></i> ---> <cfif LEN(getInfo.clientid)>#GetCalls(getInfo.clientid)#</cfif>
                      </td>
                      <td class="emails one-way"><i class="fb_listing" href="/admin/contacts/lightboxes/messages.cfm?id=#getinfo.clientid#&reply=&dash=agent"></i> <cfif LEN(getInfo.clientid)>#GetEmails(getInfo.clientid)#</cfif></td>
                      <td class="drip ok">
                        #gotDripCampaign(clientid)#
                      </td>
                      <td class="date">
                        <cfset fdate = GetFollowUps(clientid)>
                        <cfset ftime = timeformat(fdate, 'h:mm tt')>
                        <cfset fdate = dateformat(fdate, 'yyyy-mm-dd')>
                        <cfif LEN(fdate)>#fdate# #ftime#<div>#DateDiff("d", fdate, now())# day<cfif DateDiff("d", fdate, now()) gt 1 or DateDiff("d", fdate, now()) eq 0>s</cfif> ago</div></cfif>
                      </td>
                      <td class="agent">
                        #GetEAlerts(clientid)#
                        <!--- <div>Agent</div> --->
                      </td>
                      <td class="price">
                    <!--- <select class="selectpicker">
                          <option>#GetSSMinMax(clientid)#</option>
                        </select> --->#GetSSMinMax(clientid)#
                      </td>
                      <td class="last-visit">
                        <cfif LEN(clientid)>#GetLastVisit(clientid)#</cfif>
                        <!--- <cfif LEN(clientid)>#dateformat(theLastLogin, 'm/d/yyyy')# <br>#timeformat(theLastLogin, 'hh:mmtt')#</cfif> --->
                      </td>
                      <td class="visits"><cfif LEN(getInfo.clientid)>#GetVisits(getInfo.clientId)#</cfif></td>
                      <td class="views"><cfif LEN(getinfo.clientid)><a hreflang="en" href="contact-details.cfm?id=#clientid#&display=Views##LOC" target="_blank">#GetAllProperties(getinfo.clientid)#</a></cfif></td>
                      <td class="favs"><cfif LEN(getinfo.clientid)><a hreflang="en" href="contact-details.cfm?id=#clientid#&display=Favorites##LOC" target="_blank">#GetFavs(getinfo.clientId)#</a></cfif></td>
                      <td class="site">#GetAcctInfo.camefromwebsite#</td>
                      <td class="created">#dateformat(GetAcctInfo.thedate, 'm/d/yyyy')#<br>#timeformat(GetAcctInfo.thedate, 'hh:mmtt')#</td>
                    </tr>
</cfif>
</cfif>
</cfoutput>

