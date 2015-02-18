
if(leader group player == player) then
{
	ATLAS_squadManagementNetMessage = [player,(group player),"lock",(lbCurSel 2100)];
	publicVariableServer "ATLAS_squadManagementNetMessage";
	if(isServer) then
	{
		ATLAS_squadManagementNetMessage call ATLAS_fnc_SquadManagement_forwardNetMessage;
	};
	
	(Group player) setVariable ["ATLAS_squadManagement_lockState",(lbCurSel 2100),true]; //lock or unlock group
	[] call ATLAS_fnc_SquadManagement_refreshGroupGUI;
};
