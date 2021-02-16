<cfif request.appConfigData.PMS EQ "VRM">
	<!--- Creates the vrm_amenities Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vrm_amenities` (
      `amenity_id` int(11) DEFAULT NULL,
      `name` text,
      `label` varchar(50) DEFAULT NULL,
      `comments` text,
      `num_shortterms` varchar(255) DEFAULT NULL,
      `lastInsert` timestamp NULL DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
		</cfquery>
		<cfcatch type="any"><cfdump var="#cfcatch#"></cfcatch>
	</cftry>
    
	<!--- Creates the vrm_booking_lead_time Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vrm_booking_lead_time` (
      `bookingLeadTime` int(11) DEFAULT NULL,
      `updatedDateTime` datetime DEFAULT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vrm_calendars Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vrm_calendars` (
      `property_id` int(11) DEFAULT NULL,
      `thedate` date DEFAULT NULL,
      `theid` int(11) DEFAULT NULL,
      `info` varchar(255) DEFAULT NULL,
      `user_type` int(11) DEFAULT NULL,
      `lastInsert` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      `code` char(5) DEFAULT NULL,
      KEY `inx_propid` (`property_id`) USING BTREE,
      KEY `ind_thedate` (`thedate`) USING BTREE
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vrm_countries Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vrm_countries` (
      `country_name` varchar(50) DEFAULT NULL,
      `country_code` varchar(50) DEFAULT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vrm_long_terms_detail Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vrm_long_terms_detail` (
      `product_id` varchar(255) NOT NULL,
      `office_id` varchar(255) DEFAULT NULL,
      `product_type` varchar(255) DEFAULT NULL,
      `name` varchar(255) DEFAULT NULL,
      `description` varchar(5000) DEFAULT NULL,
      `security_deposit` varchar(255) DEFAULT NULL,
      `date_created` varchar(255) DEFAULT NULL,
      `date_modified` varchar(255) DEFAULT NULL,
      `status` varchar(255) DEFAULT NULL,
      `location_id` varchar(255) DEFAULT NULL,
      `hg_id` varchar(255) DEFAULT NULL,
      `proptype_id` varchar(255) DEFAULT NULL,
      `address1` varchar(255) DEFAULT NULL,
      `address2` varchar(255) DEFAULT NULL,
      `unit` varchar(255) DEFAULT NULL,
      `city` varchar(255) DEFAULT NULL,
      `state` varchar(255) DEFAULT NULL,
      `zip` varchar(255) DEFAULT NULL,
      `country_id` varchar(255) DEFAULT NULL,
      `phone` varchar(255) DEFAULT NULL,
      `bedrooms` varchar(255) DEFAULT NULL,
      `sleeps` varchar(255) DEFAULT NULL,
      `baths` varchar(255) DEFAULT NULL,
      `smoking` varchar(255) DEFAULT NULL,
      `pets` varchar(255) DEFAULT NULL,
      `handicap` varchar(255) DEFAULT NULL,
      `key_code` varchar(255) DEFAULT NULL,
      `min_balance` varchar(255) DEFAULT NULL,
      `mng_fee_amnt` varchar(255) DEFAULT NULL,
      `mng_fee_type` varchar(255) DEFAULT NULL,
      `beds` varchar(255) DEFAULT NULL,
      `warranty_notes` varchar(5000) DEFAULT NULL,
      `housekeeping_status` varchar(255) DEFAULT NULL,
      `price` varchar(255) DEFAULT NULL,
      `date_available` varchar(255) DEFAULT NULL,
      `date_start` varchar(255) DEFAULT NULL,
      `date_end` varchar(255) DEFAULT NULL,
      `virtual_tour_url` varchar(255) DEFAULT NULL,
      `internal_memo` varchar(5000) DEFAULT NULL,
      `office` varchar(255) DEFAULT NULL,
      `location` varchar(255) DEFAULT NULL,
      `housekeeping_group` varchar(255) DEFAULT NULL,
      `property_type` varchar(255) DEFAULT NULL,
      `is_public` varchar(255) DEFAULT NULL,
      `res_fee_acct_id` varchar(255) DEFAULT NULL,
      `mng_acct_id` varchar(255) DEFAULT NULL,
      `cancellation_acct_id` varchar(255) DEFAULT NULL,
      `travel_ins_acct_id` varchar(255) DEFAULT NULL,
      `directions_to` varchar(255) DEFAULT NULL,
      `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      PRIMARY KEY (`product_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vrm_long_terms_list Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vrm_long_terms_list` (
      `product_id` varchar(255) NOT NULL,
      `name` varchar(255) DEFAULT NULL,
      `office_id` varchar(255) DEFAULT NULL,
      `product_type` varchar(255) DEFAULT NULL,
      `description` varchar(5000) DEFAULT NULL,
      `security_deposit` varchar(255) DEFAULT NULL,
      `date_created` varchar(255) DEFAULT NULL,
      `date_modified` varchar(255) DEFAULT NULL,
      `date_available` varchar(255) DEFAULT NULL,
      `is_public` varchar(255) DEFAULT NULL,
      `address1` varchar(255) DEFAULT NULL,
      `address2` varchar(255) DEFAULT NULL,
      `unit` varchar(255) DEFAULT NULL,
      `city` varchar(255) DEFAULT NULL,
      `state` varchar(255) DEFAULT NULL,
      `zip` varchar(255) DEFAULT NULL,
      `country_id` varchar(255) DEFAULT NULL,
      `bedrooms` varchar(255) DEFAULT NULL,
      `sleeps` varchar(255) DEFAULT NULL,
      `baths` varchar(255) DEFAULT NULL,
      `smoking` varchar(255) DEFAULT NULL,
      `pets` varchar(255) DEFAULT NULL,
      `handicap` varchar(255) DEFAULT NULL,
      `price` varchar(255) DEFAULT NULL,
      `content_thumbnail` longblob,
      `content_type` varchar(255) DEFAULT NULL,
      `content_length` varchar(255) DEFAULT NULL,
      `seopropertyname` varchar(255) DEFAULT NULL,
      `status` varchar(50) DEFAULT NULL,
      `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      PRIMARY KEY (`product_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vrm_photos Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vrm_photos` (
      `property_id` int(11) DEFAULT NULL,
      `label` varchar(255) DEFAULT NULL,
      `order_num` int(11) DEFAULT NULL,
      `lastInsert` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      `picture_id` int(11) DEFAULT NULL,
      `picture_binary` mediumblob,
      KEY `property_id` (`property_id`) USING BTREE
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vrm_photos_ltr Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vrm_photos_ltr` (
      `property_id` int(11) DEFAULT NULL,
      `label` varchar(255) DEFAULT NULL,
      `order_num` int(11) DEFAULT NULL,
      `lastInsert` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      `picture_id` int(11) DEFAULT NULL,
      `picture_binary` mediumblob,
      KEY `property_id` (`property_id`) USING BTREE
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vrm_properties Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vrm_properties` (
      `property_id` int(11) NOT NULL DEFAULT '0',
      `name` varchar(255) DEFAULT NULL,
      `seopropertyname` varchar(255) DEFAULT NULL,
      `pets` char(5) DEFAULT NULL,
      `handicap` char(5) DEFAULT NULL,
      `smoking` char(5) DEFAULT NULL,
      `location` varchar(255) DEFAULT NULL,
      `proptype_id` int(11) DEFAULT NULL,
      `bedrooms` int(11) DEFAULT NULL,
      `baths` int(11) DEFAULT NULL,
      `office_id` int(11) DEFAULT NULL,
      `office` varchar(50) DEFAULT NULL,
      `featured` char(5) DEFAULT NULL,
      `baths_half` int(11) DEFAULT NULL,
      `baths_shower` int(11) DEFAULT NULL,
      `parking_spots` int(11) DEFAULT NULL,
      `maxoccupancy` int(11) DEFAULT NULL,
      `property_type` varchar(255) DEFAULT NULL,
      `security_deposit` double DEFAULT NULL,
      `virtual_tour_url` varchar(255) DEFAULT NULL,
      `short_desc` text,
      `beds` varchar(255) DEFAULT NULL,
      `long_desc` text,
      `lastInsert` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      `user_def1` varchar(255) DEFAULT NULL,
      `user_def2` varchar(255) DEFAULT NULL,
      `user_def3` varchar(255) DEFAULT NULL,
      `user_def4` varchar(255) DEFAULT NULL,
      `user_def5` varchar(255) DEFAULT NULL,
      `user_def6` varchar(255) DEFAULT NULL,
      `rating` varchar(255) DEFAULT NULL,
      `address1` varchar(255) DEFAULT NULL,
      `address2` varchar(100) DEFAULT NULL,
      `city` varchar(150) DEFAULT NULL,
      `state` char(5) DEFAULT NULL,
      `zip` varchar(15) DEFAULT NULL,
      `phone` varchar(50) DEFAULT NULL,
      `brochure_page` varchar(255) DEFAULT NULL,
      `reservation_email` varchar(100) DEFAULT NULL,
      `phone_local` varchar(50) DEFAULT NULL,
      `phone_tollfree` varchar(50) DEFAULT NULL,
      `check_in_time` varchar(25) DEFAULT NULL,
      `check_out_time` varchar(25) DEFAULT NULL,
      `product_date_modified` varchar(50) DEFAULT NULL,
      `cal_date_modified` varchar(50) DEFAULT NULL,
      `pics_date_modified` varchar(50) DEFAULT NULL,
      `rates_date_modified` varchar(50) DEFAULT NULL,
      `amenities_date_modified` varchar(50) DEFAULT NULL,
      `defaultPhoto` int(11) DEFAULT NULL,
      `latitude` varchar(50) DEFAULT NULL,
      `longitude` varchar(50) DEFAULT NULL,
      `title_SEO` varchar(255) DEFAULT NULL,
      `keyword_SEO` varchar(255) DEFAULT NULL,
      `desc_SEO` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`property_id`),
      KEY `property_id` (`property_id`) USING BTREE,
      KEY `seopropertyname` (`seopropertyname`) USING BTREE,
      KEY `office` (`office`) USING BTREE,
      KEY `bedrooms` (`bedrooms`) USING BTREE,
      KEY `baths` (`baths`) USING BTREE,
      KEY `location` (`location`) USING BTREE
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vrm_property_amenities Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vrm_property_amenities` (
      `property_id` int(11) DEFAULT NULL,
      `amenity_id` int(11) DEFAULT NULL,
      KEY `property_id` (`property_id`) USING BTREE
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vrm_property_amenities_ltr Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vrm_property_amenities_ltr` (
      `property_id` int(11) DEFAULT NULL,
      `amenity_id` int(11) DEFAULT NULL,
      KEY `property_id` (`property_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vrm_rates Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vrm_rates` (
      `property_id` int(11) unsigned NOT NULL,
      `season` varchar(150) DEFAULT NULL,
      `min_nights` int(11) DEFAULT NULL,
      `daily` double DEFAULT NULL,
      `weekly` double DEFAULT NULL,
      `monthly` double DEFAULT NULL,
      `turn_day` int(11) DEFAULT NULL,
      `date_start` date DEFAULT NULL,
      `date_end` date DEFAULT NULL,
      `enforce_weekly` char(5) DEFAULT NULL,
      `enforce_start_day` char(5) DEFAULT NULL,
      `last_insert` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      `day2` double DEFAULT NULL,
      `day3` double DEFAULT NULL,
      `day4` double DEFAULT NULL,
      KEY `index` (`property_id`) USING BTREE
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vrm_reservations Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vrm_reservations` (
      `ID` int(255) NOT NULL AUTO_INCREMENT,
      `productID` int(11) DEFAULT NULL,
      `userID` int(11) DEFAULT NULL,
      `uCity` varchar(50) DEFAULT NULL,
      `uState` varchar(20) DEFAULT NULL,
      `uZip` varchar(20) DEFAULT NULL,
      `uCountryID` varchar(10) DEFAULT NULL,
      `reservationID` int(255) DEFAULT NULL,
      `dateReserved` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
      `dateCancelled` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
      `guestType` varchar(20) DEFAULT NULL,
      `reservationType` varchar(50) DEFAULT NULL,
      `marketingCode` varchar(50) DEFAULT NULL,
      `marketingCodeID` int(1) DEFAULT NULL,
      `reservationDateStart` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
      `reservationDateEnd` datetime DEFAULT NULL,
      `numberInParty` int(11) DEFAULT NULL,
      `guestFirstName` varchar(50) DEFAULT NULL,
      `guestLastName` varchar(50) DEFAULT NULL,
      `guestEmailAddress` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`ID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vrm_reservations_for_survey Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vrm_reservations_for_survey` (
      `ID` int(255) NOT NULL AUTO_INCREMENT,
      `productID` int(11) DEFAULT NULL,
      `userID` int(11) DEFAULT NULL,
      `uCity` varchar(50) DEFAULT NULL,
      `uState` varchar(20) DEFAULT NULL,
      `uZip` varchar(20) DEFAULT NULL,
      `uCountryID` varchar(10) DEFAULT NULL,
      `reservationID` int(255) DEFAULT NULL,
      `dateReserved` datetime DEFAULT NULL,
      `dateCancelled` datetime DEFAULT NULL,
      `guestType` varchar(20) DEFAULT NULL,
      `reservationType` varchar(50) DEFAULT NULL,
      `marketingCode` varchar(50) DEFAULT NULL,
      `marketingCodeID` int(1) DEFAULT NULL,
      `reservationDateStart` datetime DEFAULT NULL,
      `reservationDateEnd` datetime DEFAULT NULL,
      `numberInParty` int(11) DEFAULT NULL,
      `guestFirstName` varchar(50) DEFAULT NULL,
      `guestLastName` varchar(50) DEFAULT NULL,
      `guestEmailAddress` varchar(255) DEFAULT NULL,
      `survey_status` varchar(10) NOT NULL DEFAULT 'pending',
      `survey_sent_date` datetime DEFAULT NULL,
      PRIMARY KEY (`ID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vrm_specials Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vrm_specials` (
      `property_id` int(11) DEFAULT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
</cfif>
