<cfinclude template="results-search-query.cfm">
<cfinclude template="/#settings.booking.dir#/components/header.cfm">
<div class="refine-wrap map-refine-wrap refine-mobile">
  <form class="map-refine refine-form mobile-hidden" id="mapForm" method="post">
    <input type="checkbox" name="mapArea" id="mapAreaChkall" value="all"<cfif listfind(form.mapArea, 'all')>checked</cfif>>
    <label for="mapAreaChkall">All Properties</label>
    <cfoutput query="settings.booking.mapPageData">
      <input type="checkbox" name="mapArea" class="mapAreaChks" id="mapAreaChk#settings.booking.mapPageData.currentrow#" value="#settings.booking.mapPageData.name#"<cfif listfind(form.mapArea, settings.booking.mapPageData.name)>checked</cfif>>
      <label for="mapAreaChk#settings.booking.mapPageData.currentrow#">#settings.booking.mapPageData.name# (#settings.booking.mapPageData.cnt#)</label>
    </cfoutput>
    <input class="map-apply refine-clear-filters-wrap site-color-1-bg text-white" type="submit" name="submit" value="Apply">
    <div class="refine-item refine-clear-filters-wrap">
      <a href="/<cfoutput>#settings.booking.dir#</cfoutput>/property-map/" class="btn refine-clear-all text-black">Clear <i class="fa fa-recycle text-black" aria-hidden="true"></i></a>
    </div>
  </form>
  <div class="refine-panel-controls refine-mobile-controls">
    <a href="javascript:;" id="viewFiltersMobile"  rel="tooltip" data-placement="bottom" title="Refine Your Search">
      <i class="fa fa-toggle-off site-color-1" aria-hidden="true"></i>
      <span class="site-color-1">Refine Your Search</span>
    </a>
  </div>
</div>

<div class="map-results">
  <cfinclude template="results-map.cfm">
</div>

<cf_htmlfoot>
  <script>
    $('#mapAreaChkall').on('click', function(){
        if ( $(this).is(':checked') ) {
            $('.mapAreaChks').prop('checked', true);
        }
    });
  </script>
</cf_htmlfoot>

<cfinclude template="/#settings.booking.dir#/components/footer.cfm">