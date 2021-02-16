<div id="recent-cleans" name="recent-cleans" class="info-wrap recent-cleans-wrap">
  <div class="info-wrap-heading"><i class="fa fa-list" aria-hidden="true"></i> Recent Cleans</div>
  <div class="info-wrap-body">
   <div class="table-wrap">
  		<table class="table rates-table">
  			<tbody><tr>
  				<th>Cleaning</th>
  				<th>Description</th>			
           </tr>
  			<cfoutput query="cleanings">
  			<tr>
          <td>#dateformat(finished_at, 'mm/dd/yyyy')# - 

            <cfif LEN(assignees)>

              <cfset assignListCnt = 1>
              <cfset assignSecondtoLast = ListLen(assignees) - 1>
              <cfloop list="#assignees#" index="i">
              #i#<cfif listlen(assignees) gt 1><cfif assignListCnt lt assignSecondtoLast>,<cfelseif assignListCnt eq assignSecondtoLast> and </cfif></cfif>
              <cfset assignListCnt = assignListCnt + 1>
              </cfloop>

            <cfelse>

              Housekeeper

            </cfif>

          finished cleaning this property at #timeformat(finished_at, 'hh:mm tt')#.
          </td>
  				<td>#title#</td>
  			</tr>
  			</cfoutput>
  		</tbody>
  	</table>
  </div>
  </div><!-- END info-wrap-body -->
</div><!-- END recent-cleans-wrap -->