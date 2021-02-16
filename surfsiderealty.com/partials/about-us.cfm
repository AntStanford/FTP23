<cfquery name="getReviews" datasource="#settings.dsn#" >
SELECT *
FROM pp_reviews
where comments <> ''
Order by Rand()
limit 10
</cfquery>
<cfoutput query="getReviews">
	<blockquote><i>"#TRIM(stripHTMLR(comments))#"</i><br>~#fname# #lname#</blockquote>
</cfoutput>