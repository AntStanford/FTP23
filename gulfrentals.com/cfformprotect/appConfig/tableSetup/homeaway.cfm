<cfif request.appConfigData.PMS EQ "Homeaway">
  <!--- Creates the pp_minnightsinfo Table --->
  <cftry>
    <cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `pp_minnightsinfo` (
      `strPropId` varchar(25) NOT NULL DEFAULT '',
      `dtBeginDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
      `dtEndDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
      `intMinNights` int(11) DEFAULT NULL,
      `intStayIncrement` int(11) DEFAULT NULL,
      PRIMARY KEY (`strPropId`,`dtBeginDate`,`dtEndDate`)
    ) ENGINE=innodb DEFAULT CHARSET=latin1;
    </cfquery>
    <cfcatch type="any"></cfcatch>
  </cftry>
  <!--- Creates the pp_property_non_available_dates Table --->
  <cftry>
    <cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `pp_property_non_available_dates` (
      `strPropId` varchar(25) NOT NULL DEFAULT '',
      `DtFromDate` date NOT NULL DEFAULT '0000-00-00',
      `DtToDate` date NOT NULL DEFAULT '0000-00-00',
      `IntQuoteNum` varchar(100) DEFAULT NULL,
      `strStayType` varchar(100) DEFAULT NULL,
      `DtChangedOn` date DEFAULT NULL,
      `IntLogID` varchar(20) DEFAULT NULL,
      PRIMARY KEY (`strPropId`,`DtFromDate`,`DtToDate`)
    ) ENGINE=innodb DEFAULT CHARSET=latin1;
    </cfquery>
    <cfcatch type="any"></cfcatch>
  </cftry>
  <!--- Creates the pp_propertyinfo Table --->
  <cftry>
    <cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `pp_propertyinfo` (
      `StrPropId` varchar(25) NOT NULL DEFAULT '',
      `StrName` varchar(255) DEFAULT NULL,
      `DblBaths` double DEFAULT NULL,
      `DblBeds` double DEFAULT NULL,
      `DblRate` varchar(255) DEFAULT NULL,
      `IntOccu` int(10) DEFAULT NULL,
      `SEOAddress` varchar(255) DEFAULT NULL,
      `StrAddress1` varchar(255) DEFAULT NULL,
      `StrAddress2` varchar(255) DEFAULT NULL,
      `StrArea` varchar(255) DEFAULT NULL,
      `StrChangeLogFlag` varchar(255) DEFAULT NULL,
      `StrCity` varchar(255) DEFAULT NULL,
      `StrComplex` varchar(255) DEFAULT NULL,
      `StrCountry` varchar(255) DEFAULT NULL,
      `StrDesc` text,
      `StrLocation` varchar(255) DEFAULT NULL,
      `StrMapRef` varchar(255) DEFAULT NULL,
      `StrPhone` varchar(255) DEFAULT NULL,
      `StrPicUrl` varchar(255) DEFAULT NULL,
      `StrState` varchar(255) DEFAULT NULL,
      `StrTurnDay` varchar(255) DEFAULT NULL,
      `StrType` varchar(255) DEFAULT NULL,
      `StrUnitType` varchar(255) DEFAULT NULL,
      `StrZip` varchar(255) DEFAULT NULL,
      `TypeDesc` varchar(255) DEFAULT NULL,
      `hashCode` varchar(255) DEFAULT NULL,
      `picList` longtext,
      `PicListLarge` text,
      `featureList` text,
      `blue` varchar(20) DEFAULT NULL,
      `clean` varchar(20) DEFAULT NULL,
      `damagefee` varchar(20) DEFAULT NULL,
      `iholding` varchar(20) DEFAULT NULL,
      `neighborhood` varchar(255) DEFAULT NULL,
      `rentalagreement` text,
      `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      `seoPropertyName` varchar(255) DEFAULT NULL,
      `cleanStrPropID` varchar(255) DEFAULT NULL,
      `defaultPhoto` varchar(255) DEFAULT NULL,
      `latitude` VARCHAR(100) DEFAULT NULL,
     `longitude` VARCHAR(100) DEFAULT NULL,
      PRIMARY KEY (`StrPropId`),
      KEY `StrArea` (`StrArea`),
      KEY `dblBeds` (`DblBeds`),
      KEY `IntOccu` (`IntOccu`),
      KEY `StrComplex` (`StrComplex`),
      KEY `DblBaths` (`DblBaths`),
      KEY `cleanStrPropID` (`cleanStrPropID`),
      KEY `strType` (`strType`),
      KEY `defaultPhoto` (`defaultPhoto`),
      KEY `StrTurnDay` (`StrTurnDay`)
    ) ENGINE=innodb DEFAULT CHARSET=latin1;
    </cfquery>
    <cfcatch type="any"></cfcatch>
  </cftry>
  <!--- Creates the pp_propertyinfo_lat_long Table --->
  <cftry>
    <cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `pp_propertyinfo_lat_long` (
      `StrPropId` varchar(25) NOT NULL DEFAULT '',
      `latitude` varchar(255) DEFAULT NULL,
      `longitude` varchar(255) DEFAULT NULL,
      `strname` varchar(255) DEFAULT NULL,
      `strarea` varchar(255) DEFAULT NULL,
      PRIMARY KEY (`StrPropId`)
    ) ENGINE=innodb DEFAULT CHARSET=latin1;
    </cfquery>
    <cfcatch type="any"></cfcatch>
  </cftry>
  <!--- Creates the pp_season_rates Table --->
  <cftry>
    <cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `pp_season_rates` (
      `strPropId` varchar(25) NOT NULL DEFAULT '',
      `dtBeginDate` date NOT NULL DEFAULT '0000-00-00',
      `dtEndDate` date NOT NULL DEFAULT '0000-00-00',
      `dblRate` double NOT NULL DEFAULT '0',
      `strChargeBasis` varchar(100) NOT NULL DEFAULT '',
      PRIMARY KEY (`strPropId`,`dtBeginDate`,`dtEndDate`,`strChargeBasis`),
      KEY `strPropId` (`strPropId`)
    ) ENGINE=innodb DEFAULT CHARSET=latin1;
    </cfquery>
    <cfcatch type="any"></cfcatch>
  </cftry>
  <!--- Creates the pp_turndayinfo Table --->
  <cftry>
    <cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `pp_turndayinfo` (
      `strpropid` varchar(100) NOT NULL DEFAULT '',
      `dtBegindate` date NOT NULL DEFAULT '0000-00-00',
      `dtEndDate` date NOT NULL DEFAULT '0000-00-00',
      `intTurnDay` int(11) NOT NULL DEFAULT '0',
      `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (`strpropid`,`dtBegindate`,`dtEndDate`,`intTurnDay`)
    ) ENGINE=innodb DEFAULT CHARSET=latin1;
    </cfquery>
    <cfcatch type="any"></cfcatch>
  </cftry>
  <!--- Creates the pp_attributes Table --->
  <cftry>
    <cfquery datasource="#request.appConfigData.clientsDSN#">
    CREATE TABLE `pp_attributes` (
    `strpropid` varchar(255) NOT NULL DEFAULT '',
    `attribute` varchar(255) DEFAULT NULL,
    `attribute_value` varchar(255) DEFAULT NULL,
    KEY `strpropid` (`strpropid`)
    ) ENGINE=innodb DEFAULT CHARSET=latin1
    </cfquery>
    <cfcatch type="any"></cfcatch>
  </cftry>
</cfif>
