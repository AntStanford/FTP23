<cfset settings.booking.crlf = "#Chr(13)##Chr(10)#">

<cfprocessingdirective suppresswhitespace="yes">
<cfsavecontent variable="XMLvar">
<cfoutput>
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <QueryAllSiteDoors xmlns="AdministrativesServices">
      <SiteName>Surfside Realty Company</SiteName>
      <DoorProfileID>0</DoorProfileID>
      <LoginName>icndSurfsideRC</LoginName>
      <PassWord>SRC575icnd</PassWord>
      <DoorList></DoorList>
      <StatusCode>0</StatusCode>
    </QueryAllSiteDoors>
  </soap:Body>
</soap:Envelope>
</cfoutput>
</cfsavecontent>
</cfprocessingdirective>

<cfset XMLVar = trim(XMLVar)> 

<cfsavecontent variable="HEADERS">
<cfoutput>
Content-Type: text/xml; charset=utf-8#settings.booking.CRLF#
Content-Length: #len(XMLVar)##settings.booking.CRLF#
</cfoutput>
</cfsavecontent>

<Cfdump var="#XMLvar#">
<hr>
<Cfdump var="#HEADERS#">

<cfhttp url="https://www.kaba-ecode-dev.com/KWS_eCode_Admin/KWS_eCode_Admin.asmx" method="post" result="httpResponse" timeout="20">
    <cfhttpparam type="header" name="SOAPAction" value="AdministrativesServices/QueryAllSiteDoors"/>
    <cfhttpparam type="header" name="accept-encoding" value="no-compression" />
    <cfhttpparam type="xml" value="#trim( xmlVar )#" />
</cfhttp>  

<cfset res = httpresponse.filecontent>   


<hr>
<cfdump var="#res#">
