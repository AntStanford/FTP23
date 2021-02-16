                              </td>
                            </tr>
                            <!-- spacing -->
                            <tr>
                              <td width="100%" height="15" style="font-size:1px;line-height:1px;mso-line-height-rule:exactly;">&nbsp;</td>
                            </tr>
                            <!-- End of spacing -->
                            <!-- Spacing -->
                            <tr>
                              <td width="100%" height="15" style="font-size:1px;line-height:1px;mso-line-height-rule:exactly;">&nbsp;</td>
                            </tr>
                            <!-- Spacing -->
                          </tbody>
                        </table>
                      </td>
                    </tr>
                    <!-- Spacing -->
                    <tr>
                      <td height="20" style="font-size:1px;line-height:1px;mso-line-height-rule:exactly;">&nbsp;</td>
                    </tr>
                    <!-- Spacing -->
                  </tbody>
                </table>
              </td>
            </tr>
          </tbody>
        </table>
      </td>
    </tr>
  </tbody>
</table>
<!-- End of Full Text -->
<!-- Start of footer -->
<table width="100%" class="footer" bgcolor="#06407c" cellpadding="0" cellspacing="0" border="0" id="backgroundTable" st-sortable="postfooter" >
  <tbody>
    <tr>
      <td>
        <table width="600" cellpadding="0" cellspacing="0" border="0" align="center" class="devicewidth">
          <tbody>
            <!-- Spacing -->
            <tr>
              <td width="100%" height="5"></td>
            </tr>
            <!-- Spacing -->
            <cfif LEN(settings.company)>
              <tr width="600">
                <td height="30" align="center" valign="middle" style="font-family:Helvetica,arial,sans-serif;font-size:16px;font-weight:bold;color:#b8b8b8" st-content="menu">
                  <cfoutput>
                    <p style="color:##ffffff !important;">#settings.company#</p>
                  </cfoutput>
                </td>
              </tr>
            </cfif>
            <cfif LEN(settings.address)>
              <tr width="600">
                <td align="center" valign="middle" style="font-family:Helvetica,arial,sans-serif;font-size:13px;color:#b8b8b8" st-content="menu">
                  <cfoutput>
                    <p style="padding:0 0 5px 0;color:##ffffff !important;line-height:20px;">#settings.address# <br /> #settings.city#,#settings.state# #settings.zip#</p>
                  </cfoutput>
                </td>
              </tr>
            </cfif>
            <cfif LEN(settings.tollFree)>
              <tr width="600">
                <td align="center" valign="middle" style="font-family:Helvetica,arial,sans-serif;font-size:13px;color:#b8b8b8" st-content="menu">
                  <cfoutput>
                    <p style="padding:0;"><a hreflang="en" href="tel:#settings.company#" style="color:##ffffff !important;">#settings.tollFree#</a></p>
                  </cfoutput>
                </td>
              </tr>
            </cfif>
            <!-- Spacing -->
            <tr>
              <td width="100%" height="10"></td>
            </tr>
            <!-- Spacing -->
          </tbody>
        </table>
      </td>
    </tr>
  </tbody>
</table>
<table width="100%" bgcolor="#06407c" cellpadding="0" cellspacing="0" border="0" id="backgroundTable" st-sortable="footer">
  <tbody>
    <tr>
      <td>
        <table width="600" cellpadding="0" cellspacing="0" border="0" align="center" class="devicewidth">
          <tbody>
            <tr>
              <td width="100%">
                <table width="600" cellpadding="0" cellspacing="0" border="0" align="center" class="devicewidth">
                <tbody>
                  <!-- Spacing -->
                  <tr>
                    <td>
                      <cfoutput>
                        <!-- Social icons -->
                        <table  width="150" align="center" border="0" cellpadding="0" cellspacing="0" class="devicewidth social-wrapper">
                          <tbody>
                            <tr>
                              <cfif LEN(settings.facebookURL)>
                                <td width="43" height="43" align="center">
                                  <div class="imgpop">
                                   <a href="#settings.facebookURL#" hreflang="en" class="" target="_blank"><img src="http://www.icoastalnet.com/images/social/facebook.jpg" alt="facebook" border="0" width="43" height="43" style="display:block;border:none;outline:none;text-decoration:none;"></a>
                                  </div>
                                </td>
                              </cfif>
                              <cfif LEN(settings.twitterURL)>
                                <td width="43" height="43" align="center">
                                  <div class="imgpop">
                                    <a href="#settings.twitterURL#" hreflang="en" class="" target="_blank"><img src="http://www.icoastalnet.com/images/social/twitter.jpg" alt="twitter" border="0" width="43" height="43" style="display:block;border:none;outline:none;text-decoration:none;"></a>
                                  </div>
                                </td>
                              </cfif>
                              <cfif LEN(settings.pinterestURL)>
                                <td width="43" height="43" align="center">
                                  <div class="imgpop">
                                    <a href="#settings.pinterestURL#" hreflang="en" class="" target="_blank"><img src="http://www.icoastalnet.com/images/social/pinterest.jpg" alt="pinterest" border="0" width="43" height="43" style="display:block;border:none;outline:none;text-decoration:none;"></a>
                                  </div>
                                  </td>
                                </cfif>
                                <cfif LEN(settings.youtubeURL)>
                                  <td width="43" height="43" align="center">
                                    <div class="imgpop">
                                      <a href="#settings.youtubeURL#" hreflang="en" class="" target="_blank"><img src="http://www.icoastalnet.com/images/social/youtube.jpg" alt="youtube" border="0" width="43" height="43" style="display:block;border:none;outline:none;text-decoration:none;"></a>
                                    </div>
                                  </td>
                                </cfif>
                                <cfif LEN(settings.googlePlusURL)>
                                  <td width="43" height="43" align="center">
                                    <div class="imgpop">
                                      <a href="#settings.googlePlusURL#" hreflang="en" class="" target="_blank"><img src="http://www.icoastalnet.com/images/social/googleplus.jpg" alt="googleplus" border="0" width="43" height="43" style="display:block;border:none;outline:none;text-decoration:none;"></a>
                                    </div>
                                  </td>
                                </cfif>
                              </tr>
                            </tbody>
                          </table>
                        </cfoutput>
                        <!-- end of Social icons -->
                      </td>
                    </tr>
                    <!-- Spacing -->
                    <tr>
                      <td height="10" style="font-size:1px;line-height:1px;mso-line-height-rule:exactly;">&nbsp;</td>
                    </tr>
                    <!-- Spacing -->
                  </tbody>
                </table>
              </td>
            </tr>
          </tbody>
        </table>
      </td>
    </tr>
  </tbody>
</table>
</body>
</html>