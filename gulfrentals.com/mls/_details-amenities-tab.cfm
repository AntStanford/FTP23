<cfoutput>
<div id="details-amenities" name="details-amenities" class="info-wrap details-wrap">
  <div class="info-wrap-heading"><i class="fa fa-list" aria-hidden="true"></i> Amenities</div>
  <div class="info-wrap-body">
    <ul class="details-list">
      <cfloop list="#property.AMENTITIES#" index="i">
  		<cfif !(isdefined('settings.noShowList') and settings.noShowList contains(i))>
  			<li>#i#</li>
  		</cfif>
      </cfloop>
    </ul>
  </div><!-- END info-wrap-body -->
</div><!-- END details-wrap -->
</cfoutput>
