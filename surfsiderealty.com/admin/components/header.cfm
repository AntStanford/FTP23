<cfif cgi.script_name is not '/admin/login.cfm' AND NOT isDefined('session.loggedInUserStruct')>	<!---checkLoggedInUserSecurity()--->
    <cflocation addToken="no" url="/admin/login.cfm?logout">
</cfif>

<!---<cfif NOT IsDefined('getCount') AND isDefined('session.loggedInUserStruct')>
	<cffunction name="getCount" returnType="string">
        <cfargument name="table" hint="Name of the database table" required="true" type="string">
			<cfif left(table,3) eq "be_">
				<cfquery name="returnCount" dataSource="#settings.bcDSN#">
               		select count(id) as 'numrows' from #table# where siteid = <cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#settings.id#">
             	</cfquery>
            <cfelse>  
             	<cfquery name="returnCount" dataSource="#settings.dsn#">
               		select count(id) as 'numrows' from #table#
             	</cfquery>
            </cfif>
        <cfreturn returnCount.numrows>
    </cffunction>
</cfif>--->

<cfset adminPath = #ExpandPath('/admin')#>
<!--- These are always installed by default --->
<cfset numContacts = getCount('cms_contacts')>
<cfquery name="getNumUsers" dataSource="#settings.dsn#">
   select count(id) as numUsers from cms_users where `role` != 'icnd'
</cfquery>
<cfquery name="numPages" dataSource="#settings.dsn#">
   select count(id) as numPages from cms_pages where showInAdmin = 'Yes'
</cfquery>
<cfquery name="getHomepageannouncements" dataSource="#settings.dsn#">
   select count(id) as numHomepageannouncements from cms_homepage_announcements
</cfquery><!doctype html>
<html lang="en">
<head>
  <cfoutput>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <cfif isdefined('page.title')>
    <title><cfoutput>#page.title#</cfoutput></title>
  </cfif>
  <link rel="stylesheet" href="//#cgi.server_name#/admin/bootstrap/css/unicorn-app.css">
  <link rel="stylesheet" href="//#cgi.server_name#/admin/bootstrap/css/custom.css">
  <link rel="stylesheet" href="//#cgi.server_name#/admin/bootstrap/css/datepicker.css">
  <link rel="stylesheet" href="//#cgi.server_name#/admin/bootstrap/css/bootstrap2-toggle.min.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Abel">
  <script src="//#cgi.server_name#/javascripts/jquery-3.1.1.min.js"></script>
  <script src="//#cgi.server_name#/javascripts/jquery-migrate-1.4.1.min.js"></script>
  <script src="//#cgi.server_name#/javascripts/jquery-ui/jquery-ui.min.js"></script>
  <script type="text/javascript" src="//#cgi.server_name#/admin/tinymce/tinymce.min.js"></script>
  </cfoutput>
  <script type="text/javascript">
  tinymce.init({
    selector: "textarea:not(.mceNoEditor)",
    <cfif cgi.script_name contains "/admin/pages/">
      plugins: [
        "filemanager advlist autolink autosave link image lists charmap preview hr anchor pagebreak spellchecker",
        "searchreplace wordcount code fullscreen insertdatetime nonbreaking",
        "table contextmenu directionality template textcolor paste textcolor colorpicker textpattern"
        ],
      font_formats: "Andale Mono=andale mono,times;Arial=arial,helvetica,sans-serif;Arial Black=arial black,avant garde;Book Antiqua=book antiqua,palatino;Comic Sans MS=comic sans ms,sans-serif;Courier New=courier new,courier;Georgia=georgia,palatino;Helvetica=helvetica;Impact=impact,chicago;Open Sans=open sans;Symbol=symbol;Tahoma=tahoma,arial,helvetica,sans-serif;Terminal=terminal,monaco;Times New Roman=times new roman,times;Trebuchet MS=trebuchet ms,geneva;Verdana=verdana,geneva;Webdings=webdings;Wingdings=wingdings,zapf dingbats",
        toolbar1: "filemanager undo redo | styleselect | fontselect fontsizeselect | bold italic underline strikethrough | alignleft aligncenter alignright alignjustify",
        toolbar2: "cut copy paste | searchreplace | bullist numlist | outdent indent  link unlink anchor image code | preview | forecolor",
        toolbar3: "table | hr removeformat | fullscreen | nonbreaking template pagebreak",
        menubar: false,
    <cfelse>
      menubar: false,
      toolbar: "filemanager undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | table | code",
      plugins: "filemanager link table code",
    </cfif>
    height: 300,
    width: '81%',
    content_css : '/stylesheets/styles.css',
    remove_trailing_brs: false,
    extended_valid_elements:'+@[data-options],script[language|type|src],a[href|onclick|style|target|class]',
    style_formats: [
      {title: 'Headers', items: [
        {title: 'Header 1', format: 'h1'},
        {title: 'Header 2', format: 'h2'},
        {title: 'Header 3', format: 'h3'},
        {title: 'Header 4', format: 'h4'},
        {title: 'Header 5', format: 'h5'},
        {title: 'Header 6', format: 'h6'}
      ]},
      {title: 'Inline', items: [
        {title: 'Bold', icon: 'bold', format: 'bold'},
        {title: 'Italic', icon: 'italic', format: 'italic'},
        {title: 'Underline', icon: 'underline', format: 'underline'},
        {title: 'Strikethrough', icon: 'strikethrough', format: 'strikethrough'},
        {title: 'Superscript', icon: 'superscript', format: 'superscript'},
        {title: 'Subscript', icon: 'subscript', format: 'subscript'},
        {title: 'Code', icon: 'code', format: 'code'}
      ]},
      {title: 'Blocks', items: [
        {title: 'Paragraph', format: 'p'},
        {title: 'Blockquote', format: 'blockquote'},
        {title: 'Div', format: 'div'},
        {title: 'Pre', format: 'pre'}
      ]},
      {title: 'Alignment', items: [
        {title: 'Left', icon: 'alignleft', format: 'alignleft'},
        {title: 'Center', icon: 'aligncenter', format: 'aligncenter'},
        {title: 'Right', icon: 'alignright', format: 'alignright'},
        {title: 'Justify', icon: 'alignjustify', format: 'alignjustify'}
      ]},
      {title: 'Site Colors Text', items: [
        {title: 'Site Color 1', selector: 'div,button,a,p,ul,li,h1,h2,h3,h4,h5,h6,.h1,.h2,.h3,.h4,.h5,.h6', classes: 'site-color-1'},
        {title: 'Site Color 2', selector: 'div,button,a,p,ul,li,h1,h2,h3,h4,h5,h6,.h1,.h2,.h3,.h4,.h5,.h6', classes: 'site-color-2'},
        {title: 'Site Color 3', selector: 'div,button,a,p,ul,li,h1,h2,h3,h4,h5,h6,.h1,.h2,.h3,.h4,.h5,.h6', classes: 'site-color-3'},
        {title: 'Site Color 4', selector: 'div,button,a,p,ul,li,h1,h2,h3,h4,h5,h6,.h1,.h2,.h3,.h4,.h5,.h6', classes: 'site-color-4'},
        {title: 'Site Color 5', selector: 'div,button,a,p,ul,li,h1,h2,h3,h4,h5,h6,.h1,.h2,.h3,.h4,.h5,.h6', classes: 'site-color-5'},
        {title: 'Site Color 6', selector: 'div,button,a,p,ul,li,h1,h2,h3,h4,h5,h6,.h1,.h2,.h3,.h4,.h5,.h6', classes: 'site-color-6'},
      ]},
      {title: 'Site Colors Background', items: [
        {title: 'Site Color 1', selector: 'div,button,a,p,ul,li,h1,h2,h3,h4,h5,h6,.h1,.h2,.h3,.h4,.h5,.h6', classes: 'site-color-1-bg'},
        {title: 'Site Color 2', selector: 'div,button,a,p,ul,li,h1,h2,h3,h4,h5,h6,.h1,.h2,.h3,.h4,.h5,.h6', classes: 'site-color-2-bg'},
        {title: 'Site Color 3', selector: 'div,button,a,p,ul,li,h1,h2,h3,h4,h5,h6,.h1,.h2,.h3,.h4,.h5,.h6', classes: 'site-color-3-bg'},
        {title: 'Site Color 4', selector: 'div,button,a,p,ul,li,h1,h2,h3,h4,h5,h6,.h1,.h2,.h3,.h4,.h5,.h6', classes: 'site-color-4-bg'},
        {title: 'Site Color 5', selector: 'div,button,a,p,ul,li,h1,h2,h3,h4,h5,h6,.h1,.h2,.h3,.h4,.h5,.h6', classes: 'site-color-5-bg'},
        {title: 'Site Color 6', selector: 'div,button,a,p,ul,li,h1,h2,h3,h4,h5,h6,.h1,.h2,.h3,.h4,.h5,.h6', classes: 'site-color-6-bg'},
      ]},
    ]
  });
  </script>
  <link href="/images/layout/favicon.ico" rel="icon" type="image/x-icon">
</head>
<body>
  <cfif cgi.script_name contains 'login'>
    <style>

        .url-alert { margin-bottom: 25px; padding: 15px; background: #C40307; font-family: 'Helvetica Neue', helvetica, sans-serif; font-size: 18px; color: #fff; line-height: 1.35; font-weight: 500; text-align: center; }

        .url-alert a { color: #fff; text-decoration: underline; }

        .url-alert strong { display: block; margin-top: 10px; font-size: 200%; }

        @-moz-keyframes bounce {

          0%, 20%, 50%, 80%, 100% { -moz-transform: translateY(0); transform: translateY(0); }

          40% { -moz-transform: translateY(-30px); transform: translateY(-30px); }

          60% { -moz-transform: translateY(-15px); transform: translateY(-15px); }

        }

        @-webkit-keyframes bounce {

          0%, 20%, 50%, 80%, 100% { -webkit-transform: translateY(0); transform: translateY(0); }

          40% { -webkit-transform: translateY(-30px); transform: translateY(-30px); }

          60% { -webkit-transform: translateY(-15px); transform: translateY(-15px); }

        }

        @keyframes bounce {

          0%, 20%, 50%, 80%, 100% { -moz-transform: translateY(0); -ms-transform: translateY(0); -webkit-transform: translateY(0); transform: translateY(0); }

          40% { -moz-transform: translateY(-30px); -ms-transform: translateY(-30px); -webkit-transform: translateY(-30px); transform: translateY(-30px); }

          60% { -moz-transform: translateY(-15px); -ms-transform: translateY(-15px); -webkit-transform: translateY(-15px); transform: translateY(-15px); }

        }

        .arrow { display: block; width: 40px; height: 24px; margin: 10px 0; position: relative; bottom: 0; left: 50%; transform: rotate(180deg); }

        .bounce { -moz-animation: bounce 2s infinite; -webkit-animation: bounce 2s infinite; animation: bounce 2s infinite; }

      </style>

     <div class="url-alert">

        ALERT: Very important - please make sure the address in your URL Bar matches the one below.<br>Call <a href="tel:910-575-6095">910-575-6095</a> or email <a href="mailto:support@icoastalnet.com">support@icoastalnet.com</a> if any doubt. <strong><cfoutput>http<cfif cgi.https is "On">s</cfif>://#cgi.http_host#/admin/login.cfm</cfoutput></strong>

        <img class="arrow bounce" alt="arrow.png" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAYCAYAAACIhL/AAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyhpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTQwIDc5LjE2MDQ1MSwgMjAxNy8wNS8wNi0wMTowODoyMSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTggKE1hY2ludG9zaCkiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6OTMxMDUyN0VBNjQ1MTFFOTk0MjBBRTU1QTYwQzJFMDUiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6OTMxMDUyN0ZBNjQ1MTFFOTk0MjBBRTU1QTYwQzJFMDUiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDpEMjFDNjg4OUE2MzcxMUU5OTQyMEFFNTVBNjBDMkUwNSIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDpEMjFDNjg4QUE2MzcxMUU5OTQyMEFFNTVBNjBDMkUwNSIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PuxyKHkAAAGjSURBVHjaxJddKwRRGMdnvL9HhEhJSr6Lb+FC7tyQUkq5UOwFypaSLaGNNqKVl0IpiUI2KSnkwoVSrtxw/E+dkWad3f/MnJ196nc1z3meX2dmzoslhLAMUAii4B18gh3QaqK2CbkCsCDS4xQ05VvQBjGhj3PQmC9BWzNz7jgDDfkQnBd8yNddH6ZgVHiPE1AXhuCs8B/HoDaXgtMieByCmlwIRoS5OADVJgUnycZHYJHM3QOVJgQnyIYXf/7UGDlG7jgVQQTHyUaXoNm1uyyRY7dBuR/BMbLBNWjR7M+rZI1NUOpFcJQsfKWRcygCy2StBChhBEfIgjfkiUVKxsmaa25Jd7FhstAtaPOwRBWDdbJ2XOWnCQ6SBe5Au48dSH5jG2SPFTXzv4J95MB70BHggFEGtshe8qRky0E96hScLR5Ap4EDrlxSkqTkkByQIhIfQZeh64GlFuddou+rRSQ9gW6Dcg5VYD9bc5n4kuF5yvDM/SeZyND/Qyb1ah4mgxzVPV66pjQOESepHzyDb/AG5tQfZ4XIgPqcvtT1dUYuTT8CDABCJ7M5NHFPSgAAAABJRU5ErkJggg=="/>

      </div>

                 

  <div id="logo">
      <img src="/admin/bootstrap/img/logo.png">
    </div>
  <cfelse>
    <div id="header">
  		<h1><a href="/admin/dashboard.cfm">ICND Admin</a></h1>
    </div>
    <div id="user-nav" class="navbar navbar-inverse">
      <ul class="nav btn-group">
        <cfoutput><li class="btn btn-inverse"><a title="" href="/admin/users/form.cfm?id=#session.loggedInUserStruct.LoggedInID#"><i class="icon icon-user"></i> <span class="text">#session.loggedInUserStruct.LoggedInName#</span></a></li></cfoutput>
        <li class="btn btn-inverse"><a title="" href="/admin/settings"><i class="icon icon-cog"></i> <span class="text">Settings</span></a></li>
        <li class="btn btn-inverse"><a title="" href="/admin/login.cfm?logout"><i class="icon icon-share-alt"></i> <span class="text">Logout</span></a></li>
      </ul>
    </div>
    <!--- Start the left side navigation here --->
    <cfoutput>
    <div id="sidebar">
      <a href="/admin/dashboard.cfm" class="visible-phone"><i class="icon icon-home"></i> Dashboard</a>
      <ul>
        <li<cfif cgi.script_name contains "/admin/dashboard.cfm"> class="active"</cfif>><a href="/admin/dashboard.cfm"><i class="icon icon-home"></i> <span>Dashboard</span></a></li>
        <li<cfif cgi.script_name contains "/admin/users/"> class="active"</cfif>><a href="/admin/users/"><i class="icon icon-user"></i> <span>Users</span> <span class="label">#getNumUsers.numUsers#</span></a></li>
        <li<cfif cgi.script_name contains "/admin/contacts/"> class="active"</cfif>><a href="/admin/contacts/"><i class="icon icon-comment"></i> <span>Contacts</span> <span class="label">#numContacts#</span></a></li>
        <li<cfif cgi.script_name contains "/admin/home-page-announcements/"> class="active"</cfif>><a href="/admin/home-page-announcements/"><i class="icon icon-comment"></i> <span>Announcements</span> <span class="label">#getHomepageannouncements.numHomepageannouncements#</span></a></li>

        <li class="submenu <cfif  cgi.script_name contains '/admin/pages/' or
                                  cgi.script_name contains '/admin/ads/' or
                                  cgi.script_name contains '/admin/homeslideshow/' or
                                  cgi.script_name contains '/admin/documents/' or
                                  cgi.script_name contains '/admin/multi-upload-gallery/' or
                                  cgi.script_name contains '/admin/events/' or
                                  cgi.script_name contains '/admin/events-recurring/' or
                                  cgi.script_name contains '/admin/thingstodo/' or
                                  cgi.script_name contains '/admin/testimonials/' or
                                  cgi.script_name contains '/admin/staff/' or
                                  cgi.script_name contains '/admin/faqs/' or
                                  cgi.script_name contains '/admin/callouts/' or
                                  cgi.script_name contains '/admin/condos/' or
                                  cgi.script_name contains '/admin/popups/'
                            >open</cfif>">
            <a href="##"><i class="icon icon-chevron-down"></i> <span>Manage Content</span> </a>
            <ul>
               <li<cfif cgi.script_name contains "/admin/pages/"> class="active"</cfif>><a href="/admin/pages/"><i class="icon icon-file"></i> <span>Pages</span> <span class="label">#numPages.numPages#</span></a></li>

<!---                <cfif FileExists('#adminPath#\ads\index.cfm')>
                  <cfset numAds = getCount('cms_ads')>
                  <li<cfif cgi.script_name contains "/admin/ads/"> class="active"</cfif>><a href="/admin/ads/"><i class="icon icon-film"></i> <span>Ads</span> <span class="label">#numAds#</span></a></li>
               </cfif> --->

               <cfif FileExists('#adminPath#\homeslideshow\index.cfm')>
                  <cfquery name="numHomeSlides" dataSource="#settings.dsn#">
                  select count(id) as 'numHomeSlides' from cms_assets where section = 'Homepage Slideshow'
                  </cfquery>
                  <li<cfif cgi.script_name contains "/admin/homeslideshow/"> class="active"</cfif>><a href="/admin/homeslideshow/"><i class="icon icon-picture"></i> <span>Home Slideshow</span> <span class="label">#numHomeSlides.numHomeSlides#</span></a></li>
               </cfif>

               <li<cfif cgi.script_name contains "/admin/popups/"> class="active"</cfif>><a href="/admin/popups/"><i class="icon icon-bullhorn"></i> <span>Pop Ups</span></a></li>
<!--- 
               <cfif FileExists('#adminPath#\documents\index.cfm')>
                  <cfquery name="numDocs" dataSource="#settings.dsn#">
                  select count(id) as numDocs from cms_assets where section = 'Documents'
                  </cfquery>
                  <li<cfif cgi.script_name contains "/admin/documents/"> class="active"</cfif>><a href="/admin/documents/"><i class="icon icon-file"></i> <span>Documents</span> <span class="label">#numDocs.numDocs#</span></a></li>
               </cfif>
 --->
               <cfif FileExists('#adminPath#\multi-upload-gallery\index.cfm')>
                  <cfquery name="numGalleryPhotos" dataSource="#settings.dsn#">
                  select count(id) as 'numGalleryPhotos' from cms_assets where section = 'Gallery'
                  </cfquery>
                  <li<cfif cgi.script_name contains "/admin/multi-upload-gallery/"> class="active"</cfif>><a href="/admin/multi-upload-gallery/"><i class="icon icon-picture"></i> <span>Gallery</span> <span class="label">#numGalleryPhotos.numGalleryPhotos#</span></a></li>
               </cfif>
<!--- 
               <cfif FileExists('#adminPath#\events\index.cfm')>
                  <cfset numEvents = getCount('cms_eventcal')>
                  <li<cfif cgi.script_name contains "/admin/events/"> class="active"</cfif>><a href="/admin/events/"><i class="icon icon-calendar"></i> <span>Events</span> <span class="label">#numEvents#</span></a></li>
               </cfif>

               <cfif FileExists('#adminPath#\events-recurring\index.cfm')>
                  <cfset numEvents = getCount('cms_eventcal')>
                  <li<cfif cgi.script_name contains "/admin/events-recurring/"> class="active"</cfif>><a href="/admin/events-recurring/"><i class="icon icon-calendar"></i> <span>Events - Reccuring</span> <span class="label">#numEvents#</span></a></li>
               </cfif>

               <cfif FileExists('#adminPath#\thingstodo\index.cfm')>
                  <cfset numThingsToDo = getCount('cms_thingstodo')>
                  <li<cfif cgi.script_name contains "/admin/thingstodo/"> class="active"</cfif>><a href="/admin/thingstodo/"><i class="icon icon-calendar"></i> <span>Things To Do</span> <span class="label">#numThingsToDo#</span></a></li>
               </cfif>

               <cfif FileExists('#adminPath#\testimonials\index.cfm')>
                  <cfset numTestimonials = getCount('cms_testimonials')>
                  <li<cfif cgi.script_name contains "/admin/testimonials/"> class="active"</cfif>><a href="/admin/testimonials/"><i class="icon icon-comment"></i> <span>Testimonials</span> <span class="label">#numTestimonials#</span></a></li>
               </cfif> --->

               <cfif FileExists('#adminPath#\staff\index.cfm')>
                  <cfset numStaff = getCount('cms_staff')>
                  <li<cfif cgi.script_name contains "/admin/staff/"> class="active"</cfif>><a href="/admin/staff/"><i class="icon icon-user"></i> <span>Staff</span> <span class="label">#numStaff#</span></a></li>
               </cfif>
<!--- 
               <cfif FileExists('#adminPath#\faqs\index.cfm')>
                  <cfset numFAQs = getCount('cms_faqs')>
                  <li<cfif cgi.script_name contains "/admin/faqs/"> class="active"</cfif>><a href="/admin/faqs/"><i class="icon icon-question-sign"></i> <span>FAQs</span> <span class="label">#numFAQs#</span></a></li>
               </cfif>

               <cfif FileExists('#adminPath#\callouts\index.cfm')>
                  <cfset numCallouts = getCount('cms_callouts')>
                  <li<cfif cgi.script_name contains "/admin/callouts/"> class="active"</cfif>><a href="/admin/callouts/"><i class="icon icon-bullhorn"></i> <span>Callouts</span> <span class="label">#numCallouts#</span></a></li>
               </cfif>
 --->
               <cfif FileExists('#adminPath#\condos\index.cfm')>
                  <cfset numCondos = getCount('cms_condos')>
                  <li<cfif cgi.script_name contains "/admin/condos/"> class="active"</cfif>><a href="/admin/condos/"><i class="icon icon-certificate"></i> <span>Condos</span> <span class="label">#numCondos#</span></a></li>
               </cfif>

            </ul>
         </li>



        <li class="submenu <cfif  cgi.script_name contains '/admin/specials/' or
                                  cgi.script_name contains '/admin/reviews/' or
                                  cgi.script_name contains '/admin/unifocus/' or
                                  cgi.script_name contains '/admin/property_q_and_a/' or
                                  cgi.script_name contains '/admin/flipkey/' or
                                  cgi.script_name contains '/admin/properties/' or
                                  cgi.script_name contains '/admin/data-harvest/' or
                                  cgi.script_name contains '/admin/featured-properties/' or
                                  cgi.script_name contains '/admin/long-term-rentals/' or
                                  cgi.script_name contains '/admin/nextyear/' or
                                  cgi.script_name contains '/admin/amenities/' or
                                  cgi.script_name contains '/admin/property-photos/' or
                                  cgi.script_name contains '/admin/terms/' or
                                  cgi.script_name contains '/admin/addons/' or
                                  cgi.script_name contains '/admin/blacklist/'
                            >open</cfif>">
                            <a href="##"><i class="icon icon-chevron-down"></i> <span>Manage Booking Engine</span> </a>
          <ul>
           <cfif FileExists('#adminPath#\specials\index.cfm')>
             <cfset numSpecials = getCount('cms_specials')>
             <li<cfif cgi.script_name contains "/admin/specials/"> class="active"</cfif>><a href="/admin/specials/"><i class="icon icon-certificate"></i> <span>Specials</span> <span class="label">#numSpecials#</span></a></li>
           </cfif>
           <cfif FileExists('#adminPath#\reviews\index.cfm')>
              <cfquery name="getReviews" dataSource="#settings.dsn#">
                select count(id) as totalReviews from be_reviews
              </cfquery>
             <li<cfif cgi.script_name contains "/admin/reviews/"> class="active"</cfif>><a href="/admin/reviews/"><i class="icon icon-certificate"></i> <span>Website Reviews</span> <span class="label">#getReviews.totalReviews#</span></a></li>
           </cfif>

<!---            <cfif FileExists('#adminPath#\unifocus\index.cfm')>
             <li<cfif cgi.script_name contains "/admin/unifocus/"> class="active"</cfif>><a href="/admin/unifocus/"><i class="icon icon-certificate"></i> <span>Unifocus Reviews</span></a></li>
           </cfif> --->

           <cfif FileExists('#adminPath#\property_q_and_a\index.cfm')>
             <cfset numPropertyQA = getCount('be_questions_and_answers_properties','booking_clients')>
             <li<cfif cgi.script_name contains "/admin/property_q_and_a/"> class="active"</cfif>><a href="/admin/property_q_and_a/"><i class="icon icon-certificate"></i> <span>Property Q/A</span> <span class="label">#numPropertyQA#</span></a></li>
           </cfif>

<!--- 
           <cfif FileExists('#adminPath#\flipkey\index.cfm')>
             <!--- write a query to get the total num properties --->
             <li<cfif cgi.script_name contains "/admin/flipkey/"> class="active"</cfif>><a href="/admin/flipkey/"><i class="icon icon-certificate"></i> <span>Flipkey IDs</span> <span class="label">0</span></a></li>
           </cfif> --->

<!---            <cfif FileExists('#adminPath#\properties\index.cfm')>
             <!--- write a query to get the total num properties --->
             <li<cfif cgi.script_name contains "/admin/properties/"> class="active"</cfif>><a href="/admin/properties/"><i class="icon icon-certificate"></i> <span>VR Enhancement</span> <span class="label">0</span></a></li>
           </cfif> --->

            <li<cfif cgi.script_name contains "/admin/data-harvest/"> class="active"</cfif>><a href="/admin/data-harvest/form.cfm"><i class="icon icon-ok"></i> <span>Data Harvest</span></a></li>

           <!---
<cfif FileExists('#adminPath#\rewrites\index.cfm')>
             <cfset numTestimonials = getCount('cms_rewrites')>
             <li<cfif cgi.script_name contains "/admin/rewrites/"> class="active"</cfif>><a href="/admin/rewrites/"><i class="icon icon-file"></i> <span>Rewrites</span> <span class="label">#numTestimonials#</span></a></li>
           </cfif>
--->
<!---
           <cfif FileExists('#adminPath#\property-photos\index.cfm')>
             <li<cfif cgi.script_name contains "/admin/property-photos/"> class="active"</cfif>><a href="/admin/property-photos/"><i class="icon icon-file"></i> <span>Property Photos</span> </a></li>
           </cfif>
           --->

           <cfif FileExists('#adminPath#\featured-properties\index.cfm')>
             <li<cfif cgi.script_name contains "/admin/featured-properties/"> class="active"</cfif>><a href="/admin/featured-properties/"><i class="icon icon-file"></i> <span>Featured Properties</span> </a></li>
           </cfif>

           <cfif FileExists('#adminPath#\long-term-rentals\index.cfm')>
             <li<cfif cgi.script_name contains "/admin/long-term-rentals/"> class="active"</cfif>><a href="/admin/long-term-rentals/"><i class="icon icon-home"></i> <span>Long Term Rentals</span> </a></li>
           </cfif>

           <cfif FileExists('#adminPath#\nextyear\index.cfm')>
             <li<cfif cgi.script_name contains "/admin/nextyear/"> class="active"</cfif>><a href="/admin/nextyear/"><i class="icon icon-home"></i> <span>Next Year Rates</span> </a></li>
           </cfif>

           <cfif FileExists('#adminPath#\terms\index.cfm')>
             <li<cfif cgi.script_name contains "/admin/terms/"> class="active"</cfif>><a href="/admin/terms/"><i class="icon icon-home"></i> <span>Terms</span> </a></li>
           </cfif>

           <cfif FileExists('#adminPath#\addons\index.cfm')>
             <li<cfif cgi.script_name contains "/admin/addons/"> class="active"</cfif>><a href="/admin/addons/"><i class="icon icon-file"></i> <span>Add-ons</span> </a></li>
           </cfif>

           <cfif FileExists('#adminPath#\blacklist\index.cfm')>
             <li<cfif cgi.script_name contains "/admin/blacklist/"> class="active"</cfif>><a href="/admin/blacklist/"><i class="icon icon-file"></i> <span>Blacklist</span> </a></li>
           </cfif>

	      </ul>
      </li>

      <li <cfif cgi.script_name contains "/admin/cart-abandonment"> class="submenu active open"<cfelse>class="submenu"</cfif>>
         <a href="javascript:;"><i class="icon icon-user"></i> Cart Abandonment</a>
         <ul>
            <li <cfif cgi.script_name contains '/admin/cart-abandonment/checkout-page.cfm'>class="active"</cfif>><a href="/admin/cart-abandonment/checkout-page.cfm"><span>Checkout Page</span></a></li>
            <li <cfif cgi.script_name contains '/admin/cart-abandonment/detail-page.cfm'>class="active"</cfif>><a href="/admin/cart-abandonment/detail-page.cfm"><span>Detail Page</span></a></li>
         </ul>
      </li>

      <cfif FileExists('#adminPath#\guest-reviews\index.cfm')>
          <li <cfif cgi.script_name contains "/admin/guest-reviews/"> class="active"</cfif>><a href="/admin/guest-reviews/"><i class="icon icon-certificate"></i> <span>Guest Reviews</span></a></li>
       </cfif>



        <cfif session.loggedInUserStruct.LoggedInRole eq 'icnd'>
          <li class="submenu">
            <a href="javascript:;"><i class="icon icon-ban-circle"></i> <span>ICND Only</span></a>
            <ul style="display: none;">
              <li><a href="/admin/pages/quick-view.cfm">Meta View</a></li>
              <li><a href="/admin/pages/notfound-frequency.cfm">404 table</a></li>
            </ul>
          </li>
        </cfif>
      </ul>
    </div>
  </cfoutput>
  <!--- End the left side navigation --->
  <div id="content">
    <div id="content-header">
      <cfif isdefined('page.title')>
      	<h1><cfoutput>#page.title#</cfoutput></h1>
      </cfif>
    </div>
    <div id="breadcrumb">
      <a href="/admin/dashboard.cfm" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a>
      <span style="font-weight:bold;color:#444;font-size:11px;padding-left:7px"><cfif isdefined('page.title')><cfoutput>#page.title#</cfoutput></cfif></span>
    </div>
    <div class="container-fluid">
      <div class="row-fluid">
        <div class="span12">
  </cfif>