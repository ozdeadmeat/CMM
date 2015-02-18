//Hywel
//Aug. 2014

lbClear 1500;
ATLAS_squadManagement_groupMemberList = [];
_selectedGroup = grpNull;

if((group player) getVariable ["ATLAS_squadManagement_realGroup",false ]) then  //player is in a group
	{
		_selectedGroup = group player;
		ctrlSetText [1000,(groupID _selectedGroup)]; //show group name (above group members)
	} 
	else 
	{
		if(((lbCurSel 1501) >= 0) && ((lbCurSel 1501) < count ATLAS_squadManagement_groupList)) then //player has highlighted a group in the listbox
		{
			_selectedGroup = ((ATLAS_squadManagement_groupList select (lbCurSel 1501)) select 0);
			ctrlSetText [1000,(groupID _selectedGroup)]; //show group name (above group members)
			
		};
	};

{ //add units in selected group to listbox
	ATLAS_squadManagement_groupMemberList set [count ATLAS_squadManagement_groupMemberList, _x];
	lbAdd [1500, (name _x)]; 
	lbSetValue [1500, _forEachindex, _forEachindex ];
	
	_iconName = (getText(configfile >> "CfgVehicles" >> (typeOf _x) >> "icon"));
	lbSetPicture [1500, _forEachindex, (getText(configfile >> "CfgVehicleIcons" >> _iconName))]; 
	//player sideChat (getText (configfile >> "CfgVehicles" >> (typeOf _x) >> "picture"));
} forEach (units _selectedGroup);	