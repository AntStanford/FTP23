<cfinclude template="/sales/components/header.cfm">
<cfinclude template="/sales/includes/session-killer.cfm">

<div class="full-width" id="content">
  <div class="mls-advanced-search">
    <script language="javascript">
    function NoteConfirm() {
      var answer = confirm ("<cfoutput>#cookie.UserFirstname#</cfoutput>, Are you sure you would like to delete this listing?");
      if (answer){
        //alert ("Archived!");
        return true;
        //document.getElementById('LeadForm').submit();
      }else{
        return false;
      }
    }
    </script>
    <h1>Unsubscribe From Save Search Notification</h1>



    <!---START: SHOW ALL FAVORITES--->
    <cfif isdefined('url.RemoveID')>
      <cfset decryptedID = DecryptID(#RemoveID#)>
      <cfquery datasource="#mls.dsn#" name="GetInfo">
        delete
        FROM cl_saved_searches
        where id = <cfqueryparam cfsqltype="cf_sql_varchar" value='#decryptedID#'>
      </cfquery>
      <cfquery datasource="#mls.dsn#" name="GetInfo">
        delete
        FROM cl_saved_searches_props_returned
        where searchid = <cfqueryparam cfsqltype="cf_sql_varchar" value='#decryptedID#'>
      </cfquery>
      <p>This search has been deleted from your "Saved Search Profile".</p>
    </cfif>
    <cfif isdefined('url.unsubscribe')>
      <cfoutput>
        <p>Are you sure you would like to delete this search: #url.unsubsearchname#? <a hreflang="en" href="#script_name#?RemoveID=#unsubscribe#">Yes</a></p>
        <p>Remember, you can always <a hreflang="en" href="/sales/index.cfm?LinkToLogin=">login</a> and adjust the email notification frequency of this search.</p>
      </cfoutput>
    </cfif>
  </div>
</div>

<cfinclude template="/sales/components/footer.cfm">