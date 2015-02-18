//Hywel
//Aug. 2014

if((_this >= 0) && (_this < count ATLAS_squadManagement_groupMemberList)) then //a unit is selected
{
	_playerToKick = (ATLAS_squadManagement_groupMemberList select _this);
	if(leader group _playerToKick == player) then //player has authority to kick
	{
		ATLAS_squadManagementNetMessage = [player,(group player),"kick",_playerToKick];
		publicVariableServer "ATLAS_squadManagementNetMessage";
		if(isServer) then
		{
			ATLAS_squadManagementNetMessage call ATLAS_fnc_SquadManagement_forwardNetMessage;
		};
		
		
		
		[_playerToKick] join grpNull; //bye bye
		[] call ATLAS_fnc_SquadManagement_refreshGroupGUI;
	};
};