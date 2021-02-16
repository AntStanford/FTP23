<cfset page.title ="Unifocus Reviews">

<cfquery name="GetProperties" datasource="#settings.dsn#">
  Select strpropid from pp_propertyinfo order by strpropid
</cfquery>

<cfparam name="form.strpropid" default="#GetProperties.strpropid#">
<cfparam name="url.strpropid" default="#form.strpropid#">

<cfquery name="getinfo" dataSource="#settings.dsn#">
  select * from cms_unifocus_reviews 
  where roomnumber = <cfqueryparam value="#url.strpropid#" cfsqltype="cf_sql_varchar"> 
  order by surveydate desc
</cfquery>

<cfinclude template="/admin/components/header.cfm">  

<div style="height:50px">
  <div class="alert alert-success" style="display:none" id="success">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <strong>Success!</strong> Rating is updated
  </div>
  <div class="alert alert-danger" style="display:none" id="failure">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <strong>Failure!</strong> Rating not updated
  </div>
</div>


<form action="index.cfm" method="post">
  Select Property: 
  <select name="strpropid" onchange="this.form.submit()" style="width:300px">
    <cfoutput query="GetProperties">
      <option value="#strpropid#" <cfif strpropid eq url.strpropid>selected</cfif>>#strpropid#</option>
    </cfoutput>
  </select>
</form> 

<div class="widget-box">
  <div class="widget-title">
    <span class="icon">
      <i class="icon-th"></i>
    </span>  
  	<h5><cfoutput>#page.title#</cfoutput></h5>
  </div>

  <div class="widget-content nopadding">
    <table class="table table-bordered table-striped">
    <tr>
      <th>No.</th>
      <th>Name</th> 
      <th>Email</th>         
      <th>Arrival</th> 
      <th>Departure</th> 
      <th>Submitted</th> 
      <th>Rating</th>
      <th></th>  
    </tr>        
    <cfset lastEmail = ''>
    <cfoutput query="getinfo">
      <cfif lastEmail neq email>
        <cfif lastEmail neq ''>
          <tr><td colspan="8"></td></tr>
        </cfif>
        <tr>
          <td width="45">#currentrow#.</td>
          <td>#guestname#</td> 
          <td>#email#</td> 
          <td width="80">#dateformat(arrivaldate,'m/d/yyyy')#</td>      
          <td width="80">#dateformat(departuredate,'m/d/yyyy')#</td>    
          <td width="80">#dateformat(surveydate,'m/d/yyyy')#</td>
          <td width="50"><input type="text" id="#id#" class="rating" style="width:45px" value="#rating#" placeholder="Rating"></td>         
          <td width="75">
              <a <!--- href="index.cfm?strpropid=#url.strpropid#&id=#id#&approve" ---> id="approve#id#"
                class="btn btn-mini btn-primary approve" <cfif approved eq '1'>style="display:none"</cfif>>
                  <i class="icon-thumbs-up icon-white"></i> Approve</a>
               <a <!--- href="index.cfm?strpropid=#url.strpropid#&id=#id#&remove" ---> id="remove#id#"
                class="btn btn-mini btn-success remove" <cfif approved eq '0'>style="display:none"</cfif>>
                  <i class="icon-thumbs-up icon-white"></i> Remove</a>
          </td>                  
        </tr>
      </cfif>
      <cfset lastEmail = email>
      <tr>
        <td></td><td colspan="6">
          <strong>#commentCategory#:</strong> #commentVerbatim#
        </td><td></td>
      </tr>
    </cfoutput>
    </table>
  </div>
</div>

<cfinclude template="/admin/components/footer.cfm">


<script>

$(document).ready(function() {
    $('.rating').change(function() {
      var id = $(this).attr('id');
      var rating = $( this ).val();
      // console.log(id);
      // console.log(rating);
        $.ajax({
          url: 'update-rating.cfm?id=' + id + '&rating=' + rating,
          success: function(response){
            response = $.trim(response);
            if(response === "success") { 
              $('#failure').hide();
              $('#success').show().delay(1000).fadeOut('slow');
            }
            else {
              $('#failure').show().delay(3000).fadeOut('slow');
              $('#success').hide();
            }
          }
        });
    });

    $('.remove').click(function() {
      var id = $(this).attr('id');

        $.ajax({
          url: 'approve.cfm?id=' + id + '&remove',
          success: function(response){
            response = $.trim(response);
            if($.isNumeric(response)) { 
              $('#remove'+response).hide();
              $('#approve'+response).show();
            }
          }
        });

    });

    $('.approve').click(function() {
      var id = $(this).attr('id');

        $.ajax({
          url: 'approve.cfm?id=' + id + '&approve',
          success: function(response){
            response = $.trim(response);
            if($.isNumeric(response)) { 
              $('#remove'+response).show();
              $('#approve'+response).hide();
            }
          }
        });

    });



});

</script>