<cfif request.appConfigData.PMS EQ "Streamline">
	<!--- Creates the streamline_amenities Table --->
  <cftry>
    <cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `streamline_amenities` (
      `unit_id` int(11) NOT NULL DEFAULT '0',
      `group_name` varchar(255) DEFAULT NULL,
      `group_description` varchar(255) DEFAULT NULL,
      `amenity_name` varchar(255) DEFAULT NULL,
      `amenity_description` varchar(255) DEFAULT NULL,
      `amenity_id` int(11) NOT NULL DEFAULT '0',
      `amenity_show_on_website` char(5) DEFAULT 'No',
      `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (`unit_id`,`amenity_id`),
      KEY `unit_id` (`unit_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    </cfquery>
    <cfcatch type="any"></cfcatch>
  </cftry>
  <!--- Creates the streamline_non_avail_dates Table --->
  <cftry>
    <cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `streamline_non_avail_dates` (
      `unit_id` int(11) DEFAULT NULL,
      `start_date` date DEFAULT NULL,
      `end_date` date DEFAULT NULL,
      `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      KEY `unit_id` (`unit_id`),
      KEY `start_date` (`start_date`),
      KEY `end_date` (`end_date`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    </cfquery>
    <cfcatch type="any"></cfcatch>
  </cftry>
  <!--- Creates the streamline_photos Table --->
  <cftry>
    <cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `streamline_photos` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `unit_id` int(11) DEFAULT NULL,
      `photo_id` int(11) NOT NULL DEFAULT '0',
      `image_path` varchar(255) DEFAULT NULL,
      `thumbnail_path` varchar(255) DEFAULT NULL,
      `original_path` varchar(255) DEFAULT NULL,
      `description` text,
      `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (`id`),
      KEY `unit_id` (`unit_id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=8372983 DEFAULT CHARSET=latin1;
    </cfquery>
    <cfcatch type="any"></cfcatch>
  </cftry>
  <!--- Creates the streamline_properties Table --->
  <cftry>
    <cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `streamline_properties` (
      `unit_id` int(11) unsigned NOT NULL,
      `public_unit_id` varchar(20) DEFAULT NULL,
      `name` varchar(255) DEFAULT NULL,
      `address` varchar(255) DEFAULT NULL,
      `addition_seo_text` varchar(255) DEFAULT NULL,
      `bathrooms_number` double(10,2) DEFAULT NULL,
      `bedrooms_number` int(11) DEFAULT NULL,
      `building_id` int(11) DEFAULT NULL,
      `building_short_name` varchar(255) DEFAULT NULL,
      `building_name` varchar(255) DEFAULT NULL,
      `city` varchar(255) DEFAULT NULL,
      `comment` text,
      `company_id` int(11) DEFAULT NULL,
      `condo_type_id` int(11) DEFAULT NULL,
      `coupons_enabled` int(11) DEFAULT NULL,
      `country_name` varchar(255) DEFAULT NULL,
      `condo_type_name` varchar(255) DEFAULT NULL,
      `condo_type_group_id` int(11) DEFAULT NULL,
      `condo_type_group_name` varchar(255) DEFAULT NULL,
      `discounts_enabled` int(11) DEFAULT NULL,
      `default_image_path` varchar(255) DEFAULT NULL,
      `default_thumbnail_path` varchar(255) DEFAULT NULL,
      `default_unit_id` int(11) DEFAULT NULL,
      `description` text,
      `email_quote_description` text,
      `floor` varchar(255) DEFAULT NULL,
      `flyer_url` varchar(255) DEFAULT NULL,
      `floor_plan_url` varchar(255) DEFAULT NULL,
      `floor_name` varchar(255) DEFAULT NULL,
      `gallery_code` varchar(255) DEFAULT NULL,
      `google_map_overlay_url` varchar(255) DEFAULT NULL,
      `global_description` text,
      `half_baths` int(11) DEFAULT '0',
      `housekeeping_processor_id` int(11) DEFAULT NULL,
      `home_type` varchar(255) DEFAULT NULL,
      `home_type_id` int(11) DEFAULT NULL,
      `image_ext` varchar(255) DEFAULT NULL,
      `inspection_view` int(11) DEFAULT NULL,
      `images_number` int(11) DEFAULT NULL,
      `local_phone` varchar(255) DEFAULT NULL,
      `longterm_enabled` int(11) DEFAULT NULL,
      `location_id` int(11) DEFAULT NULL,
      `latitude` varchar(255) DEFAULT NULL,
      `longitude` varchar(255) DEFAULT NULL,
      `location_latitude` varchar(25) DEFAULT NULL,
      `location_longitude` varchar(25) DEFAULT NULL,
      `location_name` varchar(255) DEFAULT NULL,
      `lodging_type_id` int(11) DEFAULT NULL,
      `location_area_id` int(11) DEFAULT NULL,
      `location_area_name` varchar(255) DEFAULT NULL,
      `location_resort_name` varchar(255) DEFAULT NULL,
      `location_image_ext` varchar(255) DEFAULT NULL,
      `max_adults` int(11) DEFAULT NULL,
      `max_pets` int(11) DEFAULT NULL,
      `max_occupants` int(11) DEFAULT NULL,
      `mobile_seo_text` text,
      `neighborhood_name` varchar(255) DEFAULT NULL,
      `neighborhood_area_id` int(11) DEFAULT NULL,
      `owning_type_id` int(11) DEFAULT NULL,
      `owning_result_table_order` int(11) DEFAULT NULL,
      `obxblue_area_sort` int(11) DEFAULT '0',
      `parent_id` int(11) DEFAULT NULL,
      `pets_allowed` char(5) DEFAULT 'No',
      `property_rating_name` varchar(255) DEFAULT NULL,
      `property_rating_points` varchar(255) DEFAULT NULL,
      `rating_count` int(11) DEFAULT NULL,
      `rating_average` double(10,2) DEFAULT NULL,
      `resort_area_id` int(11) DEFAULT NULL,
      `sale_enabled` varchar(255) DEFAULT NULL,
      `seopropertyname` varchar(255) DEFAULT NULL,
      `search_position` int(11) DEFAULT NULL,
      `seo_title` varchar(255) DEFAULT NULL,
      `seo_description` text,
      `seo_keywords` varchar(255) DEFAULT NULL,
      `short_description` text,
      `status_id` int(11) DEFAULT NULL,
      `state_name` varchar(255) DEFAULT NULL,
      `state_description` varchar(255) DEFAULT NULL,
      `seo_page_name` varchar(255) DEFAULT NULL,
      `status_name` varchar(255) DEFAULT NULL,
      `square_foots` int(11) DEFAULT NULL,
      `shortterm_enabled` int(11) DEFAULT NULL,
      `state` varchar(255) DEFAULT NULL,
      `type_id` int(11) DEFAULT NULL,
      `thumbnail_ext` varchar(255) DEFAULT NULL,
      `use_parent_different_owners_logic` int(11) DEFAULT NULL,
      `unit_code` varchar(255) DEFAULT NULL,
      `virtual_tour_url` varchar(255) DEFAULT NULL,
      `virtual_tour_image_overlay_url` varchar(255) DEFAULT NULL,
      `web_name` varchar(255) DEFAULT NULL,
      `view_name` varchar(255) DEFAULT NULL,
      `view_order` int(11) DEFAULT NULL,
      `wifi_security_key` varchar(255) DEFAULT NULL,
      `zip` varchar(25) DEFAULT NULL,
      `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
      `obxblue_name` varchar(255) DEFAULT NULL,
      `sandbridge_name` varchar(255) DEFAULT NULL,
      `distancetobeach` int(10) DEFAULT NULL,
      PRIMARY KEY (`unit_id`),
      KEY `idxSeoPropertyName` (`seopropertyname`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    </cfquery>
    <cfcatch type="any"></cfcatch>
  </cftry>
  <!--- Creates the streamline_rates Table --->
  <cftry>
    <cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `streamline_rates` (
      `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      `unit_id` int(11) DEFAULT NULL,
      `season_name` varchar(100) DEFAULT NULL,
      `period_name` varchar(100) DEFAULT NULL,
      `period_begin` date DEFAULT NULL,
      `period_end` date DEFAULT NULL,
      `weekly_price` double(10,2) DEFAULT NULL,
      `monthly_price` double(10,2) DEFAULT NULL,
      `narrow_defined_days` int(11) DEFAULT NULL,
      `daily_first_interval` varchar(255) DEFAULT NULL,
      `daily_first_interval_price` double(10,2) DEFAULT NULL,
      `daily_second_interval` varchar(255) DEFAULT NULL,
      `daily_second_interval_price` double(10,2) DEFAULT NULL,
      KEY `unit_id` (`unit_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    </cfquery>
    <cfcatch type="any"></cfcatch>
  </cftry>
</cfif>
