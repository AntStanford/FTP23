<div class="i-newsletter site-color-1-bg">
    <div class="container">
        <div id="newsletterformMSG"></div>
        <form class="newsletterform" id="newsletterform">
            <cfinclude template="/cfformprotect/cffp.cfm">
            <div class="row">
                <h3 class="text-white text-center">Sign Up For Specials &amp; Deals</h3>
                <div class="col-sm-2">
                    <label class="hidden" id="newsletter-firstname">First Name</label>
                    <input class="form-control required" name="firstname" type="text" placeholder="First Name">
                </div>
                <div class="col-sm-2">
                    <label class="hidden" id="newsletter-lastname">Email</label>
                    <input class="form-control required" name="lastname" type="text" placeholder="Last Name">
                </div>
                <div class="col-sm-4">
                    <label class="hidden" id="newsletter-email">Email</label>
                    <input class="form-control required" name="email" type="text" placeholder="ENTER YOUR EMAIL ADDRESS">
                </div>
                <div class="col-sm-2">
                    <div id="newslettercaptcha"></div>
                    <div class="g-recaptcha-error"></div>
                </div>
                <div class="col-sm-2">
                    <input class="btn text-white site-color-2-bg" name="newsletterform" type="submit" value="SIGN UP">
                </div>
                </div>
            </div>
        </form>
    </div>
</div>