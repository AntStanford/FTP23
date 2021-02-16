 <!---START: NEW CART Abandonment FEATURE--->
  <!---cookie is defined b/c viewer made it the checkout page, but did not book--->
	<cfif script_name does not contain "book-now.cfm">
		
		<cfif isdefined('cookie.CartAbandonmentFooter') and isdefined('cookie.CartAbandonmentFooterCheckIn') and isdefined('cookie.CartAbandonmentFooterCheckOut')>		
		  <cfquery name="AbandonUnitInfo" dataSource="#settings.booking.dsn#">
        	select *
        	from escapia_properties
        	where unitcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cookie.CartAbandonmentFooter#">
       </cfquery>		
			
  		<div id="cartAbandonment" class="cart-abandonment">
    		<cfoutput query="AbandonUnitInfo">
      		You Have an Incomplete Booking <span class="btn-container"><a class="cart-btn btn-view-property" href="/cart-abandonment-footer-clickthrough.cfm?typeclick=DetailPage&seoPropertyName=#AbandonUnitInfo.seoPropertyName#">View Unit</a> <a class="cart-btn btn-book-property" href="/cart-abandonment-footer-clickthrough.cfm?typeclick=BookNow&seoPropertyName=#AbandonUnitInfo.seoPropertyName#">Book Your Vacation</a></span>
    		  <div id="viewUnit" class="view-unit">
      		  <a hreflang="en" href="/cart-abandonment-footer-clickthrough.cfm?typeclick=DetailPage&seoPropertyName=#AbandonUnitInfo.seoPropertyName#">
        		  <img src="#mapPhoto#" alt="#seopropertyname#">
        		  <h6>#unitshortname#</h6>
      		  </a>
            <div>#bedrooms# beds <span>&bull;</span> #bathrooms# baths <span>&bull;</span> Sleeps #maxoccupancy#</div>
    		  </div>
    		  <span id="abandonCookie" class="abandon-cookie">x</span>
        </cfoutput>
      </div>
		</cfif>
	</cfif>


  <script>
    $(document).ready(function(){
      $('#abandonCookie').click(function(){
        $.ajax({url: '/kill-cart-abandonment-cookie.cfm'});
        $('#cartAbandonment').fadeOut('slow');
      }); 
      $('.btn-view-property, .counter').hover(function(){
        $('#cartAbandonment').toggleClass('btn-hovered');
      });
    });
  </script>
  <style>
    .cart-abandonment {position: fixed; right: 0; bottom: 0; left: 0; z-index: 99999; padding: 20px; background-color: rgba(0,0,0,0.65); font-family: "Helvetica Neue", helvetica, arial, sans-serif; font-size: 14px; color: #fff; font-weight: 100; letter-spacing: 1px;}
    .cart-abandonment .view-unit {opacity: 0; visibility: hidden; max-width: 400px; width: 95%; position: absolute; bottom: 100%; left: 10px; margin-bottom: 10px; padding: 10px; background-color: rgba(0,0,0,0.85); border-radius: 2px; text-align: left; -webkit-transition: opacity 350ms, visibility 350ms; -moz-transition: opacity 350ms, visibility 350ms; transition: opacity 350ms, visibility 350ms;}
    .cart-abandonment .view-unit:after {content: ""; display: block; width: 0; height: 0; position: absolute; top: 100%; left: 50px; border-style: solid; border-width: 10px 8px 0 8px; border-color: rgba(0,0,0,0.85) transparent transparent transparent;}
    .cart-abandonment .view-unit img {display: block; width: 100px; height: auto; float: left; margin-right: 8px;}
    .cart-abandonment .view-unit h6 {margin-top: 0; margin-bottom: 5px; font-size: 21px; line-height: 1;}
    .cart-abandonment .view-unit > div > span {display: inline-block; vertical-align: middle; font-size: 7px;}
    .cart-abandonment.btn-hovered .view-unit {opacity: 1; visibility: visible;}
    .cart-abandonment .counter {cursor: pointer; font-weight: 700; text-decoration: underline;}
    .cart-abandonment .cart-btn {display: inline-block; margin-left: 10px; padding: 8px 14px; border-radius: 1px; font-size: 13px; text-transform: uppercase; color: #fff; line-height: 1; text-align: center; font-weight: 400; text-shadow: 0 1px 1px rgba(0,0,0,0.5);}
    .cart-abandonment .cart-btn:hover, .cart-abandonment .cart-btn:active, .cart-abandonment .cart-btn:focus {outline: none; text-decoration: none;}
    .cart-abandonment .btn-view-property {background-color: #004778;}
    .cart-abandonment .btn-view-property:hover {background-color: #005fa0;}
    .cart-abandonment .btn-book-property {background-color: #00781e;}
    .cart-abandonment .btn-book-property:hover {background-color: #009c27;}
    .abandon-cookie {cursor: pointer; display: block; width: 20px; height: 20px; position: absolute; top: 24px; right: 15px; padding: 6px; background-color: rgba(255,255,255,0.35); border-radius: 50%; border: 1px solid #fff; box-shadow: 1px 1px 4px -1px #000; font-size: 10px; line-height: 0.5; color: #fff; font-weight: 700; text-shadow: 0 1px 1px rgba(0,0,0,0.5);}
    @media only screen and (max-width : 736px) {
      .cart-abandonment .view-unit {max-width: none;}
      .cart-abandonment .btn-container {display: block;}
      .cart-abandonment .cart-btn {margin: 5px auto 0;}
    }
  </style>
  <!---END: NEW CART abandonment FEATURE--->