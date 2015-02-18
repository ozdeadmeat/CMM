//Hywel
//Aug. 2014

ATLAS_squadManagementNetMessage = [player,(group player),"leave",player];
publicVariableServer "ATLAS_squadManagementNetMessage";
if(isServer) then
{
	ATLAS_squadManagementNetMessage call ATLAS_fnc_SquadManagement_forwardNetMessage;
};

[player] join grpNull; //All by myself
[] call ATLAS_fnc_SquadManagement_refreshGroupGUI;


