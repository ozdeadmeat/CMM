//--------------------DO NOT EDIT BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING!!--------------------\\
iniDB_Check_Array = {
//_Usage = [DBiD,DBSection,DBEntry] call iniDB_Check_Array;
	private["_read","_check"];
	_check = FALSE;
	_read = [_this select 0, _this select 1, _this select 2,"ARRAY"] call iniDB_read;
	If (count _read != 0) then {_check = TRUE;};
_check
};
iniDB_Check_String = {
//_Usage = [DBiD,DBSection,DBEntry] call iniDB_Check_String;
	private["_read","_check"];
	_check = FALSE;
	_read = [_this select 0, _this select 1, _this select 2,"STRING"] call iniDB_read;
	If (_read != "") then {_check = TRUE;};
_check
};
iniDB_CreatePlayerPD = {
//	[player,"",getPlayerUID player, name player] call iniDB_CreatePlayerPD
private ["_Player_Index","_check","_uid","_name","_clientID","_player","_written"];
	_player = _this select 0;
	_clientID = _this select 1;
	_uid = _this select 2;
	_name = _this select 3;
	_Player_Index = [];
	_check = [PlayerDBName,"INDEX","PlayerIndex"] call iniDB_Check_Array;
	If(_check) then {
		_Player_Index = ([PlayerDBName,"INDEX","PlayerIndex","ARRAY"] call iniDB_read);
		_Player_Index = _Player_Index + [_uid];
		_written = [PlayerDBName,"INDEX","PlayerIndex",_Player_Index] call iniDB_write;
	} Else {
		_Player_Index = [_uid];
		_written = [PlayerDBName,"INDEX","PlayerIndex",_Player_Index] call iniDB_write;
	};
	removeAllWeapons _player; 
	removeGoggles _player; 
	removeVest _player;
	removeBackpack _player; 
	removeAllAssignedItems _player; 
	removeHeadgear _player;
	[_player, _clientID, _uid, _name] call iniDB_SavePlayerPD;
};
iniDB_SavePlayerPD = {
// Testing [player,"",getPlayerUID player, name player] call iniDB_SavePlayerPD
private ["_player",
		"_clientID",
		"_uid",
		"_name",
		"_dir",
		"_anim",
		"_posASL",
		"_dmg",
		"_headgear",
		"_goggles",
		"_uniform",
		"_uniformITEMS",
		"_vest",
		"_vestITEMS",
		"_backpack",
		"_backpackITEMS",
		"_priW",
		"_priWitems",
		"_priWmag",
		"_secW",
		"_secWitems",
		"_secWmag",
		"_hgW",
		"_hgWitems",
		"_hgWmag",
		"_assignedItems",
		"_playerLoc",
		"_attire",
		"_weapons",
		"_weaponsITEMS",
		"_weaponsMAGS",
		"_inventory",
		"_written",
		"_check"
		];		
_player = _this select 0;
_clientID = _this select 1;
_uid = _this select 2;
_name = _this select 3;
_dir = getDir _player;
_anim = animationState _player;
_posASL = getPosASL _player;
_dmg = getDammage _player;
_headgear = headgear _player;
_goggles = goggles _player;
_uniform = uniform _player;
_uniformITEMS= uniformItems _player;
_vest = vest _player;
_vestITEMS = vestItems _player;
_backpack = backpack _player;
_backpackITEMS = backpackItems _player;
_priW = ([primaryWeapon _player] call BIS_fnc_baseWeapon);
_priWitems = primaryWeaponItems _player;
_priWmag = primaryWeaponMagazine _player;
_secW = ([secondaryWeapon _player] call BIS_fnc_baseWeapon);
_secWitems = secondaryWeaponItems _player;
_secWmag = secondaryWeaponMagazine _player;
_hgW = ([handgunWeapon _player] call BIS_fnc_baseWeapon);
_hgWitems = handgunItems _player;
_hgWmag = handgunMagazine _player;
_assignedItems = assignedItems _player;
_playerLoc =	[_posASL, _dir];
_attire = 		[_headgear, _goggles, _uniform, _vest, _backpack];
_weapons = 		[_priW,_secW,_hgW];
_weaponsITEMS = [_priWitems, _secWitems, _hgWitems];
_weaponsMAGS = 	[_priWmag, _secWmag, _hgWmag];
_inventory =	[_uniformITEMS, _vestITEMS, _backpackITEMS, _assignedItems];
_written = [PlayerDBName, _uid, "Name",_name] call iniDB_write;
_written = [PlayerDBName, _uid, "UID",_uid] call iniDB_write;
_check = ([PlayerDBName,_UID,"SCORE"] call iniDB_Check_Array);
// Score Data = [Previous Score Total, Missions Attended, Successful Missions]
if !(_check) then {_written = [PlayerDBName, _uid, "SCORE",[0,0,0]] call iniDB_write};
_written = [PlayerDBName, _uid, "PLAYERLOC",_playerLoc] call iniDB_write;
_written = [PlayerDBName, _uid, "ATTIRE",_attire] call iniDB_write;
_written = [PlayerDBName, _uid, "WEAPONS",_weapons] call iniDB_write;
_written = [PlayerDBName, _uid, "WEAPONS_ITEMS",_weaponsITEMS] call iniDB_write;
_written = [PlayerDBName, _uid, "WEAPONS_MAGS",_weaponsMAGS] call iniDB_write;
_written = [PlayerDBName, _uid, "INVENTORY",_inventory] call iniDB_write;
//diag_log format ["Player %1 data written to DataBase", _name];
};
iniDB_DCPlayerPD = {
private ["_player",
		"_clientID",
		"_uid",
		"_name",
		"_Array"
		];
_player = _this select 0;
_clientID = _this select 1;
_uid = _this select 2;
_name = _this select 3;
If(SPECIAL_SLOT find (vehicleVarName _player) == -1) then {
_this spawn iniDB_SavePlayerPD;
};
sleep 10;
_Array = (nearestObjects [_player,[],2.5]);
{If(_x isKindOf "WeaponHolderSimulated") then {deletevehicle _x}} foreach _Array;
deletevehicle _player;
};
iniDB_SendPlayerPD = {
private ["_player",
		"_clientID",
		"_uid",
		"_name",
		"_dir",
		"_pos",
		"_health",
		"_goggles",
		"_uniform",
		"_uniformITEMS",
		"_vest",
		"_vestITEMS",
		"_backpack",
		"_backpackITEMS",
		"_priW",
		"_priWitems",
		"_priWmag",
		"_secW",
		"_secWitems",
		"_secWmag",
		"_hgW",
		"_hgWitems",
		"_hgWmag",
		"_assignedItems",
		"_check",
		"_playerLOC",
		"_attire",
		"_weaponsMAGS",
		"_weapons",
		"_weaponsITEMS",
		"_inventory",
		"_VARname",
		"_score"
		];
_player = _this select 0;
_clientID = _this select 1;
_uid = _this select 2;
_name = _this select 3;
_check = ([PlayerDBName,_uid,"UID"] call iniDB_Check_String);
	If (_check) then {
	diag_log format ["SendPlayer Arguments Recieved are : %1",_this];
		CMM_SystemChat = "Server Profile found. Loading";
		["CMM_SystemChat","client",_clientID] call BME_fnc_publicvariable;
		_attire = ([PlayerDBName,_uid,"ATTIRE","ARRAY"] call iniDB_read);
		sleep 0.1;
		CMM_PlayerUniform = _attire;
		["CMM_PlayerUniform","client",_clientID] call BME_fnc_publicvariable;
		//diag_log CMM_PlayerUniform;
		_weaponsMAGS = ([PlayerDBName,_uid,"WEAPONS_MAGS","ARRAY"] call iniDB_read);
		sleep 0.1;
		CMM_PlayerWeapons_MAGS = _weaponsMAGS;
		["CMM_PlayerWeapons_MAGS","client",_clientID] call BME_fnc_publicvariable;
		//diag_log CMM_PlayerWeapons_MAGS;
		_weapons = ([PlayerDBName,_uid,"WEAPONS","ARRAY"] call iniDB_read);
		sleep 0.1;
		CMM_PlayerWeapons = _weapons;
		["CMM_PlayerWeapons","client",_clientID] call BME_fnc_publicvariable;
		//diag_log CMM_PlayerWeapons;
		_weaponsITEMS = ([PlayerDBName,_uid,"WEAPONS_ITEMS","ARRAY"] call iniDB_read);
		sleep 0.1;
		CMM_PlayerWeapons_ITEMS = _weaponsITEMS;
		//diag_log format ["Weapon Items = %1", CMM_PlayerWeapons_ITEMS];
		["CMM_PlayerWeapons_ITEMS","client",_clientID] call BME_fnc_publicvariable;
		//Inventory
		_inventory = ([PlayerDBName,_uid,"INVENTORY","ARRAY"] call iniDB_read);
		sleep 0.1;
		CMM_Player_Inventory = _inventory;
		["CMM_Player_Inventory","client",_clientID] call BME_fnc_publicvariable;
		//diag_log CMM_Player_Inventory;	
		sleep 0.1;
		_playerLOC = ([PlayerDBName,_uid,"PLAYERLOC","ARRAY"] call iniDB_read);
		CMM_PlayerLOC = _playerloc;
		["CMM_PlayerLOC","client",_clientID] call BME_fnc_publicvariable;
		//diag_log CMM_PlayerLOC;	
		sleep 0.1;
		 _VARname = format ["%1_HISTORY",_UID];
		_score = ([PlayerDBName,_uid,"SCORE","ARRAY"] call iniDB_read);
		OzDM_Srv setVariable [_VARname,_score,true];
		diag_log _score;
	} Else {
		//Say Player is not found and strip player of all weapons and equipment. 
		CMM_SystemChat = "New Player Detected Creating Profile";
		["CMM_SystemChat","client",_clientID] call BME_fnc_publicvariable;
		sleep 0.1;
		[_player, _clientID, _uid, _name] call iniDB_CreatePlayerPD;
		CMM_SystemChat = format ["Welcome %1, your profile has now been created", _name];
		["CMM_SystemChat","client",_clientID] call BME_fnc_publicvariable;
	};
};
iniDB_SaveMissionData = {
	private["_MissionDate","_MissionFogParams","_MissionWeather","_MissionWind","_written","_MissionHistory","_missionSuccess","_MissionLives","_MissionDeaths","_RETURNPOS","_RESPAWNPOS"];
	_missionSuccess = _this;
	_MissionDate = date;
	_written = [MissionDBName, MissionDBSection, "Date",_MissionDate] call iniDB_write;
	_MissionFogParams = fogParams;
	_written = [MissionDBName, MissionDBSection, "FogParams",_MissionFogParams] call iniDB_write;
	_MissionWeather = [overcast,rain,rainbow,waves];
	_written = [MissionDBName, MissionDBSection, "Weather",_MissionWeather] call iniDB_write;
	_MissionWind = [wind, windDir, windStr];
	_written = [MissionDBName, MissionDBSection, "Wind",_MissionWind] call iniDB_write;	
	if!(Isnull RESPAWN_POSITION) then {
		_RESPAWNPOS = getpos RESPAWN_POSITION;
		_written = [MissionDBName, MissionDBSection, "RESPAWN_POS",_RESPAWNPOS] call iniDB_write;
	};
	if!(Isnull RETURN) then {
		_RETURNPOS = getpos RETURN;
		_written = [MissionDBName, MissionDBSection, "RETURN_POS",_RETURNPOS] call iniDB_write;
	};
	_MissionLives = CM_LIVES;
	If(_missionSuccess) then {_MissionLives = (_MissionLives + MISSIONSUCCESS_BONUS_LIVES)};
	_MissionDeaths = DEATHS_HISTORY + CM_DEATHS;
	_MissionData = [_MissionLives, _MissionDeaths];
	_written = [MissionDBName, MissionDBSection, "MissionData",_MissionData] call iniDB_write;
	MISSION_HISTORY = (MISSION_HISTORY + 1);
	If(_missionSuccess) then {MISSION_SUCCESS_HISTORY = (MISSION_SUCCESS_HISTORY +1)};
	_MissionHistory = [MISSION_HISTORY, MISSION_SUCCESS_HISTORY];
	_written = [MissionDBName, MissionDBSection, "MissionHistory",_MissionHistory] call iniDB_write;
true
};
iniDB_VehicleSave = {
private["_this","_veh","_name","_data","_Support","_cargoWeapons","_cargoItems","_cargoMags","_cargoBkPks","_written","_ItemsInTriggerArray","_Array","_fullList","_pos","_dir","_PartDmg","_DupList","_AGM_Logistics_Cargo"];
//		[SaveTrig1] call iniDB_VehicleSave;
if !(isServer) exitWith {};
	_Array = [];
	_written = [VehicleDBName, "GLOBAL","VehicleCount", [VEHICLE_COUNT]] call iniDB_write;
	_count = (count RESTORED_VEHICLE) -1;
	for "_i" from 0 to _count do {
	_veh = RESTORED_VEHICLE select _i;
		If!(IsNull _veh) then {	//NOT WORKING TRY TYPENAME
			if ((damage _veh) < 1) then {
				_name = format ["%1_%2",VehicleSaveName,_i];
				_pos = getPosASL _veh;
				_dir = [vectorDir _veh, vectorUP _veh];
				_PartDmg = _veh call CMM_GETPARTDMG;
				_data = [typeOf _veh, getPosASL _veh, _dir, damage _veh, fuel _veh];
				_cargoWeapons = GetWeaponCargo _veh;
				_cargoItems = GetItemCargo _veh;
				_cargoMags = GetMagazineCargo _veh;
				_cargoBkPks = GetBackpackCargo _veh;
				_Array = _Array +[_name];
				_Support = [If((GetFuelCargo _veh) > 0) then {GetFuelCargo _veh} Else {0},If((GetAmmoCargo _veh) > 0) then {GetAmmoCargo _veh} Else {0},If((GetRepairCargo _veh) > 0) then {GetRepairCargo _veh} Else {0}];
				_AGM_Logistics_Cargo = _veh getVariable ["AGM_Logistics_loadedItems",[]];
				_written = [VehicleDBName, _name,"Name",_name] call iniDB_write;
				_written = [VehicleDBName, _name,"Data",_data] call iniDB_write;
				_written = [VehicleDBName, _name,"PartDmg",_PartDmg] call iniDB_write;
				_written = [VehicleDBName, _name,"Support",_Support] call iniDB_write;
				_written = [VehicleDBName, _name,"AGMLogisticsCargo",[_AGM_Logistics_Cargo]] call iniDB_write;
				_written = [VehicleDBName, _name,"WeaponCargo",_cargoWeapons] call iniDB_write;
				_written = [VehicleDBName, _name,"ItemCargo",_cargoItems] call iniDB_write;
				_written = [VehicleDBName, _name,"MagCargo",_cargoMags] call iniDB_write;
				_written = [VehicleDBName, _name,"BkPkCargo",_cargoBkPks] call iniDB_write;
			};
		};
	};
	_written = [VehicleDBName, "GLOBAL","INDEX-VEHICLES", _Array] call iniDB_write;
true
};
iniDB_VehicleLoad = {
// 			call iniDB_VehicleLoad;				null = [] spawn iniDB_VehicleLoad;
private["_count","_veh","_name","_written","_UnitType","_Array","_Data","_Support","_HitDmg","_WpnCargo","_ItemCargo","_MagCargo","_BkPkCargo","_class","_faction","_pos","_dir","_dmg","_fuel","_i","_PartData","_Partdamage","_FuelCargo","_AmmoCargo","_RepairCargo"];
if !(isServer) exitWith {};
If !(VehicleDBName call iniDB_exists) Then {
	_written = [VehicleDBName, "GLOBAL","INDEX-VEHICLES",""] call iniDB_write;
	VEHICLE_COUNT = 0;
	RESTORED_VEHICLE = [];
	_written = [VehicleDBName, "GLOBAL","VehicleCount",[VEHICLE_COUNT]] call iniDB_write;
} Else {
	_Array = [VehicleDBName, "GLOBAL","INDEX-VEHICLES","ARRAY"] call iniDB_read;
	_numArray = [VehicleDBName, "GLOBAL","VehicleCount","ARRAY"] call iniDB_read;
	//CRATE_COUNT = (parseNumber (_numArray select 0));
	VEHICLE_COUNT = (_numArray select 0);
	RESTORED_VEHICLE = [];
	_count = (count _Array) - 1;
 if (_count >= 0) then {
		for "_i" from 0 to _count do {
			_name = _Array select _i;
			_Data = [VehicleDBName, _name,"Data","ARRAY"] call iniDB_read;
			_HitDmg = [VehicleDBName, _name,"PartDmg","ARRAY"] call iniDB_read;
			_Support = [VehicleDBName, _name,"Support","ARRAY"] call iniDB_read;
			_FuelCargo = _Support Select 0;
			_AmmoCargo = _Support Select 1;
			_RepairCargo = _Support Select 2;
			_AGM_Logistics_Cargo = [VehicleDBName, _name,"AGMLogisticsCargo","ARRAY"] call iniDB_read;
			_WpnCargo  = [VehicleDBName, _name,"WeaponCargo","ARRAY"] call iniDB_read;
			_ItemCargo = [VehicleDBName, _name,"ItemCargo","ARRAY"] call iniDB_read;
			_MagCargo  = [VehicleDBName, _name,"MagCargo","ARRAY"] call iniDB_read;
			_BkPkCargo = [VehicleDBName, _name,"BkPkCargo","ARRAY"] call iniDB_read;
			_UnitType = (_Data select 0);
			_class  = gettext (configfile >> "CfgVehicles" >> _UnitType >> "vehicleClass");
			_faction = gettext (configfile >> "CfgVehicles" >> _UnitType >> "faction");
			_pos = (_Data select 1);
			_dir = (_Data select 2);
			_dmg = (_Data select 3);
			_fuel = (_Data select 4);
			//diag_log format ["Spawning vehicle #%1 - Type %1", _i, _UnitType];
			_veh = createVehicle [_UnitType,[0,0,150],[], 0, "NONE"];
			//diag_log format ["missionNamespace setVariable [%1,%2]",_name,_veh];
			missionNamespace setVariable [_name,_veh];
			//[[_veh,_name],"setVehicleName",true,false,false] call BIS_fnc_MP;
			_veh setVehicleVarName _name;
			_veh setVariable ["AGM_Logistics_loadedItems",[]];
			_veh setFuelCargo _FuelCargo;
			_veh setfuel _fuel;
			_veh setAmmoCargo _AmmoCargo;
			_veh setRepairCargo _RepairCargo;
			clearItemCargoGlobal _veh;
			clearWeaponCargoGlobal _veh;
			clearMagazineCargoGlobal _veh;
			clearBackpackCargoGlobal _veh;
			_veh setVectorDirAndUp _dir;
			_veh setVelocity [0,0,0]; 
			_AGMArray = (_AGM_Logistics_Cargo select 0);
			_AGMcount = (count _AGMArray) - 1;
			If(_AGMcount >= 0) then {
				for "_i" from 0 to _AGMcount do {
					_item = _AGMArray select _i;
					[_veh, _item] call AGM_Logistics_fnc_initLoadedObject;
				};
			};
			_veh setPosASL _pos;
			_veh setdamage _dmg;
			[[_veh,_HitDmg],"CMM_SETPARTDMG",true,false,false] call BIS_fnc_MP;  //[_veh,_PartData] call CMM_SETPARTDMG
			//diag_log format ["Damage Data for Vehicle %1 = %2", _veh, _HitDmg];
			if ((_class == "Autonomous") && (_faction == CAMPAIGN_FACTION)) then {createVehicleCrew _veh};
			if((count _MagCargo)  > 0) then {[_veh,_MagCargo] call CMM_MAGCARGOLOAD};
			if((count _ItemCargo) > 0) then {[_veh,_ItemCargo] call CMM_ITMCARGOLOAD};
			if((count _BkPkCargo) > 0) then {[_veh,_BkPkCargo] call CMM_BKPCARGOLOAD};
			if((count _WpnCargo)  > 0) then {[_veh,_WpnCargo] call CMM_WPNCARGOLOAD};
			RESTORED_VEHICLE = RESTORED_VEHICLE + [_veh];
			CURATOR_OBJ addCuratorEditableObjects [[_veh],false];
			};
		};
	};
};
iniDB_CrateSave = { //	Usage call iniDB_CrateSave
private["_count","_this","_crate","_name","_data","_cargoWeapons","_cargoItems","_cargoMags","_cargoBkPks","_written","_deleted","_Array","_pos","_dir"];
if !(isServer) exitWith {};
_array =[];
_written = [CrateDBName, "GLOBAL","CrateCount", [CRATE_COUNT]] call iniDB_write;
	_count = (count RESTORED_CRATE) -1;
	for "_i" from 0 to _count do {
	_crate = RESTORED_CRATE select _i;
		If!(IsNull _crate) then {
			if ((damage _crate) < 1) then {
				_name = VehicleVarName _crate;
				_pos = getPosASL _crate;
				_dir = [vectorDir _crate, vectorUP _crate];
				_data = [typeOf _crate, _pos,_dir, damage _crate];
				_cargoWeapons = GetWeaponCargo _crate;
				_cargoItems = GetItemCargo _crate;
				_cargoMags = GetMagazineCargo _crate;
				_cargoBkPks = GetBackpackCargo _crate;
				_Array = _Array +[_name];
				_written = [CrateDBName, _name,"Name",_name] call iniDB_write;
				_written = [CrateDBName, _name,"Data",_data] call iniDB_write;
				_written = [CrateDBName, _name,"WeaponCargo",_cargoWeapons] call iniDB_write;
				_written = [CrateDBName, _name,"ItemCargo",_cargoItems] call iniDB_write;
				_written = [CrateDBName, _name,"MagCargo",_cargoMags] call iniDB_write;
				_written = [CrateDBName, _name,"BkPkCargo",_cargoBkPks] call iniDB_write;
			};
		};
	_written = [CrateDBName, "GLOBAL","INDEX-Crates", _Array] call iniDB_write;
	};
true
};
iniDB_CrateLoad = { //	Usage call iniDB_CrateLoad
private["_count","_this","_crate","_name","_data","_cargoWeapons","_cargoItems","_cargoMags","_cargoBkPks","_written","_Array","_pos","_dir","_PVArray"];
if !(isServer) exitWith {};
_PVArray = [];
If !(CrateDBName call iniDB_exists) Then {
	_written = [CrateDBName, "GLOBAL","INDEX-Crates",""] call iniDB_write;
	CRATE_COUNT = 0;
	RESTORED_CRATE = [];
	_written = [CrateDBName, "GLOBAL","CrateCount",[CRATE_COUNT]] call iniDB_write;
} Else {
	_Array = [CrateDBName, "GLOBAL","INDEX-Crates","ARRAY"] call iniDB_read;
	_numArray = [CrateDBName, "GLOBAL","CrateCount","ARRAY"] call iniDB_read;
	//CRATE_COUNT = (parseNumber (_numArray select 0));
	CRATE_COUNT = (_numArray select 0);
	RESTORED_CRATE = [];
	_count = (count _Array) - 1;
	if (_count >= 0) then {
		for "_i" from 0 to _count do {
			_name = _Array select _i;
			_Data = [CrateDBName, _name,"Data","ARRAY"] call iniDB_read;
			_WpnCargo  = [CrateDBName, _name,"WeaponCargo","ARRAY"] call iniDB_read;
			_ItemCargo = [CrateDBName, _name,"ItemCargo","ARRAY"] call iniDB_read;
			_MagCargo  = [CrateDBName, _name,"MagCargo","ARRAY"] call iniDB_read;
			_BkPkCargo = [CrateDBName, _name,"BkPkCargo","ARRAY"] call iniDB_read;
			_UnitType = (_Data select 0);
			_pos = (_Data select 1);
			_dir = (_Data select 2);
			_dmg = (_Data select 3);
			//diag_log format ["Spawning vehicle #%1 - Type %1", _i, _UnitType];
			_crate = createVehicle [_UnitType,[0,0,150],[], 0, "NONE"];
			diag_log format ["missionNamespace setVariable [%1,%2]",_name,_crate];
			missionNamespace setVariable [_name,_crate];
			_crate setVehicleVarName _name;
			_crate setVectorDirAndUp _dir;
			_crate setVelocity [0,0,0]; 
			_crate setPosASL _pos;
			_crate setdamage 0;
			_crate allowDamage false;
			clearItemCargoGlobal _crate;
			clearWeaponCargoGlobal _crate;
			clearMagazineCargoGlobal _crate;
			clearBackpackCargoGlobal _crate;
			if((count _MagCargo)  > 0) then {[_crate,_MagCargo] call CMM_MAGCARGOLOAD};
			if((count _ItemCargo) > 0) then {[_crate,_ItemCargo] call CMM_ITMCARGOLOAD};
			if((count _BkPkCargo) > 0) then {[_crate,_BkPkCargo] call CMM_BKPCARGOLOAD};
			if((count _WpnCargo)  > 0) then {[_crate,_WpnCargo] call CMM_WPNCARGOLOAD};
			RESTORED_CRATE = RESTORED_CRATE + [_crate];
			CURATOR_OBJ addCuratorEditableObjects [[_crate],false];
			};
		OzDM_Srv setVariable ["RESTORED_CRATE", RESTORED_CRATE, true];
		};
	};
};
iniDB_ObjectSave = { //	Usage call iniDB_ObjectSave
private["_count","_this","_Obj","_name","_data","_cargoWeapons","_cargoItems","_cargoMags","_cargoBkPks","_written","_deleted","_Array","_pos","_dir","_Support","_FuelCargo","_AmmoCargo","_RepairCargo"];
if !(isServer) exitWith {};
_array =[];
_written = [ObjDBName, "GLOBAL","ObjectCount", [OBJECT_COUNT]] call iniDB_write;
	_count = (count RESTORED_OBJ) -1;
	for "_i" from 0 to _count do {
	_Obj = RESTORED_OBJ select _i;
		If!(IsNull _Obj) then {
			if ((damage _Obj) < 1) then {
				_name = VehicleVarName _Obj;
				_pos = getPosASL _Obj;
				_dir = [vectorDir _Obj, vectorUP _Obj];
				_data = [typeOf _Obj, _pos,_dir, damage _Obj];
				_Support = [If((GetFuelCargo _Obj) > 0) then {GetFuelCargo _Obj} Else {0},If((GetAmmoCargo _Obj) > 0) then {GetAmmoCargo _Obj} Else {0},If((GetRepairCargo _Obj) > 0) then {GetRepairCargo _Obj} Else {0}];
				_Array = _Array +[_name];
				_written = [ObjDBName, _name,"Name",_name] call iniDB_write;
				_written = [ObjDBName, _name,"Data",_data] call iniDB_write;
				_written = [ObjDBName, _name,"Support",_Support] call iniDB_write;
				};
		};
	_written = [ObjDBName, "GLOBAL","INDEX-Objects", _Array] call iniDB_write;
	};
true
};
iniDB_ObjectLoad = { //	Usage call iniDB_ObjectLoad
private["_count","_this","_Obj","_name","_data","_cargoWeapons","_cargoItems","_cargoMags","_cargoBkPks","_written","_Array","_pos","_dir","_Support","_FuelCargo","_AmmoCargo","_RepairCargo"];
if !(isServer) exitWith {};
If !(ObjDBName call iniDB_exists) Then {
	_written = [ObjDBName, "GLOBAL","INDEX-Objects",""] call iniDB_write;
	OBJECT_COUNT = 0;
	RESTORED_OBJ = [];
	_written = [ObjDBName, "GLOBAL","ObjectCount",[OBJECT_COUNT]] call iniDB_write;
} Else {
	_Array = [ObjDBName, "GLOBAL","INDEX-Objects","ARRAY"] call iniDB_read;
	_numArray = [ObjDBName, "GLOBAL","ObjectCount","ARRAY"] call iniDB_read;
	OBJECT_COUNT = (_numArray select 0);
	RESTORED_OBJ = [];
	_count = (count _Array) - 1;
	if (_count >= 0) then {
		for "_i" from 0 to _count do {
			_name = _Array select _i;
			_Data = [ObjDBName, _name,"Data","ARRAY"] call iniDB_read;
			_UnitType = (_Data select 0);
			_pos = (_Data select 1);
			_dir = (_Data select 2);
			_dmg = (_Data select 3);
			_Support = [ObjDBName, _name,"Support","ARRAY"] call iniDB_read;
			_FuelCargo = _Support Select 0;
			_AmmoCargo = _Support Select 1;
			_RepairCargo = _Support Select 2;
			//diag_log format ["Spawning vehicle #%1 - Type %1", _i, _UnitType];
			_Obj = createVehicle [_UnitType,[0,0,150],[], 0, "NONE"];
			diag_log format ["missionNamespace setVariable [%1,%2]",_name,_Obj];
			missionNamespace setVariable [_name,_Obj];
			_Obj setVehicleVarName _name;
			//[[_Obj,_name],"setVehicleName",true,false,false] call BIS_fnc_MP;
			_Obj setVectorDirAndUp _dir;
			_Obj setVelocity [0,0,0]; 
			_Obj setPosASL _pos;
			_Obj setdamage 0;
			_Obj allowDamage false;
			clearItemCargoGlobal _Obj;
			clearWeaponCargoGlobal _Obj;
			clearMagazineCargoGlobal _Obj;
			clearBackpackCargoGlobal _Obj;
			RESTORED_OBJ = RESTORED_OBJ + [_Obj];
			CURATOR_OBJ addCuratorEditableObjects [[_Obj],false];
			};
		};
	};
};
iniDB_MarkerSave = {
private ["_mkr","_pos","_color","_type","_txt","_iniDBArray"];
_array = RESTORED_MARKERS;
_count = (count _array) -1;
_iniDBArray = [];
for "_i" from 0 to _count do {
	_mkr = _array select _i;
	_name = format ["%1_%2", MkrSaveName, _i];
	_mkrType = markerType _mkr;
	If !(_mkrType == "") then {
		_pos = GetMarkerPos _mkr;
		_color = MarkerColor _mkr;
		if ((markerText _mkr) == "") then {_txt = " "} Else {_txt = markerText _mkr};
		_written = [MarkerDBName, _name,"Name",_name] call iniDB_write;
		_written = [MarkerDBName, _name,"POS",_pos] call iniDB_write;
		_written = [MarkerDBName, _name,"Type",_mkrType] call iniDB_write;
		_written = [MarkerDBName, _name,"Color",_color] call iniDB_write;
		_written = [MarkerDBName, _name,"TxT",_txt] call iniDB_write;
		_iniDBArray = _iniDBArray + [_name];
		};
	};
_written = [MarkerDBName, "GLOBAL","INDEX-MARKERS", _iniDBArray] call iniDB_write;
true
};
iniDB_MarkerLoad = {
private ["_mkr","_pos","_color","_type","_txt","_iniDBArray","_array","_check"];
_check = ([MarkerDBName,"GLOBAL","INDEX-MARKERS"] call iniDB_Check_Array);
	If(_check) then {
		_iniDBArray = ([MarkerDBName,"GLOBAL","INDEX-MARKERS","ARRAY"] call iniDB_read);
		} Else {
		_written = [MarkerDBName,"GLOBAL","MISSION-NAME",missionName] call iniDB_write;
		_written = [MarkerDBName,"GLOBAL","INDEX-MARKERS",[]] call iniDB_write;
		_iniDBArray = [];
		};
_array = [];
_count = (count _iniDBArray) -1;
for "_i" from 0 to _count do {
			_name = _iniDBArray select _i;
			_POS = [MarkerDBName, _name,"POS","ARRAY"] call iniDB_read;
			_type = [MarkerDBName, _name,"Type","STRING"] call iniDB_read;
			_color = [MarkerDBName, _name,"Color","STRING"] call iniDB_read;
			_txt = [MarkerDBName, _name,"TxT","STRING"] call iniDB_read;
			_mkr = createMarker [_name,_pos];
			_mkr setMarkerType _type;
			_mkr setMarkerColor _color;
			_mkr setMarkerText _txt;
			_array = _array + [_mkr];
			};
RESTORED_MARKERS = _array;		
};
iniDB_CleanUp = {
// Designed to go through DB and clean out old entries that are not refered to anymore.
};
iniDB_StartMissionDataLoad ={
	private["_MissionDate","_MissionFogParams","_MissionWeather","_MissionWind","_check","_MissionLives","_MD","_txt","_MissionData","_MissionHistory","_StartDate","_Player_Index","_days","_RESPAWNPOS","_RETURNPOS","_tmp"];
	_MD = 0;
	_check = ([MissionDBName,MissionDBSection,"Date"] call iniDB_Check_Array);
	If(_check) then {
		_MissionDate = [MissionDBName, MissionDBSection, "Date","ARRAY"] call iniDB_read;
		setdate _MissionDate;
	};
	_check = ([MissionDBName,MissionDBSection,"FogParams"] call iniDB_Check_Array);
	If(_check) then {
		_MissionFogParams = [MissionDBName, MissionDBSection, "FogParams","ARRAY"] call iniDB_read;
		0 setFog _MissionFogParams;
	};		
	_check = ([MissionDBName,MissionDBSection,"Weather"] call iniDB_Check_Array);
	If(_check) then {
		_MissionWeather = [MissionDBName, MissionDBSection, "Weather","ARRAY"] call iniDB_read;
		0 setOvercast (_MissionWeather select 0);
		0 setRain (_MissionWeather select 1);
		0 setRainbow (_MissionWeather select 2);
		0 setWaves (_MissionWeather select 3);
	};		
	_check = ([MissionDBName,MissionDBSection,"Wind"] call iniDB_Check_Array);
	If(_check) then {
		_MissionWind = [MissionDBName, MissionDBSection, "Wind","ARRAY"] call iniDB_read;
		setwind [(_MissionWind select 0),false];
		0 setWindDir (_MissionWind select 1);
		0 setWindStr (_MissionWind select 2);
	};	
	_check = ([MissionDBName,MissionDBSection,"RESPAWN_POS"] call iniDB_Check_Array);
	If(_check) then {
		_RESPAWNPOS = [MissionDBName, MissionDBSection, "RESPAWN_POS","ARRAY"] call iniDB_read;
		RESPAWN_POSITION setpos _RESPAWNPOS;
	};		
	_check = ([MissionDBName,MissionDBSection,"RETURN_POS"] call iniDB_Check_Array);
	If(_check) then {
		_RETURNPOS = [MissionDBName, MissionDBSection, "RETURN_POS","ARRAY"] call iniDB_read;
		RETURN setpos _RETURNPOS;
	};			
	_check = ([MissionDBName,MissionDBSection,"MissionData"] call iniDB_Check_Array);
	If(_check) then {
		_MissionData = ([MissionDBName, MissionDBSection, "MissionData","ARRAY"] call iniDB_read);
		_MissionLives = (_MissionData select 0);
		diag_log format ["Mission Lives Loaded = %1", _MissionLives];
		_MD = (_MissionData select 1);
		diag_log format ["Mission Deaths Loaded = %1", _MD];
		if((typeName _MD) != "SCALAR") then {DEATHS_HISTORY = 0} Else {DEATHS_HISTORY = _MD};
		if((typeName _MissionLives) != "SCALAR") then {CM_LIVES = CM_STARTING_LIVES} Else {CM_LIVES = _MissionLives};
		DEATHS_HISTORYmkr setMarkerText format ["Campaign K.I.A.: %1", DEATHS_HISTORY];
	} Else {
		DEATHS_HISTORY = 0;
		DEATHS_HISTORYmkr setMarkerText format ["Campaign K.I.A.: %1", DEATHS_HISTORY];
	};
	_check = ([MissionDBName,MissionDBSection,"MissionHistory"] call iniDB_Check_Array);
	If(_check) then {
		_MissionHistory = [MissionDBName, MissionDBSection, "MissionHistory","ARRAY"] call iniDB_read;
		if((typeName (_MissionHistory select 0)) != "SCALAR") then {MISSION_HISTORY = 0} Else {MISSION_HISTORY = (_MissionHistory select 0)};
		if((typeName (_MissionHistory select 1)) != "SCALAR") then {MISSION_SUCCESS_HISTORY = 0} Else {MISSION_SUCCESS_HISTORY = (_MissionHistory select 1)};
		MISSION_HISTORYmkr setMarkerText format ["Missions Conducted: %1", MISSION_HISTORY];
		MISSION_SUCCESS_HISTORYmkr setMarkerText format ["Missions Achieved: %1", MISSION_SUCCESS_HISTORY];
		} Else {
		MISSION_HISTORY = 0;
		MISSION_SUCCESS_HISTORY = 0;
		MISSION_HISTORYmkr setMarkerText format ["Missions Conducted: %1", MISSION_HISTORY];
		MISSION_SUCCESS_HISTORYmkr setMarkerText format ["Missions Achieved: %1", MISSION_SUCCESS_HISTORY];
	};
	_check = ([MissionDBName,MissionDBSection,"CampaignStartDate"] call iniDB_Check_Array);
	If(_check) then {
		_StartDate = ([MissionDBName,MissionDBSection,"CampaignStartDate","ARRAY"] call iniDB_read);
		CAMPAIGN_STARTDATE = _StartDate;
		//hint format ["StartDate = %1", _StartDate];
		} Else {
		_StartDate = [date select 0,date select 1,date select 2,0,0];
		_written = [MissionDBName, MissionDBSection, "CampaignStartDate",_StartDate] call iniDB_write;
		_written = [MissionDBName, MissionDBSection, "Date",date] call iniDB_write;
		//hint format ["StartDate = %1", _StartDate];
		CAMPAIGN_STARTDATE = _StartDate;
		};
	_check = [PlayerDBName,"INDEX","PlayerIndex"] call iniDB_Check_Array;
	If(_check) then {
		_Player_Index = ([PlayerDBName,"INDEX","PlayerIndex","ARRAY"] call iniDB_read);
		Total_PDPlayers = count _Player_Index;
	} Else {Total_PDPlayers = 0};
	_txt = format ["Mission Deaths:  %1",CM_DEATHS];
	CM_DEATHSmkr setMarkerText _txt;
	_txt = format ["Lives Remaining:  %1",CM_LIVES];
	CM_LIVESmkr setMarkerText _txt;
	CAMPAIGN_NAMEmkr setMarkerText CAMPAIGN_NAME;
	MISSIONCOUNT_mkr setMarkerText format ["Mission No. %1",(MISSION_HISTORY + 1)];
	_days = ([CAMPAIGN_STARTDATE, date] call CMM_COUNTDAYS);
	CAMPAIGN_DAYSmkr setMarkerText format ["Campaign Days: %1", _days];
	_check = [CrateDBName, "GLOBAL","CrateCount"] call iniDB_Check_Array;
	If(_check) then {
		_tmp = ([CrateDBName, "GLOBAL","CrateCount","ARRAY"] call iniDB_read);
		CRATE_COUNT = (_tmp select 0);
	} Else {CRATE_COUNT = 0};
	_check = [VehicleDBName, "GLOBAL","VehicleCount"] call iniDB_Check_Array;
	If(_check) then {
		_tmp = ([VehicleDBName, "GLOBAL","VehicleCount","ARRAY"] call iniDB_read);
		VEHICLE_COUNT = (_tmp select 0);
	} Else {VEHICLE_COUNT = 0};
	_check = [ObjDBName, "GLOBAL","ObjectCount"] call iniDB_Check_Array;
	If(_check) then {
		_tmp = ([ObjDBName, "GLOBAL","ObjectCount","ARRAY"] call iniDB_read);
		OBJECT_COUNT = (_tmp select 0);
	} Else {OBJECT_COUNT = 0};	
	OzDM_Srv setVariable ["MISSION-History",[MISSION_HISTORY,MISSION_SUCCESS_HISTORY,DEATHS_HISTORY,Total_PDPlayers,CAMPAIGN_STARTDATE,VEHICLE_COUNT, CRATE_COUNT, OBJECT_COUNT],TRUE];
	call iniDB_CrateLoad;
	call iniDB_ObjectLoad;
	call iniDB_MarkerLoad;
	waitUntil {!isNil "AGM_Logistics_loadedItemsDummy"};
	sleep 5;
	call iniDB_VehicleLoad;
	[] spawn CMM_SERVERMARKERPROCESS;
};
iniDB_EndMission = {
// [true,"iniDB_EndMission",false,false,false] call BIS_fnc_MP;
//Usage = true/False spawn iniDB_EndMission
private ["_this","_missionSuccess","_ALLuid","_VARname","_playerHistory","_uid","_unit","_score","_Missions","_Smissions","_array","_MissionScore","_NewScore","_NewMissions","_NewSMissions","_MissionBonus","_written","_prefix","_waitMarker","_waitObject","_waitCrate","_waitVehicle","_waitMission"];
_missionSuccess = _this;
	if(IsServer) then {
		["Mission Ending Initialized. Find a safe place to End Mission","systemChat",nil,false] call BIS_fnc_MP;
		sleep 2;
		["Save Commencing in 5","systemChat",nil,false] call BIS_fnc_MP;
		sleep 1;
		["Save Commencing in 4","systemChat",nil,false] call BIS_fnc_MP;
		sleep 1;
		["Save Commencing in 3","systemChat",nil,false] call BIS_fnc_MP;		
		sleep 1;
		["Save Commencing in 2","systemChat",nil,false] call BIS_fnc_MP;
		sleep 1;
		["Save Commencing in 1","systemChat",nil,false] call BIS_fnc_MP;
		
		_ALLuid = ([PlayerDBName,"INDEX","PlayerIndex","ARRAY"] call iniDB_read);
		{
			//This finds the playable unit for the player and grabs his score.
			_uid = getPlayerUID _x;
			_MissionScore = score _x;
			_VARname = format ["%1_HISTORY", _uid];
			_playerHistory = OzDM_Srv getVariable [_VARname,[0,0,0]];
			_score = _playerHistory select 0;
			_Missions = _playerHistory select 1;
			_Smissions = _playerHistory select 2;
			_MissionBonus = if(_missionSuccess) then {MISSIONSUCCESS_BONUS_SCORE} Else {0};
			_NewScore = _score + _MissionScore + _MissionBonus;
			_NewMissions = _Missions + 1;
			If(SPECIAL_SLOT find (vehicleVarName _x) == -1) then {[_x,"",	getPlayerUID _x, name _x] call iniDB_SavePlayerPD};
			If(_missionSuccess) then {_NewSMissions = _Smissions + 1} Else {_NewSMissions = _Smissions};
			_array = [_NewScore,_NewMissions,_NewSMissions];
			//diag_log format ["Writing Player %1 Score Data: %2", name _x, _array];
			_written = [PlayerDBName, _uid, "SCORE",_array] call iniDB_write;
		} foreach playableUnits;
		//SAVEMISSIONDATA HERE!!!	
		["Saving Zeus Marker Data","systemChat",nil,false] call BIS_fnc_MP;
		_waitMarker = [] spawn iniDB_MarkerSave;
		waitUntil{sleep 0.5; scriptDone _waitMarker};
		
		["Saving Zeus Object Data","systemChat",nil,false] call BIS_fnc_MP;
		_waitObject = [] spawn iniDB_ObjectSave;
		waitUntil{sleep 0.5; scriptDone _waitObject};
		
		["Saving Zeus Crate Data","systemChat",nil,false] call BIS_fnc_MP;
		_waitCrate = [] spawn iniDB_CrateSave;
		waitUntil{sleep 0.5; scriptDone _waitCrate};
		
		["Saving Zeus Vehicle Data","systemChat",nil,false] call BIS_fnc_MP;
		_waitVehicle = [] spawn iniDB_VehicleSave;
		waitUntil{sleep 0.5; scriptDone _waitVehicle};

		["Finalizing Save Data","systemChat",nil,false] call BIS_fnc_MP;
		_waitMission = _missionSuccess spawn iniDB_SaveMissionData;
		waitUntil{sleep 0.5; scriptDone _waitMission};
		
		/*
		["Saving Zeus Marker Data","systemChat",nil,false] call BIS_fnc_MP;
		_waitMarker = call iniDB_MarkerSave;
		
		["Saving Zeus Marker Data","systemChat",nil,false] call BIS_fnc_MP;
		_waitObject = call iniDB_ObjectSave;
		_waitCrate = call iniDB_CrateSave;
		_waitVehicle = call iniDB_VehicleSave;
		_missionSuccess call iniDB_SaveMissionData;
		
		*/
		/////

		sleep 1;
		if(_missionSuccess) then {["end1","BIS_fnc_endMission",true,false,false] call BIS_fnc_MP;} Else {["end2","BIS_fnc_endMission",true,false,false] call BIS_fnc_MP;};
	};
};