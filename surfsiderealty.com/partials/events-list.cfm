<style>
.cms-events-option-1 { margin: 25px 0; }
.cms-events-option-1 ul { margin: 0; padding: 0; }
.cms-events-option-1 ul li { list-style: none; margin: 0 0 25px; }
.cms-events-option-1 ul li:last-child { border: none; }
.cms-events-option-1 .media-img-link { width: 200px; display: block; position: relative; border-radius: 5px; }
.cms-events-option-1 .media-img-link.no-photo { min-height: 150px; }
.cms-events-option-1 .media-img-link.no-photo:hover .date { background: rgba(0,0,0,0.8); }
.cms-events-option-1 .media-img-link:hover .date { background: rgba(0,0,0,0.0); }
.cms-events-option-1 .media-img-link img { width: 200px; position: relative; z-index: 1; border-radius: 5px; }
.cms-events-option-1 .date { font-size: 18px; color: #fff; line-height: normal; text-align: center; z-index: 2; position: absolute; left: 0; top: 0; right: 0; bottom: 0; background: rgba(0,0,0,0.4); transition: all .25s ease-in-out; border-radius: 5px; }
.cms-events-option-1 .date span.date-wrap { position: absolute; left: 50%; top: 50%; transform: translate(-50%,-50%); border-radius: 5px; }
.cms-events-option-1 .date em { font-size: 30px; display: block; font-style: normal; }
.cms-events-option-1 .media-body { width: 100%; padding: 10px 15px; }
.cms-events-option-1 .event-info { font-size: 16px; padding: 3px 0; margin: 0 0 10px; border-top: 1px rgba(0,0,0,0.1) solid; border-bottom: 1px rgba(0,0,0,0.1) solid; }
.cms-events-option-1 span.start-date, .cms-events-option-1 span.end-date {display: inline-block;}
.cms-events-option-1 span.end-date b {position: relative; top: 17px; left: -6px;}
.cms-events-option-1 span.end-date {padding-left: 10px;}

@media (max-width: 480px) {
  .cms-events-option-1 .media-left { display: block; }
  .cms-events-option-1 .media-img-link { width: 100%; margin: 0 0 20px; }
  .cms-events-option-1 .media-img-link img  { width: 100%; }
  .cms-events-option-1 .media-body { padding: 0; }
}
</style>

<cfcache key="cms_eventcal" action="cache" timespan="#settings.globalTimeSpan#" usequerystring="true" useCache="true" directory="e:/inetpub/wwwroot/domains/#tinymce_domain#/temp_files">

<cfquery name="getinfo" dataSource="#settings.dsn#">
  select * from cms_eventcal order by start_date
</cfquery>

<div class="cms-events-option-1">
  <ul>
    <cfoutput query="getinfo">
      <li>
        <div class="media">
          <div class="media-left">
            <cfset cleanTitle = replace(event_title,' ','-','all')>
            <a hreflang="en" href="/event/#cleanTitle#/#id#" class="media-img-link <cfif isDefined("getinfo.photo") and getinfo.photo eq "">no-photo</cfif>">
              <cfif isDefined("getinfo.photo") and getinfo.photo neq "">
                <img src="/images/events/#photo#" width="200">
              </cfif>
              <span class="date">
                <span class="date-wrap">
                    <span class="start-date">
                      #DateFormat(start_date,"mmm")#
                      <em>#DateFormat(start_date,"dd")#</em>
                    </span>
                    <cfif len(end_date) and end_date is not start_date>
                      <span class="end-date"><b>-</b>
                        #DateFormat(end_date,"mmm")#
                        <em>#DateFormat(end_date,"dd")#</em>
                      </span>
                    </cfif>
                </span>
              </span>
            </a>
          </div>
          <div class="media-body">
            <h2 class="media-heading"><a hreflang="en" href="/event/#cleanTitle#/#id#" class="site-color-1 site-color-1-lighten-hover">#event_title#</a></h2>
            <p class="lead event-info">
              #event_location# |
              Starts: #time_start# |
              Ends: #time_end#
            </p>
            <cfif len(details_long) gt 250>
              #left(details_long,250)#...
            <cfelse>
              #details_long#
            </cfif>
          </div>
        </div>
      </li>
    </cfoutput>
  </ul>
</div>
</cfcache>