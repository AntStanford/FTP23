<cfif request.appConfigData.PMS EQ "Vreasy">
	<!--- Creates the translations Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `translations` (
      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
      `english` varchar(255) DEFAULT NULL,
      `french` varchar(255) DEFAULT NULL,
      `italian` varchar(255) DEFAULT NULL,
      `spanish` varchar(255) DEFAULT NULL,
      `german` varchar(255) DEFAULT NULL,
      `dutch` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=742 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vreasy_amenities Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vreasy_amenities` (
      `amenity_id` int(11) NOT NULL,
      `amenity_name` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`amenity_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vreasy_calendars Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vreasy_calendars` (
      `id` int(11) NOT NULL,
      `bookingPropID` int(11) DEFAULT NULL,
      `checkin` date NOT NULL,
      `checkout` date DEFAULT NULL,
      `status` varchar(255) DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vreasy_data_harvest Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vreasy_data_harvest` (
      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
      `listing_id` int(11) DEFAULT NULL,
      `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      `script_ran_at` timestamp NULL DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vreasy_descriptions Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vreasy_descriptions` (
      `listing_id` int(11) NOT NULL,
      `language` varchar(10) NOT NULL,
      `description` text,
      `laundry_instructions` text,
      `cleaning_instructions` text,
      `payment_instructions` text,
      `rental_agreement` text,
      `directions` text,
      `portal_title` varchar(255) DEFAULT NULL,
      `house_rules` text,
      PRIMARY KEY (`listing_id`,`language`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vreasy_error_messages Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vreasy_error_messages` (
      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
      `error` varchar(255) DEFAULT NULL,
      `comment` text,
      `friendly_response` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vreasy_payment_types Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vreasy_payment_types` (
      `id` int(11) unsigned NOT NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `description` varchar(255) DEFAULT NULL,
      `name` varchar(255) DEFAULT NULL,
      `name_key` varchar(255) DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `user_id` int(11) DEFAULT NULL,
      `visible` char(5) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vreasy_photos Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vreasy_photos` (
      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
      `listing_id` int(11) DEFAULT NULL,
      `caption` varchar(255) DEFAULT NULL,
      `order` int(11) DEFAULT NULL,
      `title` varchar(255) DEFAULT NULL,
      `url` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=33012 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vreasy_properties Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vreasy_properties` (
      `listing_id` int(11) NOT NULL,
      `bookingPropID` int(11) DEFAULT NULL,
      `title` varchar(255) DEFAULT NULL,
      `checkin` time DEFAULT NULL,
      `checkout` time DEFAULT NULL,
      `active` int(11) DEFAULT NULL,
      `accommodates` int(11) DEFAULT NULL,
      `accommodates_max` int(11) DEFAULT NULL,
      `default_photo` varchar(255) DEFAULT NULL,
      `address` varchar(255) DEFAULT NULL,
      `city` varchar(255) DEFAULT NULL,
      `country_name` varchar(255) DEFAULT NULL,
      `latitude` varchar(255) DEFAULT NULL,
      `longitude` varchar(255) DEFAULT NULL,
      `postal_code` varchar(255) DEFAULT NULL,
      `state_province` varchar(255) DEFAULT NULL,
      `timezone` varchar(255) DEFAULT NULL,
      `timezone_offset` varchar(100) DEFAULT NULL,
      `timezone_offset_hours` time DEFAULT NULL,
      `property_type` varchar(255) DEFAULT NULL,
      `bedrooms` int(11) DEFAULT '0',
      `bathrooms` int(11) DEFAULT '0',
      `seopropertyname` varchar(255) DEFAULT NULL,
      `type_id` int(11) DEFAULT NULL,
      `manager_notes` text,
      `cleaning_fee` double(10,2) DEFAULT '0.00',
      `cleaning_fee_trigger` varchar(255) DEFAULT NULL,
      `security_deposit` double(10,2) DEFAULT '0.00',
      `deposit_percentage` int(11) DEFAULT NULL,
      `hours_within_deposit_due` int(11) DEFAULT NULL,
      `days_from_checkin_balance_due` int(11) DEFAULT NULL,
      `late_checkout_fee` double(10,2) DEFAULT NULL,
      `late_checkin_fee` double(10,2) DEFAULT NULL,
      `early_checkin_fee` double(10,2) DEFAULT NULL,
      `property_size` int(11) DEFAULT NULL,
      `currency` varchar(45) DEFAULT NULL,
      `refundPercentage` int(11) DEFAULT NULL,
      `refundPercentage2` int(11) DEFAULT NULL,
      `daysBeforeCheckinDue` int(11) DEFAULT NULL,
      `daysBeforeCheckinDue2` int(11) DEFAULT NULL,
      `tourist_tax_adult` float DEFAULT NULL,
      `tourist_tax_kid` float DEFAULT NULL,
      `tourist_tax_max_days` int(11) DEFAULT NULL,
      `credit_card_fee` float DEFAULT NULL,
      PRIMARY KEY (`listing_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vreasy_property_amenities Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vreasy_property_amenities` (
      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
      `listing_id` int(11) DEFAULT NULL,
      `amenity_id` int(11) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=31666 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vreasy_rate_periods Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vreasy_rate_periods` (
      `listing_id` int(11) NOT NULL,
      `start_date` date NOT NULL,
      `arrival_days_monday` char(5) DEFAULT 'No',
      `arrival_days_tuesday` char(5) DEFAULT 'No',
      `arrival_days_wednesday` char(5) DEFAULT 'No',
      `arrival_days_thursday` char(5) DEFAULT 'No',
      `arrival_days_friday` char(5) DEFAULT 'No',
      `arrival_days_saturday` char(5) DEFAULT 'No',
      `arrival_days_sunday` char(5) DEFAULT 'No',
      `base_daily_default` double(10,2) DEFAULT NULL,
      `currency_id` int(11) DEFAULT NULL,
      `daily_default` double(10,2) DEFAULT '0.00',
      `departure_days_monday` char(5) DEFAULT 'No',
      `departure_days_tuesday` char(5) DEFAULT 'No',
      `departure_days_wednesday` char(5) DEFAULT 'No',
      `departure_days_thursday` char(5) DEFAULT 'No',
      `departure_days_friday` char(5) DEFAULT 'No',
      `departure_days_saturday` char(5) DEFAULT 'No',
      `departure_days_sunday` char(5) DEFAULT 'No',
      `exchange_rate_applied` varchar(255) DEFAULT NULL,
      `exhange_rate_date` date DEFAULT NULL,
      `extra_person_fee` int(11) DEFAULT NULL,
      `extra_person_fee_trigger_amount` int(11) DEFAULT NULL,
      `minimum_stay` int(11) DEFAULT '0',
      `maximum_stay` int(11) DEFAULT '0',
      `minimum_advanced_reservation_min_hours` int(11) DEFAULT '0',
      `minimum_advanced_reservation_max_hours` int(11) DEFAULT '0',
      `monthly_percentage_decrease` int(11) DEFAULT NULL,
      `weekend_increase` int(11) DEFAULT NULL,
      `weekly_percentage_decrease` int(11) DEFAULT NULL,
      PRIMARY KEY (`listing_id`,`start_date`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vreasy_rates Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vreasy_rates` (
      `listing_id` int(11) NOT NULL,
      `arrival_days_monday` char(5) DEFAULT 'No',
      `arrival_days_tuesday` char(5) DEFAULT 'No',
      `arrival_days_wednesday` char(5) DEFAULT 'No',
      `arrival_days_thursday` char(5) DEFAULT 'No',
      `arrival_days_friday` char(5) DEFAULT 'No',
      `arrival_days_saturday` char(5) DEFAULT 'No',
      `arrival_days_sunday` char(5) DEFAULT 'No',
      `base_daily_default` double(10,2) DEFAULT NULL,
      `currency_id` int(11) DEFAULT NULL,
      `daily_default` double(10,2) DEFAULT '0.00',
      `departure_days_monday` char(5) DEFAULT 'No',
      `departure_days_tuesday` char(5) DEFAULT 'No',
      `departure_days_wednesday` char(5) DEFAULT 'No',
      `departure_days_thursday` char(5) DEFAULT 'No',
      `departure_days_friday` char(5) DEFAULT 'No',
      `departure_days_saturday` char(5) DEFAULT 'No',
      `departure_days_sunday` char(5) DEFAULT 'No',
      `exchange_rate_applied` varchar(255) DEFAULT NULL,
      `exhange_rate_date` date DEFAULT NULL,
      `extra_person_fee` int(11) DEFAULT NULL,
      `extra_person_fee_trigger_amount` int(11) DEFAULT NULL,
      `minimum_stay` int(11) DEFAULT '0',
      `maximum_stay` int(11) DEFAULT '0',
      `minimum_advanced_reservation_min_hours` int(11) DEFAULT '0',
      `minimum_advanced_reservation_max_hours` int(11) DEFAULT '0',
      `monthly_percentage_decrease` int(11) DEFAULT NULL,
      `weekend_increase` int(11) DEFAULT NULL,
      `weekly_percentage_decrease` int(11) DEFAULT NULL,
      PRIMARY KEY (`listing_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vreasy_reservations Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vreasy_reservations` (
      `listing_id` int(11) NOT NULL,
      `checkin` date NOT NULL,
      `checkout` date DEFAULT NULL,
      PRIMARY KEY (`listing_id`,`checkin`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vreasy_subscriptions Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vreasy_subscriptions` (
      `id` int(11) unsigned NOT NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `endpoint` varchar(255) DEFAULT NULL,
      `event` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
    
	<!--- Creates the vreasy_webhook_logs Table --->
	<cftry>
		<cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `vreasy_webhook_logs` (
      `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
      `update_fields` text,
      `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      `url_string` text,
      `event` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=553 DEFAULT CHARSET=latin1;
		</cfquery>
		<cfcatch type="any"></cfcatch>
	</cftry>
</cfif>
