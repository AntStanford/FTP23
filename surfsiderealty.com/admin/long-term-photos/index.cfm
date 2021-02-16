<cfset page.title ="Long Term Photos">

<cfinclude template="/admin/components/header.cfm">


<cfif isdefined('url.addsuccess')>
  <div class="alert alert-success">
    <strong>Image Added</strong>
  </div>
<cfelseif isdefined('url.addfail')>
  <div class="alert alert-danger">
    <strong>Image Failed</strong> Make sure file name is alphanumeric only--no spaces or special characters.<br>
    If your filename is alphanumeric only Rackspace may be experiencing issues, please try again later.
  </div>
<cfelseif isdefined('url.deletesuccess')>
  <div class="alert alert-success">
    <strong>Image Deleted</strong>
  </div>
</cfif>

<cfset fileURL = '/images/long-term'>

<cfif url.rental_id neq "">
  
    <div class="widget-box">
      <div class="widget-content">
        <div class="widget-box">
          <div class="widget-title">
            <span class="icon">
              <i class="icon-picture"></i>
            </span>
            <h5>Add Photos</h5>
          </div>

          <div class="widget-content nopadding">
            <form action="submit.cfm" method="post" class="form-horizontal" enctype="multipart/form-data">
              <div class="control-group">
                <label class="control-label" style="width:80px">Filename</label>
                <div class="controls"  style="margin-left:100px">
                    <input type="file" name="photo" required> 
                    <input type="submit" value="Submit" class="btn btn-primary">
                    <input type="hidden" name="rental_id" value="<cfoutput>#url.rental_id#</cfoutput>">
                    <br>Alphanumeric only--no spaces or special characters in file name.
                </div>
              </div>
            </form>
          </div>
        </div>



  <cfquery name="getphotos" dataSource="#settings.dsn#">
    select *
    from cms_long_term_rentals_photos
    where rental_id = <cfqueryparam value="#url.rental_id#" cfsqltype="cf_sql_integer">
    order by sort 
  </cfquery>
  <cfoutput>
      <cfif getphotos.recordcount gt 0>
        <div class="widget-box">
          <div class="widget-title">
            <span class="icon">
              <i class="icon-picture"></i>
            </span>
            <h5>Current Photos</h5>
          </div>
          <div class="widget-content">
            <ul id="sort-list" class="thumbnails">
              <cfloop query="getphotos">
                <li id="#id#" style="border:none"><!--- #id# --->
                  <a href="##modal#id#" role="button" class="thumbnail" data-toggle="modal">
                    <img src="#fileURL#/#photo#" title="#tag#" style="height:135px;object-fit:cover;">
                  </a>
                  <div class="img-desc">
                    <p><b>File:</b> <a href="#fileURL#/#photo#" target="_blank" title="#photo#">...#right(photo, 20)#</a></p>
                    <p><b>Tag:</b> <cfif len(tag)>#tag#<cfelse>None</cfif></p>
                  </div>
                  <a href="delete.cfm?photoid=#getPhotos.id#&rental_id=#url.rental_id#" class="btn btn-danger">
                    <i class="icon-remove icon-white"></i> Delete
                  </a>
                </li>
              </cfloop>
            </ul>
          </div>
        </div>
        <!-- This is the image displayed in the modal -->
        <cfloop query="getphotos">
          <div id="modal#id#" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="modallbl#id#" aria-hidden="false">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-hidden="false">X</button>
              <h3 id="modallbl#id#">Image Preview</h3>
            </div>
            <div class="modal-body">
              <img src="#fileURL#/#photo#" style="height:350px;">
            </div>
            <div class="modal-footer">
              <button class="btn" data-dismiss="modal" aria-hidden="false">Close</button>
            </div>
          </div>
        </cfloop>
      </cfif>
    </div>
  </cfoutput>
</cfif>

<cfinclude template="/admin/components/footer.cfm">

<script type="text/javascript">
  $(document).ready(function() {
    $("#sort-list").sortable({
      update: function(event, ui) {
        var sortOrder = $(this).sortable('toArray').toString();
        console.log(sortOrder);
        $.get('sorter.cfm', {sortOrder:sortOrder});
        $('#sortStatus').css('display','block');
      }
    });
  });
</script>