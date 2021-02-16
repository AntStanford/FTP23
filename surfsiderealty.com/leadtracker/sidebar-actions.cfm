<h3>Actions</h3>

<ul>
	<li><a hreflang="en" href="contact-details.cfm">Create New Contact</a></li>
    <cfif isdefined('url.id')><li><a class="fb_listing-add fancybox.iframe" href="/admin/contacts/lightboxes/listing.cfm">Create New Listing</a></li></cfif>
    <li><a hreflang="en" class="fb_activity fancybox.iframe" href="/admin/McCalendar/activity.cfm">Create New Activity</a></li>
    <li><a  hreflang="en" class="fb_activity fancybox.iframe" href="/admin/McCalendar/activities.cfm?dates=missed">My Missed Activities</a></li>
    <li><a hreflang="en" class="fb_activity fancybox.iframe" href="/admin/McCalendar/activities.cfm?dates=open">My Open Activities</a></li>
    <!--- <li><a hreflang="en" href="/admin/contacts/contacts.cfm?agentid=">Unassigned Contacts</a></li> --->
</ul>

		