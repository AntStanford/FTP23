<cfset page.title ="Longterm Rentals">
<cfset uppicture = #ExpandPath('/images/longtermrentals')#>


<cfif isdefined('url.id')>
  
  <cfquery name="getinfo" dataSource="#settings.dsn#">
    select * from cms_long_term_rentals where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>
  
</cfif>

<cfinclude template="/admin/components/header.cfm">  
  
<cfquery name="getStates" dataSource="#settings.bcdsn#">
	select * from states order by name_long
</cfquery> 
  
  
<cfoutput>

  <cfif isdefined('url.success') and isdefined('url.id')>
    <div class="alert alert-success">
      <button class="close" data-dismiss="alert">x</button>
      <strong>Update successful!</strong> Continue editing this long term rental or <a href="index.cfm">go back.</a>
    </div>
  <cfelseif isdefined('url.deletephoto') and isdefined('url.id')>
    <div class="alert alert-success">
      <button class="close" data-dismiss="alert">x</button>
      <strong>Photo deleted!</strong> Continue editing this long term rental or <a href="index.cfm">go back.</a>
    </div>
  <cfelseif isdefined('url.success')>
    <div class="alert alert-success">
      <button class="close" data-dismiss="alert">x</button>
      <strong>Insert successful!</strong> Add another long term rental or <a href="index.cfm">go back.</a>
    </div>
  </cfif>

    
  <div class="widget-box">
    <div class="widget-title">
      <span class="icon">
        <i class="icon-th"></i>
      </span>
      <h5>Add / Edit Form</h5>
    </div>
    <div class="widget-content nopadding">
  
      <form action="submit.cfm" method="post" class="form-horizontal" enctype="multipart/form-data">        
        
            <div class="control-group">
					<label class="control-label">Name</label>
					<div class="controls">
						<input type="text" name="name" <cfif parameterexists(id)>value="#getinfo.name#"</cfif>>
					</div>
				</div>
				

           	<div class="control-group">
					<label class="control-label">Address</label>
					<div class="controls">
						<input type="text" name="address1" <cfif parameterexists(id)>value="#getinfo.address1#"</cfif>>
					</div>
				</div>
				
           	<div class="control-group">
					<label class="control-label">Address 2</label>
					<div class="controls">
						<input type="text" name="address2" <cfif parameterexists(id)>value="#getinfo.address2#"</cfif>>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">City</label>
					<div class="controls">
						<input type="text" name="city" <cfif parameterexists(id)>value="#getinfo.city#"</cfif>>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">State</label>
					<div class="controls">
						<select name="state" style="width:200px">
							<cfloop query="getStates">
								<option <cfif parameterexists(id) and getinfo.state eq getStates.name_long>selected="selected"</cfif>>#name_long#</option>
							</cfloop>
						</select>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">Zip</label>
					<div class="controls">
						<input type="text" name="zip" <cfif parameterexists(id)>value="#getinfo.zip#"</cfif>>
					</div>
				</div>
				
				
				<div class="control-group">
					<label class="control-label">Beds</label>
					<div class="controls">
		            <select class="form-control" name="beds" style="width:100px">							
							<cfloop from="1" to="6" index="i">
							    <cfoutput><option <cfif parameterexists(id) and getinfo.beds eq #i#>selected="selected"</cfif>>#i#</option></cfoutput>
							</cfloop>
						</select>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">Baths</label>
					<div class="controls">
						<input type="text" name="baths" <cfif parameterexists(id)>value="#getinfo.baths#"<cfelse>value="0.0"</cfif>>
						<div class="help-block">(Decimals are allowed)</div>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">Rate</label>
					<div class="controls">
						<input type="text" name="rate" <cfif parameterexists(id)>value="#getinfo.rate#"<cfelse>value="0.0"</cfif>>
						<div class="help-block">(No commas please, decimals are allowed)</div>
					</div>
				</div>	
				
				<div class="control-group">
					<label class="control-label">Community</label>
					<div class="controls">
						<input type="text" name="community" <cfif parameterexists(id)>value="#getinfo.community#"</cfif>>
					</div>
				</div>
						
				<div class="control-group">
					<label class="control-label">Longitude</label>
					<div class="controls">
						<input type="text" name="Longitude" <cfif parameterexists(id)>value="#getinfo.Longitude#"</cfif>>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">Latitude</label>
					<div class="controls">
						<input type="text" name="Latitude" <cfif parameterexists(id)>value="#getinfo.Latitude#"</cfif>>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">Furnished</label>
					<div class="controls">
						<select class="form-control" name="Furnished" style="width:100px">							
							<option <cfif parameterexists(id) and getinfo.Furnished eq '0'>selected="selected"</cfif> value="0">No</option>
							<option <cfif parameterexists(id) and getinfo.Furnished eq '1'>selected="selected"</cfif> value="1">Yes</option>
						</select>
					</div>
				</div>
				

				<div class="control-group">
					<label class="control-label">Description</label>
					<div class="controls">
						<textarea name="description" id="txtContent"><cfif parameterexists(id)>#getinfo.description#</cfif></textarea>
						
                    
					</div>
				</div>
<!--- 
				<div class="control-group">
					<label class="control-label">Meta Title</label>
					<div class="controls">
						<input type="text" name="metaTitle" <cfif parameterexists(id)>value="#getinfo.metaTitle#"</cfif>>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">Meta Description</label>
					<div class="controls">
						<textarea name="metaDescription" class="mceNoEditor" style="height:100px"><cfif parameterexists(id)>#getinfo.metaDescription#</cfif></textarea>
					</div>
				</div>    --->  
				
<!---                <div class="control-group">
                  <label class="control-label">Main Photo</label>
                  <div class="controls">
                  <div class="uploader" id="uniform-undefined">
                  <input type="file" size="19" name="mainphoto" style="opacity:0;">
                  <span class="filename">No file selected</span>
                  <span class="action">Choose File</span>
                  </div>	
                  <div class="help-block">For optimal load times, images should be resized to 800px max width before uploading</div>			
                  <cfif parameterexists(id) and len(getinfo.mainphoto)>
                  <a href="/images/longtermrentals/#getinfo.mainphoto#" target="_blank" class="btn btn-mini btn-success"><i class="icon-eye-open icon-white"></i> View Image</a>                  
                  </cfif>              
                  </div>
               </div> --->
							
				
				<div class="form-actions">
					<input type="submit" value="Submit" class="btn btn-primary">
               <cfif parameterexists(id)><input type="hidden" name="id" value="#url.id#"></cfif>
				</div>
				
      </form>
    
    </div>
  </div> 
  
  
</cfoutput>

<cfinclude template="/admin/components/footer.cfm">


<script type="text/javascript">

   	/*
$(document).ready(function(){
   		
   		$(".form-horizontal").validate({
   		rules:{
   			pricingLow:{
   				number:true
   			},
   			pricingHigh:{
   				number:true
   			}
   		},
   		errorClass: "help-inline",
   		errorElement: "span",
   		highlight:function(element, errorClass, validClass) {
   			$(element).parents('.control-group').addClass('error');
   		},
   		unhighlight: function(element, errorClass, validClass) {
   			$(element).parents('.control-group').removeClass('error');
   			$(element).parents('.control-group').addClass('success');
   		}
   	
   	});
		
	});
*/

</script>

