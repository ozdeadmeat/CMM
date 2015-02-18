//v1.2
//Hywel
//Aug. 2014
_autoGroup = false; //make player's group show by default?




if(hasInterface) then 
{
	ATLASInput_canOpenGroupMenu = true;
	ATLAS_squadManagement_groupList = [];
	if(_autoGroup) then {(group player) setvariable ["ATLAS_squadManagement_realGroup",true,true];};
	//player addAction[localize "STR_ATLAS_SquadManager", {createDialog "rGUI_squadGUI"}];
	player addAction[localize "STR_ATLAS_SquadManager",{createDialog "rGUI_squadGUI"},[],0,false];
	[] spawn 
	{
		sleep 1;
		ATLAS_squadManagement_UIEventhandler = (findDisplay 46) displayAddEventHandler ["KeyDown", 
		{
			if((_this select 1) == 22) then 
			{
				
				if(isNull(findDisplay 7230)) then 
				{
					createDialog "rGUI_squadGUI"
				} else
				{
					(findDisplay 7230) closeDisplay 2;
				};
			};

		}];
		
	};
	"ATLAS_squadManagementNetMessage" addPublicVariableEventHandler {(_this select 1) call ATLAS_fnc_SquadManagement_receiveNetMessage;};
};


if(isServer) then 
{
	"ATLAS_squadManagementNetMessage" addPublicVariableEventHandler {(_this select 1) call ATLAS_fnc_SquadManagement_forwardNetMessage;};
};


"ATLAS_squadManagement_groupNameChange" addPublicVariableEventHandler {_params = (_this select 1); (_params select 0) setGroupID [(_params select 1)]};

