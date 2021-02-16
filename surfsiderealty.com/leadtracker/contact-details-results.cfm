<script src="js/hideshow.js" type="text/javascript" charset="utf-8"></script>

<cfinclude template="contact-details-results-query.cfm">

<!--- start: pagination --->
<cfparam name="start_record" type="any" default="1">
<cfparam name="records_per_page" type="any" default="15">
<cfparam name="page" type="any" default="1">


<cfif isdefined('graybox.recordcount')>
  <cfset totalpages = #ceiling(graybox.recordcount/records_per_page)#>
<cfelse>
  <cfset totalpages = 0>
</cfif>

<cfset start_record = records_per_page * page - records_per_page + 1>
<cfset to_record = (start_record + (records_per_page - 1))>
<!--- end: pagination --->





<h2 class="contacts-pagination"><cfoutput>#GetSubSection(url.display)#</cfoutput></h2>
	<!--- <li>Page <input id="" type="text" name="currentpage" placeholder="#url.pg#" /> of #tracker.resultPages#</li> --->


<cfinclude template="contact-details-pagination.cfm">

<div style="clear:both;"></div>
<table class="table table-hover table-striped">

<cfif isdefined('url.display') and url.display eq "LeadTracker">

<tr><td><cfinclude template="contact-details-create-message.cfm"></td></tr>

<!--- Saved Searches --->
<cfelseif isdefined('url.display') and url.display eq "SavedSearches">
	<thead>
	    <tr>
	      <th width="15">Date</th>
	      <th width="150">Search Name</th>
	      <th width="100">Frequency</th>
	      <th width="*">Details</th>
	    </tr>
	</thead>
	<tbody>
	    <cfoutput query="graybox"  startrow="#start_record#" maxrows="#records_per_page#">
	    <tr>
	      <td  class="agent">#dateformat(createdat,'mm/dd/yyyy')#<!---  #timeformat(createdat,'hh:mm tt')# ---></td>
	      <td  class="agent"><a hreflang="en" href="/mls/search-results.cfm?#searchparameters#&clearsession=" style="text-decoration:underline;" target="_blank"><b>#searchname#</b></a></td>
	      <td  class="agent">#howoften#</td>
	      <td  class="agent">
	          <cfif LEN(graybox.numberofmatches)><span class="bolditem">Listings:</span> #graybox.numberofmatches#  </cfif>
	          <cfif LEN(graybox.wsid)><span class="bolditem">Property Type:</span>  #GetPType(graybox.wsid)#   </cfif>
	          <cfif LEN(graybox.pmin) or LEN(graybox.pmax)><span class="bolditem">Price:</span> #dollarformat(graybox.pmin)# - #dollarformat(graybox.pmax)#  </cfif>
	          <cfif LEN(graybox.Bedrooms) or LEN(graybox.baths_Full)><span class="bolditem">Beds:</span> #graybox.bedrooms# <span class="bolditem">Baths:</span> #graybox.baths_Full#  </cfif>
	          <cfif LEN(graybox.subdivision)><span class="bolditem">Subdivision:</span> #graybox.subdivision#  </cfif>
	          <cfif LEN(graybox.stipulations)><span class="bolditem">Stipulations:</span> #graybox.stipulations#  </cfif>
	          <cfif LEN(graybox.shortsale)><span class="bolditem">Short Sale:</span> Yes  </cfif>
	          <cfif LEN(graybox.foreclosure)><span class="bolditem">Foreclosure:</span> Yes  </cfif>
	          <cfif LEN(graybox.mlsnumber)><span class="bolditem">MLS Number:</span> #graybox.mlsnumber#  </cfif>
	          <cfif LEN(graybox.Kind)><span class="bolditem">kind:</span> #graybox.kind#  </cfif>
	            <cfif LEN(graybox.area)><span class="bolditem">Area(s):</span> <cfset cleanAreaList = reReplace(graybox.area, ';', '', 'ALL')>
	              <cfloop list="#cleanAreaList#" index="i" >
	                #CapFirstTitle(GetAreaName(i))#
	              </cfloop>
	            </cfif>
	          
	          <cfif LEN(graybox.Lot_description)><span class="bolditem">Other:</span> #graybox.Lot_description#</cfif>
	      </td>
	    </tr>
		</cfoutput>
	</tbody>

<cfelseif isdefined('url.display') and url.display eq "notes"><!--- Notes --->

	<thead>
	    <tr >
	      <th width="10%">Date</th>
	      <th width="10%">Time</th>
	      <th  width="10%">Agent</th>
	      <th  width="*">Note </th>
	    </tr>
	</thead>
	<tbody>
	    <cfoutput query="graybox" startrow="#start_record#" maxrows="#records_per_page#">
	        <cfset FindTheBodyDelimiter = "#findoneof('__________________________________',graybox.MessageBody)#">
	        <cfif FindTheBodyDelimiter gt 0>
	          <cfset TheMessagebody = "#trim(left(graybox.MessageBody,FindTheBodyDelimiter))#">
	        <cfelse>
	          <cfset TheMessagebody = "#graybox.MessageBody#">
	        </cfif>
	      <tr title="Click to view Note" onclick="javascript:hideshow(document.getElementById('note#graybox.id#'))" style="cursor:pointer;">
	        <td class="agent">#dateformat(graybox.createdat, 'mm/d/yy')#</td>
	        <td class="agent">#timeformat(graybox.createdat, 'hh:mm tt')#</td>
	        <td class="agent">#GetAgentName(graybox.agentid)#</td>
	        <td class="agent left"><cfif graybox.contacttype eq 'Follow Up Note'>[#graybox.contacttype#] </cfif>#left(stripHTML(trim(TheMessagebody)), 100)#...</td>
	      </tr>
	      <tr><td colspan="4" id="note#graybox.id#" style="display:none;">
	      <div class="graybox-message">#TheMessagebody#</div>
	      <div class="graybox-message-close"><input type="button" name="submit" value="Close" onclick="javascript:hideshow(document.getElementById('note#graybox.id#'))" style="font-size:12px;"><br><a hreflang="en" href="contacts2.cfm?action=Edit&id=#url.id#&display=Notes&deletenote=#graybox.id###LOC"><input type="button" name="submit" value="Delete"  onclick="return confirm('Are you sure you wish to delete this Note?')" style="font-size:12px;"></a></div>
	      </td></tr>
		</cfoutput>
	</tbody>


<cfelseif isdefined('url.display') and url.display eq "AllHistory">

<thead>
     <tr>
      <th>Date</th>
      <th>Contact Type</th>
      <th>Visibility</th>
      <th>Subject</th>
      <th>Whose waiting on who?</th>
      <th>MLS #</th>
      <th>Agent</th>
    </tr>
</thead>
<tbody>
	<cfoutput query="graybox"  startrow="#start_record#" maxrows="#records_per_page#">
	        <cfset FindTheBodyDelimiter = "#findoneof('__________________________________',graybox.MessageBody)#">
	        <cfif FindTheBodyDelimiter gt 0>
	          <cfset TheMessagebody = "#trim(left(graybox.MessageBody,FindTheBodyDelimiter))#">
	        <cfelse>
	          <cfset TheMessagebody = "#graybox.MessageBody#">
	        </cfif>
	        <cfif graybox.FromorTo is "Waiting on Agent's Response">
	         <cfset TextColor = "red">
	        <cfelseif graybox.FromorTo is "Waiting On Customer's Response">
	         <cfset TextColor = "green">
	        <cfelseif graybox.FromOrTo is "Private Note - No Action Needed">
	         <cfset TextColor = "##444">
	        <cfelseif graybox.FromOrTo is "Manual Entry By Website Administrator">
	          <cfset TextColor = "red">
	         <cfelse>
	        <cfset TextColor = "red">
	        </cfif>
	    <tr title="Click to view Message" onclick="javascript:hideshow(document.getElementById('message#graybox.id#'))">
	      <td class="agent">#dateformat(createdat, 'm/d/yy')#<br>#timeformat(createdat, 'hh:mm TT')#</td>
	      <td class="agent">#ContactType#</td>
	      <td class="agent">#privatepublic#</td>
	      <td class="agent"><cfif contacttype eq 'phone'>click for call notes<cfelse>#MessageSubject#</cfif></td>
	      <td class="agent" style="color:#TextColor#;">#FromOrTo#</td>
	      <td class="agent"><cfif LEN(mlsnumber)><a hreflang="en" href="/mls/search-results.cfm?mlsnumber=#mlsnumber#" target="new" alt="Click to view property" title="Click to view property">#mlsnumber#</a></cfif></td>
	      <td class="agent"><cfif graybox.agentid eq 9>Bill True<cfelse><cfif LEN(graybox.agentid)>#GetAgentName(agentid)#</cfif></cfif></td>
	    </tr>
	    <tr><td colspan="7" id="message#id#" style="display:none;">
	    <div class="graybox-message" style="text-transform:none !important;"><cfif LEN(TheMessageBody)>#TheMessagebody#<cfelse><i>- not available -</i></cfif> <cfif LEN(BestTimeToContact)>| Best Time to Contact:#BestTimeToContact#</cfif></div>
	    <div class="graybox-message-close"><input type="button" name="submit" value="Close" onclick="javascript:hideshow(document.getElementById('message#graybox.id#'))" style="font-size:12px;"></div>
	    </td></tr>
	</cfoutput>
</tbody>

<cfelseif isdefined('url.display') and url.display eq "history">
	<thead>
	     <tr>
	      <th>Date</th>
	      <th>Contact Type</th>
	      <th>Public</th>
	      <th>Subject</th>
	      <th>Whose waiting on who?</th>
	      <th>MLS #</th>
	      <th>Agent</th>
	    </tr>
	</thead>
<cfoutput query="graybox"  startrow="#start_record#" maxrows="#records_per_page#">
        <cfset FindTheBodyDelimiter = "#findoneof('__________________________________',MessageBody)#">
        <cfif FindTheBodyDelimiter gt 0>
          <cfset TheMessagebody = "#trim(left(MessageBody,FindTheBodyDelimiter))#">
        <cfelse>
          <cfset TheMessagebody = "#MessageBody#">
        </cfif>
        <cfif FromorTo is "Waiting on Agent's Response">
         <cfset TextColor = "red">
        <cfelseif FromorTo is "Waiting On Customer's Response">
         <cfset TextColor = "green">
        <cfelseif FromOrTo is "Private Note - No Action Needed">
         <cfset TextColor = "##444">
        <cfelseif FromOrTo is "Manual Entry By Website Administrator">
          <cfset TextColor = "red">
         <cfelse>
        <cfset TextColor = "red">
        </cfif>
  <tbody>
    <tr  title="Click to view Message" onclick="javascript:hideshow(document.getElementById('message#graybox.id#'))">
      <td class="agent">#dateformat(createdat, 'm/d/yy')#<br>#timeformat(createdat, 'hh:mm TT')#</td>
      <td class="agent">#ContactType#</td>
      <td class="agent">#privatepublic#</td>
      <td class="agent">#MessageSubject#</td>
      <td class="agent" style="color:#TextColor#;">#FromOrTo#</td>
      <td class="agent"><cfif LEN(mlsnumber)><a hreflang="en" href="/mls/search-results.cfm?mlsnumber=#mlsnumber#" target="new" alt="Click to view property" title="Click to view property">#mlsnumber#</a></cfif></td>
      <td class="agent"><cfif graybox.agentid eq 9>Bill True<cfelseif isdefined('agentid') and LEN(agentid)>#GetAgentName(agentid)#<cfelse>Unassigned</cfif></td>
    </tr>
    <tr><td colspan="7" id="message#id#" style="display:none;">
    <div class="graybox-message" style="text-transform:none !important;"><cfif LEN(TheMessageBody)>#TheMessagebody#<cfelse><i>- not available -</i></cfif> <cfif LEN(BestTimeToContact)>| Best Time to Contact:#BestTimeToContact#</cfif></div>
    <div class="graybox-message-close"><input type="button" name="submit" value="Close" onclick="javascript:hideshow(document.getElementById('message#graybox.id#'))" style="font-size:12px;"></div>
    </td></tr>
    </tbody>
</cfoutput>

<cfelseif isdefined('url.display') and url.display eq "Phone">
	<thead>
	    <tr>
	      <th width="10%">Date</th>
	      <th width="10%">Time</th>
	      <th width="20%">Status</th>
	      <th width="*" >Notes</th>
	    </tr>
	</thead>
    <cfoutput query="graybox" startrow="#start_record#" maxrows="#records_per_page#">
    <tbody>
	    <tr>
	      <td class="agent" width="10%">#dateformat(calldatetime, 'm/dd/yyyy')#</td>
	      <td class="agent" width="10%">#timeformat(calldatetime, 'h:m: tt')#</td>
	      <td class="agent" width="20%">#callresult#</td>
	      <td class="agent" width="*">#callnotes#</td>
	    </tr>
    </tbody>
    </cfoutput>


<cfelseif isdefined('url.display') and url.display eq "Favorites">
	<thead>
	    <tr>
	      <th width="10%">Date</th>
	      <th width="10%">MLS Number</th>
	      <th width="*">Property Info</th>
	    </tr>
	</thead>
    <cfoutput query="graybox"  startrow="#start_record#" maxrows="#records_per_page#">
    <tbody>
	    <tr>
	      <td class="agent">#dateformat(thedate, 'mm/dd/yy')#</td>
	      <td class="agent"><a hreflang="en" href="/mls/search-results.cfm?mlsnumber=#mlsnumber#&wsid=#wsid#&mlsid=#mlsid#&clearsession=" target="_blank">#mlsnumber#</a> </td>
	      <td class="agent">#GetFavInfo(mlsnumber,mlsid)#</td>
	    </tr>
    </tbody>
    </cfoutput>


<cfelseif isdefined('url.display') and url.display eq "Views">
	<thead>
    <tr>
      <th width="10%">Date</th>
      <th width="10%">MLS Number</th>
      <th width="*">Property Info</th>
    </tr>
	</thead>
    <cfoutput query="graybox"  startrow="#start_record#" maxrows="#records_per_page#">
	   <tbody>
	    <tr>
	      <td class="agent">#dateformat(createdat, 'mm/dd/yy')#</td>
	      <td class="agent"><a hreflang="en" href="/mls/search-results.cfm?mlsnumber=#mlsnumber#&wsid=#wsid#&mlsid=#mlsid#&clearsession=" target="_blank">#mlsnumber#</a> </td>
	      <td class="agent">#GetFavInfo(mlsnumber,mlsid)#</td>
	    </tr>
	  </tbody>
    </cfoutput>


<cfelseif isdefined('url.display') and url.display eq "AllSearches">
	<thead>
    <tr>
      <th width="10%">Date</th>
      <th width="20%">Search Name</th>
      <th width="*">Search Name</th>
    </tr>
	</thead>
    <cfoutput query="graybox"  startrow="#start_record#" maxrows="#records_per_page#">
	 	<tbody>
		    <tr>
		      <td class="agent">#dateformat(createdat,'mm/dd/yyyy')#</td>
		      <td class="agent"><a hreflang="en" href="/mls/search-results.cfm?#searchparameters#&clearsession=" style="text-decoration:underline;" target="_blank"><b>#searchname#</b></a></td>
		      <td class="agent">
		          <cfif LEN(numberofmatches)><span class="bolditem">Listings:</span> #numberofmatches#, </cfif>
		          <cfif LEN(wsid)><span class="bolditem">Property Type:</span> #wsid#, </cfif>
		          <cfif LEN(pmin) or LEN(pmax)><span class="bolditem">Price:</span> #dollarformat(pmin)# - #dollarformat(pmax)#, </cfif>
		          <cfif LEN(Bedrooms) or LEN(baths_Full)><span class="bolditem">Beds:</span> #bedrooms# Baths: #baths_Full#, </cfif>
		          <cfif LEN(subdivision)><span class="bolditem">Subdivision:</span> #subdivision#, </cfif>
		          <cfif LEN(stipulations)><span class="bolditem">Stipulations:</span> #stipulations#, </cfif>
		          <cfif LEN(shortsale)><span class="bolditem">Short Sale:</span> Yes, </cfif>
		          <cfif LEN(foreclosure)><span class="bolditem">Foreclosure:</span> Yes, </cfif>
		          <cfif LEN(mlsnumber)><span class="bolditem">MLS Number:</span> #mlsnumber#, </cfif>
		          <cfif LEN(Kind)><span class="bolditem">kind:</span> #kind#, </cfif>
		            <cfif LEN(area)><span class="bolditem">Area(s):</span> 
		              <cfloop list="#area#" index="i" >
		                <cfif LEN(i) and isNumeric(i)>
		                	#CapFirstTitle(GetAreaName(i))#
		                </cfif>
		              </cfloop>
		            </cfif>
		          
		          <cfif LEN(Lot_description)><span class="bolditem">Lot:</span> #Lot_description#</cfif>
		      </td>
		    </tr>
	  	</tbody>
    </cfoutput>


<cfelseif isdefined('url.display') and url.display eq "Activity">
	<thead>
	    <tr>
	      <th width="15%">Date</th>
	      <th width="25%">Action</th>
	      <th width="*">Referring Site</th>
	      <th width="10%">MLS Number</th>
	    </tr>
	</thead>
    <cfoutput query="graybox" startrow="#start_record#" maxrows="#records_per_page#">
    <tbody>
	    <tr>
	      <td class="agent">#dateformat(createdat,'mm/dd/yyyy')# #timeformat(createdat,'hh:mm tt')#</td>
	      <td class="agent">#action#</td>
	      <td class="agent"><cfif RefferingSite is not "N/A"><a hreflang="en" href="#RefferingSite#" target="_blank">#left(RefferingSite,'100')#</a><cfelse>#RefferingSite#</cfif></td>
	      <td class="agent"><cfif LEN(mlsnumber)><a hreflang="en" href="/mls/search-results.cfm?mlsnumber=#mlsnumber#" target="new">#mlsnumber#</a></cfif></td>
	    </tr>
    </tbody>
    </cfoutput>


<cfelseif isdefined('url.display') and url.display eq "Views">
	<thead>
    <tr>
      <th width="10%">Date</th>
      <th>MLS Number</th>
      <th>Property Info</th>
    </tr>
	</thead>
    <cfoutput query="graybox"  startrow="#start_record#" maxrows="#records_per_page#">
    <tbody>
    <tr>
      <td class="agent">#dateformat(createdat, 'mm/dd/yy')#</td>
      <td class="agent"><a hreflang="en" href="/mls/search-results.cfm?mlsnumber=#mlsnumber#&wsid=#wsid#&mlsid=#mlsid#&clearsession=" target="_blank">#mlsnumber#</a> </td>
      <td class="agent">#GetFavInfo(mlsnumber,mlsid)#</td>
    </tr>
    </tbody>
    </cfoutput>


<cfelseif isdefined('url.display') and url.display eq "Drip">
	<thead>
    <tr>
      <th width="10%">Created</th>
      <th>Name</th>
      <th>Start Date</th>
      <th>Status</th>
      <th>Last Sent</th>
    </tr>
	</thead>
    <cfoutput query="graybox"  startrow="#start_record#" maxrows="#records_per_page#">
    <tbody>
    <tr>
      <td class="agent">#dateformat(createdat, 'mm/dd/yy')#</td>
      <td class="agent"><a hreflang="en" href="drip-campaign-lead.cfm?campaignid=#id#&clientid=#url.id#">#PlanName#</a></td>
      <td class="agent">#dateformat(DripStartDate, 'mm/dd/yy')#</td>
      <td class="agent">#Status#</td>
      <td class="agent">#dateformat(LastSent, 'mm/dd/yy')#</td>
    </tr>
    </tbody>
    </cfoutput>

<cfelseif isdefined('url.display') and url.display eq "Showing">
	<thead>
    <tr>
      <th width="10%">Created</th>
      <th width="10%">MLS Number</th>
      <th width="10%">Show Date</th>
      <th width="20%">Address</th>
      <th width="*">Notes</th>
    </tr>
	</thead>
  <cfoutput query="graybox"  startrow="#start_record#" maxrows="#records_per_page#">
      <tbody>
      <tr>
        <td class="agent">#dateformat(createdat, 'mm/dd/yy')#</td>
        <td class="agent">#mlsnumber#</td>
        <td class="agent">#dateformat(showdate, 'mm-dd-yyyy')# #timeformat(showdate, 'h:mm tt')#</td>
        <td class="agent">#Address#</td>
        <td class="agent">#notes#</td>
      </tr>
    </tbody>
  </cfoutput>



<cfelseif isdefined('url.display') and url.display eq "ListInfo" or url.display eq "PastPur" or url.display eq "PendPur">
	<thead>
    <tr>
      <th>Agent</th>
      <th>Address</th>
      <th>City/State</th>
      <th>Type</th>
      <th>MLS</th>
      <th>List Price</th>
      <th></th>
    </tr>
	</thead>
<cfoutput query="graybox"  startrow="#start_record#" maxrows="#records_per_page#">
    <tbody>
	    <tr title="Click to View Full Listing Info" onclick="javascript:hideshow(document.getElementById('listings#graybox.id#'))">
	      <td class="agent">#GetAgentName(agentid)#</td>
	      <td class="agent">#Address#</td>
	      <td class="agent">#city# #state#</td>
	      <td class="agent">#proptype#</td>
	      <td class="agent">#mlsnumber#</td>
	      <td class="agent">#List_Price#</td>
	      <td class="agent"></td>
	    </tr>
	    <tr>
		    <td colspan="7" id="listings#graybox.id#" style="display:none;">
			    <div class="infobox-gray">
				      <table style="width:100%;" border="1">
					        <tr>
					          <td width="*" align="left"><span><b>Address:</b></span> #Address# #city#, #state# #zip_code#</td>
					          <td width="20%"><span><b>List Price:</b></span> #dollarformat(List_Price)#</td>
					          <td width="30%">
						            <a hreflang="en" href="/admin/contacts/lightboxes/listing.cfm?id=#graybox.id#" class="fb_listing fancybox.iframe"><input type="button" name="submit" value="Edit Listing" onclick="##"></a><br>
						            <cfif url.display eq "ListInfo">
						              <input type="button" name="submit" value="Move to Pending Purchases" onclick="window.location='/admin/contacts/contacts2.cfm?action=Edit&id=8586&display=#url.display#&ChangeType=Pending&listing=#graybox.id###LOC';"><br>
						              <input type="button" name="submit" value="Mark as Sold / Move to Past Purchases" onclick="window.location='/admin/contacts/contacts2.cfm?action=Edit&id=8586&display=#url.display#&ChangeType=Past&listing=#graybox.id###LOC';"><br>
						            <cfelseif url.display eq "PastPur">
						             <input type="button" name="submit" value="Move to Listings" onclick="window.location='/admin/contacts/contacts2.cfm?action=Edit&id=8586&display=#url.display#&ChangeType=Active&listing=#graybox.id###LOC';"><br>
						                           <input type="button" name="submit" value="Move to Pending Purchases" onclick="window.location='/admin/contacts/contacts2.cfm?action=Edit&id=8586&display=#url.display#&ChangeType=Pending&listing=#graybox.id###LOC';"><br>
						            <cfelseif url.display eq "PendPur">   
						              <input type="button" name="submit" value="Move to Listings" onclick="window.location='/admin/contacts/contacts2.cfm?action=Edit&id=8586&display=#url.display#&ChangeType=Active&listing=#graybox.id###LOC';"><br>
						              <input type="button" name="submit" value="Sold / Move to Past Purchases" onclick="window.location='/admin/contacts/contacts2.cfm?action=Edit&id=8586&display=#url.display#&ChangeType=Past&listing=#graybox.id###LOC';"><br>
						            </cfif>
						            <a hreflang="en" href="##" onclick="javascript:hideshow(document.getElementById('listings#graybox.id#'))"><input type="button" name="submit" value="Close" onclick="##">
					          </td>
					        </tr>
					        <tr>
					          <td colspan="3" align="left"><span><b>Property Type:</b></span> #proptype#</td>
					        </tr>
					        <tr>
					          <td align="left"><span><b>Date Listed:</b></span> #dateformat(list_date, 'yyyy-mm-dd')#</td>
					          <td><span><b>Date Expires:</b></span> #dateformat(expire_date, 'yyyy-mm-dd')#</td>
					          <td><span><b>MLS ##:</b></span> #mlsnumber#</td>
					        </tr>
					        <tr>
					          <td colspan="3" align="left"><span><b>Agent:</b></span> #GetAgentName(agentid)#</td>
					        </tr>
					        <tr>
					          <td colspan="3" align="left"><span><b>Notes:</b></span><br>#notes#</td>
					        </tr>
				      </table>
			    </div>
			</td>
		</tr>
     </tbody>
</cfoutput>


<cfelseif isdefined('url.display') and url.display eq "SecContacts">
	<tbody>
		<cfoutput query="graybox" maxrows="1">
		<cfif LEN(graybox.birthday)>
		      <tr>
		        <td width="15%">Birthday:</td>
		        <td width="*">#birthday#</td>
		      </tr>
		</cfif>
		<cfif LEN(graybox.spousefirstname)>
		      <tr>
		        <td>Spouse's First Name:</td>
		        <td>#spousefirstname#</td>
		      </tr>
		</cfif>
		<cfif LEN(graybox.spouselastname)>
		      <tr>
		        <td>Spouse's Last Name:</td>
		        <td>#spouselastname#</td>
		      </tr>
		</cfif>
		<cfif LEN(graybox.spouseemail)>
		      <tr>
		        <td>Spouse's Email:</td>
		        <td>#spouseemail#</td>
		      </tr>
		</cfif>
		<cfif LEN(graybox.spousephone)>
		      <tr>
		        <td>Spouse's Phone:</td>
		        <td>#spousephone#</td>
		      </tr>
		</cfif>
		<cfif LEN(graybox.children)>
		      <tr>
		        <td>Children:</td>
		        <td>#children#</td>
		      </tr>
		</cfif>
		<cfif LEN(graybox.facebook)>
		      <tr>
		        <td>Facebook:</td>
		        <td><a hreflang="en" href="<cfif facebook does not contain "http://">http://</cfif>#facebook#" target="_blank">#facebook#</a></td>
		      </tr>
		</cfif>
		<cfif LEN(graybox.twitter)>
		      <tr>
		        <td>Twitter:</td>
		        <td><a hreflang="en" href="<cfif twitter does not contain "http://">http://</cfif>#twitter#" target="_blank">#twitter#</a></td>
		      </tr>
		</cfif>
		</cfoutput>
</tbody>



<cfelseif isdefined('url.display') and url.display eq "Documents">
	<thead>
    <tr>
      <th width="10%">Date</th>
      <th width="20%">Title</th>
      <th width="*">File</th>
      <th width="10%">Action</th>
    </tr>
	</thead>
	<tbody>
	  <cfoutput query="graybox"  startrow="#start_record#" maxrows="#records_per_page#">
	      <tr>
	        <td class="agent">#dateformat(createdat, 'mm/dd/yy')#</td>
	        <td class="agent">#documenttitle#</td>
	        <td class="agent"><a hreflang="en" href="/admin/contacts/clientdocs/#filename#" target="_blank">#filename#</a></td>
	        <td class="agent"><a hreflang="en" href="#script_name#?Action=Edit&DeleteDocument=#graybox.id#&id=#url.id#&deletefilename=#filename#&display=Documents##LOC" class="delete"  onClick="return NoteConfirm();">delete</a></td>
	      </tr>
	  </cfoutput>
	</tbody>


</cfif>	
</table>			







			</div>
		</section>