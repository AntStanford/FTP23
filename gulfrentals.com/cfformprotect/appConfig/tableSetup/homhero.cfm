<cfif request.appConfigData.PMS EQ "Homhero">
	<!--- Creates the homhero_amenities Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `homhero_amenities` (
      `propertyID` int(11) DEFAULT NULL,
      `name` varchar(255) DEFAULT NULL,
      `amenityID` int(11) NOT NULL AUTO_INCREMENT,
      PRIMARY KEY (`amenityID`)
    ) ENGINE=InnoDB AUTO_INCREMENT=3461045 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the homhero_avail_checkout_dates Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `homhero_avail_checkout_dates` (
      `propertyID` int(11) DEFAULT NULL,
      `theDate` date DEFAULT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the homhero_guestreservationinfo Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `homhero_guestreservationinfo` (
      `propertyID` int(11) DEFAULT NULL,
      `strEmail` varchar(255) DEFAULT NULL,
      `dtCheckInDate` datetime DEFAULT NULL,
      `dtCheckOutDate` datetime DEFAULT NULL,
      `intAdults` int(10) DEFAULT NULL,
      `intChildren` int(10) DEFAULT NULL,
      `intQuoteNum` int(10) NOT NULL DEFAULT '0',
      `strStatus` varchar(255) DEFAULT NULL,
      `strStatFlag` varchar(2) DEFAULT NULL,
      `strNotes` text,
      `dtBookDate` datetime DEFAULT NULL,
      `dtChangeDate` datetime DEFAULT NULL,
      `strResAgent` varchar(255) DEFAULT NULL,
      `strGuestID` varchar(255) DEFAULT NULL,
      `strStayType` varchar(255) DEFAULT NULL,
      `strGuestType` varchar(255) DEFAULT NULL,
      `strLockOffProps` varchar(255) DEFAULT NULL,
      `dblAmountPaid` double DEFAULT NULL,
      `strMarketID` varchar(255) DEFAULT NULL,
      `strFirstName` varchar(255) DEFAULT NULL,
      `strLastName` varchar(255) DEFAULT NULL,
      `strPhone` varchar(255) DEFAULT NULL,
      `booktype` varchar(255) DEFAULT NULL,
      `contractSignDateTime` datetime DEFAULT NULL,
      `autopay` varchar(10) NOT NULL DEFAULT 'NA',
      `travelInsurance` varchar(10) DEFAULT NULL,
      `contractSignatureTextField` varchar(255) DEFAULT NULL,
      `signatureip` varchar(100) DEFAULT NULL,
      `welcomeEmailSentDateTime` date DEFAULT NULL,
      `welcomeemailsentbywho` varchar(255) DEFAULT NULL,
      `welcomeemailsent` varchar(5) DEFAULT NULL,
      `reviewed` int(11) NOT NULL DEFAULT '0',
      `initials1` varchar(10) DEFAULT NULL,
      `initials2` varchar(10) DEFAULT NULL,
      `initials3` varchar(10) DEFAULT NULL,
      `PostDepartureSurveySent` varchar(255) DEFAULT 'No',
      `PostDepartureSurveyOpenedDate` datetime DEFAULT NULL,
      `PostDepartureSurveySentDate` datetime DEFAULT NULL,
      PRIMARY KEY (`intQuoteNum`),
      KEY `dtCheckInDate` (`dtCheckInDate`),
      KEY `dtbookdate` (`dtBookDate`),
      KEY `propertyID` (`propertyID`),
      KEY `strEmail` (`strEmail`),
      KEY `intQuoteNum` (`intQuoteNum`) USING BTREE,
      KEY `strStatus` (`strStatus`) USING BTREE
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the homhero_non_available_dates Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `homhero_non_available_dates` (
      `propertyID` int(11) DEFAULT NULL,
      `theDate` date DEFAULT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the homhero_non_checkin_dates Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `homhero_non_checkin_dates` (
      `propertyID` int(11) DEFAULT NULL,
      `theDate` date DEFAULT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the homhero_photos Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `homhero_photos` (
      `photoID` int(11) NOT NULL AUTO_INCREMENT,
      `propertyID` int(11) DEFAULT NULL,
      `url` varchar(255) DEFAULT NULL,
      `thumb` varchar(255) DEFAULT NULL,
      `caption` varchar(255) DEFAULT NULL,
      `displayOrder` int(11) DEFAULT NULL,
      PRIMARY KEY (`photoID`)
    ) ENGINE=InnoDB AUTO_INCREMENT=2356887 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the homhero_properties Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `homhero_properties` (
      `propertyID` int(11) NOT NULL,
      `name` varchar(255) DEFAULT NULL,
      `bedrooms` int(11) DEFAULT '0',
      `bathrooms` int(11) DEFAULT '0',
      `sleeps` int(11) DEFAULT NULL,
      `defaultPhoto` varchar(255) DEFAULT NULL,
      `seopropertyname` varchar(255) DEFAULT NULL,
      `description` text,
      `latitude` varchar(255) DEFAULT NULL,
      `longitude` varchar(255) DEFAULT NULL,
      `address1` varchar(255) DEFAULT NULL,
      `address2` varchar(255) DEFAULT NULL,
      `city` varchar(255) DEFAULT NULL,
      `state` varchar(255) DEFAULT NULL,
      `country` varchar(255) DEFAULT NULL,
      `postcode` varchar(20) DEFAULT NULL,
      PRIMARY KEY (`propertyID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the homhero_rates Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `homhero_rates` (
      `propertyID` int(11) DEFAULT NULL,
      `price` double(10,2) DEFAULT '0.00',
      `theDate` date DEFAULT NULL,
      `minStay` int(11) DEFAULT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
</cfif>
