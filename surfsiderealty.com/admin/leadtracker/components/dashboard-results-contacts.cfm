<!--- To display message to user after action select box changed --->
<tr><td colspan="16" id="searchresultsActionChange" style="display: none;" Onclick="javascript:hidemessage(document.getElementById('searchresultsActionChange'))" title="Click to close message."></td></tr>


<cfoutput query="WaitingCust">

<CFQUERY DATASOURCE="#mls.dsn#" NAME="GetLastContact">
  SELECT cl_leadtracker_response.FromOrTo,cl_leadtracker_response.clientid,cl_leadtracker_response.createdat,cl_accounts.thedate
  FROM cl_leadtracker_response
  INNER JOIN cl_accounts on cl_leadtracker_response.clientid = cl_accounts.id
  where cl_leadtracker_response.clientid = '#clientid#'
       <cfif isdefined('cookie.LoggedInAgentID') and cookie.LoggedInAgentID neq "50">
          and cl_accounts.agentid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#cookie.LoggedInAgentID#">
        </cfif>
  order by cl_leadtracker_response.createdat desc
  limit 1
</CFQUERY>

<cfif isdefined('GetLastContact.recordcount') and GetLastContact.FromOrTo is "Waiting on Customer's Response">

<CFQUERY DATASOURCE="#mls.dsn#" NAME="getAgentInfo">
  SELECT firstname,lastname
  FROM cl_agents
  where id = <cfqueryparam value="#agentid#" cfsqltype="cf_sql_integer">
</CFQUERY>

  <!--- SET lastlogin --->
  <cfif GetLastLogin(clientid) gt 0>
    <cfset thelastlogin = GetLastLogin(clientid)>
  <cfelse>
    <cfset thelastlogin = "#thedate#">
  </cfif>

  <cfset lastprop = "#GetLastProperty(clientid)#">
  <cfif LISTLEN(lastprop) GTE 1><cfset propnum = "#ListGetAt(lastprop,1)#"></cfif>
  <cfif LISTLEN(lastprop) GTE 2>
    <cfset propmlsid = "#ListGetAt(lastprop,2)#">
    <cfset propertydetails = "#GetPropertyInfo(propnum,propmlsid)#">
  </cfif>
<!---   <cfif isdefined('propertydetails') and LISTLEN(propertydetails) GTE 1>
    <cfset listprice = "#ListGetAt(propertydetails,1)#">
  </cfif> --->
  <cfif isdefined('propertydetails') and LISTLEN(propertydetails) GTE 2>
    <cfset areaid = "#ListGetAt(propertydetails,2)#">
  </cfif>

  <cfset getallpropdata = #GetAllProperties(clientid)#>
  <cfset allproperties = #GetAllProperties(clientid)#>
  <cfset allfavs = #GetFavs(clientid)#>
  <cfset allemails = #GetEmails(clientid)#>
  <cfset allcalls = #GetCalls(clientid)#>
  <cfset answeredcalls = #GetAnsweredCalls(clientid)#>
  <cfset newleads = #CheckNewLead(clientid)#>
  <cfset allshowings = #GetShowings(clientid)#>

  <cfset stripphone = rereplace(phone,'\)|\(|\.|-|\##','','ALL')>
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
<cfif rating eq '4'>
<cfset ratingClass = "cold">
<cfelseif rating eq '10'>
<cfset ratingClass = "nurture">
<cfelseif rating eq '9'>
<cfset ratingClass = "watch">
<cfelseif rating eq '2'>
<cfset ratingClass = "hot">
<cfelseif rating eq '8'>
<cfset ratingClass = "pending">
<cfelseif rating eq '7'>
<cfset ratingClass = "trash">
<cfelseif rating eq ''>
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

<!--- cl_accounts.thedate as thedate
cl_accounts.firstname
cl_accounts.lastname
cl_accounts.email
cl_accounts.CAMEFROMWEBSITE as site
cl_accounts.address
cl_accounts.address2
cl_accounts.city
cl_accounts.state
cl_accounts.zip
cl_accounts.phone
cl_accounts.agentid
cl_accounts.id as theid
cl_accounts.leadstatus as leadstatus

  cl_leadtracker_response.createdat as responsedate,cl_accounts.PPCsignup as PPCsignup,cl_accounts.thedate as acctcreated --->
                    <tr>
                      <td class="status #ratingClass#"><cfif LEN(rating)>#GetLeadRating(rating)#<cfelse>Qualify</cfif></td>
                      <td class="agent">#capFirstTitle(getAgentInfo.firstname)# #capFirstTitle(getAgentInfo.lastname)#</td>
                      <td class="contact"><a hreflang="en" href="contact-details.cfm?id=#clientid#"><cfif LEN(firstname) and LEN(lastname)>#capFirstTitle(firstname)# #capFirstTitle(lastname)#<cfelse>Name Unavailable</cfif></a><br>#phone#</td>
                      <td class="action">
                        <select class="selectpicker" onChange="ActionSelector(this.value);javascript:hideshow(document.getElementById('searchresultsActionChange'))">
                          
                           
						  					 <option value="#clientid#~none">Change Status</option>
														<cfloop query="getRating">
														<option value="#WaitingCust.clientid#~#rating#">#rating#</option>
													</cfloop>
						   
						    <!--- <option value="#clientid#~none">Change Status</option>
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
                        <i href="/admin/contacts/lightboxes/phonecall.cfm?clientid=#clientid#" class="fb_phoneadd #phoneClass#"></i><!--- <i href="/admin/contacts/lightboxes/phoneupdate.cfm?phonenumber=#rereplace(phone,'\)|\(|\.|-|\##','','ALL')#" class="fb_listing #phoneClass#"></i> ---> <cfif LEN(clientid)><a hreflang="en" href="contact-details.cfm?id=#clientid#&display=Phone##LOC" target="_blank">#GetCalls(clientid)#</a></cfif>
                      </td>
                      <td class="emails one-way"><i class="fb_listing" href="/admin/contacts/lightboxes/messages.cfm?id=#clientid#&reply=&dash=agent"></i> <cfif LEN(clientid)><a hreflang="en" href="contact-details.cfm?id=#clientid#&display=History##LOC" target="_blank">#GetEmails(clientid)#</a></cfif></td>
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
                      <td class="visits"><cfif LEN(clientid)>#GetVisits(clientId)#</cfif></td>
                      <td class="views"><cfif LEN(clientid)><a hreflang="en" href="contact-details.cfm?id=#clientid#&display=Views##LOC" target="_blank">#GetAllProperties(clientid)#</a></cfif></td>
                      <td class="favs"><cfif LEN(clientid)><a hreflang="en" href="contact-details.cfm?id=#clientid#&display=Favorites##LOC" target="_blank">#GetFavs(clientId)#</a></cfif></td>
                      <td class="site">#site#</td>
                      <td class="created">
                        #dateformat(GetLastContact.thedate, 'm/d/yyyy')#<br>#timeformat(GetLastContact.thedate, 'hh:mmtt')#
                      </td>
                    </tr>
</cfif>
</cfoutput>
