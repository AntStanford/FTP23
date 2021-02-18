<style>
 
</style>

<cfset page.title ="Property Enhancement">
<cfinclude template="/admin/components/header.cfm">  

<cfquery name="getEnhancements" dataSource="#settings.booking.dsn#">
  select * 
  from cms_property_enhancements
</cfquery>

<cfif settings.booking.pms eq 'Homeaway'>
   
   <cfquery name="getinfo" dataSource="#settings.booking.dsn#">
     select 
     strpropid as property_id,
     strname as property_name
     from pp_propertyinfo
     order by strname
   </cfquery>

<cfelseif settings.booking.pms eq 'Barefoot'>
   
   <cfquery name="getinfo" dataSource="#settings.booking.dsn#">
     select 
     propertyid as property_id,
     name as property_name 
     from bf_properties
     order by name
   </cfquery>
   
<cfelseif settings.booking.pms eq 'Escapia'>
   
   <cfquery name="getinfo" dataSource="#settings.booking.dsn#">
     select 
     unitcode as property_id,
     unitshortname as property_name
     from escapia_properties
     order by unitshortname
   </cfquery>
      
</cfif>  

<cfif isdefined('message') and len(message)>
  <div class="alert alert-success">
    <button class="close" data-dismiss="alert">x</button>
    <strong><cfoutput>#message#</cfoutput></strong>
  </div>
</cfif>

<div class="widget-box">
  <div class="widget-title">
    <span class="icon">
      <i class="icon-th"></i>
    </span>  
  	<h5>Properties</h5>
  </div>
  <div class="widget-content nopadding">
    <table class="table table-bordered table-striped table-hover" style="font-size:14px;">
    
    <cfoutput query="getinfo">
      
      <form method="post" action="form.cfm" id="theForm">          
         <cfif currentrow eq 1>
         <tr>
            <th>No.</th>
            <th>Property ID</th>
            <th>Property Name</th>    
            <!---<th>New Property</th> 
            <th>Show On Website</th>                    --->
            <th></th>
         </tr>        
         </cfif>         
         <tr>
            <td><a name="#property_id#"></a>#currentrow#.</td>
            <td>#property_id#</td>
            <td>#property_name#</td>  
            <!---<cfquery name="getnew" dbtype="query">
              select new
              from getEnhancements 
              where strpropid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#property_id#">
            </cfquery>
            <cfquery name="getshow" dbtype="query">
              select showonsite
              from getEnhancements 
              where strpropid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#property_id#">
            </cfquery>
            <cfif getnew.recordcount gt 0 and getnew.new eq 'Yes'>
              <td width="50" style="text-align:right"><input type="checkbox" checked="checked" data-toggle="toggle" class="toggle-event newprop" data-propertyid="#property_id#" data-new="No"></td>
            <cfelse>
              <td width="50" style="text-align:right"><input type="checkbox" data-toggle="toggle" class="toggle-event newprop" data-propertyid="#property_id#" data-new="Yes"></td>
            </cfif>  
            <cfif getshow.recordcount gt 0 and getshow.showonsite eq 'Yes'>
              <td width="50" style="text-align:right"><input type="checkbox" checked="checked" data-toggle="toggle" class="toggle-event showprop" data-propertyid="#property_id#" data-show="No"></td>
            <cfelse>
              <td width="50" style="text-align:right"><input type="checkbox" data-toggle="toggle" class="toggle-event showprop" data-propertyid="#property_id#" data-show="Yes"></td>
            </cfif>                --->
            <td width="50" style="text-align:right"><a href="form.cfm?id=#property_id#&name=#property_name#" class="btn btn-success">Edit</a></td>            
         </tr>        
       </form> 
    </cfoutput>
    
</table>

<script type="text/javascript">

	$(document).ready(function(){

		$('.newprop').change(function() {

         var propertyid = $(this).data('propertyid');
         var datanew = $(this).data('new');

         $.ajax({
   			url: 'submit.cfm?propertyid='+propertyid+'&datanew='+datanew,
   			success: function(data) {
   			   //do nuthin
   			}
         });


      });

      $('.showprop').change(function() {

          var propertyid = $(this).data('propertyid');
          var datashow = $(this).data('show');

          $.ajax({
          url: 'submit.cfm?propertyid='+propertyid+'&datashow='+datashow,
          success: function(data) {
            //do nuthin
          }
          });


      });

	});

</script>

<cfinclude template="/admin/components/footer.cfm">