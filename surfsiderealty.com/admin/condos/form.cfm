<cfset page.title ="Condos">
<cfset picPath = "/images/condos">

<cfif isDefined('url.deletepic') AND ListContainsNoCase('Picture1,Picture2,Picture3,Picture4,Picture5', url.deletepic)>
	<cfquery name="DeletePic" datasource="#settings.dsn#">
		Update cms_condos
		Set #url.deletepic# = ''
		where id = <cfqueryparam value="#url.id#" cfsqltype="CF_SQL_VARCHAR">
	</cfquery>
</cfif>

<cfif isdefined('url.id')>

  <cfquery name="getinfo" dataSource="#settings.dsn#">
    select * from cms_condos where id = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
  </cfquery>

</cfif>

<cfquery name="variables.qryComplexes" dataSource="#settings.dsn#">
SELECT distinct categoryvalue 
FROM surfsiderealty.escapia_amenities 
WHERE category = 'complex' AND categoryvalue <> 'None'
</cfquery>

<cfinclude template="/admin/components/header.cfm">

<cfoutput>

  <cfif isdefined('url.success') and isdefined('url.id')>
    <div class="alert alert-success">
      <button class="close" data-dismiss="alert">x</button>
      <strong>Update successful!</strong> Continue editing this record or <a href="index.cfm">go back.</a>
    </div>
  <cfelseif isdefined('url.deletephoto') and isdefined('url.id')>
    <div class="alert alert-success">
      <button class="close" data-dismiss="alert">x</button>
      <strong>Photo deleted!</strong> Continue editing this record or <a href="index.cfm">go back.</a>
    </div>
  <cfelseif isdefined('url.success')>
    <div class="alert alert-success">
      <button class="close" data-dismiss="alert">x</button>
      <strong>Insert successful!</strong> Add another record or <a href="index.cfm">go back.</a>
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
            <label class="control-label">Complex</label>
            <div class="controls">
              <select name="complex" style="width:200px" id="parentID">
               <option value="0" <cfif parameterexists(id) and getinfo.complex eq 0>selected="selected"</cfif>> -- Select Complex-- </option>
               <cfloop query="variables.qryComplexes">
                  <option value="#variables.qryComplexes.categoryvalue#" <cfif isdefined('url.id') and getinfo.complex eq variables.qryComplexes.categoryvalue>selected="selected"</cfif>>#variables.qryComplexes.categoryvalue#</option>
               </cfloop>
              </select>
            </div>
          </div>

        		<div class="control-group">
					<label class="control-label">Name</label>
					<div class="controls">
						<input type="text" name="condoname" <cfif parameterexists(id)>value="#getinfo.condoname#"</cfif>>
					</div>
				</div>

        		<div class="control-group">
					<label class="control-label">Address</label>
					<div class="controls">
						<input type="text" name="address" <cfif parameterexists(id)>value="#getinfo.address#"</cfif>>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">Slug</label>
					<div class="controls">
						<cfif parameterexists(id) and getinfo.slug eq ''>
							<cfset getinfo.slug = lcase(replace(replace(getinfo.condoname,"'", '', 'all'),' ', '-', 'all'))>
						</cfif>
						<input type="text" name="slug" <cfif parameterexists(id)>value="#getinfo.slug#"</cfif>>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">Description</label>
					<div class="controls">
						<textarea name="description" id="txtContent"><cfif parameterexists(id)>#getinfo.description#</cfif></textarea>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">ShortDescription</label>
					<div class="controls">
						<textarea name="description2"><cfif parameterexists(id)>#getinfo.description2#</cfif></textarea>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">Amenities</label>
					<div class="controls">
						<textarea name="amenities" class="mceNoEditor" style="height:25px"><cfif parameterexists(id)>#getinfo.amenities#</cfif></textarea>
						<br>comma separated please
					</div>
				</div>

			 <div class="control-group">
					<label class="control-label">Picture 1</label>
					<div class="controls">
						<input type="file" style="width:250px" name="Picture1">
						<cfif parameterexists(id) and getinfo.Picture1 neq ''>
							 &nbsp; | &nbsp;
							<a href="#picPath#/#getinfo.Picture1#" target="_blank">View Picture</a> &nbsp; | &nbsp;
							<a href="form.cfm?id=#id#&deletePic=Picture1" class="btn btn-mini btn-danger"><i class="icon-remove icon-white"></i> Delete</a>
						</cfif>
					</div>
       		 </div>
			 <div class="control-group">
					<label class="control-label">Picture 2</label>
					<div class="controls">
						<input type="file" style="width:250px" name="Picture2">
						<cfif parameterexists(id) and getinfo.Picture2 neq ''>
							 &nbsp; | &nbsp;
							<a href="#picPath#/#getinfo.Picture2#" target="_blank">View Picture</a> &nbsp; | &nbsp;
							<a href="form.cfm?id=#id#&deletePic=Picture2" class="btn btn-mini btn-danger"><i class="icon-remove icon-white"></i> Delete</a>
						</cfif>
					</div>
       		 </div>
			 <div class="control-group">
					<label class="control-label">Picture 3</label>
					<div class="controls">
						<input type="file" style="width:250px" name="Picture3">
						<cfif parameterexists(id) and getinfo.Picture3 neq ''>
							 &nbsp; | &nbsp;
							<a href="#picPath#/#getinfo.Picture3#" target="_blank">View Picture</a> &nbsp; | &nbsp;
							<a href="form.cfm?id=#id#&deletePic=Picture3" class="btn btn-mini btn-danger"><i class="icon-remove icon-white"></i> Delete</a>
						</cfif>
					</div>
       		 </div>
			 <div class="control-group">
					<label class="control-label">Picture 4</label>
					<div class="controls">
						<input type="file" style="width:250px" name="Picture4">
						<cfif parameterexists(id) and getinfo.Picture4 neq ''>
							 &nbsp; | &nbsp;
							<a href="#picPath#/#getinfo.Picture4#" target="_blank">View Picture</a> &nbsp; | &nbsp;
							<a href="form.cfm?id=#id#&deletePic=Picture4" class="btn btn-mini btn-danger"><i class="icon-remove icon-white"></i> Delete</a>
						</cfif>
					</div>
       		 </div>
			 <div class="control-group">
					<label class="control-label">Picture 5</label>
					<div class="controls">
						<input type="file" style="width:250px" name="Picture5">
						<cfif parameterexists(id) and getinfo.Picture5 neq ''>
							 &nbsp; | &nbsp;
							<a href="#picPath#/#getinfo.Picture5#" target="_blank">View Picture</a> &nbsp; | &nbsp;
							<a href="form.cfm?id=#id#&deletePic=Picture5" class="btn btn-mini btn-danger"><i class="icon-remove icon-white"></i> Delete</a>
						</cfif>
					</div>
       		 </div>


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
				</div>

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
