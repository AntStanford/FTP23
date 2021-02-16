<cfcontent type="text/xml" /><?xml version="1.0"?>
<ITEMS>
  <cfquery name="GetBlogs" datasource="#settings.dsn#">
    Select tblblogentries.*,tblblogcategories.categoryname from tblblogentries,tblblogentriescategories,tblblogcategories
    where tblblogentriescategories.categoryidfk = tblblogcategories.categoryid
    and tblblogentriescategories.entryidfk = tblblogentries.id
  </cfquery>
  <cfoutput query="GetBlogs">
    <cfset thebody = replace(replace(replace(replace(htmlcodeformat(body),Chr(10),'','all'),Chr(13),'','all'),'&nbsp;',' ','all'),"'",'&##39;','all')>
    <cfset thebody = replace(thebody,'<PRE>','','all')>
    <cfset thebody = replace(thebody,'</PRE>','','all')>
    <item>
     <pubDate>#dateformat(posted,'ddd, d mmm yyyy')# #timeformat(posted,'HH:mm:ss')# +0000</pubDate>
     <category>#categoryname#</category>
     <title>#replace(title,'&','&amp;','all')#</title>
     <content>#thebody#</content>
    </item>
  </cfoutput>
</ITEMS>
