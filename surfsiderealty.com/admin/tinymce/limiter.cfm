<cfscript>
function limiter( count=4, duration=1) {
   /*
      Written by Charlie Arehart, charlie@carehart.org, in 2009, updated 2012
      - Throttles requests made more than "count" times within "duration" seconds from single IP.
      - sends 503 status code for bots to consider as well as text for humans to read
      - also logs to a new "limiter.log" that is created automatically in cf logs directory, tracking when limits are hit, to help fine tune
      - note that since it relies on the application scope, you need to place the call to it AFTER a cfapplication tag in application.cfm
      - updated 10/16/12: now adds a test around the actual throttling code, so that it applies only to requests that present no cookie, so should only impact spiders, bots, and other automated requests. A "legit" user in a regular browser will be given a cookie by CF after their first visit and so would no longer be throttled.
      - I also tweaked the cflog output to be more like a csv-format output
      Original Code at http://www.carehart.org/blog/client/index.cfm/2010/5/21/throttling_by_ip_address/
      This function found at http://pi.bradwood.com/blog/rate-limiting-against-dos

      - 6/24/2016 DP had a version of this code (Plantation Services and Lachicotte) where he had the if statement commented on line 25.  We may need to do this but for now we are gonna roll with the default.

   */


   if (!structKeyExists(application, 'rate_limiter' )) {
      application.rate_limiter = StructNew();
      application.rate_limiter[CGI.REMOTE_ADDR] = StructNew();
      application.rate_limiter[CGI.REMOTE_ADDR].attempts = 1;
      application.rate_limiter[CGI.REMOTE_ADDR].last_attempt = Now();
     } else {
      if( cgi.http_cookie is "" or 1 ) {
         if( StructKeyExists(application.rate_limiter, CGI.REMOTE_ADDR) and DateDiff("s",application.rate_limiter[CGI.REMOTE_ADDR].last_attempt,Now()) LT arguments.duration) {
            if( application.rate_limiter[CGI.REMOTE_ADDR].attempts GT arguments.count) {
               writeOutput( '<p>You are making too many requests too fast, please slow down and wait #arguments.duration# seconds</p>' );
               cfheader(statuscode="503", statustext="Service Unavailable");
               cfheader(name="Retry-After", value="#arguments.duration#");
               writelog(file="limiter", text="'limiter invoked for:','#cgi.remote_addr#',#application.rate_limiter[CGI.REMOTE_ADDR].attempts#,#cgi.request_method#,'#cgi.SCRIPT_NAME#', '#cgi.QUERY_STRING#','#cgi.http_user_agent#','#application.rate_limiter[CGI.REMOTE_ADDR].last_attempt#',#listlen(cgi.http_cookie,';')#");
               application.rate_limiter[CGI.REMOTE_ADDR].attempts = application.rate_limiter[CGI.REMOTE_ADDR].attempts + 1;
               application.rate_limiter[CGI.REMOTE_ADDR].last_attempt = Now();
               abort;
            } else {
               application.rate_limiter[CGI.REMOTE_ADDR].attempts = application.rate_limiter[CGI.REMOTE_ADDR].attempts + 1;
               application.rate_limiter[CGI.REMOTE_ADDR].last_attempt = Now();
            }
         } else {
            application.rate_limiter[CGI.REMOTE_ADDR] = StructNew();
            application.rate_limiter[CGI.REMOTE_ADDR].attempts = 1;
            application.rate_limiter[CGI.REMOTE_ADDR].last_attempt = Now();
         }
      }
   }
}

limiter();
</cfscript>