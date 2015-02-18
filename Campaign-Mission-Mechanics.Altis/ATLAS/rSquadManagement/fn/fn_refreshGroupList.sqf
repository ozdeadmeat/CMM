//Hywel
//Aug. 2014

lbClear 1501;
ATLAS_squadManagement_groupList = [];
{
	_v = (_x call ATLAS_fnc_SquadManagement_checkGroup); //check if group is defined as a player created group and is on players side
	if !(isNil "_v") then 
	{
	
	
		_locked = "(locked)";
		if((_v select 1) == 0) then //group is unlocked
		{
			_locked = "";
		};
		_text = format ["%1 (%2) %3",(groupID (_v select 0)),(count units (_v select 0)),_locked];
		lbAdd [1501, _text]; //add group to listbox
		lbSetValue [1501, _forEachindex, _forEachindex ]; 
		ATLAS_squadManagement_groupList set [ count ATLAS_squadManagement_groupList,_v]; //add group to array
		
		
	};
} forEach allGroups;

//hint str ATLAS_squadManagement_groupList;