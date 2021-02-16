<div class="container">
	<div class="row">
		<ul class="mls-login">
			<cfif isdefined('cookie.loggedin')> <!--- isdefined('session.loggedin') or  --->
				<cfquery name="GetAccountInfo" datasource="#mls.dsn#">
					select *
					from cl_accounts
		   		where id = <cfqueryparam value="#cookie.LoggedIn#" cfsqltype="CF_SQL_VARCHAR">
		   	</cfquery>
				<!--- <li style="font-size: 14px;">Welcome back, <cfoutput>#capFirstTitle(GetAccountInfo.firstname)# #capFirstTitle(GetAccountInfo.lastname)#</cfoutput></li> --->
		   	<li><a hreflang="en" href="/sales/my-profile.cfm" class="button">My Profile</a></li>
		   	<li><a hreflang="en" href="/sales/index.cfm?logout=" class="button">Logout</a></li>
			<cfelse>
			<li><a  href="#" data-toggle="modal" data-target="#mlsModalLogin">Login / Create An Account</a></li> <!--- href="/sales/lightboxes/create-account.cfm" --->
			</cfif>
			<li><a hreflang="en" href="/" class="button">Home</a></li>
		</ul>
	</div>
</div>