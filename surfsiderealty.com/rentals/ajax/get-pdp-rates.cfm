<cfif
	isdefined('form.strcheckin') and
	IsValid('date',form.strcheckin) and
	isdefined('form.strcheckout') and
	IsValid('date',form.strcheckout) and
	isdefined('form.propertyid') and
	len(form.propertyid)
	>

	<cfset apiresponse = application.bookingObject.getDetailRates(form.propertyid,form.strcheckin,form.strcheckout)>

  <script>
    $(document).ready(function(){
      // LOADER FOR BUTTONS
      if ($('.btn-loader').length) {
        $('.btn-loader').on('click', function(){
          $(this).find('.btn-text').hide();
          $(this).find('.btn-loading-text').show();
        });
      }
    });
  </script>

<cfelse>
	<cfset apiresponse = 'One or more required parameters is missing. Please try again.'>
</cfif>

<cfoutput>#apiresponse#</cfoutput>