<cfinclude template="/components/header.cfm">

<cfif cgi.http_url contains('/mls') or cgi.http_url contains('/booking') or cgi.http_url contains('.com')>
	<cflocation url="/vacation-rental-blog-old/index.cfm" addtoken="false">
</cfif>

<cfsetting enablecfoutputonly=true>
<cfprocessingdirective pageencoding="utf-8">
<!---
	Name         : Index
	Author       : Raymond Camden
	Created      : February 10, 2003
	Last Updated : May 18, 2007
	History      : Reset history for version 5.0
				 : Link for more entries fixed (rkc 6/25/06)
				 : Gravatar support (rkc 7/8/06)
				 : Cleanup of area shown when no entries exist (rkc 7/15/06)
				 : Use of rb(), use of icons, other small mods (rkc 8/20/06)
				 : Change how categories are handled (rkc 9/17/06)
				 : Big change to cut down on whitespace (rkc 11/30/06)
				 : comment mod support (rkc 12/7/06)
				 : gravatar fix, thanks Pete F (rkc 12/26/06)
				 : use app.maxentries, digg link (rkc 2/28/07)
				 : fix bug where 11 items showed up, not 10 (rkc 5/18/07)
	Purpose		 : Blog home page
--->
<cfset dsnmls = "mlsmaster30">
<!--- Handle URL variables to figure out how we will get betting stuff. --->

<cfquery name="getBookingInfo" dataSource="propertyplus">
   select strUserID,strPassword,strCOID from clients where dsn = '#dsn#'
</cfquery>

<cfquery name="getAreas" dataSource="#dsn#">
  select distinct strArea from pp_propertyinfo order by strArea
</cfquery>

<cfquery name="getTypes" dataSource="#dsn#">
   select distinct strType from pp_propertyinfo order by strType
</cfquery>

<cfquery name="getMinMaxBeds" dataSource="#dsn#">
   select min(dblbeds) as minbed, max(dblbeds) as maxbed from pp_propertyinfo
</cfquery>

<cfset application.minBed = getMinMaxBeds.minbed>
<cfset application.maxBed = getMinMaxBeds.maxbed>

<cfquery name="getMinMaxBath" dataSource="#dsn#">
   select min(dblbaths) as minbath, max(dblbaths) as maxbath from pp_propertyinfo
</cfquery>

<cfset application.minBath = getMinMaxBath.minbath>
<cfset application.maxBath = getMinMaxBath.maxbath>

<cfquery name="getMinMaxSleeps" dataSource="#dsn#">
   select min(intoccu) as minsleeps, max(intoccu) as maxsleeps from pp_propertyinfo
</cfquery>

<cfset application.minsleeps = getMinMaxSleeps.minsleeps>
<cfset application.maxsleeps = getMinMaxSleeps.maxsleeps>

<cfquery name="getMinMax" datasource="#dsn#">
	SELECT
		max(dblrate) as maxPrice,
		min(dblrate) as minPrice
	FROM
		pp_season_rates
	WHERE
		dtBeginDate >= '#DateFormat(now(),"YYYY")#-01-01'
   AND
      strChargeBasis = 'Weekly'
</cfquery>

<cfset application.minWeekly = getMinMax.minPrice>
<cfset application.maxWeekly = getMinMax.maxPrice>



<!--- set a cookie to store the recently viewed properties --->
<cfif NOT StructKeyExists(cookie,'recent')>
   <cfcookie name="recent" expires="never">
</cfif>

<!--- set a cookie to store the property favs --->
<cfif NOT StructKeyExists(cookie,'favorites')>
   <cfcookie name="favorites" expires="never">
</cfif>


<cfif isdefined('cookie.UserTrackingCookie') is "No">
	<cfcookie name="UserTrackingCookie" value="#CFID##CFTOKEN#" expires="NEVER">
</cfif>

<!--- 
<cffunction name="getPriceRange" returnType="string">

	<cfargument name="strpropid" required="true" type="string">
	<cfargument name="price1" required="false" type="string">
	<cfargument name="price2" required="false" type="string">

	<cfset currentYear = datePart('yyyy',now())>

	<cfquery name="temp" dataSource="#dsn#">
		select min(dblrate) as minPrice, max(dblrate) as maxPrice
		from pp_season_rates
		where strpropid = <cfqueryparam CFSQLType="CF_SQL_VARCHAR" value="#strpropid#">
		and strchargebasis = 'Weekly'
		and dtBeginDate >= '#DateFormat(now(),"YYYY")#-01-01'

		<cfif isdefined('price1') and len(price1) and isdefined('price2') and len(price2)>
		    and dblrate between #price1# and #price2#
		</cfif>

	</cfquery>

	<cfif temp.recordcount gt 0 and len(temp.minPrice) and len(temp.maxPrice)>
	  <cfset tempReturn = DollarFormat(#temp.minPrice#) & ' - ' & DollarFormat(#temp.maxPrice#) & ' / Week'>
	<cfelse>
	  <cfset tempReturn = ''>
	</cfif>

	<cfreturn tempReturn>

</cffunction>
 --->



<!---THIS IS THE CP FOR URGENCY ITEMS--->
<cfset ShowPropertyInterestCount = "Yes">  <!---yes/no--->
<cfset ShowPecentBooked = "Yes">  <!---yes/no--->

<cfset StatesThatRequireAnOptin="CA,FL,MN,ME,MS,WA">


<cfmodule template="tags/getmode.cfm" r_params="params"/>

<!--- only cache on home page --->
<cfset disabled = false>
<cfif url.mode is not "" or len(cgi.query_string) or not structIsEmpty(form)>
	<cfset disabled = true>
</cfif>

<cfmodule template="tags/scopecache.cfm" cachename="#application.applicationname#" scope="application" disabled="#disabled#" timeout="#application.timeout#">



<!--- Try to get the articles. --->
<cftry>
	<cfset articleData = application.blog.getEntries(params)>
	<cfset articles = articleData.entries>
	<!--- if using alias, switch mode to entry --->
	<cfif url.mode is "alias">
		<cfset url.mode = "entry">
		<cfset url.entry = articles.id>
	</cfif>
	<cfcatch>
		<cfset articleData =  structNew()>
		<cfset articleData.totalEntries = 0>
		<cfset articles = queryNew("id")>
	</cfcatch>
</cftry>

<!--- 
<cfif cgi.remote_addr eq '45.42.5.230'>
<cfoutput>#cgi.http_url#</cfoutput>
<cfdump var="#params#">
</cfif>
 --->

<cfif cgi.http_url eq '/vacation-rental-blog/index.cfm' or cgi.http_url contains('/index.cfm?&startRow=')>
<cfelseif isDefined('params.bycat') or isDefined('params.byyear') or isDefined('params.bymonth')>
<cfelseif articleData.totalEntries gt 1>
	<cflocation url="/vacation-rental-blog/index.cfm" addtoken="false">
</cfif>

<!--- Call layout custom tag. --->
<!--- <cfmodule template="tags/layout.cfm"> --->

	<!--- load up swfobject --->
	<cfoutput>
	<script src="#application.rooturl#/includes/swfobject_modified.js" type="text/javascript"></script>
	</cfoutput>

	<cfset lastDate = "">
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<cfloop query="articles">

		
		
		
		
		
		<!--- BEGIN BLOG ENTRY FOR FRONT PAGE --->
		
		
		
		
    	
		
		
		
		
		
        <cfoutput>
           <div class="container">
           <div class="row">
           <div class="col-md-12">
            <div class="entry<cfif articles.currentRow EQ articles.recordCount>Last</cfif>">
        </cfoutput>

        <cfif application.trackbacksallowed>
            <!--- output this rdf for auto discovery of trackback links --->
            <cfoutput>
                <!--
                            <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns##"
                                 xmlns:dc="http://purl.org/dc/elements/1.1/"
                                 xmlns:trackback="http://madskills.com/public/xml/rss/module/trackback/">
                            <rdf:Description
                                rdf:about="#application.blog.makeLink(id)#"
                                dc:identifier="#application.blog.makeLink(id)#"
                                dc:title="#title#"
                                trackback:ping="#application.rooturl#/trackback.cfm?#id#" />
                            </rdf:RDF>
                            -->
            </cfoutput>
        </cfif>

        <cfoutput>
            <h1><a href="#application.blog.makeLink(id)#">#title#</a></h1>

            <div class="alert alert-info byline">#rb("postedat")# : #application.localeUtils.dateLocaleFormat(posted)# #application.localeUtils.timeLocaleFormat(posted)#
                <cfif len(name)>| #rb("postedby")# : #name#</cfif><br /> #rb("relatedcategories")#:
        </cfoutput>
        <cfset lastid=listLast(structKeyList(categories))>
        <cfloop item="catid" collection="#categories#">
            <cfoutput><a href="#application.blog.makeCategoryLink(catid)#">#categories[currentRow][catid]#</a>
                <cfif catid is not lastid>, </cfif>
            </cfoutput>
        </cfloop>
        <cfoutput>
            </div>
        </cfoutput>
		
		
		
		
		<!--- BLOG BODY --->

		<cfoutput>
            <div class="body">
            #replace(application.blog.renderEntry(body,false,enclosure),'../../','/','all')#

            <!--- STICK IN THE MP3 PLAYER --->
            <cfif enclosure contains "mp3">
                <cfset alternative=replace(getFileFromPath(enclosure),".mp3","") />
                <div class="audioPlayerParent">
                    <div id="#alternative#" class="audioPlayer">
                    </div>
                </div>
                <script type="text/javascript">
                // <![CDATA[
                    var flashvars = {};
                    // unique ID
                    flashvars.playerID = "#alternative#";
                    // load the file
                    flashvars.soundFile= "#application.rooturl#/enclosures/#getFileFromPath(enclosure)#";
                    // Load width and Height again to fix IE bug
                    flashvars.width = "470";
                    flashvars.height = "24";
                    // Add custom variables
                    var params = {};
                    params.allowScriptAccess = "sameDomain";
                    params.quality = "high";
                    params.allowfullscreen = "true";
                    params.wmode = "transparent";
                    var attributes = false;
                    swfobject.embedSWF("#application.rooturl#/includes/audio-player/player.swf", "#alternative#", "470", "24", "8.0.0","/includes/audio-player/expressinstall.swf", flashvars, params, attributes);
                // ]]>
                </script>
            </cfif>


            <cfif len(morebody) and url.mode is not "entry">
            <p align="right">
            <a href="#application.blog.makeLink(id)###more">[#rb("more")#]</a>
            </p>
            <cfelseif len(morebody)>
            <span id="more"></span>
            #application.blog.renderEntry(morebody)#
            </cfif>
            </div>
		</cfoutput>
		
		
		
        <cfoutput>
            <div class="alert well-gray byline">
                <br />
                <a name="fb_share" type="button_count" share_url="#application.blog.makeLink(id)#"></a>
                | Total Views: #views#
                <br /><br />
                <iframe src="http://www.facebook.com/plugins/like.php?href=#application.blog.makeLink(id)#&layout=button_count&show_faces=false&width=80&action=like&font=lucida+grande&colorscheme=light" allowtransparency="true" style="border: medium none; overflow: hidden; width: 80px; height: 21px; padding:0px 0px;" frameborder="0" scrolling="no" align="bottom"></iframe>

                <script src="http://platform.twitter.com/widgets.js" type="text/javascript"></script>
                <a href="http://twitter.com/share" class="twitter-share-button" data-url="#application.blog.makeLink(id)#" data-via="SurfsideRealty - ##myrtlebeach" data-text="#title#" data-related="SurfsideRealty:Surfside Realty" data-count="horizontal">Tweet</a>

                <img src="#application.rooturl#/images/digg.gif" align="middle" title="Digg It!" height="14" width="16"> <a href="http://digg.com/submit?phase=2&url=#application.blog.makeLink(id)#&title=#URLEncodedFormat(" #title# ")#&topic=">Digg It!</a>
                <img src="#application.rooturl#/images/technorati.gif" align="middle" title="Technorati" height="16" width="16"> <a href="http://www.technorati.com/cosmos/links.html?url=#application.blog.makeLink(id)#">Technorati</a>
        </cfoutput>
        
        
       
        <cfoutput><img src="#application.rooturl#/images/email.gif" align="middle" title="#rb(" send ")#" height="16" width="16"> <a href="#application.rooturl#/send.cfm?id=#id#" rel="nofollow">#rb("send")#</a> </cfoutput>
        
        <cfoutput>
            <!---<img src="#application.rooturl#/images/icon_delicious.gif" align="middle" title="del.ico.us" height="11" width="11"> <a href="http://del.icio.us/post?url=#application.blog.makeLink(id)#&title=#URLEncodedFormat("#application.blog.getProperty('blogTitle')#:#title#")#">del.icio.us</a>
                ---></div>
                
        </div>	
        </div>   
        </div>     
        </cfoutput>
		
		
		
		
		
	
		
		
		
		
		


        
        
        

      

		<!--- Things to do if showing one entry --->
		<cfif articles.recordCount is 1>

			<cfset qRelatedBlogEntries = application.blog.getRelatedBlogEntries(entryId=id,bDislayFutureLinks=true) />

		<!---	<cfif qRelatedBlogEntries.recordCount>
				<cfoutput>
				<div id="relatedentries">
				<p>
				<div class="relatedentriesHeader">#rb("relatedblogentries")#</div>
				</p>

  				<ul id="relatedEntriesList">
				<cfloop query="qRelatedBlogEntries">
				<li><a href="#application.blog.makeLink(entryId=qRelatedBlogEntries.id)#">#qRelatedBlogEntries.title#</a> (#application.localeUtils.dateLocaleFormat(posted)#)</li>
				</cfloop>
		  		</ul>
		  		</div>
		  		</cfoutput>
			</cfif> --->

		<!---	<cfif application.trackbacksallowed>
				<cfset trackbacks = application.blog.getTrackBacks(id)>
				<cfoutput>
				<div id="trackbacks">
				<div class="trackbackHeader">TrackBacks</div>
				</cfoutput>

				<cfif trackbacks.recordCount>

					<cfoutput>
					<div class="trackbackBody addTrackbackLink">
					[<a href="javaScript:launchTrackback('#id#')">#application.resourceBundle.getResource("addtrackback")#</a>]
					</div>
					</cfoutput>

					<cfoutput query="trackbacks">
						<div class="trackback<cfif currentRow mod 2>Alt</cfif>">
						<div class="trackbackBody">
						<a href="#postURL#" target="_new" rel="nofollow" class="tbLink">#title#</a><br>
						#paragraphFormat2(excerpt)#
						</div>
						<div class="trackbackByLine">#application.resourceBundle.getResource("trackedby")# #blogname# | #application.resourceBundle.getResource("trackedon")# #application.localeUtils.dateLocaleFormat(created,"short")# #application.localeUtils.timeLocaleFormat(created)#</div>
						</div>
					</cfoutput>
				<cfelse>
					<cfoutput><div class="body">#application.resourceBundle.getResource("notrackbacks")#</div></cfoutput>
				</cfif>

				<cfoutput>
				<p>
				<div class="body">
				#application.resourceBundle.getResource("trackbackurl")#<br>
				#application.rooturl#/trackback.cfm?#id#
				</div>
				</p>
				<div class="trackbackBody addTrackbackLink">
					[<a href="javaScript:launchTrackback('#id#')">#application.resourceBundle.getResource("addtrackback")#</a>]
				</div>
				</div>
				</cfoutput>
			</cfif> --->

			<!---<cfif application.usetweetbacks>

				<cfoutput>
				<div id="tweetbacks">
				<div class="tweetbackHeader">TweetBacks</div>
				<div id="tbContent">
				</cfoutput>

				<cfoutput>
				</div>
				</div>
				</cfoutput>

			</cfif>--->

			<!--- <cfoutput>
			<div id="comments">
			<div class="commentHeader">#rb("comments")# <cfif application.commentmoderation>(#rb("moderation")#)</cfif></div>
			</cfoutput> --->

			<cfset comments = application.blog.getComments(id)>
		<!---	<cfif comments.recordCount>

				<cfif allowComments>
					<cfoutput>
					<div class="trackbackBody addCommentLink">
					[<a href="javaScript:launchComment('#id#')">#rb("addcomment")#</a>]
					[<a href="javaScript:launchCommentSub('#id#')">#rb("addsub")#</a>]

					</div>
					</cfoutput>
				</cfif>

				<cfset entryid = id>
				<cfoutput query="comments">
				<div id="c#id#" class="comment<cfif currentRow mod 2>Alt</cfif>">
					<div class="commentBody">
					<cfif application.gravatarsAllowed><img src="http://www.gravatar.com/avatar/#lcase(hash(email))#?s=40&r=pg&d=#application.rooturl#/images/gravatar.gif" alt="#name#'s Gravatar" border="0"></cfif>
					#paragraphFormat2(replaceLinks(comment))#
					</div>
					<div class="commentByLine">
					<a href="#application.blog.makeLink(entryid)###c#id#">##</a> #rb("postedby")# <cfif len(comments.website)><a href="#comments.website#" rel="nofollow">#name#</a><cfelse>#name#</cfif>
					| #application.localeUtils.dateLocaleFormat(posted,"short")# #application.localeUtils.timeLocaleFormat(posted)#
					</div>
				</div>
				</cfoutput>

				<cfif allowComments>
					<cfoutput>
					<div class="trackbackBody addCommentLink">
					[<a href="javaScript:launchComment('#id#')">#rb("addcomment")#</a>]
					</div>
					</cfoutput>
				</cfif>

			<cfelseif not allowcomments>
				<cfoutput><div class="body">#rb("commentsnotallowed")#</div></cfoutput>
			<cfelse>
				<cfoutput>
				<div class="trackbackBody addCommentLink">
				<p style="text-align:left">#rb("nocomments")#</p>
				[<a href="javaScript:launchComment('#id#')">#rb("addcomment")#</a>]
				[<a href="javaScript:launchCommentSub('#id#')">#rb("addsub")#</a>]
				</div>
				</cfoutput>
			</cfif> --->

			<cfoutput>
			</div>
			</cfoutput>

		</cfif>

		<!--- this div ends the entry div --->
		<cfoutput>
		</div>
		</cfoutput>

	</cfloop>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	<cfif articles.recordCount is 0>

		<cfoutput><div class="body">#rb("sorry")#</div></cfoutput>
		<cfoutput>
		<div class="body">
		<cfif url.mode is "">
			#rb("noentries")#
		<cfelse>
			#rb("noentriesforcriteria")#
		</cfif>
		</div>
		</cfoutput>

	</cfif>

	<!--- Used for pagination. --->
	<cfif (url.startRow gt 1) or (articleData.totalEntries gte url.startRow + application.maxEntries)>

		<!--- get path if not /index.cfm --->
		<cfset path = rereplace(cgi.path_info, "(.*?)/index.cfm", "")>

		<!--- clean out startrow from query string --->
		<cfset qs = cgi.query_string>
		<!--- handle: http://www.coldfusionjedi.com/forums/messages.cfm?threadid=4DF1ED1F-19B9-E658-9D12DBFBCA680CC6 --->
		<cfset qs = reReplace(qs, "<.*?>", "", "all")>
		<cfset qs = reReplace(qs, "[\<\>]", "", "all")>

		<cfset qs = reReplaceNoCase(qs, "&*startrow=[\-0-9]+", "")>
		<cfif isDefined("form.search") and len(trim(form.search)) and not structKeyExists(url, "search")>
			<cfset qs = qs & "&search=#htmlEditFormat(form.search)#">
		</cfif>

		<cfoutput>
		<div class="container">
		    <div class="row">
		       
		</cfoutput>

		<cfif url.startRow gt 1>

			<cfset prevqs = qs & "&startRow=" & (url.startRow - application.maxEntries)>

            <cfoutput>
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <a class="btn btn-lg btn-primary" href="#application.rooturl#/index.cfm#path#?#prevqs#">#rb("preventries")#</a>
                </div>
            </cfoutput>

		</cfif>

		<cfif (url.startRow gt 1) and (articleData.totalEntries gte url.startRow + application.maxEntries)>
			<cfoutput></cfoutput>
		</cfif>

		<cfif articleData.totalEntries gte url.startRow + application.maxEntries>

			<cfset nextqs = qs & "&startRow=" & (url.startRow + application.maxEntries)>

            <cfoutput>
                <div class="col-md-6 col-sm-6 col-xs-6 text-right">
                    <a class="btn btn-lg btn-primary" href="#application.rooturl#/index.cfm#path#?#nextqs#">#rb("moreentries")#</a>
                </div>
            </cfoutput>
            
		</cfif>

		<cfoutput>
	    </div>
		</div>
		</cfoutput>

	</cfif>


<!--- </cfmodule> --->
</cfmodule>

<cfsetting enablecfoutputonly=false>

<cfinclude template="/components/footer.cfm">