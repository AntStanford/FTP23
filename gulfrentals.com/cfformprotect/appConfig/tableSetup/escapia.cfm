<cfif request.appConfigData.PMS EQ "Escapia">
	<!--- Creates the escapia_deposits Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
		CREATE TABLE `escapia_deposits` (
			`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
			`unitcode` varchar(150) DEFAULT NULL,
			`strcheckin` date DEFAULT NULL,
			`strcheckout` date DEFAULT NULL,
			`depositArray` text,
			PRIMARY KEY (`id`)
		) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
	<!--- Creates the escapia_amenities Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
		CREATE TABLE `escapia_amenities` (
			`unitcode` varchar(50) DEFAULT NULL,
			`category` varchar(255) DEFAULT NULL,
			`categoryvalue` varchar(255) DEFAULT NULL,
			`id` int(11) NOT NULL AUTO_INCREMENT,
			`last_insert` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
			PRIMARY KEY (`id`),
			KEY `unitcode` (`unitcode`),
			KEY `thevalue` (`categoryvalue`)
		) ENGINE=innodb DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
	<!--- Creates the escapia_customcategories Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
		CREATE TABLE `escapia_customcategories` (
			`unitcode` varchar(100) NOT NULL DEFAULT '',
			`category` varchar(255) NOT NULL DEFAULT '',
			`categoryvalue` varchar(255) DEFAULT NULL,
			`last_insert` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
			KEY `ctegory` (`category`),
			KEY `unitcode` (`unitcode`)
		) ENGINE=innodb DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
	<!--- Creates the escapia_dailyavailabilities Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
		CREATE TABLE `escapia_dailyavailabilities` (
			`unitcode` varchar(50) NOT NULL DEFAULT '',
			`thedate` date NOT NULL DEFAULT '0000-00-00',
			`dailyminlos` int(11) NOT NULL DEFAULT '0',
			`code` varchar(5) NOT NULL DEFAULT '',
			`last_insert` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
			PRIMARY KEY (`unitcode`,`thedate`),
			KEY `code` (`code`),
			KEY `daily` (`dailyminlos`)
		) ENGINE=innodb DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
	<!--- Creates the escapia_photos Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
		CREATE TABLE `escapia_photos` (
			`unitcode` varchar(50) NOT NULL DEFAULT '',
			`original` varchar(255) NOT NULL DEFAULT '',
			`thumbnail` varchar(255) DEFAULT NULL,
			`standard` varchar(255) DEFAULT NULL,
			`descriptive` varchar(255) DEFAULT NULL,
			`large` varchar(255) DEFAULT NULL,
			`isdefault` varchar(10) DEFAULT NULL,
			`caption` varchar(255) DEFAULT NULL,
			`category` varchar(100) DEFAULT NULL,
			`sort` int(11) DEFAULT NULL,
			`last_insert` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
			`url` varchar(255) DEFAULT NULL,
			`description` text,
		KEY `unitcode` (`unitcode`),
		KEY `isdefault` (`isdefault`),
		KEY `category` (`category`)
		) ENGINE=innodb DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
	<!--- Creates the escapia_properties Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
		CREATE TABLE `escapia_properties` (
			`unitcode` varchar(50) NOT NULL DEFAULT '',
			`unitshortname` varchar(255) DEFAULT NULL,
			`whenbuilt` int(10) DEFAULT NULL,
			`numberfloors` int(10) DEFAULT NULL,
			`maxoccupancy` int(10) DEFAULT NULL,
			`unitcategory` varchar(50) DEFAULT NULL,
			`bedrooms` int(5) DEFAULT NULL,
			`bathrooms` decimal(10,1) DEFAULT '0.0',
			`longdescription` text,
			`roomdescription` text,
			`descriptivetext` text,
			`cityname` varchar(255) DEFAULT NULL,
			`postalcode` varchar(100) DEFAULT NULL,
			`statecode` varchar(5) DEFAULT NULL,
			`stateprov` varchar(50) DEFAULT NULL,
			`checkintime` varchar(10) DEFAULT NULL,
			`checkouttime` varchar(10) DEFAULT NULL,
			`petsallowedcode` varchar(100) DEFAULT NULL,
			`cancelpolicyindicator` varchar(5) DEFAULT NULL,
			`cancellationpolicy` text,
			`rentalagreement` text,
			`nonsmoking` varchar(5) DEFAULT NULL,
			`amenities` text,
			`internalunitcode` varchar(100) DEFAULT NULL,
			`lastupdated` varchar(50) NOT NULL DEFAULT 'CURRENT_TIMESTAMP',
			`latitude` varchar(50) DEFAULT NULL,
			`longitude` varchar(50) DEFAULT NULL,
			`virtualtour` text,
			`address` varchar(255) DEFAULT NULL,
			`last_insert` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
			`mapPhoto` varchar(255) DEFAULT NULL,
			`seoPropertyName` varchar(150) DEFAULT NULL,
			`neighborhood` varchar(150) DEFAULT NULL,
			`distance_from_town` varchar(25) DEFAULT '0.00',
			`property_highlights` varchar(255) DEFAULT NULL,
			`marketing_headline` varchar(255) DEFAULT NULL,
			`minRentMin` double(10,2) DEFAULT NULL,
			`minRentMax` double(10,2) DEFAULT NULL,
			`guestRating` double(10,2) DEFAULT NULL,
			PRIMARY KEY (`unitcode`),
			KEY `bedrooms` (`bedrooms`),
			KEY `bathrooms` (`bathrooms`),
			KEY `cityname` (`cityname`),
			KEY `petsallowedcode` (`petsallowedcode`),
			KEY `unitcategory` (`unitcategory`),
			KEY `maxoccupancy` (`maxoccupancy`)
		) ENGINE=innodb DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
	<!--- Creates the escapia_rates Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
		CREATE TABLE `escapia_rates` (
			`unitcode` varchar(50) NOT NULL DEFAULT '',
			`startdate` date NOT NULL DEFAULT '0000-00-00',
			`enddate` date NOT NULL DEFAULT '0000-00-00',
			`ratetype` varchar(50) NOT NULL DEFAULT '',
			`ratetimeunit` varchar(50) NOT NULL DEFAULT '',
			`maxrent` decimal(10,4) NOT NULL DEFAULT '0.0000',
			`minRent` decimal(10,4) DEFAULT '0.0000',
			`maxfees` decimal(10,4) NOT NULL DEFAULT '0.0000',
			`maxtax` decimal(10,4) NOT NULL DEFAULT '0.0000',
			`seasonname` varchar(100) DEFAULT NULL,
			`last_insert` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
			`minLOS` int(11) DEFAULT NULL,
			`stayContext` varchar(25) DEFAULT NULL,
			`monday` char(5) DEFAULT NULL,
			`tuesday` char(5) DEFAULT NULL,
			`wednesday` char(5) DEFAULT NULL,
			`thursday` char(5) DEFAULT NULL,
			`friday` char(5) DEFAULT NULL,
			`saturday` char(5) DEFAULT NULL,
			`sunday` char(5) DEFAULT NULL,
			`minrate` decimal(10,4) DEFAULT NULL,
			`maxrate` decimal(10,4) DEFAULT NULL,
			KEY `unitcode` (`unitcode`),
		KEY `startdate` (`startdate`),
		KEY `enddate` (`enddate`),
		KEY `ratetype` (`ratetype`)
		) ENGINE=innodb DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
	<!--- Creates the escapia_reviews Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
		CREATE TABLE `escapia_reviews` (
			`id` int(11) NOT NULL AUTO_INCREMENT,
			`unitcode` varchar(100) DEFAULT NULL,
			`reviewercountry` varchar(255) DEFAULT NULL,
			`reviewerstate` varchar(100) DEFAULT NULL,
			`reviewercheckin` date DEFAULT NULL,
			`propertymanagerrejected` char(5) DEFAULT NULL,
			`reviewercheckout` date DEFAULT NULL,
			`reviewdate` date DEFAULT NULL,
			`lastupdated` varchar(100) DEFAULT NULL,
			`reviewercity` varchar(255) DEFAULT NULL,
			`reviewername` varchar(255) DEFAULT NULL,
			`review` text,
			`reviewerid` varchar(255) DEFAULT NULL,
			`camefrom` varchar(100) DEFAULT NULL,
			`last_insert` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
			`title` varchar(255) DEFAULT NULL,
			`managerresponse` text,
			PRIMARY KEY (`id`),
			KEY `unitcode` (`unitcode`),
			KEY `propertymanagerrejected` (`propertymanagerrejected`)
		) ENGINE=innodb DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
</cfif>
