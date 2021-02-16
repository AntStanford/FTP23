<cfif request.appConfigData.PMS EQ "Track">
	<!--- Creates the track_nodes Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `track_nodes` (
      `id` int(11) unsigned NOT NULL,
      `checkinDetails` varchar(255) DEFAULT NULL,
      `checkinTime` varchar(25) DEFAULT NULL,
      `checkoutTime` varchar(25) DEFAULT NULL,
      `childrenAllowed` char(5) DEFAULT NULL,
      `country` char(2) DEFAULT NULL,
      `directions` text,
      `earlyCheckinTime` varchar(25) DEFAULT NULL,
      `extendedAddress` varchar(255) DEFAULT NULL,
      `hasEarlyCheckin` char(5) DEFAULT NULL,
      `hasLateCheckout` char(5) DEFAULT NULL,
      `isAccessible` char(5) DEFAULT NULL,
      `lateCheckoutTime` varchar(25) DEFAULT NULL,
      `latitude` varchar(100) DEFAULT NULL,
      `locality` varchar(255) DEFAULT NULL,
      `longDescription` text,
      `longitude` varchar(100) DEFAULT NULL,
      `maxPets` int(11) DEFAULT NULL,
      `minimumAgeLimit` int(11) DEFAULT NULL,
      `name` varchar(255) DEFAULT NULL,
      `parentId` int(11) DEFAULT NULL,
      `petsFriendly` char(5) DEFAULT NULL,
      `phone` varchar(100) DEFAULT NULL,
      `postal` varchar(100) DEFAULT NULL,
      `region` char(2) DEFAULT NULL,
      `shortDescription` text,
      `smokingAllowed` char(5) DEFAULT NULL,
      `streetAddress` varchar(100) DEFAULT NULL,
      `timezone` varchar(100) DEFAULT NULL,
      `typeId` int(11) DEFAULT NULL,
      `typeName` varchar(100) DEFAULT NULL,
      `updatedAt` varchar(100) DEFAULT NULL,
      `seoMetaTitle` varchar(255) DEFAULT NULL,
      `seoMetaDescription` text,
      `seoMetaKeywords` varchar(255) DEFAULT NULL,
      `seoFriendlyURL` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the track_nodes_amenities Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `track_nodes_amenities` (
      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
      `nodeId` int(11) DEFAULT NULL,
      `amenityId` int(11) DEFAULT NULL,
      `amenityName` varchar(255) DEFAULT NULL,
      `amenityGroupId` int(11) DEFAULT NULL,
      `amenityGroupName` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=508074 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the track_nodes_images Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `track_nodes_images` (
      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
      `nodeId` int(11) DEFAULT NULL,
      `imageId` int(11) DEFAULT NULL,
      `name` varchar(100) DEFAULT NULL,
      `original` varchar(255) DEFAULT NULL,
      `order` int(11) DEFAULT NULL,
      `updatedAt` varchar(100) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=379952 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the track_properties Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `track_properties` (
      `id` int(11) unsigned NOT NULL,
      `name` varchar(255) DEFAULT NULL,
      `shortName` varchar(255) DEFAULT NULL,
      `headline` varchar(255) DEFAULT NULL,
      `shortDescription` text,
      `longDescription` text,
      `nodeId` int(11) DEFAULT NULL,
      `unitTypeId` int(11) DEFAULT '0',
      `unitTypeName` varchar(255) DEFAULT NULL,
      `lodgingTypeId` int(11) DEFAULT NULL,
      `lodgingTypeName` varchar(255) DEFAULT NULL,
      `directions` text,
      `checkinDetails` text,
      `timezone` varchar(255) DEFAULT NULL,
      `checkinTime` varchar(25) DEFAULT NULL,
      `hasEarlyCheckin` char(5) DEFAULT NULL,
      `earlyCheckinTime` char(5) DEFAULT NULL,
      `checkoutTime` char(5) DEFAULT NULL,
      `hasLateCheckout` char(5) DEFAULT NULL,
      `lateCheckoutTime` char(5) DEFAULT NULL,
      `website` varchar(255) DEFAULT NULL,
      `phone` varchar(100) DEFAULT NULL,
      `streetAddress` varchar(255) DEFAULT NULL,
      `extendedAddress` varchar(255) DEFAULT NULL,
      `locality` varchar(255) DEFAULT NULL,
      `region` varchar(100) DEFAULT NULL,
      `postal` int(5) DEFAULT NULL,
      `country` char(2) DEFAULT NULL,
      `latitude` varchar(100) DEFAULT NULL,
      `longitude` varchar(100) DEFAULT NULL,
      `petsFriendly` char(5) DEFAULT NULL,
      `maxPets` int(5) DEFAULT NULL,
      `eventsAllowed` char(5) DEFAULT NULL,
      `smokingAllowed` char(5) DEFAULT NULL,
      `childrenAllowed` char(5) DEFAULT NULL,
      `minimumAgeLimit` int(11) DEFAULT NULL,
      `isAccessible` char(5) DEFAULT NULL,
      `area` varchar(255) DEFAULT NULL,
      `floors` int(11) DEFAULT NULL,
      `maxOccupancy` int(11) DEFAULT NULL,
      `bedrooms` int(11) DEFAULT NULL,
      `fullBathrooms` int(11) DEFAULT NULL,
      `threeQuarterBathrooms` int(11) DEFAULT NULL,
      `halfBathrooms` int(11) DEFAULT NULL,
      `coverImage` varchar(255) DEFAULT NULL,
      `updatedAt` varchar(100) DEFAULT NULL,
      `cancellationPolicy` text,
      `rentalPolicy` text,
      `petPolicy` text,
      `minRate` double(10,2) DEFAULT NULL,
      `maxRate` double(10,2) DEFAULT NULL,
      `seoFriendlyURL` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the track_properties_amenities Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `track_properties_amenities` (
      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
      `propertyId` int(11) DEFAULT NULL,
      `amenityId` int(11) DEFAULT NULL,
      `amenityName` varchar(255) DEFAULT NULL,
      `amenityGroupId` int(11) DEFAULT NULL,
      `amenityGroupName` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=17234765 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the track_properties_availability Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `track_properties_availability` (
      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
      `propertyId` int(11) DEFAULT NULL,
      `theDate` date DEFAULT NULL,
      `allowArrival` int(11) DEFAULT NULL,
      `allowDeparture` int(11) DEFAULT NULL,
      `avail` int(11) DEFAULT NULL,
      `rateMin` double(10,2) DEFAULT NULL,
      `rateMax` double(10,2) DEFAULT NULL,
      `stayMin` int(11) DEFAULT NULL,
      `stayMax` int(11) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=1658739765 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the track_properties_bed_types Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `track_properties_bed_types` (
      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
      `propertyId` int(11) DEFAULT NULL,
      `bedTypeId` int(11) DEFAULT NULL,
      `bedTypeName` varchar(100) DEFAULT NULL,
      `bedTypeCount` int(11) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=1065123 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the track_properties_custom_data Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `track_properties_custom_data` (
      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
      `propertyId` int(11) DEFAULT NULL,
      `customDataId` int(11) DEFAULT NULL,
      `data` text,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=7138291 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the track_properties_fees Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `track_properties_fees` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `feeName` varchar(255) DEFAULT NULL,
      `feeType` varchar(255) DEFAULT NULL,
      `feeAmount` float DEFAULT NULL,
      `startDate` date DEFAULT NULL,
      `endDate` date DEFAULT NULL,
      `propertyId` int(11) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=171293 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the track_properties_images Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `track_properties_images` (
      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
      `propertyId` int(11) DEFAULT NULL,
      `imageId` int(11) DEFAULT NULL,
      `name` varchar(255) DEFAULT NULL,
      `original` varchar(255) DEFAULT NULL,
      `order` int(11) DEFAULT NULL,
      `updatedAt` varchar(100) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=2952030 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the track_properties_rates Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `track_properties_rates` (
      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
      `propertyId` int(11) DEFAULT NULL,
      `theDate` date DEFAULT NULL,
      `theRate` double(10,2) DEFAULT '0.00',
      PRIMARY KEY (`id`),
      KEY `PropertyID` (`propertyId`)
    ) ENGINE=InnoDB AUTO_INCREMENT=33692026 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the track_properties_taxes Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `track_properties_taxes` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `taxName` varchar(255) DEFAULT NULL,
      `taxType` varchar(45) DEFAULT NULL,
      `taxRate` float DEFAULT NULL,
      `startDate` date DEFAULT NULL,
      `endDate` date DEFAULT NULL,
      `propertyId` int(11) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=177964 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
</cfif>
