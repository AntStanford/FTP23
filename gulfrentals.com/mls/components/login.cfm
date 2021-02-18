<div class="container">
  <div class="row">
    <ul class="mls-login">
       <cfif isDefined("cookie.loggedIn") and isDefined("cookie.userfirstname") and isDefined("cookie.userlastname")>
       <li style="font-size: 14px;">Welcome back, <cfoutput>#capFirstTitle(cookie.userfirstname)# #capFirstTitle(cookie.userlastname)#</cfoutput></li>
       <li class="profile"><a href="/#settings.mls.dir#/my-profile.cfm" class="button btn btn-danger">My Profile</a></li>
       <li class="logout"><a href="/#settings.mls.dir#/index.cfm?logout=" class="button btn btn-success">Logout</a></li>
       <cfelse>
      <!---  <li><a  href="#" data-toggle="modal" data-target="#mlsModalLogin" class="btn btn-success">Login / Create An Account</a></li> --->
       <li class="login"><a href="/#settings.mls.dir#/components/mls-account.cfm" class="btn btn-success">Login / Create An Account</a></li>
       </cfif>
       <!--- href="/#settings.mls.dir#/lightboxes/create-account.cfm" --->
       <li class="home"><a href="/" class="button btn btn-danger">Home</a></li>
       <li class="mls-home"><a href="/real-estate" class="button btn btn-success">MLS Home</a></li>
    </ul>
  </div>
</div>