<cfoutput>
<div id="details-room" name="details-room" class="info-wrap details-wrap">
  <div class="info-wrap-heading"><i class="fa fa-list" aria-hidden="true"></i> Rooms</div>
  <div class="info-wrap-body">
  	<!---
  	<cfif GetMore.BedroomMaster1ExistsFlag eq 'Y' or
      GetMore.BedroomFirst1ExistsFlag eq 'Y' or
      GetMore.BedroomSecond1ExistsFlag eq 'Y' or
      GetMore.BedroomThird1ExistsFlag eq 'Y' or
      GetMore.BedroomFourth1ExistsFlag eq 'Y' or
      GetMore.BedroomFifth1ExistsFlag eq 'Y' or
      GetMore.Kitchen1ExistsFlag eq 'Y' or
      GetMore.DiningRoomExistsFlag eq 'Y' or
      GetMore.FamilyRoomExistsFlag eq 'Y' or
      GetMore.Foyer1ExistsFlag eq 'Y'>

      <ul class="details-list">
        <cfif GetMore.BedroomMaster1ExistsFlag eq 'Y'>
        	<li>
  					<strong>Master Bedroom:</strong>
            <cfif LEN(GetMore.BedroomMaster1Length) and LEN(GetMore.BedroomMaster1Width)><span>#GetMore.BedroomMaster1Length#' &times; #GetMore.BedroomMaster1Width#',</span></cfif>
            <cfif LEN(GetMore.BedroomMaster1Level)><span>#GetMore.BedroomMaster1Level# Level,</span></cfif>
            <cfif LEN(GetMore.BedroomMaster1Flooring)><span>Flooring: #GetMore.BedroomMaster1Flooring#</span></cfif>
            <cfif LEN(GetMore.BedroomMaster1FirePlType)><span>Fireplace: #GetMore.BedroomMaster1FirePlType#</span></cfif>
        	</li>
  			</cfif>

        <cfif GetMore.BedroomFirst1ExistsFlag eq 'Y'>
          <li>
            <strong>Bedroom 1:</strong>
            <cfif LEN(GetMore.BedroomFirst1Length) and LEN(GetMore.BedroomFirst1Width)><span>#GetMore.BedroomFirst1Length#' x #GetMore.BedroomFirst1Width#',</span></cfif>
            <cfif LEN(GetMore.BedroomFirst1Level)><span>#GetMore.BedroomFirst1Level# Level,</span></cfif>
            <cfif LEN(GetMore.BedroomFirst1Flooring)><span>Flooring: #GetMore.BedroomFirst1Flooring#</span></cfif>
            <cfif LEN(GetMore.BedroomFirst1FirePlType)><span>Fireplace: #GetMore.BedroomFirst1FirePlType#</span></cfif>
          </li>
        </cfif>

        <cfif GetMore.BedroomSecond1ExistsFlag eq 'Y'>
          <li>
            <strong>Bedroom 2:</strong>
            <cfif LEN(GetMore.BedroomSecond1Length) and LEN(GetMore.BedroomSecond1Width)><span>#GetMore.BedroomSecond1Length#' x #GetMore.BedroomSecond1Width#',</span></cfif>
            <cfif LEN(GetMore.BedroomSecond1Level)><span>#GetMore.BedroomSecond1Level# Level,</span></cfif>
            <cfif LEN(GetMore.BedroomSecond1Flooring)><span>Flooring: #GetMore.BedroomSecond1Flooring#</span></cfif>
            <cfif LEN(GetMore.BedroomFirst1FirePlType)><span>Fireplace: #GetMore.BedroomFirst1FirePlType#</span></cfif>
          </li>
        </cfif>

        <cfif GetMore.BedroomThird1ExistsFlag eq 'Y'>
          <li>
            <strong>Bedroom 3:</strong>
            <cfif LEN(GetMore.BedroomThird1Length) and LEN(GetMore.BedroomThird1Width)><span>#GetMore.BedroomThird1Length#' x #GetMore.BedroomThird1Width#',</span></cfif>
            <cfif LEN(GetMore.BedroomThird1Level)><span>#GetMore.BedroomThird1Level# Level,</span></cfif>
            <cfif LEN(GetMore.BedroomThird1Flooring)><span>Flooring: #GetMore.BedroomThird1Flooring#</span></cfif>
            <cfif LEN(GetMore.BedroomThird1FirePlType)><span>Fireplace: #GetMore.BedroomThird1FirePlType#</span></cfif>
          </li>
        </cfif>

        <cfif GetMore.BedroomFourth1ExistsFlag eq 'Y'>
          <li>
            <strong>Bedroom 4:</strong>
            <cfif LEN(GetMore.BedroomFourth1Length) and LEN(GetMore.BedroomFourth1Width)><span>#GetMore.BedroomFourth1Length#' x #GetMore.BedroomFourth1Width#',</span></cfif>
            <cfif LEN(GetMore.BedroomFourth1Level)><span>#GetMore.BedroomFourth1Level# Level,</span></cfif>
            <cfif LEN(GetMore.BedroomFourth1Flooring)><span>Flooring: #GetMore.BedroomFourth1Flooring#</span></cfif>
            <cfif LEN(GetMore.BedroomFourth1FirePlType)><span>Fireplace: #GetMore.BedroomFourth1FirePlType#</span></cfif>
          </li>
        </cfif>

        <cfif GetMore.BedroomFifth1ExistsFlag eq 'Y'>
          <li>
            <strong>Bedroom 5:</strong>
            <cfif LEN(GetMore.BedroomFifth1Length) and LEN(GetMore.BedroomFifth1Width)><span>#GetMore.BedroomFifth1Length#' x #GetMore.BedroomFifth1Width#',</span></cfif>
            <cfif LEN(GetMore.BedroomFifth1Level)><span>#GetMore.BedroomFifth1Level# Level,</span></cfif>
            <cfif LEN(GetMore.BedroomFifth1Flooring)><span>Flooring: #GetMore.BedroomFifth1Flooring#</span></cfif>
            <cfif LEN(GetMore.BedroomFifth1FirePlType)><span>Fireplace: #GetMore.BedroomFifth1FirePlType#</span></cfif>
          </li>
        </cfif>

        <cfif GetMore.Kitchen1ExistsFlag eq 'Y'>
          <li>
            <strong>Kitchen:</strong>
            <cfif LEN(GetMore.Kitchen1Length) and LEN(GetMore.Kitchen1Width)><span>#GetMore.Kitchen1Length#' x #GetMore.Kitchen1Width#',</span></cfif>
            <cfif LEN(GetMore.Kitchen1Level)><span>#GetMore.Kitchen1Level# Level,</span></cfif>
            <cfif LEN(GetMore.Kitchen1Flooring)><span>Flooring: #GetMore.Kitchen1Flooring#</span></cfif>
            <cfif LEN(GetMore.Kitchen1FirePlType)><span>Fireplace: #GetMore.Kitchen1FirePlType#</span></cfif>
          </li>
        </cfif>

        <cfif GetMore.DiningRoomExistsFlag eq 'Y'>
          <li>
            <strong>Dining Room:</strong>
            <cfif LEN(GetMore.DiningRoomLength) and LEN(GetMore.DiningRoomWidth)><span>#GetMore.DiningRoomLength#' x #GetMore.DiningRoomWidth#',</span></cfif>
            <cfif LEN(GetMore.DiningRoom1Level)><span>#GetMore.DiningRoom1Level# Level,</span></cfif>
            <cfif LEN(GetMore.DiningRoom1Flooring)><span>Flooring: #GetMore.DiningRoom1Flooring#</span></cfif>
            <cfif LEN(GetMore.DiningRoom1FirePlType)><span>Fireplace: #GetMore.DiningRoom1FirePlType#</span></cfif>
          </li>
        </cfif>

        <cfif GetMore.FamilyRoomExistsFlag eq 'Y'>
          <li>
            <strong>Family Room:</strong>
            <cfif LEN(GetMore.FamilyRoomLength) and LEN(GetMore.FamilyRoomWidth)><span>#GetMore.FamilyRoomLength#' x #GetMore.FamilyRoomWidth#',</span></cfif>
            <cfif LEN(GetMore.FamilyRm1Level)><span>#GetMore.FamilyRm1Level# Level,</span></cfif>
            <cfif LEN(GetMore.FamilyRm1Flooring)><span>Flooring: #GetMore.FamilyRm1Flooring#</span></cfif>
            <cfif LEN(GetMore.FamilyRm1FirePlType)><span>Fireplace: #GetMore.FamilyRm1FirePlType#</span></cfif>
          </li>
        </cfif>

        <cfif GetMore.Foyer1ExistsFlag eq 'Y'>
          <li>
            <strong>Foyer:</strong>
            <cfif LEN(GetMore.Foyer1Length) and LEN(GetMore.Foyer1Width)><span>#GetMore.Foyer1Length#' x #GetMore.Foyer1Width#',</span></cfif>
            <cfif LEN(GetMore.Foyer1Level)><span>#GetMore.Foyer1Level# Level,</span></cfif>
            <cfif LEN(GetMore.Foyer1Flooring)><span>Flooring: #GetMore.Foyer1Flooring#</span></cfif>
            <cfif LEN(GetMore.Foyer1FirePlType)><span>Fireplace: #GetMore.Foyer1FirePlType#</span></cfif>
          </li>
        </cfif>
      </ul>
  	</cfif> --->
  </div><!-- END info-wrap-body -->
</div><!-- END details-wrap -->
</cfoutput>