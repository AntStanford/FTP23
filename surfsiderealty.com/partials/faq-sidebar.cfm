<style>
.cms-faqs-option-2 { margin: 25px 0; }
.cms-faqs-option-2 .fa { padding: 10px; margin: -10px -6px -10px -13px; }
.cms-faqs-option-2 .block { display: none; }
.cms-faqs-option-2 .block .h2 { margin: 0 0 10px; padding: 0 0 5px; border-bottom: 1px #eee solid; }
.cms-faqs-option-2 .block td { border: none; }
.cms-faqs-option-2 .block .table .fa { font-size: 30px; }
.cms-faqs-option-2 .block .alert .btn { position: relative; top: -7px; }
</style>

<cfcache key="cms_faqs" action="cache" timespan="#settings.globalTimeSpan#" usequerystring="true" useCache="true" directory="e:/inetpub/wwwroot/domains/#tinymce_domain#/temp_files">

<cfquery name="getinfo" dataSource="#settings.dsn#">
  select * from cms_faqs order by id
</cfquery>

<div class="cms-faqs-option-2">
  <div class="row">
    <div class="col-md-4">
      <div class="list-group">
        <cfif getinfo.recordcount gt 0>
          <cfset currentrow = 1>
          <cfoutput query="getinfo">
            <a hreflang="en" href="javascript:;" class="list-group-item" data-id="question-#currentrow#"><i class="fa fa-question-circle"></i> #question#</a>
        	  <cfset currentrow = currentrow + 1>
          </cfoutput>
        </cfif>
      </div>
    </div>
    <div class="col-md-8">
      <cfif getinfo.recordcount gt 0>
        <cfset currentrow = 1>
        <cfoutput query="getinfo">
          <div class="block" id="question-#currentrow#">
            <p class="h2 site-color-2">#question#</p>
            <table class="table">
              <tr>
                <td><i class="fa fa-check-circle"></i></td>
                <td>#answer#</td>
              </tr>
            </table>
          </div>
          <cfset currentrow = currentrow + 1>
        </cfoutput>
      </cfif>
    </div>
  </div>
</div>
</cfcache>

<cf_htmlfoot>
<script type="text/javascript">
$(document).ready(function(){
  //sets first question as active on page load
  $('.cms-faqs-option-2 .list-group a:first').addClass('site-color-1-bg').css({'color':'#fff'});
  //shows first answer on page load
  $('.cms-faqs-option-2 .block:first').show();
  //toggles answers per answer selected
  $('.cms-faqs-option-2 .list-group a').click(function(){
    var dataID = $(this).attr('data-id');
    $('.cms-faqs-option-2 .block').hide();
    $('#'+dataID+'').show();
    $('.cms-faqs-option-2 .list-group a').removeClass('site-color-1-bg').css({'color':'#333'});
    $(this).addClass('site-color-1-bg').css({'color':'#fff'});
    $(this).blur();
  });
});
</script>
</cf_htmlfoot>