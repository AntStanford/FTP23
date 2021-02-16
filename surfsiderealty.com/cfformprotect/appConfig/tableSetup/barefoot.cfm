<cfif request.appConfigData.PMS EQ "Barefoot">
	<!--- Creates the bf_amenities Table --->
  <cftry>
    <cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `bf_amenities` (
      `id` varchar(100) NOT NULL DEFAULT '',
      `name` varchar(100) DEFAULT NULL,
      `lastinsert` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (`id`)
    ) ENGINE=innodb DEFAULT CHARSET=latin1;
    </cfquery>
    <cfcatch type="any"></cfcatch>
  </cftry>
  <!--- Creates the bf_checkin_checkout_rules Table --->
  <cftry>
    <cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `bf_checkin_checkout_rules` (
      `propertyid` varchar(50) DEFAULT NULL,
      `priorDays` varchar(100) DEFAULT NULL,
      `date1` date DEFAULT NULL,
      `date2` date DEFAULT NULL,
      `checkInDay` varchar(255) DEFAULT NULL,
      `checkOutDay` varchar(255) DEFAULT NULL,
      `insertedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      `cameFrom` char(5) DEFAULT 'BF',
      `minNights` int(11) NOT NULL DEFAULT '0',
      KEY `propertyid` (`propertyid`),
      KEY `date1` (`date1`),
      KEY `date2` (`date2`),
      KEY `checkInDay` (`checkInDay`),
      KEY `checkOutDay` (`checkOutDay`)
    ) ENGINE=innodb DEFAULT CHARSET=latin1;
    </cfquery>
    <cfcatch type="any"></cfcatch>
  </cftry>
  <!--- Creates the bf_mindays Table --->
  <cftry>
    <cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `bf_mindays` (
      `propertyid` int(10) NOT NULL DEFAULT '0',
      `NumOfDayInAdvance_From` int(10) NOT NULL DEFAULT '0',
      `NumOfDayInAdvance_To` int(10) NOT NULL DEFAULT '0',
      `Period_From` date NOT NULL DEFAULT '0000-00-00',
      `Period_To` date NOT NULL DEFAULT '0000-00-00',
      `NumOfMinDay` int(10) NOT NULL DEFAULT '0',
      `TurnoverDay` varchar(50) NOT NULL DEFAULT '',
      `lastinsert` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (`propertyid`,`NumOfDayInAdvance_From`,`NumOfDayInAdvance_To`,`Period_From`,`Period_To`,`NumOfMinDay`,`TurnoverDay`)
    ) ENGINE=innodb DEFAULT CHARSET=latin1;
    </cfquery>
    <cfcatch type="any"></cfcatch>
  </cftry>
  <!--- Creates the bf_non_available_dates Table --->
  <cftry>
    <cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `bf_non_available_dates` (
      `propertyid` int(10) NOT NULL DEFAULT '0',
      `startdate` date NOT NULL DEFAULT '0000-00-00',
      `enddate` date NOT NULL DEFAULT '0000-00-00',
      `lastinsert` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (`propertyid`,`startdate`,`enddate`)
    ) ENGINE=innodb DEFAULT CHARSET=latin1;
    </cfquery>
    <cfcatch type="any"></cfcatch>
  </cftry>
  <!--- Creates the bf_properties Table --->
  <cftry>
    <cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `bf_properties` (
     `PropertyID` varchar(255) NOT NULL,
     `addressid` int(11) NOT NULL,
     `name` varchar(255) NOT NULL,
     `keyboardid` varchar(255) NOT NULL,
     `keywords` text,
     `extdescription` text NOT NULL,
     `description` text NOT NULL,
     `unitComments` text NOT NULL,
     `internetDescription` text,
     `videoLink` text,
     `status` varchar(255) NOT NULL,
     `mindays` int(11) NOT NULL,
     `propAddress` varchar(255) NOT NULL,
     `minprice` varchar(25) NOT NULL DEFAULT '',
     `maxprice` varchar(25) NOT NULL DEFAULT '',
     `maxoccupancy` int(11) NOT NULL DEFAULT '0',
     `bedrooms` int(11) NOT NULL DEFAULT '0',
     `LastInsert` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
     `imagePath` varchar(255) DEFAULT NULL,
     `bathrooms` double(10,2) DEFAULT '0.00',
     `latitude` varchar(25) DEFAULT NULL,
     `longitude` varchar(25) DEFAULT NULL,
     `seoPropertyName` varchar(255) DEFAULT NULL,
     `unitType` varchar(100) DEFAULT NULL,
     `location` varchar(100) DEFAULT NULL,
     `petsAllowed` int(11) DEFAULT NULL,
     `area` varchar(255) DEFAULT NULL,
     `rentalType` varchar(100) DEFAULT NULL,
     `floorPlanLink` varchar(255) DEFAULT NULL,
     `view` varchar(255) DEFAULT NULL,
     PRIMARY KEY (`PropertyID`),
     KEY `bedrooms` (`bedrooms`),
    KEY `bathrooms` (`bathrooms`),
    KEY `maxoccupancy` (`maxoccupancy`)
    ) ENGINE=innodb DEFAULT CHARSET=latin1;
    </cfquery>
    <cfcatch type="any"></cfcatch>
  </cftry>
  <!--- Creates the bf_property_amenities Table --->
  <cftry>
    <cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `bf_property_amenities` (
      `propertyid` int(10) NOT NULL DEFAULT '0',
      `aid` varchar(10) NOT NULL DEFAULT '',
      `name` varchar(100) DEFAULT NULL,
      `amenityvalue` text,
      `lastinsert` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (`propertyid`,`aid`)
    ) ENGINE=innodb DEFAULT CHARSET=latin1;
    </cfquery>
    <cfcatch type="any"></cfcatch>
  </cftry>
  <!--- Creates the bf_propertyimages Table --->
  <cftry>
    <cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `bf_propertyimages` (
      `propertyid` int(11) NOT NULL DEFAULT '0',
      `imageno` int(11) DEFAULT NULL,
      `imagepath` varchar(255) NOT NULL DEFAULT '',
      `imagedesc` text,
      `lastinsert` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (`propertyid`,`imagepath`),
      KEY `propertyid` (`propertyid`)
    ) ENGINE=innodb DEFAULT CHARSET=latin1;
    </cfquery>
    <cfcatch type="any"></cfcatch>
  </cftry>
  <!--- Creates the bf_rates Table --->
  <cftry>
    <cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `bf_rates` (
      `propertyid` int(10) NOT NULL DEFAULT '0',
      `startdate` date NOT NULL DEFAULT '0000-00-00',
      `enddate` date NOT NULL DEFAULT '0000-00-00',
      `rent` double DEFAULT NULL,
      `pricetype` varchar(20) NOT NULL DEFAULT '',
      `lastinsert` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (`propertyid`,`startdate`,`enddate`,`pricetype`)
    ) ENGINE=innodb DEFAULT CHARSET=latin1;
    </cfquery>
    <cfcatch type="any"></cfcatch>
  </cftry>
</cfif>
