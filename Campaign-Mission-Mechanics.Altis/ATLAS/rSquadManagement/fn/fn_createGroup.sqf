//Hywel
//Aug. 2014

if(leader group player == player) then
{
	 group player setVariable ["ATLAS_squadManagement_realGroup",true, true ];
	 if(ctrlText 1400 != "") then //user entered custom group name (its probably incredibly stupid)
	 {
		(group player) setGroupID [ctrlText 1400];
		ATLAS_squadManagement_groupNameChange = [(group player),ctrlText 1400];
		publicVariable "ATLAS_squadManagement_groupNameChange";
	 };
(Group player) setVariable ["ATLAS_squadManagement_lockState",0,true]; //set group to unlocked by default
[] call ATLAS_fnc_SquadManagement_refreshGroupGUI;

	 
	 
	 
	 
};
