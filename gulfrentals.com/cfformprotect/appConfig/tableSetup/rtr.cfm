<cfif request.appConfigData.PMS EQ "Real Time Rentals">
	<!--- Creates the rr_amenities Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rr_amenities` (
      `PropertyID` int(10) NOT NULL DEFAULT '0',
      `ID` int(11) NOT NULL DEFAULT '0',
      `Type` varchar(255) DEFAULT NULL,
      `Label` varchar(255) DEFAULT NULL,
      `Value` varchar(255) DEFAULT NULL,
      `Description` text,
      PRIMARY KEY (`PropertyID`,`ID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the rr_availability Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rr_availability` (
      `propertyid` int(10) NOT NULL DEFAULT '0',
      `CheckInDate` date NOT NULL DEFAULT '0000-00-00',
      `CheckOutDate` date NOT NULL DEFAULT '0000-00-00',
      `Status` varchar(255) DEFAULT NULL,
      `AverageRate` double DEFAULT NULL,
      `MinimumRate` double DEFAULT NULL,
      `MaximumRate` double DEFAULT NULL,
      PRIMARY KEY (`propertyid`,`CheckInDate`,`CheckOutDate`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the rr_deposits Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rr_deposits` (
      `propertyid` int(10) NOT NULL DEFAULT '0',
      `Name` varchar(255) NOT NULL DEFAULT '',
      `Amount` double DEFAULT NULL,
      PRIMARY KEY (`propertyid`,`Name`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the rr_fees Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rr_fees` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `propertyid` varchar(255) DEFAULT NULL,
      `description` varchar(255) DEFAULT NULL,
      `defaultfeeamount` decimal(10,2) unsigned zerofill DEFAULT NULL,
      `duefromguestaddDays` varchar(255) DEFAULT NULL,
      `duefromguestbasedate` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=370418 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the rr_non_available_dates Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rr_non_available_dates` (
      `propertyid` int(10) NOT NULL,
      `thedate` date NOT NULL,
      PRIMARY KEY (`propertyid`,`thedate`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the rr_photos Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rr_photos` (
      `propertyid` int(10) NOT NULL DEFAULT '0',
      `ID` int(10) NOT NULL DEFAULT '0',
      `Caption` varchar(255) DEFAULT NULL,
      `Image` varchar(255) NOT NULL DEFAULT '',
      PRIMARY KEY (`propertyid`,`Image`,`ID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the rr_properties Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rr_properties` (
      `ReferenceID` int(10) NOT NULL DEFAULT '0',
      `PropertyID` int(10) DEFAULT NULL,
      `PropertyName` varchar(255) DEFAULT NULL,
      `SEOPropertyName` varchar(255) DEFAULT NULL,
      `Description` text,
      `PropertyType` varchar(255) DEFAULT NULL,
      `Street` varchar(255) DEFAULT NULL,
      `City` varchar(255) DEFAULT NULL,
      `State` varchar(255) DEFAULT NULL,
      `Zip` varchar(255) DEFAULT NULL,
      `Country` varchar(255) DEFAULT NULL,
      `Unit` varchar(255) DEFAULT NULL,
      `Floor` varchar(255) DEFAULT NULL,
      `OccupancyLimit` int(10) DEFAULT NULL,
      `TotalSleeps` int(10) DEFAULT NULL,
      `Smoking` varchar(255) DEFAULT NULL,
      `BedRooms` int(10) DEFAULT NULL,
      `Baths` int(10) DEFAULT NULL,
      `HalfBaths` int(10) DEFAULT NULL,
      `FeeDescription` varchar(255) DEFAULT NULL,
      `RateDescription` varchar(255) DEFAULT NULL,
      `Amenities` varchar(255) DEFAULT NULL,
      `Amenity` varchar(255) DEFAULT NULL,
      `LocationCode` varchar(255) DEFAULT NULL,
      `Location` varchar(100) DEFAULT NULL,
      `LocationOther` varchar(30) DEFAULT NULL,
      `StreetCode` varchar(255) DEFAULT NULL,
      `Geography` varchar(255) DEFAULT NULL,
      `PropertyURL` varchar(255) DEFAULT NULL,
      `Photos` varchar(255) DEFAULT NULL,
      `Image` varchar(255) DEFAULT NULL,
      `Activities` varchar(255) DEFAULT NULL,
      `Views` varchar(255) DEFAULT NULL,
      `Deposits` varchar(255) DEFAULT NULL,
      `Deposit` varchar(255) DEFAULT NULL,
      `RateCount` int(3) unsigned DEFAULT '0',
      `RateLow` decimal(10,2) DEFAULT NULL,
      `RateHigh` decimal(10,2) DEFAULT NULL,
      `RateTypes` varchar(255) DEFAULT NULL,
      `Latitude` varchar(100) DEFAULT NULL,
      `Longitude` varchar(100) DEFAULT NULL,
      `PetPolicy` varchar(50) DEFAULT NULL,
      PRIMARY KEY (`ReferenceID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the rr_rates Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rr_rates` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `propertyid` int(10) NOT NULL DEFAULT '0',
      `Description` text,
      `Rules` varchar(255) DEFAULT NULL,
      `Rate` double DEFAULT NULL,
      `CheckInDate` date NOT NULL DEFAULT '0000-00-00',
      `CheckOutDate` date NOT NULL DEFAULT '0000-00-00',
      `MinimumStay` int(11) DEFAULT NULL,
      `DailyRate` double DEFAULT NULL,
      `CheckInDay` int(11) DEFAULT NULL,
      PRIMARY KEY (`propertyid`,`id`),
      KEY `idx` (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=2471426 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
</cfif>
