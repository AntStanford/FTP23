<cfset page.title ="Manage Your Amenities">
<cfset module = 'amenity'>
<cfinclude template="/admin/components/header.cfm">

<cfquery name="getAmenityCategories" dataSource="#settings.booking.dsn#">
	select distinct escapia_amenities.category from escapia_amenities order by escapia_amenities.category
</cfquery>

<cfif isdefined('url.category')>
	<cfquery name="getCategoryAmenities" dataSource="#settings.booking.dsn#">
		select distinct categoryvalue from escapia_amenities where category = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.category#">
	</cfquery>
</cfif>

<cfif isdefined('url.category') and isdefined('url.amenity') and isdefined('url.btnSubmit')>
	
	<!--- First, make sure it doesn't already exist. --->
	<cfquery name="amenityCheck" dataSource="#settings.dsn#">
		select title from cms_amenities where title = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.amenity#">
	</cfquery>
	
	<cfif amenityCheck.recordcount eq 0>
	
			<!--- use the title to create a unique ID by removing all special characters and spaces; we will use this unique_id value on the front end ---> 
		   <cfset newString = replace(url.amenity,' ','','all')>
		   <cfset newString = replace(newString,'(','','all')>
		   <cfset newString = replace(newString,')','','all')>
		   <cfset newString = replace(newString,'-','','all')>
		   <cfset newString = replace(newString,'/','','all')>	
			
			<cfquery dataSource="#settings.dsn#">
				insert into cms_amenities(title,unique_id) 
				values(<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#url.amenity#">,<cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="Amenity#newString#">)
			</cfquery>
			
			<div class="alert alert-success">
		      <button class="close" data-dismiss="alert">x</button>
		      <strong>The amenity was added.</strong>
		    </div>
    
    <cfelse>
    		
    		<div class="alert alert-danger">
		      <button class="close" data-dismiss="alert">x</button>
		      <strong>That amenity has already been added; please choose a different one.</strong>
		    </div>
    		
    </cfif>
    
</cfif>

<cfoutput>
  
  <p><a hreflang="en" href="index.cfm" class="btn btn-success"><i class="icon-chevron-left icon-white"></i> Back to Amenity List</a></p>
  
  <div class="widget-box">
    <div class="widget-title">
      <span class="icon">
        <i class="icon-th"></i>
      </span>
      <h5>Add / Edit Form</h5>
    </div>
    <div class="widget-content nopadding">
  
      <form method="get" class="form-horizontal">
            								
            <div class="control-group">
					<label class="control-label">Choose category</label>
					<div class="controls">
						<select name="category" style="width:300px" onchange="javascript:this.form.submit();">
							<option value=" ">- Select One -</option>
							<cfloop query="getAmenityCategories">
								<option <cfif isdefined('url.category') and url.category eq getAmenityCategories.category>selected</cfif>>#category#</option>
							</cfloop>  					
						</select>
					</div>
				</div>      
            
            <cfif isdefined('getCategoryAmenities')>
					<div class="control-group">
						<label class="control-label">Choose amenity</label>
						<div class="controls">
							<select name="amenity" style="width:300px">
								<option value=" ">- Select One -</option>
								<cfloop query="getCategoryAmenities">
									<option>#upperFirst(categoryvalue)#</option>
								</cfloop>  					
							</select>
						</div>
					</div>
					
					<div class="form-actions">
						<input type="submit" value="Submit" class="btn btn-primary" name="btnSubmit">
				   </div>
				
				</cfif>
				
		</form>
				
				
    </div>
  </div>
  
</cfoutput>

<cfinclude template="/admin/components/footer.cfm">

<!---
 Upper cases the first letter of a string.
 Phil Arnold (philip.r.j.arnold@googlemail.com
 
 @param name 	 String to capitalize the first letter of (Required)
 @return Returns a string. 
 @author Brian Meloche (brianmeloche@gmail.com) 
 @version 0, March 17, 2010 
--->
<cffunction name="upperFirst" access="public" returntype="string" output="false" hint="I convert the first letter of a string to upper case, while leaving the rest of the string alone.">
		<cfargument name="name" type="string" required="true">
		<cfreturn uCase(left(arguments.name,1)) & right(arguments.name,len(arguments.name)-1)>
</cffunction>