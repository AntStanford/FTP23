<cfif request.appConfigData.PMS EQ "365 villas">
	<!--- Creates the villas_amenities Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `villas_amenities` (
      `amenityID` int(11) NOT NULL AUTO_INCREMENT,
      `amenityName` varchar(255) DEFAULT NULL,
      `propertyID` int(11) DEFAULT NULL,
      `amenityValue` int(11) DEFAULT NULL,
      `amenityQty` int(11) DEFAULT NULL,
      PRIMARY KEY (`amenityID`)
    ) ENGINE=InnoDB AUTO_INCREMENT=3246075 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
	<!--- Creates the villas_non_available_dates Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `villas_non_available_dates` (
      `nonAvailableDateID` int(11) NOT NULL AUTO_INCREMENT,
      `startDate` date DEFAULT NULL,
      `endDate` date DEFAULT NULL,
      `PropertyID` int(11) DEFAULT NULL,
      PRIMARY KEY (`nonAvailableDateID`)
    ) ENGINE=InnoDB AUTO_INCREMENT=32729295 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
	<!--- Creates the villas_photos Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `villas_photos` (
      `id` int(11) NOT NULL,
      `position` int(11) DEFAULT NULL,
      `propertyID` int(11) DEFAULT NULL,
      `typeID` int(11) DEFAULT NULL,
      `photoURL` varchar(255) DEFAULT NULL,
      `photoURLsmall` varchar(255) DEFAULT NULL,
      `photoURLthumb` varchar(255) DEFAULT NULL,
      `photoURL179` varchar(255) DEFAULT NULL,
      `photoURLbanner` varchar(255) DEFAULT NULL,
      `photoURL317x179` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
	<!--- Creates the villas_properties Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `villas_properties` (
      `propertyID` int(11) NOT NULL,
      `name` varchar(255) DEFAULT NULL,
      `bedrooms` int(11) DEFAULT '0',
      `bathrooms` int(11) DEFAULT '0',
      `sleeps` int(11) DEFAULT NULL,
      `allowchildren` int(11) DEFAULT NULL,
      `allowpet` int(11) DEFAULT NULL,
      `allowsmoking` int(11) DEFAULT NULL,
      `propertyType` varchar(255) DEFAULT NULL,
      `defaultPhoto` varchar(255) DEFAULT NULL,
      `imageMedium` varchar(255) DEFAULT NULL,
      `imageSmall` varchar(255) DEFAULT NULL,
      `seopropertyname` varchar(255) DEFAULT NULL,
      `description` text,
      `latitude` varchar(255) DEFAULT NULL,
      `longitude` varchar(255) DEFAULT NULL,
      `address` varchar(255) DEFAULT NULL,
      `city` varchar(255) DEFAULT NULL,
      `state` varchar(255) DEFAULT NULL,
      `country` varchar(255) DEFAULT NULL,
      `postcode` varchar(20) DEFAULT NULL,
      PRIMARY KEY (`propertyID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
	<!--- Creates the villas_rates Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `villas_rates` (
      `rateID` int(11) NOT NULL AUTO_INCREMENT,
      `seasonName` varchar(100) DEFAULT NULL,
      `startDate` date DEFAULT NULL,
      `endDate` date DEFAULT NULL,
      `nightlyRate` int(11) DEFAULT NULL,
      `weekendRate` int(11) DEFAULT NULL,
      `weeklyRate` int(11) DEFAULT NULL,
      `minStay` int(11) DEFAULT NULL,
      `allowCheckin` varchar(100) DEFAULT NULL,
      `allowCheckout` varchar(100) DEFAULT NULL,
      `propertyID` int(11) DEFAULT NULL,
      PRIMARY KEY (`rateID`)
    ) ENGINE=InnoDB AUTO_INCREMENT=3436628 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
	<!--- Creates the villas_reservations Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `villas_reservations` (
      `bookingId` int(11) NOT NULL,
      `checkin` datetime DEFAULT NULL,
      `checkout` datetime DEFAULT NULL,
      `grandTotal` double DEFAULT NULL,
      `numberofadults` int(11) DEFAULT NULL,
      `numberofchildren` int(11) DEFAULT NULL,
      `propertyId` int(11) DEFAULT NULL,
      `propertyName` varchar(255) DEFAULT NULL,
      `qtyofnights` int(11) DEFAULT NULL,
      `servicesList` text,
      `serviceTotal` double DEFAULT NULL,
      `taxTotal` double DEFAULT NULL,
      `taxesList` text,
      `totalRent` double DEFAULT NULL,
      `lastUpdated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      `firstname` varchar(255) DEFAULT NULL,
      `lastname` varchar(255) DEFAULT NULL,
      `email` varchar(255) DEFAULT NULL,
      `PostDepartureSurveyOpenedDate` datetime DEFAULT NULL,
      `PostDepartureSurveySentDate` datetime DEFAULT NULL,
      `PostDepartureSurveySent` varchar(5) DEFAULT 'No',
      `survey_status` varchar(15) DEFAULT NULL,
      PRIMARY KEY (`bookingId`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
</cfif>
