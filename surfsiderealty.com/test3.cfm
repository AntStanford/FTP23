<cfset settings.booking.crlf = "#Chr(13)##Chr(10)#">

<cfprocessingdirective suppresswhitespace="yes">
<cfsavecontent variable="XMLvar">
<cfoutput>
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <GenerateAccessCode xmlns="AdministrativesServices">
      <SiteName>Surfside Realty Company</SiteName>
      <DoorName>TestSiteDoor</DoorName>
      <StartDate>03/20/2018</StartDate>
      <NbTimeUnits>7</NbTimeUnits>
      <UserPrefix>1</UserPrefix>
      <LoginName>icndSurfsideRC</LoginName>
      <PassWord>SRC575icnd</PassWord>
      <ActionType>NEW_CODE</ActionType>
      <AccessCode></AccessCode>
      <ValidStartDate>03/20/2018</ValidStartDate>
      <ValidEndDate>03/27/2018</ValidEndDate>
      <CheckIn>15:00</CheckIn>
      <CheckOut>10:00</CheckOut>
    </GenerateAccessCode>
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

Body<br>
<Cfdump var="#XMLvar#">
<hr>
Headers:<br>
<Cfdump var="#HEADERS#">

<cfhttp url="https://www.kaba-ecode.com/KWS_eCode_Admin/KWS_eCode_Admin.asmx" method="post" result="httpResponse" timeout="20">
    <cfhttpparam type="header" name="SOAPAction" value="AdministrativesServices/GenerateAccessCode" />
    <cfhttpparam type="header" name="accept-encoding" value="no-compression" />
    <cfhttpparam type="xml" value="#trim( xmlVar )#" />
</cfhttp>  

<cfset res = httpresponse.filecontent>   


<hr>
Response:<Br>
<cfdump var="#res#">
