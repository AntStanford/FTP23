<cfif request.appConfigData.PMS EQ "RNS">
	<!--- Creates the rns_amenities Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rns_amenities` (
      `unitid` int(11) DEFAULT NULL,
      `amenityID` int(11) DEFAULT NULL,
      `name` varchar(255) DEFAULT NULL,
      `description` text,
      `sortOrder` int(11) DEFAULT NULL,
      `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      KEY `unitid` (`unitid`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the rns_deposits Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rns_deposits` (
      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
      `unitid` varchar(100) DEFAULT NULL,
      `strcheckin` date DEFAULT NULL,
      `strcheckout` date DEFAULT NULL,
      `depositArray` text,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1
    /*!50100 PARTITION BY HASH (id)
    PARTITIONS 64 */;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the rns_images Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rns_images` (
      `unitid` int(11) DEFAULT NULL,
      `imageName` varchar(255) DEFAULT NULL,
      `imageDesc` varchar(255) DEFAULT NULL,
      `imageSortNo` int(11) DEFAULT NULL,
      `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      KEY `unitid` (`unitid`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the rns_non_available_dates Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rns_non_available_dates` (
      `unitid` int(11) DEFAULT NULL,
      `arriveDate` date DEFAULT NULL,
      `departDate` date DEFAULT NULL,
      `availID` varchar(150) DEFAULT NULL,
      `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      KEY `unitid` (`unitid`),
      KEY `arriveDate` (`arriveDate`),
      KEY `availID` (`availID`),
      KEY `departDate` (`departDate`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the rns_properties Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rns_properties` (
      `unitid` int(11) NOT NULL DEFAULT '0',
      `locationID` int(11) DEFAULT NULL,
      `propName` varchar(255) DEFAULT NULL,
      `propNumber` varchar(255) DEFAULT NULL,
      `address` varchar(255) DEFAULT NULL,
      `address2` varchar(100) DEFAULT NULL,
      `city` varchar(255) DEFAULT NULL,
      `state` char(2) DEFAULT NULL,
      `zip` varchar(25) DEFAULT NULL,
      `bed` int(11) DEFAULT NULL,
      `bath` float(10,2) DEFAULT NULL,
      `sleeps` int(11) DEFAULT NULL,
      `inactive` char(5) DEFAULT NULL,
      `turnday` int(11) DEFAULT NULL,
      `description` text,
      `amenityList` text,
      `geocode` varchar(255) DEFAULT NULL,
      `reviews` text,
      `unitTypesListId` int(11) DEFAULT NULL,
      `subdivisionsId` int(11) DEFAULT NULL,
      `reservationGroupId` int(11) DEFAULT NULL,
      `financeGroupId` int(11) DEFAULT NULL,
      `insertedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      `seopropertyname` varchar(255) DEFAULT NULL,
      `maxoccupancy` varchar(255) DEFAULT NULL,
      `petfriendly` varchar(255) DEFAULT NULL,
      `pool` varchar(255) DEFAULT NULL,
      `type` varchar(255) DEFAULT NULL,
      `mapphoto` varchar(255) DEFAULT NULL,
      `avgGuestRating` double(10,2) DEFAULT '5.00',
      `latitude` double DEFAULT NULL,
      `longitude` double DEFAULT NULL,
      PRIMARY KEY (`unitid`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the rns_rates Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rns_rates` (
      `unitid` varchar(25) DEFAULT NULL,
      `startDate` date DEFAULT NULL,
      `endDate` date DEFAULT NULL,
      `dailyRate` double(10,2) DEFAULT NULL,
      `weeklyRate` double(10,2) DEFAULT NULL,
      `minNoNights` int(11) DEFAULT NULL,
      `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      KEY `unitid` (`unitid`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the rns_unit_types Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `rns_unit_types` (
      `unitTypeListID` int(11) NOT NULL,
      `locationID` int(11) DEFAULT NULL,
      `name` varchar(255) DEFAULT NULL,
      `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (`unitTypeListID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
</cfif>
