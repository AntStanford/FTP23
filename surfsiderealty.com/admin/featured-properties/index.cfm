<cfset page.title ="Featured Properties">
<cfinclude template="/admin/components/header.cfm">  

<cfquery name="getFeaturedProperties" dataSource="#settings.dsn#">
   select strpropid from cms_featured_properties
</cfquery>

<cfset propList = ValueList(getFeaturedProperties.strpropid)>

   
<cfquery name="getinfo" dataSource="#settings.booking.dsn#">
 select unitcode,unitshortname,address 
 from escapia_properties
 order by unitshortname
</cfquery>
      
      
<cfif isdefined('message') and len(message)>
  <div class="alert alert-success">
    <button class="close" data-dismiss="alert">x</button>
    <strong><cfoutput>#message#</cfoutput></strong>
  </div>
</cfif>

<div class="alert">
Directions: You have two options with this module:<br /><br />
<ol>
   <li>The website will pick properties at random for your homepage featured properties module OR</li>
   <li>You can manually choose which properties you want to appear on your homepage</li>
</ol>
If you want the website to display properties at random, leave all the property options below set to 'OFF'; otherwise the website
will only display the properties you have chosen below that are set to 'ON'.  
<br /><br />Selected properties will also appear in random order for each guest.
</div>
    
    <div id="console-event"></div>
    
<div class="widget-box">
  <div class="widget-title">
    <span class="icon">
      <i class="icon-th"></i>
    </span>  
  	<h5>Properties</h5>
  </div>
  <div class="widget-content nopadding">
    <table class="table table-bordered table-striped table-hover">
    
    <cfoutput query="getinfo">
      
      <form method="post" action="form.cfm" id="theForm">          
         <cfif currentrow eq 1>
         <tr>
            <th>No.</th>
            <th>Property ID</th>
            <th>Name</th>              
            <th>Address</th>
            <th></th>
         </tr>        
         </cfif>
         <tr>
            <td><a name="#unitcode#"></a>#currentrow#.</td>
            <td>#unitcode#</td>
            <td>#unitshortname#</td>
            <td>#address#</td>
            <cfif ListFind(propList,unitcode)>
               <td colspan="9" style="text-align:right"><input type="checkbox" data-toggle="toggle" class="toggle-event" data-propertyid="#unitcode#" checked="checked"></td>              
            <cfelse>
               <td colspan="9" style="text-align:right"><input type="checkbox" data-toggle="toggle" class="toggle-event" data-propertyid="#unitcode#"></td>
            </cfif>
         </tr>
       </form> 
    </cfoutput>
    
</table>

<script type="text/javascript">

	$(document).ready(function(){
		
		$('.toggle-event').change(function() {
		    
         var propertyid = $(this).data('propertyid');
         
         $.ajax({
   			url: 'submit.cfm?propertyid='+propertyid,
   			success: function(data) {
   			   //do nuthin
   			}
         });
         
         
      });
		
	});

</script>

<cfinclude template="/admin/components/footer.cfm">