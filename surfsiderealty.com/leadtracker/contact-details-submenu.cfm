<cfparam name="url.display" default="LeadTracker">
<cfparam name="SubSection" default="Lead Tracker">

<cfoutput>
	<nav>
		<div><button class="btn btn-plain <cfif isdefined('url.display') and url.display eq 'LeadTracker'>active</cfif>" type="button" id="messages" onclick="javascript:location.href='#cgi.script_name#?id=#url.id#&display=LeadTracker##LOC'">Messages</button></div>
		<div><button class="btn btn-plain <cfif isdefined('url.display') and url.display eq 'Notes'>active</cfif>" type="button" id="notes" onclick="javascript:location.href='#cgi.script_name#?id=#url.id#&display=Notes##LOC'">Notes (#GetInsideData('Notes')#)</button></div>
		<div class="dropdown">
		<button class="btn btn-plain dropdown-toggle <cfif isdefined('url.display') and url.display contains 'History' or url.display eq 'Phone'>active</cfif>" type="button" id="history" data-toggle="dropdown">History (#(GetInsideData('History') + GetInsideData('Phone'))#)<span class="caret"></span></button>
		<ul class="dropdown-menu" role="menu" aria-labelledby="history">
			<li role="presentation"><a role="menuitem" tabindex="-1" href="#cgi.script_name#?id=#url.id#&display=AllHistory##LOC">All</a></li>
			<li role="presentation"><a role="menuitem" tabindex="-1" href="#cgi.script_name#?id=#url.id#&display=History##LOC">Emails (#GetInsideData('History')#)</a></li>
			<li role="presentation"><a role="menuitem" tabindex="-1" href="#cgi.script_name#?id=#url.id#&display=Phone##LOC">Phone Calls (#GetInsideData('Phone')#)</a></li>
		</ul>
		</div>
		<div class="dropdown">
		<button class="btn btn-plain dropdown-toggle <cfif isdefined('url.display') and url.display eq 'Favorites' or url.display eq 'SavedSearches' or url.display eq 'Activity'>active</cfif>" type="button" id="insight" data-toggle="dropdown" >Insight (#(GetInsideData('SavedSearches') + GetInsideData('AllSearches') + GetInsideData('Favorites') + GetInsideData('Activity') + GetInsideData('Views') + GetInsideData('Drip'))#)<span class="caret"></span></button>
		<ul class="dropdown-menu" role="menu" aria-labelledby="history">
			<li role="presentation"><a role="menuitem" tabindex="-1" href="#cgi.script_name#?id=#url.id#&display=Favorites##LOC">Favorites (#GetInsideData('Favorites')#)</a></li>
			<li role="presentation"><a role="menuitem" tabindex="-1" href="#cgi.script_name#?id=#url.id#&display=SavedSearches##LOC">Saved Searches  (#GetInsideData('SavedSearches')#)</a></li>
			<li role="presentation"><a role="menuitem" tabindex="-1" href="#cgi.script_name#?id=#url.id#&display=AllSearches##LOC">All Searches (#GetInsideData('AllSearches')#)</a></li>
			<li role="presentation"><a role="menuitem" tabindex="-1" href="#cgi.script_name#?id=#url.id#&display=Activity##LOC">Activity  (#GetInsideData('Activity')#)</a></li>
			<li role="presentation"><a role="menuitem" tabindex="-1" href="#cgi.script_name#?id=#url.id#&display=Views##LOC">Views  (#GetInsideData('Views')#)</a></li>
			<li role="presentation"><a role="menuitem" tabindex="-1" href="#cgi.script_name#?id=#url.id#&display=Drip##LOC">Drip Campaigns (#GetInsideData('Drip')#)</a></li>
		</ul>
		</div>
		<div><button class="btn btn-plain <cfif isdefined('url.display') and url.display eq 'Showing'>active</cfif>" type="button" id="showings" onclick="javascript:location.href='#cgi.script_name#?id=#url.id#&display=Showing##LOC'">Showings (#GetInsideData('shows')#)</button></div>
		<div><button class="btn btn-plain <cfif isdefined('url.display') and url.display eq 'ListInfo'>active</cfif>" type="button" id="listings" onclick="javascript:location.href='#cgi.script_name#?id=#url.id#&display=ListInfo##LOC'">Listings (#GetInsideData('ListInfo')#)</button></div>
		<div class="dropdown">
		<button class="btn btn-plain dropdown-toggle <cfif isdefined('url.display') and url.display eq 'PendPur' or url.display eq 'PastPur'>active</cfif>" type="button" id="purchases" data-toggle="dropdown">Purchases (#(GetInsideData('PendPur') + GetInsideData('PastPur'))#)<span class="caret"></span></button>
		<ul class="dropdown-menu" role="menu" aria-labelledby="purchases">
			<li role="presentation"><a role="menuitem" tabindex="-1" href="#cgi.script_name#?id=#url.id#&display=PendPur##LOC">Pending</a></li>
			<li role="presentation"><a role="menuitem" tabindex="-1" href="#cgi.script_name#?id=#url.id#&display=PastPur##LOC">Past</a></li>
		</ul>
		</div>
		<div><button class="btn btn-plain <cfif isdefined('url.display') and url.display eq 'SecContacts'>active</cfif>" type="button" id="listings" onclick="javascript:location.href='#cgi.script_name#?id=#url.id#&display=SecContacts##LOC'">Sec. Info<!---  (#GetInsideData('SecContacts')#) ---></button></div>
		<div><button class="btn btn-plain <cfif isdefined('url.display') and url.display eq 'Documents'>active</cfif>" type="button" id="listings" onclick="javascript:location.href='#cgi.script_name#?id=#url.id#&display=Documents##LOC'">Docs (#GetInsideData('Documents')#)</button></div>
	</nav>
</cfoutput>