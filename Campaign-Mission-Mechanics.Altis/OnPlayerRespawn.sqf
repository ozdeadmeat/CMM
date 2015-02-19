//By OzDeaDMeaT for BoTM RPG Campaign
//OnPlayerRespawn.sqf
//Version 2.0

//This section collects the players uniform, Glasses and Headgear and removes it from the corps. The stripped body shows players that the dead player has respawned.

_newUnit = _this select 0;
_oldUnit = _this select 1;
/*
//This removes all player respawned equipment
removeAllWeapons _newUnit; 
removeGoggles _newUnit; 
removeVest _newUnit;
removeBackpack _newUnit; 
removeAllAssignedItems _newUnit; 
removeHeadgear _newUnit;

//This gathers old players body uniform etc.
_oldheadgear = headgear _oldUnit;
_oldGoggles = goggles _oldUnit;
_oldUniform = uniform _oldUnit;
_oldvest = vest _oldUnit;
_oldBackPack = backpack _oldUnit;

//This sets the new body with the same gear the old body had
if (_oldheadgear != "") then {_newUnit addHeadgear _oldheadgear};
if (_oldGoggles != "") then {_newUnit addGoggles _oldGoggles};
if (_oldUniform != "") then {_newUnit addUniform _oldUniform};
if (_oldvest != "") then {_newUnit addVest _oldvest};
if (_oldBackPack != "") then {_newUnit addBackpack _oldBackPack};

*/

_newUnit linkItem "ItemMap";
_newUnit linkItem "ItemRadio";
_newUnit linkItem "ItemCompass";
_newUnit linkItem "ItemWatch";

//Comment Out If AGM is not available
_newUnit additemtoUniform "AGM_Bandage";
_newUnit additemtoUniform "AGM_Bandage";
_newUnit additemtoUniform "AGM_Bandage";
_newUnit additemtoUniform "AGM_Epipen";
_newUnit additemtoUniform "AGM_Morphine";

exit;
