## About

Component to check UserAgent to detect if request is from a crawler.

Port of https://github.com/JayBizzle/Crawler-Detect

## Location

The cfcomponent is located in /cfformprotect/crawl-detector/ on the root of the FTP server

## Usage

Include in Application.cfm in the website you want to use this feature.

```cfscript
<cfset application.crawlerDetect = CreateObject("Component", "/cfformprotect/crawler-detector/crawler_detector").init()>
```

To test if a request is coming from a crawler use:
```cfscript
<cfif NOT #application.crawlerDetect.isCrawler(CGI.HTTP_USER_AGENT)#>
...YOUR CODE HERE...
</cfif>
```

## Test Cases

Test useragents can be tested from https://github.com/JayBizzle/Crawler-Detect/blob/master/tests/crawlers.txt

```cfscript
<cfset test1 = 'yacybot (/global; amd64 Linux 3.16-0.bpo.2-amd64; java 1.7.0_65; Europe/en) http://yacy.net/bot.html'>
<cfoutput>
#application.crawlerDetect.isCrawler(test1)#
</cfoutput>
```
