<div class="well ">
    <cfif isdefined('url.success')>
        <div class="alert alert-success ">Thank you for contacting us.</div>
    </cfif>
    <legend>Contact Us</legend>
    <form class="form" method="post" name="frmPropertyManagementContact" id="frmPropertyManagementContact" action="/submit.cfm">
        <cfinclude template="/cfformprotect/cffp.cfm">
        <div class="form-group">
            <label for="firstname">First Name</label>
            <input type="text" class="form-control required" required placeholder="First Name" name="firstname" data-msg-required="Please enter first name" >
        </div>
        <div class="form-group">
            <label for="lastname">Last Name</label>
            <input type="text" class="form-control required" required placeholder="Last Name" name="lastname" data-msg-required="Please enter last name" >
        </div>
        <div class="form-group">
            <label for="phone">Phone</label>
            <input type="text" class="form-control required" required placeholder="Phone" name="phone" data-msg-required="Please enter Phone" >
        </div>
        <div class="form-group">
            <label for="email">Email</label>
            <input type="text" class="form-control required email" required placeholder="Email" name="email" data-msg-required="Please enter valid Email" >
        </div>
        <div class="form-group">
            <label for="message">Message</label>
            <input type="text" class="form-control" placeholder="Message" name="comments">
        </div>
        <div class="form-group">
            <div id="generalContactFormcaptcha"></div><br /> 
            <div class="g-recaptcha-error"></div>
        </div>
        <div class="form-group">
            <input type="hidden" value="<cfoutput>#pagename#</cfoutput>" name="camefrom">
            <input type="submit" class="btn" value="submit">
            <input type="hidden" name="contactform">
        </div>
    </form>
</div>
