//Hywel
//Aug. 2014

if((group player) getVariable ["ATLAS_squadManagement_realGroup",false ]) then //player is in a group
	{

		ctrlShow [1501, false]; //hide group list
		ctrlShow [1600, false]; //hide join group button
		ctrlShow [1602, false]; //hide create group button
		ctrlShow [1400, false]; //hide create group name entry box
		ctrlShow [1603, true];  //show leave group button
		
		
		ctrlSetText [1000,(groupID (group player))];
		
		if(leader group player == player) then //player is leader of group
		{
			disableSerialization; 
			ctrlShow [1604, true]; //show kick button
			ctrlShow [1605, true]; //show make group leader button
			ctrlShow [2100, true]; //show lock group combobox
			lbClear 2100;
			{lbAdd [2100, _x];} forEach [localize "STR_ATLAS_UnLocked",localize "STR_ATLAS_Locked"];		//Modified by OzDM
			//{lbAdd [2100, _x];} forEach [localize "STR_ATLAS_Locked",localize "STR_ATLAS_UnLocked"];		//ORIGINAL

			
			_comboctrlname = ((findDisplay 7230) displayCtrl 2100);
			_comboctrlname ctrlSetEventHandler ["LBSelChanged", ""]; //to prevent stack overflow from next line
			//I fantasize about travelling back in time to when I was 8 and raping myself
			lbSetCurSel [2100, ((group player) getVariable ["ATLAS_squadManagement_lockState",0])]; //select the selected option
			_comboctrlname ctrlSetEventHandler ["LBSelChanged", "[] call ATLAS_fnc_SquadManagement_lockGroup"]; //re-add the eventhandler
			
			
			
			
		}
		else
		{ // player is not group leader
			ctrlShow [1604, false]; //hide kick button
			ctrlShow [1605, false]; //hide make group leader button
			ctrlShow [2100, false]; //hide lock group combobox
		};
		
	}
	else 
	{ //player is not in a group

		ctrlShow [1501, true];  //show group list
		ctrlShow [1600, true];  //show join group button
		ctrlShow [1602, true];  //show create group button
		ctrlShow [1400, true];  //show create group name entry box
		ctrlShow [1603, false]; //hide leave group button
		ctrlShow [1604, false]; //hide kick button
		ctrlShow [1605, false]; //hide make group leader button
		ctrlShow [2100, false]; //hide lock group combobox
		[] spawn ATLAS_fnc_SquadManagement_refreshGroupList; //populate group list
	
	};




[] spawn ATLAS_fnc_SquadManagement_refreshGroupMembers;