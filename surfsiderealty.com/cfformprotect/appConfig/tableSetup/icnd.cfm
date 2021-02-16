<cfif request.appConfigData.PMS EQ "RNS">
	<!--- Creates the properties Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `properties` (
      `unit_id` int(11) NOT NULL AUTO_INCREMENT,
      `unit_name` varchar(255) DEFAULT NULL,
      `seopropertyname` varchar(255) DEFAULT NULL,
      `owner` int(11) DEFAULT NULL,
      `rental_type` varchar(100) DEFAULT NULL,
      `bedrooms` int(11) DEFAULT NULL,
      `full_baths` int(11) DEFAULT NULL,
      `half_baths` int(11) DEFAULT NULL,
      `sleeps` int(11) DEFAULT NULL,
      `address` varchar(255) DEFAULT NULL,
      `city` varchar(255) DEFAULT NULL,
      `state` varchar(100) DEFAULT NULL,
      `zip` varchar(255) DEFAULT NULL,
      `description` text,
      `meta_title` varchar(255) DEFAULT NULL,
      `meta_keywords` varchar(255) DEFAULT NULL,
      `meta_description` text,
      `latitude` varchar(100) DEFAULT NULL,
      `longitude` varchar(100) DEFAULT NULL,
      `community` varchar(255) DEFAULT NULL,
      `alternate_email` varchar(255) DEFAULT NULL,
      `personal_website_name` varchar(255) DEFAULT NULL,
      `personal_website_link` varchar(255) DEFAULT NULL,
      `property_website_name` varchar(255) DEFAULT NULL,
      `property_website_link` varchar(255) DEFAULT NULL,
      `youtube_url` varchar(255) DEFAULT NULL,
      `virtual_tour_url` varchar(255) DEFAULT NULL,
      `approved` varchar(255) DEFAULT NULL,
      `start_date` varchar(255) DEFAULT NULL,
      `expiration_date` varchar(255) DEFAULT NULL,
      `last_updated` varchar(255) DEFAULT NULL,
      `createdat` varchar(255) DEFAULT NULL,
      `source` varchar(100) DEFAULT NULL COMMENT 'not in base site data?',
      `bathrooms` double(10,2) DEFAULT NULL COMMENT 'not in base site data?',
      `base_occupancy` int(11) DEFAULT NULL COMMENT 'not in base site data?',
      `special_header` varchar(255) DEFAULT NULL COMMENT 'not in base site data?',
      `location` varchar(255) DEFAULT NULL COMMENT 'not in base site data?',
      `area` varchar(255) DEFAULT NULL COMMENT 'not in base site data?',
      `rate_range` varchar(255) DEFAULT NULL COMMENT 'not in base site data?',
      `default_photo` varchar(255) DEFAULT NULL COMMENT 'not in base site data?',
      `year_built` int(11) DEFAULT NULL COMMENT 'not in base site data?',
      `parking` int(11) DEFAULT NULL COMMENT 'not in base site data?',
      `square_feet` int(11) DEFAULT NULL COMMENT 'not in base site data?',
      `pet_friendly_dog` char(5) DEFAULT 'No' COMMENT 'not in base site data?',
      `pet_friendly_cat` varchar(5) DEFAULT NULL,
      `pet_friendly` varchar(5) DEFAULT NULL,
      `tax_rate` double(10,2) DEFAULT '0.00' COMMENT 'not in base site data?',
      `rate_type` varchar(255) DEFAULT NULL COMMENT 'not in base site data?',
      `str_checkin_time` varchar(255) DEFAULT NULL COMMENT 'not in base site data?',
      `str_checkout_time` varchar(255) DEFAULT NULL COMMENT 'not in base site data?',
      `payment_policy_header` varchar(255) DEFAULT NULL COMMENT 'not in base site data?',
      `payment_policy_description` text COMMENT 'not in base site data?',
      `sort` int(11) DEFAULT NULL,
      `floor` varchar(45) DEFAULT NULL,
      `inhousepropertyid` varchar(45) DEFAULT NULL,
      `headline` varchar(255) DEFAULT NULL,
      `bedding` varchar(255) DEFAULT NULL,
      `external_link` varchar(255) DEFAULT NULL,
      `laststatuschangedatetime` datetime DEFAULT NULL,
      PRIMARY KEY (`unit_id`),
      KEY `bedrooms` (`bedrooms`),
      KEY `bathrooms` (`bathrooms`),
      KEY `sleeps` (`sleeps`)
    ) ENGINE=InnoDB AUTO_INCREMENT=1422 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>

	<!--- Creates the property_activities Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `property_activities` (
      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
      `property_id` int(11) DEFAULT NULL,
      `title` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>

	<!--- Creates the property_additional_charges Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `property_additional_charges` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `property_id` int(11) DEFAULT NULL,
      `name` varchar(255) DEFAULT NULL,
      `amount` double(10,2) DEFAULT NULL,
      `type` enum('fixed','percent') DEFAULT NULL,
      `option` varchar(255) DEFAULT NULL,
      `created` datetime DEFAULT NULL,
      `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (`id`),
      KEY `property_id` (`property_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>

	<!--- Creates the property_amenities Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `property_amenities` (
      `property_id` int(11) DEFAULT NULL,
      `category_id` int(11) DEFAULT '0',
      `title` varchar(255) DEFAULT NULL,
      KEY `property_id` (`property_id`),
      KEY `category_id` (`category_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>

	<!--- Creates the property_availability Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `property_availability` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `property_id` int(11) DEFAULT NULL,
      `active_flag` tinyint(4) DEFAULT NULL COMMENT '1 is active, 0 is deleted',
      `guest_name` varchar(255) DEFAULT NULL,
      `guest_email` varchar(255) DEFAULT NULL,
      `guest_phone` varchar(255) DEFAULT NULL,
      `checkin` date DEFAULT NULL,
      `checkout` date DEFAULT NULL,
      `num_guests` int(11) DEFAULT NULL,
      `comments` text,
      `modified_by` varchar(255) DEFAULT NULL,
      `modified_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      `booked_day` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
      `reservationCode` varchar(255) DEFAULT NULL,
      `approvedDate` datetime DEFAULT NULL,
      `approvedBy` varchar(255) DEFAULT NULL,
      `depositPaid` int(11) NOT NULL DEFAULT '0',
      `balancePaid` int(11) NOT NULL DEFAULT '0',
      PRIMARY KEY (`id`),
      KEY `property_id` (`property_id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=34949 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>

	<!--- Creates the property_photos Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `property_photos` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `property_id` int(11) DEFAULT NULL,
      `photo` varchar(255) DEFAULT NULL,
      `sort` int(11) DEFAULT NULL,
      `tag` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`id`),
      KEY `property_id` (`property_id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=14329 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>

	<!--- Creates the property_rates Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `property_rates` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `property_id` int(11) DEFAULT NULL,
      `season_name` varchar(255) DEFAULT NULL,
      `daily_rate` double(10,2) DEFAULT NULL,
      `weekly_rate` double(10,2) DEFAULT NULL,
      `start_date` date DEFAULT NULL,
      `end_date` date DEFAULT NULL,
      `min_nights` int(11) DEFAULT NULL,
      `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      `created` date DEFAULT NULL,
      `adminFee` double(10,2) DEFAULT NULL,
      `cleaningFee` double(10,2) DEFAULT NULL,
      `taxRate` double(10,4) DEFAULT NULL,
      `securityDeposit` double(10,2) DEFAULT NULL,
      PRIMARY KEY (`id`),
      KEY `property_id` (`property_id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=9423 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>

	<!--- Creates the property_reservation_requests Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `property_reservation_requests` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `firstName` varchar(255) DEFAULT NULL,
      `lastName` varchar(255) DEFAULT NULL,
      `address1` varchar(255) DEFAULT NULL,
      `address2` varchar(255) DEFAULT NULL,
      `city` varchar(255) DEFAULT NULL,
      `state` varchar(255) DEFAULT NULL,
      `zip` varchar(255) DEFAULT NULL,
      `country` varchar(255) DEFAULT NULL,
      `email` varchar(255) DEFAULT NULL,
      `phone` varchar(255) DEFAULT NULL,
      `comments` text,
      `numAdults` int(11) DEFAULT NULL,
      `numChildren` int(11) DEFAULT NULL,
      `propertyName` varchar(255) DEFAULT NULL,
      `propertyID` int(11) DEFAULT NULL,
      `checkIn` date DEFAULT NULL,
      `checkOut` date DEFAULT NULL,
      `summaryOfCharges` text,
      `dateSubmitted` date DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>

	<!--- Creates the owners Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `owners` (
      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
      `name` varchar(255) DEFAULT NULL,
      `gender` varchar(10) DEFAULT NULL,
      `email` varchar(255) DEFAULT NULL,
      `password` varchar(255) DEFAULT NULL,
      `test_password` varchar(255) DEFAULT NULL,
      `encryptedSalt` text,
      `token` varchar(255) DEFAULT NULL,
      `active` char(5) DEFAULT 'No',
      `date_of_joining` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      `phone` varchar(100) DEFAULT NULL,
      `showPhone` int(11) NOT NULL DEFAULT '0',
      `bio` text,
      `photo` varchar(255) DEFAULT NULL,
      `preferred_call_start` varchar(50) DEFAULT NULL,
      `preferred_call_end` varchar(50) DEFAULT NULL,
      `time_zone` varchar(100) DEFAULT NULL,
      `address` varchar(255) DEFAULT NULL,
      `city` varchar(255) DEFAULT NULL,
      `state` varchar(255) DEFAULT NULL,
      `zip` varchar(25) DEFAULT NULL,
      `facebook_url` varchar(255) DEFAULT NULL,
      `twitter_url` varchar(255) DEFAULT NULL,
      `linkedin_url` varchar(255) DEFAULT NULL,
      `instagram_url` varchar(255) DEFAULT NULL,
      `skype_id` varchar(255) DEFAULT NULL,
      `youtube_url` varchar(255) DEFAULT NULL,
      `google_url` varchar(255) DEFAULT NULL,
      `email_provider` varchar(255) DEFAULT NULL,
      `mailchimp_api_key` varchar(255) DEFAULT NULL,
      `mailchimp_list_id` varchar(255) DEFAULT NULL,
      `constant_contact_no` varchar(255) DEFAULT NULL,
      `lastLoggedIn` timestamp NULL DEFAULT NULL,
      `modifiedon` timestamp NULL DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=550 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>

	<!--- Creates the owner_deals Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `owner_deals` (
      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
      `property_id` int(11) DEFAULT NULL,
      `active` char(5) DEFAULT NULL,
      `title` varchar(255) DEFAULT NULL,
      `advertise_start` date DEFAULT NULL,
      `advertise_end` date DEFAULT NULL,
      `booking_start` date DEFAULT NULL,
      `booking_end` date DEFAULT NULL,
      `description` text,
      `created_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      `created_by` varchar(50) DEFAULT NULL,
      `modified_by` varchar(50) DEFAULT NULL,
      `modified_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>

	<!--- Creates the owner_faqs Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `owner_faqs` (
      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
      `propertyid` int(11) unsigned DEFAULT NULL,
      `question` text,
      `answer` text,
      `approved` char(5) DEFAULT NULL,
      `createdAt` timestamp NULL DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>

	<!--- Creates the owner_inquiries Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `owner_inquiries` (
      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
      `propertyid` int(11) unsigned DEFAULT NULL,
      `owner` int(11) DEFAULT NULL,
      `adults` int(11) DEFAULT NULL,
      `children` int(11) DEFAULT NULL,
      `sender` varchar(100) DEFAULT NULL,
      `propertyname` varchar(100) DEFAULT NULL,
      `phone` varchar(100) DEFAULT NULL,
      `modeofinquiry` varchar(100) DEFAULT NULL,
      `senderinfo` varchar(100) DEFAULT NULL,
      `inquiry` varchar(255) DEFAULT NULL,
      `checkin` date DEFAULT NULL,
      `checkout` date DEFAULT NULL,
      `createdAt` timestamp NULL DEFAULT NULL,
      `status` varchar(50) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>

	<!--- Creates the owner_orders Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `owner_orders` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `orderid` int(11) DEFAULT NULL,
      `ownerid` int(11) DEFAULT NULL,
      `propertiesnumber` int(11) DEFAULT NULL,
      `listingterm` varchar(50) DEFAULT NULL,
      `amount` varchar(50) DEFAULT NULL,
      `trxnid` varchar(50) DEFAULT NULL,
      `ordertype` varchar(50) DEFAULT NULL,
      `authorizationcode` varchar(50) DEFAULT NULL,
      `sessionid` varchar(255) DEFAULT NULL,
      `response` varchar(50) DEFAULT NULL,
      `trxnstatus` varchar(50) DEFAULT NULL,
      `paymentapproved` varchar(50) DEFAULT NULL,
      `promocode` varchar(50) DEFAULT NULL,
      `start_date` date DEFAULT NULL,
      `end_date` date DEFAULT NULL,
      `codevalue` double(10,2) DEFAULT NULL,
      `createdat` timestamp NULL DEFAULT NULL,
      `invoicedetails` text,
      `resnumber` varchar(20) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>

	<!--- Creates the owner_payments Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `owner_payments` (
      `intQuoteNum` int(10) NOT NULL DEFAULT '0',
      `PaymentDate` date NOT NULL DEFAULT '0000-00-00',
      `PaymentAmount` double NOT NULL DEFAULT '0',
      `card_name` varchar(255) DEFAULT NULL,
      `email` varchar(255) NOT NULL DEFAULT '',
      `gateid` int(11) DEFAULT NULL,
      `description` varchar(255) DEFAULT NULL,
      `approved` varchar(10) DEFAULT NULL,
      `authcode` varchar(255) NOT NULL,
      `last4` varchar(4) DEFAULT NULL,
      `approvedamt` varchar(255) DEFAULT NULL,
      `responsecode` int(4) DEFAULT NULL,
      `response` varchar(255) DEFAULT NULL,
      `bal` double DEFAULT NULL,
      `strPropId` varchar(255) DEFAULT NULL,
      `createdat` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
      `cardtype` varchar(255) DEFAULT NULL,
      `camefrom` varchar(255) DEFAULT NULL,
      `processed` varchar(255) DEFAULT 'No' COMMENT 'sets whether payment been processed in-house',
      PRIMARY KEY (`intQuoteNum`,`PaymentDate`,`PaymentAmount`,`email`,`createdat`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
</cfif>
