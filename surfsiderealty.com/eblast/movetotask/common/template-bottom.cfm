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
            <table width="100%" class="footer" cellpadding="0" cellspacing="0" border="0" id="backgroundTable" st-sortable="postfooter" >
              <tbody>
                <tr>
                  <td align="center">
                    <br>
                    <table width="767" cellpadding="0" cellspacing="0" border="0" class="devicewidth">
                      <tr>
                        <td valign="top" width="5%">
                          <img src="https://www.surfsiderealty.com/eblast/booking-anniversary/map-icon.png" alt="address">
                        </td>
                        <td width="30%" valign="top">
                          <cfif LEN(settings.company)>
                            <cfoutput>
                              <p style="margin:0;font-family:Helvetica,arial,sans-serif;font-size:14px;color:##ffffff;">#settings.company#</p>
                            </cfoutput>
                          </cfif>
                          <cfif LEN(settings.address)>
                            <cfoutput>
                              <p style="margin:0;font-family:Helvetica,arial,sans-serif;font-size:14px;color:##ffffff;padding:0 0 5px 0;">#settings.address# <br /> #settings.city#,#settings.state# #settings.zip#</p>
                            </cfoutput>
                          </cfif>
                        </td>
                        <td width="35%" valign="top">
                          <table width="100%" cellpadding="0" cellspacing="0" border="0">
                            <tbody>
                              <cfif LEN(settings.tollFree)>
                                <tr>
                                  <td valign="top">
                                    <img src="https://www.surfsiderealty.com/eblast/booking-anniversary/phone-icon.png" alt="phone">
                                  </td>
                                  <td valign="top" style="font-family:Helvetica,arial,sans-serif;font-size:14px;color:#ffffff" st-content="menu">
                                    Toll Free: 800-833-8231<br>
                                    Local: 843-222-6656<br>
                                  </td>
                                </tr>
                              </cfif>
                            </tbody>
                          </table>
                        </td>
                        <td width="30%" valign="top">
                          <table width="100%" cellpadding="0" cellspacing="0" border="0">
                            <tbody>
                              <tr>
                                <td valign="top">
                                  <img src="https://www.surfsiderealty.com/eblast/booking-anniversary/mail-icon.png" alt="email">
                                </td>
                                <td valign="top" align="center" style="font-family:Helvetica,arial,sans-serif;" st-content="menu">
                                  <a href="mailto:https://www.surfsiderealty.com/contact-surfside-realty.cfm" style="color: #fff; font-size:14px;">Click Here to Email Us Directly</a>
                                </td>
                              </tr>
                            </tbody>
                          </table>
                        </td>
                      </tr>
                      <tr>
                        <td width="100%" valign="top" colspan="4">
                          <center style="color: #fff; font-size: 14px; margin-top:40px;">
                            &copy; 2019 Surfside Realty Company. All Rights Reserved. Website Design by InterCoastal Net Designs
                          </center>
                        </td>
                      </tr>
                    </table>
                    <br>
                  </td>
                </tr>
              </tbody>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <!-- Spacing -->
  <tr>
    <td height="20" style="font-size:1px;line-height:1px;mso-line-height-rule:exactly;">&nbsp;</td>
  </tr>
  <!-- Spacing -->
</table>
</body>
</html>