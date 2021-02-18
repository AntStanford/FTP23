<cfinclude template="/components/header.cfm">


<div class="full-width" id="content">
  <div class="mls-advanced-search">
    <script language="javascript">
    function NoteConfirm() {
      var answer = confirm ("Are you sure you would like to delete this listing?");
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
      <cfquery datasource="#settings.mls.propertydsn#" name="GetInfo">
        delete
        FROM cl_saved_searches
        where id = '#decryptedID#'
      </cfquery>
      <cfquery datasource="#settings.mls.propertydsn#" name="GetInfo">
        delete
        FROM cl_saved_searches_props_returned
        where searchid = '#decryptedID#'
      </cfquery>
      <p>This search has been deleted from your profile.</p>
    </cfif>
    <cfif isdefined('url.unsubscribe')>
      <cfoutput>
        <p>Are you sure you would like to delete this search: #url.unsubsearchname#? <a href="#script_name#?RemoveID=#unsubscribe#">Yes</a></p>
        <p>Remember, you can always <a href="/mls/login.cfm">login</a> and adjust the email notification frequency of this search.</p>
      </cfoutput>
    </cfif>
  </div>
</div>

<cfinclude template="/components/footer.cfm">