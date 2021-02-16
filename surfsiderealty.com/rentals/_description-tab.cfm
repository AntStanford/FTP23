<cfoutput>
<div id="description" name="description" class="info-wrap description-wrap">
  <div class="info-wrap-heading"><i class="fa fa-align-left" aria-hidden="true"></i> Description</div>
	<div class="info-wrap-body">
  	<div id="descBlock" class="desc-block" >#REReplace(property.description, "\r\n|\n\r|\n|\r", "<br />", "all")#
    </div>
  </div><!--- END info-wrap-body --->
</div><!-- END description-wrap -->
</cfoutput>