<script type="text/javascript" charset="utf-8">
	$(function () {
      var focused = false;
      var hovered = false;
      var collapsedHeight = '95px';
      $('#quick-contact form').css('height', collapsedHeight);
      var toggleForm = function () {
         if(focused) {
            $('#quick-contact form').css('height', 'auto');
            $('#quick-contact').addClass('open');
         } else {
            if(!hovered) {
               $('#quick-contact form').css('height', collapsedHeight);
               $('#quick-contact').removeClass('open');
            }
         }
      }
      var timeout;
      
      $('#quick-contact label').each(function () {
         var labelText = $(this).text();
         
         $('#' + $(this).attr('for'))
            .val(labelText)
            .focus(function () {
               $this = $(this);
               if( $this.val() == labelText ) {
                 $this.val('').removeClass('labeled');
               }
            })
            .blur(function () {
               $this = $(this);
               if( $this.val() == '' ){
                 $this.val(labelText).addClass('labeled');
               }
            });
      });
      $('#quick-contact :input')
         .focus( function () {
            focused = true;
            toggleForm();
            clearTimeout( timeout );
         })
         .blur( function () {
            focused = false;
            timeout = setTimeout( toggleForm, 500 )
         });
      
      $('#quick-contact').hover(
         function () {
            hovered = true;
            $('#quick-contact form').css('height', 'auto');
            $('#quick-contact').addClass('open');

         },
         function () {
            hovered = false;
            if(!focused) {
               $('#quick-contact form').css('height', collapsedHeight);
               $('#quick-contact').removeClass('open');
            }
         }
      );

   });
</script>

<style type="text/css" media="screen">
   #detailsGreyBar { position: relative; }
   #quick-contact {  }
   #quick-contact form { border:1px solid #CCCCCC;-moz-border-radius:10px;-webkit-border-radius:10px;background:#C4E6EB;margin:12px 0;overflow:hidden;padding:7px 0 0 }
   #quick-contact.open form { /* width: 240px; padding: 0 0 5px 0; */ }


   #quick-contact textarea { width:221px;height:41px;padding:8px;margin:0 }
   #quick-contact table    { width:240px; }
   #quick-contact label    { display: none; }
   #quick-contact input    { display: inline;height:13px;width:103px; font-size: 11px; }
   #quick-contact .field   { display: block; padding:0 2px 6px;}
   #quick-contact .submit  { display: block; margin: 0 auto; width: 120px; height: auto; line-height: 1.2em;}
   #quick-contact h5 { color: #111; padding: 10px 0 5px 0; font-size: 13px; line-height: 14px; font-weight: normal; }
   #quick-contact h5 span { display: block; color: #fefefe; font-size: 14px; line-height: 20px;}
   #quick-contact .submit { background:#007A95;color:#FFFFFF;display:block;font-family:Verdana;font-size:11px;padding:2px 0;text-align:center;text-transform:uppercase;width:125px;margin:7px 0 5px 0}
   .email-us{margin:0 0 5px 0;padding:0;line-height:normal}
   h6{text-align:center;margin:0}
</style>

<div id="quick-contact">
	<div class="qc-top">
	  <div class="qc-bottom">

	<cfoutput>

	<center>
	<cfif structkeyexists(url, "debug")>
	  	<form action="/components/bt-quick-contact-test.cfm" method="post">
   <cfelse>
   	<form action="/prod-thanks.cfm?#cgi.query_string#" method="post">
	</cfif>
		<input type="hidden" name="QuickCameFrom" value="#cgi.SCRIPT_NAME#" style="display:none">
		<input type="hidden" name="RandyForm" value="#cgi.SCRIPT_NAME#" style="display:none">
		<cfif isdefined('strPropId')><input type="hidden" name="QuickPropID" value="#strPropId#"></cfif>
		<h6>Have Questions?</h6>
      <p class="email-us">Email us for a quick answer!</p>
      <table>
			<tr>
				<td style="text-align: left;">
				   <span class="field">
				      <label for="name">Name</label>
				      <input type="text" name="name" id="name" size="10" >
				   </span>
				   <span class="field">
				      <label for="phone">Phone</label>
				      <input type="text" name="phone" id="phone" size="10" >
				   </span>
				</td>
				<td style="text-align: right;">
				   <span class="field">
				      <label for="email">Email</label>
   				   <input type="text" name="email" id="email" size="10" >
               </span>
				   <span class="field">
				      <label for="zip">Zip</label>
				      <input type="text" name="zip" id="zip" size="10" >
				   </span>
				</td>
		</table>
      <label for="comments">Comments</label>
	  <textarea cols="23" rows="3" name="comments" id="comments"></textarea>
	  <button class="submit" type="submit">Submit Request</button>

	</form>
	</center>

	</cfoutput>

	  </div>
	</div>

</div>