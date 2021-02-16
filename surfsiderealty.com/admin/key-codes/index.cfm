<cfset page.title = 'Key Codes'>

<cfparam name="form.startDate" default="#now()#">
<cfparam name="form.endDate" default="#dateadd('w', 2, now())#">
<cfparam name="form.hasCode" default="no">

<cfquery name="getinfo" dataSource="#settings.dsn#">
  select * 
  from pp_guestreservationinfo
  left outer join cms_key_codes on cms_key_codes.intquotenum = pp_guestreservationinfo.intquotenum
  where pp_guestreservationinfo.dtCheckoutDate > <cfqueryparam value="#form.startDate#" cfsqltype="cf_sql_date">
  and pp_guestreservationinfo.dtCheckoutDate < <cfqueryparam value="#form.endDate#" cfsqltype="cf_sql_date">
  <cfif form.hasCode eq 'no'>
    and cms_key_codes.emailsent is NULL
  <cfelse>
    and cms_key_codes.emailsent is not NULL
  </cfif>
  order by pp_guestreservationinfo.dtCheckinDate
</cfquery>

<cfquery name="GetIsEmailReady" dbtype="query" maxrows="1">
  Select keycode from getinfo where keycode is not Null
</cfquery>

<cfinclude template="/admin/components/header.cfm">

<cfif isdefined('url.success')>
  <div class="alert alert-success">
    <button class="close" data-dismiss="alert">×</button>
    <strong>Record deleted!</strong>
  </div>
</cfif>

<p>
<form action="index.cfm" method="post">
  <cfoutput>
    Start Date: <input type="text" class="datepicker" style="width:100px" name="startDate" value="#dateformat(form.startdate,'m/d/yyyy')#">
    End Date: <input type="text" class="datepicker" style="width:100px" name="endDate" value="#dateformat(form.endDate,'m/d/yyyy')#">
    Has Code: &nbsp; <label for="hasCodeno" style="display:inline-block"><input type="radio" name="hasCode" value="no" id="hasCodeno" 
                <cfif form.hasCode eq 'no'>checked</cfif>> No &nbsp; </label>
              <label for="hasCodeyes" style="display:inline-block"><input type="radio" name="hasCode" value="yes" id="hasCodeyes" 
                <cfif form.hasCode eq 'yes'>checked</cfif>> Yes &nbsp; </label>
    <input type="submit" value="Search" class="btn btn-success">
  </cfoutput>
</form>
</p>  


<cfif getinfo.recordcount gt 0>
<div class="widget-box">
  <div class="widget-content nopadding">
    <table class="table table-bordered table-striped">
    <tr>
      <th>Booking</th>
      <th>Property</th>
      <th>Guest</th>         
      <th>Checkin</th>
      <th>Checkout</th>
      <th>
        <a href="send-emails.cfm" class="btn btn-success btn-mini" id="btnSendEmails" <cfif GetIsEmailReady.recordcount eq 0>style="display:none"</cfif>>
          <i class="icon-envelope icon-white"></i> Send Emails</a>
      </th>  
    </tr>      
    <cfoutput query="getinfo">
      <tr>
        <td>#intquotenum#</td>
        <td>#strpropid#</td>
        <td>#strfirstname# #strlastname#</td> 
        <td>#dateformat(dtCheckinDate,'m/d/yyyy')#</td>                    
        <td>#dateformat(dtCheckoutDate,'m/d/yyyy')#</td>     
        <td>
          <cfif keycode neq ''>
            #keycode#
          <cfelse>
            <input class="kabaCode" id="#intquotenum#" name="kabaCode">
          </cfif>
        </td>    
      </tr>
    </cfoutput>
    </table>
  </div>
</div>
</cfif>

<cfinclude template="/admin/components/footer.cfm">


<script>
$(document).ready(function() {
  $(".kabaCode").change(function() {
    var jsCode = $(this).val();
    var jsID = $(this).attr('id');
    console.log(jsID + ' ' + jsCode);

    $.ajax({
       type: "POST",
       url: 'codeajax.cfm?code=' + jsCode + '&id=' + jsID,
       success: function(data) {
         $("#" + jsID).replaceWith( jsCode );
         $("#btnSendEmails").show();
       }
    });

  });
});
</script>
