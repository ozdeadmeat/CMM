	/*
	Author: code34 nicolas_boiteux@yahoo.fr
	Copyright (C) 2013 Nicolas BOITEUX

	Bus Message Exchange (BME)
	
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
	
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>. 

	Usage: 
		BME_netcode_nameofyourvariable = { code to execute on client side };
	*/

	// Example function hint message on client side
CLIENT_NETID = -1;
	
	BME_netcode_bme_message = {
		bme_message = _this select 0;
		hint bme_message;
	};
// OzDM Below this line
	BME_netcode_CMM_Hint = {
	CMM_Hint = _this select 0;
	hint CMM_Hint;
	};
	BME_netcode_CMM_SystemChat = {
	CMM_SystemChat = _this select 0;
	systemChat CMM_SystemChat;
	};
	BME_netcode_CMM_ClientID = {
	CMM_ClientID = _this select 0;
	CLIENT_NETID = CMM_ClientID;
	};
	BME_netcode_CMM_PlayerLOC = {
	CMM_PlayerLOC = _this select 0;
	_posasl = CMM_PlayerLOC select 0;
	_dir = CMM_PlayerLOC select 1;
	//_anim = CMM_PlayerLOC select 2;  // FIX FOR AGM UNCONTIOUS BUG
	//player switchMove _anim;  // FIX FOR AGM UNCONTIOUS BUG
	player setposASL _posasl;
	player setdir _dir;
	systemChat "Player Location Loaded";
	};
	BME_netcode_CMM_PlayerUniform = {
	CMM_PlayerUniform = _this select 0;
	_headgear = CMM_PlayerUniform select 0;
	_goggles = CMM_PlayerUniform select 1;
	_uniform = CMM_PlayerUniform select 2;
	_vest = CMM_PlayerUniform select 3;
	_backpack = CMM_PlayerUniform select 4;
	//sleep 4;
	if (_headgear != "") then {player addHeadgear _headgear};
	if (_goggles != "") then {player addGoggles _goggles};
	if (_uniform != "") then {player forceaddUniform _uniform};
	if (_vest != "") then {player addVest _vest};
	if (_backpack != "") then {player addBackpack _backpack; clearBackpackCargo player};
	systemChat "Uniform Loaded";
	};
	BME_netcode_CMM_PlayerWeapons = {
	CMM_PlayerWeapons = _this select 0;
	_priW = CMM_PlayerWeapons select 0;
	_secW = CMM_PlayerWeapons select 1;
	_hgW = CMM_PlayerWeapons select 2;
	//sleep 5;
	if (_priW != "") then {player addWeapon _priW};
	if (_secW != "") then {player addWeapon _secW};
	if (_hgW != "") then {player addWeapon _hgW};
	systemChat "Weapons Loaded";
	};
	BME_netcode_CMM_PlayerWeapons_ITEMS = {
	CMM_PlayerWeapons_ITEMS = _this select 0;
	_priWitems = CMM_PlayerWeapons_ITEMS select 0;
	_secWitems = CMM_PlayerWeapons_ITEMS select 1;
	_hgWitems = CMM_PlayerWeapons_ITEMS select 2;
	//systemchat format ["PrimaryWeaponItems = %1", _priWitems];
	If (count _priWitems != 0) then { 
	{
	If(_x != "") then {player addPrimaryWeaponItem _x};
	} foreach _priWitems;
	};
	If (count _secWitems != 0) then { 
	{
	If(_x != "") then {player addSecondaryWeaponItem _x};
	} foreach _secWitems;
	};
	If (count _hgWitems != 0) then { 
	{
	If(_x != "") then {player addHandgunItem _x};
	} foreach _hgWitems;
	};	
	systemChat "Weapon Items Loaded";
	};
	BME_netcode_CMM_PlayerWeapons_MAGS = {
	CMM_PlayerWeapons_MAGS = _this select 0;
	_priWmag = CMM_PlayerWeapons_MAGS select 0;
	_secWmag = CMM_PlayerWeapons_MAGS select 1;
	_hgWmag = CMM_PlayerWeapons_MAGS select 2;
	_array = _priWmag + _secWmag + _hgWmag;
	//sleep 5;
	If (count _array != 0) then { {player addmagazine _x} foreach _array};
	systemChat "Weapon Mags Loaded";
	};
	BME_netcode_CMM_Player_Inventory = {
	CMM_Player_Inventory = _this select 0;
	_uniformITEMS = CMM_Player_Inventory select 0;
	_vestITEMS = CMM_Player_Inventory select 1;
	_backpackITEMS = CMM_Player_Inventory select 2;
	_assignedITEMS = CMM_Player_Inventory select 3;
	//sleep 5;
	//If (count _assignedITEMS != 0) then { {player linkItem _x} foreach _assignedITEMS};
	If (count _assignedITEMS != 0) then {{If((gettext (configFile >> "CfgWeapons" >> _x >> "displayName")) != "") then {player addweapon _x} Else {player linkItem _x}} foreach _assignedITEMS};
	player linkItem "ItemRadio";
	sleep 0.2;
	If (count _uniformITEMS != 0) then { {player additemtoUniform _x} foreach _uniformITEMS};
	sleep 0.2;
	If (count _vestITEMS != 0) then { {player additemtoVest _x} foreach _vestITEMS};
	sleep 0.2;
	If (count _backpackITEMS != 0) then { {player additemtoBackpack _x} foreach _backpackITEMS};
	//hint format ["UniformItems\n %1\n\nVestItems\n %2\n\n", _uniformITEMS, _vestITEMS];	
	systemChat "Inventory Loaded";
	systemChat "Persistent Player Data Transfer Complete";
	};	

	// return true when read
	true;