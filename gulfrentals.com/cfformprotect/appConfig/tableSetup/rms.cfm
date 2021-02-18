<cfif request.appConfigData.PMS EQ "RMS">
	<!--- Creates the rms_bookings Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rms_bookings` (
      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
      `reservationId` int(11) DEFAULT NULL,
      `arrival` date DEFAULT NULL,
      `departure` date DEFAULT NULL,
      `email` varchar(255) DEFAULT NULL,
      `name` varchar(255) DEFAULT NULL,
      `unitID` varchar(255) DEFAULT NULL,
      `propertyAddress` varchar(255) DEFAULT NULL,
      `insertDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=7908 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the rms_calendars Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rms_calendars` (
      `unitID` varchar(25) DEFAULT NULL,
      `startDate` date DEFAULT NULL,
      `endDate` date DEFAULT NULL,
      `reservationType` varchar(255) DEFAULT NULL,
      `reservationNumber` varchar(50) DEFAULT NULL,
      `lastName` varchar(150) DEFAULT NULL,
      KEY `unitID` (`unitID`),
      KEY `startDate` (`startDate`),
      KEY `endDate` (`endDate`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the rms_comments Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rms_comments` (
      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
      `unitID` varchar(25) DEFAULT NULL,
      `comment` text,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=5963587 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the rms_miscfields Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rms_miscfields` (
      `unitID` varchar(50) DEFAULT NULL,
      `label` varchar(100) DEFAULT NULL,
      `labelValue` varchar(100) DEFAULT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the rms_photos Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rms_photos` (
      `unitID` varchar(25) DEFAULT NULL,
      `url` varchar(255) DEFAULT NULL,
      `longComment` text,
      `shortComment` varchar(255) DEFAULT NULL,
      `lastInsert` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      `sort` int(11) unsigned NOT NULL AUTO_INCREMENT,
      PRIMARY KEY (`sort`),
      KEY `unitID` (`unitID`)
    ) ENGINE=InnoDB AUTO_INCREMENT=33640566 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the rms_properties Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rms_properties` (
      `unitID` varchar(25) DEFAULT NULL,
      `address1` varchar(150) DEFAULT NULL,
      `lastChange` timestamp NULL DEFAULT NULL,
      `featured` varchar(25) DEFAULT NULL,
      `lastInsert` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      `telephoneNumber` varchar(50) DEFAULT NULL,
      `numberOfBedrooms` int(11) DEFAULT NULL,
      `numberOfBathrooms` double(10,2) DEFAULT NULL,
      `maximumNumberOfPeople` int(11) DEFAULT NULL,
      `sleepingAccommodations` varchar(100) DEFAULT NULL,
      `description` text,
      `property_level` varchar(150) DEFAULT NULL,
      `property_type` varchar(150) DEFAULT NULL,
      `rentalStatus` char(5) DEFAULT NULL,
      `location` varchar(150) DEFAULT NULL,
      `locationDescription` varchar(150) DEFAULT NULL,
      `section` varchar(150) DEFAULT NULL,
      `sectionDescription` varchar(150) DEFAULT NULL,
      `cleaningCharge` double(10,2) DEFAULT NULL,
      `ownerCleanAmount` double(10,2) DEFAULT NULL,
      `ownerFriendCleanAmount` double(10,2) DEFAULT NULL,
      `ownerBookedCleanAmount` double(10,2) DEFAULT NULL,
      `deductCleaningFromGrossRent` char(5) DEFAULT NULL,
      `address2` varchar(150) DEFAULT NULL,
      `city` varchar(150) DEFAULT NULL,
      `state` char(25) DEFAULT NULL,
      `zip` varchar(15) DEFAULT NULL,
      `latitude` varchar(25) DEFAULT NULL,
      `longitude` varchar(25) DEFAULT NULL,
      `thumbnail` varchar(255) DEFAULT NULL,
      `seopropertyname` varchar(255) DEFAULT NULL,
      `defaultPhoto` varchar(255) DEFAULT NULL,
      KEY `unitID` (`unitID`),
      KEY `numberOfBedrooms` (`numberOfBedrooms`),
      KEY `numberOfBathrooms` (`numberOfBathrooms`),
      KEY `maximumNumberOfPeople` (`maximumNumberOfPeople`),
      KEY `sectionDescription` (`sectionDescription`),
      KEY `property_type` (`property_type`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the rms_rates Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rms_rates` (
      `unitID` varchar(25) DEFAULT NULL,
      `startDate` date DEFAULT NULL,
      `endDate` date DEFAULT NULL,
      `description` varchar(255) DEFAULT NULL,
      `weeklyRate` double(10,2) DEFAULT NULL,
      `dailyRate` double(10,2) DEFAULT NULL,
      `averageExtraCost` double(10,2) DEFAULT NULL,
      `minimumNightStay` int(11) DEFAULT NULL,
      `saturdayCheckInAllowed` char(5) DEFAULT NULL,
      `sundayCheckInAllowed` char(5) DEFAULT NULL,
      `mondayCheckInAllowed` char(5) DEFAULT NULL,
      `tuesdayCheckInAllowed` char(5) DEFAULT NULL,
      `wednesdayCheckInAllowed` char(5) DEFAULT NULL,
      `thursdayCheckInAllowed` char(5) DEFAULT NULL,
      `fridayCheckInAllowed` char(5) DEFAULT NULL,
      `weekDayRate` double(10,2) DEFAULT NULL,
      `weekEndRate` double(10,2) DEFAULT NULL,
      `dailyRateSunday` double(10,2) DEFAULT NULL,
      `dailyRateMonday` double(10,2) DEFAULT NULL,
      `dailyRateTuesday` double(10,2) DEFAULT NULL,
      `dailyRateWednesday` double(10,2) DEFAULT NULL,
      `dailyRateThursday` double(10,2) DEFAULT NULL,
      `dailyRateFriday` double(10,2) DEFAULT NULL,
      `dailyRateSaturday` double(10,2) DEFAULT NULL,
      `lastInsert` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      KEY `unitID` (`unitID`),
      KEY `startDate` (`startDate`),
      KEY `endDate` (`endDate`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the rms_searchfields Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rms_searchfields` (
      `unitID` varchar(25) DEFAULT NULL,
      `label_name` varchar(255) DEFAULT NULL,
      `label_description` varchar(255) DEFAULT NULL,
      `label_id` char(25) DEFAULT NULL,
      KEY `unitID` (`unitID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
</cfif>
