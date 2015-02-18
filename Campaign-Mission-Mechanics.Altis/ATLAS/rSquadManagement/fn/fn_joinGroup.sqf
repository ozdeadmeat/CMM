//Hywel
//Aug. 2014
if((_this >= 0) && (_this < count ATLAS_squadManagement_groupList)) then 
{
	_groupToJoin = ((ATLAS_squadManagement_groupList select _this) select 0);
	_groupParams = (_groupToJoin call ATLAS_fnc_SquadManagement_checkGroup); //check if group is real/unlocked etc
	if (isNil "_groupParams") exitWith {}; //group does not exist
	if((_groupParams select 1) == 0) then 
	{//group is unlocked
		[player] join _groupToJoin;
		[] call ATLAS_fnc_SquadManagement_refreshGroupGUI;

		ATLAS_squadManagementNetMessage = [player,_groupToJoin,"join",player];
		publicVariableServer "ATLAS_squadManagementNetMessage";
		if(isServer) then
		{
			ATLAS_squadManagementNetMessage call ATLAS_fnc_SquadManagement_forwardNetMessage;
		};
		
	};
};