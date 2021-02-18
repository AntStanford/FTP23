<cfif request.appConfigData.PMS EQ "Ciirus">
	<!--- Creates the ciirus_amenities Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `ciirus_amenities` (
      `amenityID` int(11) NOT NULL AUTO_INCREMENT,
      `propertyID` int(11) DEFAULT NULL,
      `amenityName` varchar(100) DEFAULT NULL,
      `isCMSamenity` tinyint(1) DEFAULT NULL,
      PRIMARY KEY (`amenityID`),
      KEY `PI_CA_AN` (`amenityName`)
    ) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the ciirus_bookingfees Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `ciirus_bookingfees` (
      `propertyid` int(10) NOT NULL,
      `BookingFeeType` varchar(255) DEFAULT NULL,
      `FeeAmount` double(10,2) DEFAULT NULL,
      `ChargeBookingFeeOnlyWithPaymentTakenByMC` varchar(5) DEFAULT NULL,
      `ChargeTax1` varchar(5) DEFAULT NULL,
      `ChargeTax2` varchar(5) DEFAULT NULL,
      `ChargeTax3` varchar(5) DEFAULT NULL,
      `ErrorMsg` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`propertyid`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the ciirus_cleaningfees Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `ciirus_cleaningfees` (
      `propertyid` int(10) NOT NULL,
      `chargeCleaningFee` varchar(5) DEFAULT NULL,
      `CleaningFeeAmount` double(10,2) DEFAULT NULL,
      `OnlyChargeCleaningFeeWhenLessThanDays` int(10) DEFAULT NULL,
      `ChargeTax1` varchar(5) DEFAULT NULL,
      `ChargeTax2` varchar(5) DEFAULT NULL,
      `ChargeTax3` varchar(5) DEFAULT NULL,
      `ErrorMsg` text,
      PRIMARY KEY (`propertyid`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the ciirus_communities Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `ciirus_communities` (
      `communityID` int(11) NOT NULL,
      `communityName` varchar(256) DEFAULT NULL,
      `latitude` varchar(256) DEFAULT NULL,
      `longitude` varchar(256) DEFAULT NULL,
      PRIMARY KEY (`communityID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the ciirus_non_available_dates Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `ciirus_non_available_dates` (
      `propertyid` int(11) DEFAULT NULL,
      `ArrivalDate` date DEFAULT NULL,
      `DepartureDate` date DEFAULT NULL,
      `BookingID` int(11) DEFAULT NULL,
      `HasPoolHeat` varchar(5) DEFAULT NULL,
      `id` int(11) NOT NULL AUTO_INCREMENT,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=3212938 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the ciirus_poolheat Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `ciirus_poolheat` (
      `propertyid` int(11) NOT NULL,
      `HasPrivatePool` varchar(5) DEFAULT NULL,
      `PoolHeatable` varchar(5) DEFAULT NULL,
      `PoolHeatIncludedInPrice` varchar(5) DEFAULT NULL,
      `DailyCharge` double DEFAULT NULL,
      `MinimumNumberOfDaysToCharge` int(11) DEFAULT NULL,
      `ChargeTax1OnPoolHeat` varchar(5) DEFAULT NULL,
      `ChargeTax2OnPoolHeat` varchar(5) DEFAULT NULL,
      `ChargeTax3OnPoolHeat` varchar(5) DEFAULT NULL,
      PRIMARY KEY (`propertyid`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the ciirus_properties Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `ciirus_properties` (
      `PropertyID` int(10) NOT NULL,
      `ManagementCompanyName` varchar(255) DEFAULT NULL,
      `MainImageURL` varchar(255) DEFAULT NULL,
      `MCPropertyName` varchar(255) DEFAULT NULL,
      `WebsitePropertyName` varchar(255) DEFAULT NULL,
      `seoPropertyName` varchar(256) DEFAULT NULL,
      `DescriptionSetID` int(10) DEFAULT NULL,
      `Community` varchar(255) DEFAULT NULL,
      `Bedrooms` int(10) DEFAULT NULL,
      `Bathrooms` int(10) DEFAULT NULL,
      `Sleeps` int(10) DEFAULT NULL,
      `XCO` double(10,7) DEFAULT NULL,
      `YCO` double(10,7) DEFAULT NULL,
      `Bullet1` varchar(255) DEFAULT NULL,
      `Bullet2` varchar(255) DEFAULT NULL,
      `Bullet3` varchar(255) DEFAULT NULL,
      `Bullet4` varchar(255) DEFAULT NULL,
      `Bullet5` varchar(255) DEFAULT NULL,
      `CurrencySymbol` varchar(255) DEFAULT NULL,
      `CurrencyCode` varchar(255) DEFAULT NULL,
      `PropertyType` varchar(255) DEFAULT NULL,
      `PropertyClass` varchar(255) DEFAULT NULL,
      `HostMCUserID` int(10) DEFAULT NULL,
      `QuoteExcludingTax` varchar(255) DEFAULT NULL,
      `QuoteIncludingTax` varchar(255) DEFAULT NULL,
      `LessThanMinimumNightsStay` varchar(255) DEFAULT NULL,
      `MinimumNightsStay` int(10) DEFAULT NULL,
      `PetsAllowed` varchar(255) DEFAULT NULL,
      `BedroomConfiguration` varchar(255) DEFAULT NULL,
      `Address1` varchar(255) DEFAULT NULL,
      `Address2` varchar(255) DEFAULT NULL,
      `City` varchar(255) DEFAULT NULL,
      `County` varchar(255) DEFAULT NULL,
      `State` varchar(255) DEFAULT NULL,
      `Zip` varchar(255) DEFAULT NULL,
      `Country` varchar(255) DEFAULT NULL,
      `Telephone` varchar(255) DEFAULT NULL,
      `ErrorMsg` varchar(255) DEFAULT NULL,
      `SpecialResponse` varchar(255) DEFAULT NULL,
      `DescriptionHTML` text,
      `DescriptionPlainText` text,
      `Photos` text,
      PRIMARY KEY (`PropertyID`),
      KEY `PI_CP_SPN` (`seoPropertyName`),
      KEY `PI_CP_CMNTY` (`Community`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the ciirus_propertyclasses Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `ciirus_propertyclasses` (
      `propertyClassID` int(11) NOT NULL,
      `propertyClassName` varchar(256) DEFAULT NULL,
      PRIMARY KEY (`propertyClassID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the ciirus_propertyextras Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `ciirus_propertyextras` (
      `PropertyID` int(11) NOT NULL,
      `ItemCode` varchar(255) NOT NULL,
      `ItemDescription` varchar(255) DEFAULT NULL,
      `FlatFee` tinyint(1) DEFAULT NULL,
      `FlatFeeAmount` double DEFAULT NULL,
      `DailyFee` tinyint(1) DEFAULT NULL,
      `DailyFeeAmount` double DEFAULT NULL,
      `PercentageFee` tinyint(1) DEFAULT NULL,
      `Percentage` double DEFAULT NULL,
      `Mandatory` tinyint(1) DEFAULT NULL,
      `MinimumCharge` double DEFAULT NULL,
      `ChargeTax1` tinyint(1) DEFAULT NULL,
      `ChargeTax2` tinyint(1) DEFAULT NULL,
      `ChargeTax3` tinyint(1) DEFAULT NULL,
      PRIMARY KEY (`PropertyID`,`ItemCode`),
      KEY `PI_CPE_P` (`PropertyID`),
      KEY `PI_CPE_IC` (`ItemCode`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the ciirus_propertytypes Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `ciirus_propertytypes` (
      `propertyTypeID` int(11) NOT NULL,
      `propertyTypeName` varchar(256) DEFAULT NULL,
      PRIMARY KEY (`propertyTypeID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the ciirus_rates Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `ciirus_rates` (
      `propertyid` int(11) NOT NULL,
      `FromDate` date NOT NULL,
      `ToDate` date NOT NULL,
      `MinNightsStay` int(11) DEFAULT NULL,
      `MaxNightsStay` int(11) DEFAULT NULL,
      `DailyRate` double DEFAULT NULL,
      `RateType` int(11) NOT NULL,
      `arriveMon` tinyint(1) DEFAULT '1',
      `arriveTue` tinyint(1) DEFAULT '1',
      `arriveWed` tinyint(1) DEFAULT '1',
      `arriveThu` tinyint(1) DEFAULT '1',
      `arriveFri` tinyint(1) DEFAULT '1',
      `arriveSat` tinyint(1) DEFAULT '1',
      `arriveSun` tinyint(1) DEFAULT '1',
      `departMon` tinyint(1) DEFAULT '1',
      `departTue` tinyint(1) DEFAULT '1',
      `departWed` tinyint(1) DEFAULT '1',
      `departThu` tinyint(1) DEFAULT '1',
      `departFri` tinyint(1) DEFAULT '1',
      `departSat` tinyint(1) DEFAULT '1',
      `departSun` tinyint(1) DEFAULT '1',
      PRIMARY KEY (`propertyid`,`ToDate`,`FromDate`,`RateType`),
      KEY `PI_CR_P` (`propertyid`),
      KEY `PI_CR_FD` (`FromDate`),
      KEY `PI_CR_TD` (`ToDate`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the ciirus_taxrates Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `ciirus_taxrates` (
      `propertyid` int(11) NOT NULL,
      `Tax1Name` varchar(256) DEFAULT NULL,
      `Tax1Percent` double DEFAULT NULL,
      `Tax2Name` varchar(256) DEFAULT NULL,
      `Tax2Percent` double DEFAULT NULL,
      `Tax3Name` varchar(256) DEFAULT NULL,
      `Tax3Percent` double DEFAULT NULL,
      PRIMARY KEY (`propertyid`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the ciirus_terms Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `ciirus_terms` (
      `propertyid` int(11) NOT NULL,
      `HTMLTerms` text,
      `PlainTextTerms` text,
      `CancellationPolicy` text,
      `LocalCharges` text,
      `ErrorMessage` varchar(256) DEFAULT NULL,
      PRIMARY KEY (`propertyid`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
</cfif>
