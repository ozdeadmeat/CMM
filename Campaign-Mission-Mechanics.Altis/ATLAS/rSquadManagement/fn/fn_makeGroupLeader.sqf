//Hywel
//Aug. 2014

if((_this >= 0) && (_this < count ATLAS_squadManagement_groupMemberList)) then //a unit has been selected from list
{
	_playerToPromote = (ATLAS_squadManagement_groupMemberList select _this);
	if(leader group _playerToPromote == player) then //player has the authority to promote
	{
	
	
	
		ATLAS_squadManagementNetMessage = [player,(group player),"newLeader",_playerToPromote];
		publicVariableServer "ATLAS_squadManagementNetMessage";
		if(isServer) then
		{
			ATLAS_squadManagementNetMessage call ATLAS_fnc_SquadManagement_forwardNetMessage;
		};
		(group player) selectLeader _playerToPromote; //raise him from the ranks
		[] call ATLAS_fnc_SquadManagement_refreshGroupGUI;
	};
};