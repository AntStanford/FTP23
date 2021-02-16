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


<cfoutput>
<div class="contacts-pagination-area">

<form method="post" action="#cgi.script_name#">

      <cfif isdefined('url.display') and url.display neq 'LeadTracker'>

            <span class="resultSelector">
              Page #page#  of #ceiling(totalpages)#

              &nbsp;
              <select onchange="this.options[this.selectedIndex].value && (window.location = this.options[this.selectedIndex].value);" style="width: 150px; display:inline;" >
                <option value="">Select a page &##172;</option>
                <cfloop from="1" to="#ceiling(totalpages)#" index="pg">
                  <option  value="#cgi.script_name#?page=#pg#&action=edit&id=#url.id#&display=#url.display###LOC">#pg#  
                </cfloop>
              </select>
              &nbsp;

            </span>

            <!--- START: ADD NEW BUTTON --->
            <span class="newRow">
              <cfif isDefined('url.display') and url.display eq "Notes">
                <a class="fb_add-reload fancybox.iframe" href="/admin/contacts/lightboxes/notes.cfm?id=#url.id#"><input type="button" name="submit" value="Add" onclick="##"></a>
              <cfelseif isDefined('url.display') and (url.display eq "ListInfo" or url.display eq "PastPur" or url.display eq "PendPur")>
                <a class="fb_listing-add fancybox.iframe" href="/admin/contacts/lightboxes/listing.cfm?clientid=#url.id#"><input type="button" name="submit" value="Add" onclick="##"></a>
              <cfelseif isDefined('url.display') and url.display eq "Documents">
                 <a class="fb_add-reload fancybox.iframe" href="/admin/contacts/lightboxes/documents.cfm?id=#url.id#"><input type="button" name="submit" value="Add" onclick="##"></a>
              <cfelseif isDefined('url.display') and url.display eq "SecContacts"> 
               <a class="fb_add-reload fancybox.iframe" href="/admin/contacts/lightboxes/secondary.cfm?id=#url.id#"><input type="button" name="submit" value="Edit" onclick="##"></a>  
              <cfelseif isDefined('url.display') and url.display eq "Showing">
                <a class="fb_listing-add fancybox.iframe" href="/admin/contacts/lightboxes/addshowing.cfm?clientid=#url.id#"><input type="button" name="submit" value="Add" onclick="##"></a> 
              <cfelseif isDefined('url.display') and url.display eq "Phone">
                <a class="fb_listing-add fancybox.iframe" href="/admin/contacts/lightboxes/phonecall.cfm?clientid=#url.id#"><input type="button" name="submit" value="Add" onclick="##"></a> 
      <!---          <cfelseif isDefined('url.display') and url.display eq "LeadTracker">
                <a hreflang="en" href="mailto:#getContact.email#?subject=Correspondence from #mls.companyname# - #GetAgent.Firstname# #GetAgent.Lastname#&bcc=#mls.BCCToCRM#">Send Using Outlook or 3rd Party Installed Email Program</a> --->
              </cfif>
            </span>
          <!--- END: ADD NEW BUTTON --->

           <span class="viewing">View #start_record# - 
             <cfif isdefined('graybox.recordcount')>
               <cfif to_record gt graybox.recordcount>#graybox.recordcount#<cfelse>#to_record#</cfif>  of #graybox.recordcount#
              <cfelse>
                0
             </cfif> 
           </span>

        <cfelse>
                       <!---  <a hreflang="en" href="mailto:#getContact.email#?bcc=#mls.BCCToCRM#&subject=Correspondence from #URLEncodedFormat(mls.companyname)# - #GetAgent.Firstname# #GetAgent.Lastname#">Send Using Outlook or 3rd Party Installed Email Program</a> --->
      </cfif>

</form>


  </div>
  </cfoutput>