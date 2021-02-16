<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
  <meta name="x-apple-disable-message-reformatting" />
  <style type="text/css">
  @import url('https://fonts.googleapis.com/css?family=Headland+One');
  div,p,a,li,td{ -webkit-text-size-adjust:none;}
  #outlook a{padding:0;} /* Force Outlook to provide a "view in browser" menu link. */
  html{width:100%;}
  body{width:100% !important;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%;margin:0;padding:0;}
  /* Prevent Webkit and Windows Mobile platforms from changing default font sizes,while not breaking desktop design. */
  .ExternalClass{width:100%;} /* Force Hotmail to display emails at full width */
  .ExternalClass,.ExternalClass p,.ExternalClass span,.ExternalClass font,.ExternalClass td,.ExternalClass div{line-height:100%;} /* Force Hotmail to display normal line spacing. */
  #backgroundTable{margin:0;padding:0;width:100% !important;line-height:100% !important;}
  #navigation{margin:58px 0 -68px;position:relative;z-index:1;}
  img{outline:none;text-decoration:none;border:none;-ms-interpolation-mode:bicubic;}
  a img{border:none;}
  .image_fix{display:block;}
  table[class=footer] p{margin:0px 0px !important;}
  table td{border-collapse:collapse;}
  table{ border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt;}
  a{color:#000000;text-decoration:none;text-decoration:none!important;}
  /*STYLES*/
  table[class=full]{ width:100%;clear:both;}
  table.devicewidth.social-wrapper img{margin-right:10px;}
  img[class=img-border]{border:1px solid #ccc;padding:2px;background:#eee;}
  h1{line-height:normal;color:#343130;font-family:'Headland One',serif;font-size:40px;}
  /*IPAD STYLES*/
  @media only screen and (max-width:640px){
    a[href^="tel"],a[href^="sms"]{text-decoration:none;color:#000000;pointer-events:none;cursor:default;}
    .mobile_link a[href^="tel"],.mobile_link a[href^="sms"]{text-decoration:default;color:#000000 !important;pointer-events:auto;cursor:default;}
    table[class=devicewidth]{width:440px!important;}
    table[class=center]{text-align:center!important;}
    table[class=devicewidthinner]{width:420px!important;}
    img[class=banner]{width:440px!important;height:220px!important;}
    img[class=col2img]{width:440px!important;height:220px!important;}
    #navigation{margin:25px 0 -42px;position:relative;z-index:1;font-size:12px;}
  }
  /*IPHONE STYLES*/
  @media only screen and (max-width:480px){
    a[href^="tel"],a[href^="sms"]{text-decoration:none;color:#000000;pointer-events:none;cursor:default;}
    .mobile_link a[href^="tel"],.mobile_link a[href^="sms"]{text-decoration:default;color:#000000 !important;pointer-events:auto;cursor:default;}
    table[class=devicewidth]{width:280px!important;}
    table.devicewidth.social-wrapper{width:280px;}
    table[class=devicewidthinner]{width:260px!important;}
    img[class=banner]{width:280px!important;height:140px!important;}
    img[class=col2img]{width:280px!important;height:140px!important;}
    table.devicewidthinner img{display:block;width:100%;margin-bottom:9px;}
    #navigation{margin:10px 0 -30px;position:relative;z-index:1;font-size:9px;}
  }
  </style>
</head>
<body>
  <table bgcolor="#114281" width="100%" cellpadding="0" cellspacing="0" border="0" id="backgroundTable" class="devicewidth">
    <tr>
      <td align="center">
        <br><br>
        <table width="767" cellpadding="0" cellspacing="0" border="0" id="backgroundTable" class="devicewidth">
          <tr>
            <td>
              <!-- Start of header -->
              <table width="100%" cellpadding="0" cellspacing="0" border="0" id="backgroundTable" st-sortable="header">
                <tbody>
                  <tr>
                    <td>
                      <table width="767" cellpadding="0" cellspacing="0" border="0" align="center" class="devicewidth">
                        <tbody>
                          <tr>
                            <td width="100%" align="right" style="position:relative;">
                              <!-- Social icons -->
                              <cfoutput>
                                <table  border="0" cellpadding="0" cellspacing="0" class="devicewidth social-wrapper">
                                  <tbody>
                                    <tr>
                                      <cfif LEN(settings.facebookURL)>
                                        <td width="40" height="40" align="center">
                                          <div class="imgpop">
                                           <a href="#settings.facebookURL#" target="_blank" class="" target="_blank"><img src="https://www.surfsiderealty.com/eblast/booking-anniversary/facebook.jpg" alt="facebook" border="0" width="40" height="40" style="display:block;border:none;outline:none;text-decoration:none;"></a>
                                          </div>
                                        </td>
                                      </cfif>
                                      <cfif LEN(settings.twitterURL)>
                                        <td width="40" height="40" align="center">
                                          <div class="imgpop">
                                            <a href="#settings.twitterURL#" target="_blank" class="" target="_blank"><img src="https://www.surfsiderealty.com/eblast/booking-anniversary/twitter.jpg" alt="twitter" border="0" width="40" height="40" style="display:block;border:none;outline:none;text-decoration:none;"></a>
                                          </div>
                                        </td>
                                      </cfif>
                                      <cfif LEN(settings.instagramURL)>
                                        <td width="40" height="40" align="center">
                                          <div class="imgpop">
                                            <a href="#settings.instagramURL#" target="_blank" class="" target="_blank"><img src="https://www.surfsiderealty.com/eblast/booking-anniversary/instagram.jpg" alt="instagram" border="0" width="40" height="40" style="display:block;border:none;outline:none;text-decoration:none;"></a>
                                          </div>
                                          </td>
                                        </cfif>
                                      <cfif LEN(settings.youtubeURL)>
                                        <td width="40" height="40" align="center">
                                          <div class="imgpop">
                                            <a href="#settings.youtubeURL#" target="_blank" class="" target="_blank"><img src="https://www.surfsiderealty.com/eblast/booking-anniversary/youtube.jpg" alt="youtube" border="0" width="40" height="40" style="display:block;border:none;outline:none;text-decoration:none;"></a>
                                          </div>
                                        </td>
                                      </cfif>
                                      <cfif LEN(settings.googlePlusURL)>
                                        <td width="43" height="43" align="center">
                                          <div class="imgpop">
                                            <a href="#settings.googlePlusURL#" target="_blank" class="" target="_blank"><img src="http://www.icoastalnet.com/images/social/googleplus.jpg" alt="googleplus" border="0" width="43" height="43" style="display:block;border:none;outline:none;text-decoration:none;margin-right:0;"></a>
                                          </div>
                                        </td>
                                      </cfif>
                                    </tr>
                                  </tbody>
                                </table>
                              </cfoutput>
                              <!-- end of Social icons -->
                              <br>
                              <table cellpadding="0" cellspacing="0" width="100%" border="0" id="navigation">
                                <tr>
                                  <td width="33%" align="center"><a href="https://www.surfsiderealty.com/booking/results.cfm" style="color:#ffffff; font-family: Helvetica,arial,sans-serif;">VACATION RENTALS</a></td>
                                  <td width="33%"></td>
                                  <td width="33%" align="center"><a href="https://www.surfsiderealty.com/south-myrtle-beach-vacation-rental-specials" style="color:#ffffff;font-family: Helvetica,arial,sans-serif;">CURRENT SPECIALS</a></td>
                                </tr>
                              </table>
                              <a href="https://www.surfsiderealty.com/"><img src="https://www.surfsiderealty.com/eblast/booking-anniversary/header.jpg" width="100%" style="margin-bottom:-3px;"></a>
                            </td>
                          </tr>
                        </tbody>
                      </table>
                    </td>
                  </tr>
                </tbody>
              </table>
              <!-- End of Header -->
              <!-- start of Full text -->
              <table width="100%" cellpadding="0" cellspacing="0" border="0" id="backgroundTable" st-sortable="full-text">
                <tbody>
                  <tr>
                    <td>
                      <table width="767" cellpadding="0" cellspacing="0" border="0" align="center" class="devicewidth">
                        <tbody>
                          <tr>
                            <td width="100%">
                              <table bgcolor="#ffffff" width="767" cellpadding="0" cellspacing="0" border="0" align="center" class="devicewidth" style="background:url('https://www.surfsiderealty.com/eblast/booking-anniversary/email-bg.jpg');background-position:top;background-repeat:no-repeat;background-color:#fff;">
                                <tbody>
                                  <!-- Spacing -->
                                  <tr>
                                    <td height="20" style="font-size:1px;line-height:1px;mso-line-height-rule:exactly;">&nbsp;</td>
                                  </tr>
                                  <!-- Spacing -->
                                  <tr>
                                    <td>
                                      <table width="560" align="center" cellpadding="0" cellspacing="0" border="0" class="devicewidthinner">
                                        <tbody>
                                          <tr>
                                            <td style="font-family:Helvetica,arial,sans-serif;font-size:14px;color:#333333;line-height:22px;">