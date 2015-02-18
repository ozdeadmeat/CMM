//Init INIDB
if (isClass (configfile >> "CfgPatches" >> "iniDBI")) then {
	call compile preProcessFile "\inidbi\init.sqf"
	};
call compilefinal preprocessFileLineNumbers "BME\init.sqf";
//Prep Arrays and Systems
#include "CMM\CMM_init.sqf";
#include "CMM\CMM_functions.sqf";
#include "iniDB\iniDB_Functions.sqf";





0 = addMissionEventHandler ["HandleDisconnect",{_this spawn iniDB_DCPlayerPD}];
null = [] spawn iniDB_StartMissionDataLoad;
//[VirtualAmmoBox,STARTER_CRATE_WEAPONS,false] call BIS_fnc_addVirtualWeaponCargo;
[VirtualAmmoBox,STARTER_CRATE_ITEMS,true,true] call BIS_fnc_addVirtualItemCargo;
[VirtualAmmoBox,STARTER_CRATE_BACKPACKS,true,true] call BIS_fnc_addVirtualBackpackCargo;
//[VirtualAmmoBox,STARTER_CRATE_MAGS,false] call BIS_fnc_addVirtualMagazineCargo;

//Starts Marker Stuff on Server
["RESPAWN_POSITION_MKR",RESPAWN_POSITION] spawn moveMarker;
