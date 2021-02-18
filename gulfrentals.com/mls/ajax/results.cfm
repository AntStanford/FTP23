<!--- This is used for pagination calls --->
<cfif isdefined('form.page')>
  <cfset url.page = form.page />
</cfif>
<cfinclude template="/mls/results-search-query.cfm">
<cfinclude template="/mls/results-list.cfm">

<script type="text/javascript">
  // MASTER VARIABLE FOR BOOKING DIRECTORY
  var mlsFolder = '/mls';

  // ADD MAP HOVER BINDING TO THE NEW PROPERTIES (THE if PREVENTS IT FROM RUNNING ON THE FIRST, WHICH IS HANDLED BY results.js)
  $(".results-list-property").mouseover(function(){
    var markerid = $(this).attr('data-mapMarkerID');
    var icon = {url:mlsFolder+'/images/marker-hover.png', scaledSize: new google.maps.Size(12,12)};
    markers[markerid].setIcon(icon);
  });

  $(".results-list-property").mouseout(function(){
    var markerid = $(this).attr('data-mapMarkerID');
    var icon = {url:mlsFolder+'/images/marker.png', scaledSize: new google.maps.Size(12,12)};
    markers[markerid].setIcon(icon);
  });

  // SORT BY FOR RESULTS LIST
  $('#sortForm').on('click', function(e){
    e.stopPropagation();
    $(this).find('ul').toggleClass('hidden');
  });
  $('#sortForm ul li').on('click', function(){
    var txt = $(this).find('span').text();
    $('#resultsListSortTitle i').text(txt);
    var sortFormData = $(this).attr('data-resultsList');
    $('#refineForm').find('input[name=sortBy]').val(sortFormData);
    submitForm();
  });
</script>