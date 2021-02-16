<cfif isdefined('url.id')>

	<cfif isdefined('versionid')>
			<cfset PageTable = "cms_pages_versioning">
		<cfelse>
			<cfset PageTable = "cms_pages">
	</cfif>

  <cfquery name="getinfo" dataSource="#settings.dsn#">
    select * from #PageTable# where id =

	<cfif isdefined('versionid')>
			<cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.versionid#">
   <cfelse>
			<cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
	</cfif>

  </cfquery>

  <cfquery name="GetPreviousVersions" dataSource="#settings.dsn#">
    select * from cms_pages_versioning where MainPageID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
	 order by createdat desc
  </cfquery>

</cfif>

<cfif parameterexists(id)>
  <cfset page.title = "Pages - #getinfo.name#">
<cfelse>
  <cfset page.title = "Pages">
</cfif>
<!--- <cfset page.title = "Pages"> --->
<cfset page.module = 'page'>
<cfinclude template="/admin/components/header.cfm">

<cfquery name="getTopLevelPages" dataSource="#settings.dsn#">
   select id,name from cms_pages where parentID = 0 and showInAdmin = 'Yes' order by name
</cfquery>

<cfoutput>

  <cfif isdefined('url.success') and isdefined('url.id')>
    <div class="alert alert-success">
      <button class="close" data-dismiss="alert">x</button>
      <strong>Update successful!</strong> Continue editing this #page.module# or <a href="index.cfm">go back.</a>
    </div>
  <cfelseif isdefined('url.success')>
    <div class="alert alert-success">
      <button class="close" data-dismiss="alert">x</button>
      <strong>Success!</strong> Add another #page.module# or <a href="index.cfm">go back.</a>
    </div>
  </cfif>

  <div class="widget-box">
    <div class="widget-title">
      <span class="icon">
        <i class="icon-th"></i>
      </span>
      <h5>#page.title#</h5>
    </div>
    <div class="widget-content nopadding">

      <cfif parameterexists(id) and len(getinfo.slug)>
         <a href="/#getinfo.slug#" target="_blank" class="btn btn-info pull-right" style="margin-right:15px">View Page</a>
      </cfif>

      <ul class="nav nav-tabs" style="margin-top:20px">
        <li><a href="##basicTab" data-toggle="tab">Basic Form</a></li>
        <li><a href="##seoTab" data-toggle="tab">SEO Form</a></li>
        <li><a href="##customTab" data-toggle="tab">Custom Results Form</a></li>
        <li><a href="##customSearchTab" data-toggle="tab">Custom Search Form</a></li>
      </ul>



      <form action="submit.cfm" method="post" class="form-horizontal" enctype="multipart/form-data">

      <div class="tab-content">

        <div class="tab-pane active" id="basicTab">

          <script type="text/javascript">

            $(document).ready(function(){

              $('select##parentID').change(function(){

                var selectedPage = $('select##parentID option:selected').val();

                $.ajax({
                  type: "GET",
                  url: 'get-subnav.cfm?parentID='+selectedPage,
                  success: function(data){

                    if(data != ''){
                      $('div##subnavContainer').html(data).show();
                    }else{
                      $('div##subnavContainer').html('').hide();
                    }
                  }
                }); //end of ajax

              });

            });

          </script>

          <div class="control-group">
            <label class="control-label">Parent</label>
            <div class="controls">
              <select name="parentID" style="width:200px" id="parentID">
               <option value="0" <cfif parameterexists(id) and getinfo.parentID eq 0>selected="selected"</cfif>>None</option>
               <cfloop query="getTopLevelPages">
                  <option value="#id#" <cfif isdefined('url.id') and getinfo.parentID eq #id#>selected="selected"</cfif>>#name#</option>
               </cfloop>
              </select>
            </div>
          </div>

          <cfif parameterexists(id) and getinfo.subnavParentID neq '' and getinfo.subnavParentID gt 0>

              <cfquery name="getSubNav" dataSource="#settings.dsn#">
          select id,name from cms_pages where parentID = <cfqueryparam  CFSQLType="CF_SQL_INTEGER" value="#getinfo.parentID#">
        </cfquery>

              <div class="control-group" id="subnavContainer">
                <label class="control-label">Sub-nav Parent</label>
          <div class="controls">
            <select name="subnavParentID" style="width:200px">
              <option value="0">- Choose One -</option>
              <cfloop query="getSubNav">
                <option value="#id#" <cfif getinfo.subnavparentid eq getSubNav.id>selected="selected"</cfif>>#name#</option>
              </cfloop>
            </select>
          </div>
              </div>
          <cfelse>
              <div class="control-group" style="display:none"  id="subnavContainer"></div>
          </cfif>

          <div class="control-group">
            <label class="control-label">Show in Navigation</label>
            <div class="controls">
              <select name="showinnavigation" style="width:100px">
               <option <cfif parameterexists(id) and getinfo.showinnavigation eq 'Yes'>selected="selected"</cfif>>Yes</option>
               <option <cfif parameterexists(id) and getinfo.showinnavigation eq 'No'>selected="selected"</cfif>>No</option>
              </select>
            </div>
          </div>

          <div class="control-group">
            <label class="control-label">Show in Footer Quick Links</label>
            <div class="controls">
              <select name="showInFooter" style="width:100px">
               <option <cfif parameterexists(id) and getinfo.showInFooter eq 'No'>selected="selected"</cfif>>No</option>
               <option <cfif parameterexists(id) and getinfo.showInFooter eq 'Yes'>selected="selected"</cfif>>Yes</option>
              </select>
            </div>
          </div>

          <div class="control-group">
            <label class="control-label">Trigger Only?</label>
            <div class="controls">
              <select name="triggerOnly" style="width:200px">
               <option <cfif parameterexists(id) and getinfo.triggerOnly eq 'No'>selected="selected"</cfif>>No</option>
               <option <cfif parameterexists(id) and getinfo.triggerOnly eq 'Yes'>selected="selected"</cfif>>Yes</option>
              </select>
            </div>
          </div>

            <div class="control-group">
              <label class="control-label">Custom Booking Search Page?</label>
              <div class="controls">
                <input id="isCustomSearchPage" name="isCustomSearchPage" type="checkbox" value="yes" <cfif parameterexists(id) and getinfo.isCustomSearchPage eq 'Yes'>checked <cfelse> </cfif>>
                <small>Example - Pet Friendly Rentals</small>
              </div>
            </div>

          <div class="control-group">
            <label class="control-label">Name</label>
            <div class="controls">
              <input class="sluggable" maxlength="255" name="name" type="text" <cfif parameterexists(id)>value="#getinfo.name#"</cfif>>
            </div>
          </div>

          <div class="control-group">
            <label class="control-label">Slug</label>
            <div class="controls">

              <cfif parameterexists(id)>

                  <cfif getinfo.parentID neq 0 and getinfo.ignoreParentSlug eq 'No'> <!--- this page has a parent --->

                     <!--- Get the slug for the parent page --->
                     <cfquery name="getParentSlug" dataSource="#settings.dsn#">
                        select slug from cms_pages where id = <cfqueryparam  CFSQLType="CF_SQL_INTEGER" value="#getinfo.parentID#">
                     </cfquery>

                     <!--- remove the parent slug --->
                     <cfset newString = replace(getinfo.slug,'#getParentSlug.slug#/','','all')>

                     <div class="input-prepend">
                        <span class="add-on">#getParentSlug.slug# /</span>
                        <input class="span2" id="prependedInput" type="text" value="#newString#" name="slug">
                     </div>


                  <cfelse>
                     <input class="slug" maxlength="255" name="slug" type="text" <cfif parameterexists(id)>value="#getinfo.slug#"</cfif>>
                  </cfif>

              <cfelse>
                  <input class="slug" maxlength="255" name="slug" type="text" <cfif parameterexists(id)>value="#getinfo.slug#"</cfif>>
              </cfif>
              <div class="help-block">(No spaces,no special characters except hyphens, all lowercase)</div>
            </div>
          </div>

         <cfif parameterexists(id)>
            <div class="control-group">
              <label class="control-label" for="ignoreParentSlug">Ignore Parent Slug</label>
              <div class="controls">
                <label class="radio inline" for="radios-0">
                  <input type="radio" name="ignoreParentSlug" id="radios-0" value="No" <cfif getinfo.ignoreParentSlug eq 'No'>checked="checked"</cfif>>
                  No
                </label>
                <label class="radio inline" for="radios-1">
                  <input type="radio" name="ignoreParentSlug" id="radios-1" value="Yes" <cfif getinfo.ignoreParentSlug eq 'Yes'>checked="checked"</cfif>>
                  Yes
                </label>
              </div>
            </div>
         <cfelse>
            <div class="control-group">
              <label class="control-label" for="ignoreParentSlug">Ignore Parent Slug</label>
              <div class="controls">
                <label class="radio inline" for="radios-0">
                  <input type="radio" name="ignoreParentSlug" id="radios-0" value="No" checked="checked">
                  No
                </label>
                <label class="radio inline" for="radios-1">
                  <input type="radio" name="ignoreParentSlug" id="radios-1" value="Yes">
                  Yes
                </label>
              </div>
            </div>
         </cfif>


          <div class="control-group">
            <label class="control-label">External Link</label>
            <div class="controls">
              <input maxlength="255" name="externalLink" type="text" <cfif parameterexists(id)>value="#getinfo.externalLink#"</cfif>>
            </div>
          </div>


			  <cfif parameterexists(id) and getinfo.slug eq 'index'>

		  		<!--- Don't let a user change the layout for the homepage --->
		  		<input type="hidden" name="layout" value="home.cfm">

			  <cfelse>

				  <cfset layoutList = 'Default.cfm,Full.cfm,Left-sidebar.cfm'>

          <div class="control-group select-layout" id="selectStandardLayout">
            <label class="control-label">Layout</label>
            <div class="controls">
              <select style="width:200px" class="form-control" name="layout" id="layoutSelect">
<!---
               <cfif parameterexists(id)>
                 <option value="#getinfo.layout#">#getinfo.layout#</option>
               </cfif>
--->
               <cfloop list="#layoutList#" index="i">
                 <option value="#i#" <cfif parameterexists(id) and getinfo.layout eq i>selected</cfif>>#i#</option>
               </cfloop>
              </select>
            </div>
          </div>

          <div class="control-group select-layout" id="selectBookingLayout">
            <label class="control-label">Layout</label>
            <div class="controls">
              <select style="width:200px" class="form-control" name="layout" id="layoutSelect" disabled>
                <option id="bookingVal" value="full-booking.cfm">Full Booking</option>
              </select>
            </div>
          </div>

			  </cfif>


            <div class="control-group">
               <label class="control-label">Body</label>
               <div class="controls">
                  <textarea id="txtContent" name="body" rows="4" cols="30">
                     <cfif parameterexists(id)>#getinfo.body#</cfif>
                  </textarea>
               </div>
            </div>

			<cfif isdefined('url.id') and GetPreviousVersions.recordcount gt 0>

			<div class="control-group">
               <label class="control-label">Versioning</label>
               <div class="controls">
                 <a href="form.cfm?id=#url.id#" class="btn btn-info">Current</a>
   				 <cfloop query="GetPreviousVersions">
   				  <a style="margin-bottom:5px" class="btn btn-info" href="form.cfm?id=#MainPageID#&versionid=#id#">#dateformat(createdat,'dd/mm/yyyy')# #timeformat(createdat,'hh:mm tt')#</a>
   				 </cfloop>
               </div>
            </div>

			</cfif>

        </div>

        <div class="tab-pane" id="seoTab">

          <div class="control-group">
  					<label class="control-label">H1 Tag</label>
  					<div class="controls">
  						<input maxlength="255" name="h1" type="text" <cfif parameterexists(id)>value="#getinfo.h1#"</cfif>>
  					</div>
  				</div>

          <div class="control-group">
  					<label class="control-label">Meta Title</label>
  					<div class="controls">
  						<input maxlength="255" name="metatitle" size="70" type="text" <cfif parameterexists(id)>value="#getinfo.metatitle#"</cfif>>

  						<div class="input-prepend">
  						   <button class="btn btn-info" type="button" onClick="countit3(this)">Calculate Characters</button>
  						   <input type="text" name="displaycount3" class="input-small" style="width:10%"  id="prependedInputButton">
  						</div>

  					</div>
  				</div>



          <div class="control-group">
  					<label class="control-label">Meta Description</label>
  					<div class="controls">
  						<textarea name="metadescription" class="mceNoEditor"><cfif parameterexists(id)>#getinfo.metadescription#</cfif></textarea>

  						<div class="input-prepend">
  						   <button class="btn btn-info" type="button" onClick="countit2(this)">Calculate Characters</button>
  						   <input type="text" name="displaycount2" class="input-small" style="width:10%"  id="prependedInputButton">
  						</div>

  					</div>
  				</div>

        </div> <!--- end of seo tab --->



        <div class="tab-pane" id="customTab">


            <cfquery name="getproperties" dataSource="#settings.dsn#">
	          SELECT unitcode,
                   unitshortname,
                   bedrooms,
                   bathrooms,
                   maxoccupancy,
                   unitcategory,
                   cityname
	          FROM escapia_properties
            ORDER BY unitshortname
            </cfquery>

            <cfif isdefined('url.id')>
               <cfquery name="getPageProperties" dataSource="#settings.dsn#">
               SELECT unitcode
               FROM cms_pages_properties
               WHERE pageID = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#url.id#">
               </cfquery>
               <cfset propertyList = ValueList(getPageProperties.unitcode)>
            </cfif>

				<div class="control-group">
	            <div class="controls">

						<div class="control-group">
			            <label class="control-label">Popular search?</label>
			            <div class="controls">
			              <select name="popularSearch" style="width:200px">
			               <option <cfif parameterexists(id) and getinfo.popularSearch eq 'No'>selected="selected"</cfif>>No</option>
			               <option <cfif parameterexists(id) and getinfo.popularSearch eq 'Yes'>selected="selected"</cfif>>Yes</option>
			              </select>
			            </div>
			          </div>

						<div class="control-group">
							<label class="control-label">Popular Search Photo</label>
							<div class="controls">
								<div class="uploader" id="uniform-undefined">
									<input type="file" size="19" name="popularSearchPhoto" style="opacity:0;">
									<span class="filename">No file selected</span>
									<span class="action">Choose File</span>
								</div>
								<cfif parameterexists(id) and len(getinfo.popularSearchPhoto)>
									<a href="/images/popular/#getinfo.popularSearchPhoto#" target="_blank" class="btn btn-mini btn-info"><i class="icon-eye-open icon-white"></i> View Image</a>
								</cfif>
							</div>
						</div>

                   <table class="table table-striped">
                     <tr>
                        <th></th>
                        <th>Property</th>
                        <th>Beds</th>
                        <th>Bath</th>
                        <th>Sleeps</th>
                        <th>Type</th>
                        <th>Location</th>
                     </tr>
                     <cfloop query="getproperties">
      				     <tr>

      				        <cfif isdefined('url.id')>

      				            <cfif isdefined('propertyList') and ListLen(propertyList) gt 0 and ListContains(propertylist,getProperties.unitcode)>
      				                 <td><input type="checkbox" class="props" name="properties" value="#unitcode#" checked="checked"></td>
      				            <cfelse>
      				                 <td><input type="checkbox" class="props" name="properties" value="#unitcode#"></td>
      				            </cfif>

      				        <cfelse>
      				           <td><input type="checkbox" class="props" name="properties" value="#unitcode#"></td>
      				        </cfif>

      				        <td>#unitshortname#</td>
      				        <td>#bedrooms#</td>
      				        <td>#bathrooms#</td>
      				        <td>#maxoccupancy#</td>
      				        <td>#unitcategory#</td>
      				        <td>#cityname#</td>
      				     </tr>
      				   </cfloop>
                   </table>

	             </div>

	     </div> <!--- end of customTab --->

      </div>


       <div class="tab-pane" id="customSearchTab">
          <cfinclude template="_search-form.cfm">
       </div> <!--- end of customTab --->

        <div class="form-actions">
          <input type="submit" value="Submit" id="btnSave" class="btn btn-primary" />
          <cfif parameterexists(id)><input type="hidden" name="id" value="#url.id#"></cfif>
        </div>

      </form>

    </div>
  </div>

</cfoutput>


<script>
  $(document).ready(function(){
    l = $("#subnavContainer").html().length;

    if (l==0) {
      $("#parentID").trigger('change');
    }


    if($("#isCustomSearchPage").is(":checked")) {
      $('#selectStandardLayout').hide();

      $('#selectBookingLayout').show();
    } else {
      $('#selectStandardLayout').show();

      $('#selectBookingLayout').hide();
    }

    $("#isCustomSearchPage").on('click',function() {
      if($(this).is(":checked")) {
        $('#selectStandardLayout').hide();

        $('#selectBookingLayout').show();
      } else {
        $('#selectStandardLayout').show();

        $('#selectBookingLayout').hide();
      }
    });

  });
</script>

<cfinclude template="/admin/components/footer.cfm">