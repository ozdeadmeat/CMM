///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//STARTUP STUFF
CMM_PLAYER_STARTUP = {
/*
	Name:			CMM_PLAYER_STARTUP
	Author:			OzDeaDMeaT
	Description:	Initialization for Players in CMM enabled missions
	Must spawn:		YES
    Usage Example:			player spawn CMM_PLAYER_STARTUP;
	
	Parameters:
        Index		Type		Variable		Notes
		0 			OBJECT		_player			Player Object
    
    Return:
					BOOL		true			Returns true when function is complete
*/
private ["_player", "_PlayerUID","_SWRadio","_LRRadio"];
_player = _this;
titleText ["","BLACK IN",99999999];
enableSentences false;
_PlayerUID = getPlayerUID _player;
if ((vehicleVarName _player) == "ZeusPlayer") then 
	{
			If((RESERVED_UID find (_PlayerUID)) == -1) then {
			systemChat "Reserved Slot, you have been kicked from the server"; 
			sleep 3;
			endMission "LOSER";
		} Else {
			3 setRadioMsg "Add Life";
			4 setRadioMsg "Remove Life";
			5 setRadioMsg "End Mission (Win)";
			6 setRadioMsg "End Mission (Loss)";
			7 setRadioMsg "Add Death";
			8 setRadioMsg "Remove Death";
			9 setRadioMsg "Move Zeus";
			10 setRadioMsg "Move CursorTarget";
			Zeus addEventHandler ["CuratorObjectPlaced",{[_this,"CMM_CURATOROBJECTPLACED",ZeusPlayer,false,false] call BIS_fnc_MP}];
			Zeus addEventHandler ["CuratorObjectDeleted",{[_this,"CMM_CURATOROBJECTREMOVE",ZeusPlayer,false,false] call BIS_fnc_MP}];
			Zeus addEventHandler ["CuratorMarkerPlaced",{[_this,"CMM_CURATORMARKERPLACED",ZeusPlayer,false,false] call BIS_fnc_MP}];
			Zeus addEventHandler ["CuratorMarkerDeleted",{[_this,"CMM_CURATORMARKERREMOVE",ZeusPlayer,false,false] call BIS_fnc_MP}];
			//Zeus call BIS_fnc_drawCuratorLocations;
			//Starts Marker Stuff on Server
			["RETURN_MKR",return,"LOCAL"] spawn CMM_MOVEMARKER;
			"RETURN_MKR" setMarkerAlphaLocal 1;
			sleep 3;
			_player spawn CMM_ZEUSLOADOUT;
			_player setpos getpos RESPAWN_POSITION;
		};
	}
Else
	{
	_player call CMM_NONZEUS;
	_player spawn CMM_HELPERZEUS;
	};
_array = OzDM_Srv getVariable "MISSION-History";
MISSION_HISTORY = _array select 0;
MISSION_SUCCESS_HISTORY = _array select 1;
DEATHS_HISTORY = _array select 2;
Total_PDPlayers = _array select 3;
CAMPAIGN_STARTDATE = _array select 4;
//Get Persistent information from Server

If(SPECIAL_SLOT find (vehicleVarName _player) == -1) then {
CMM_ClientRequest_PPD = [];
CMM_ClientRequest_PPD = [_player, GetPlayerUID _player];
["CMM_ClientRequest_PPD", "server"] call BME_fnc_publicvariable;
sleep 5;
} Else {
};
if ((vehicleVarName _player) == "ZeusPlayer") then 
	{
	titleText ["","BLACK IN",3];
	sleep 2.5;
	call CMM_ENTRYTITLE;
} Else {
	titleText ["","BLACK IN",3];
	sleep 3;
	call CMM_ENTRYTITLE;
	sleep 10;
	call CMM_SHOWMYSCORE;
	};
true
};
CMM_HELPERZEUS = {
/*
	Name:			CMM_HELPERZEUS
	Author:			OzDeaDMeaT
	Description:	Sets up the eventhandlers for Zeus Objects
	Must spawn:		YES
    Usage Example:		player call CMM_HELPERZEUS;
	
	Parameters:
        Index		Type		Variable		Notes
		0			OBJECT		_player			Player Object
    Return:
					BOOL		true			Returns true when function is complete
*/
private ["_player"];
_player = _this;
	for "_i" from 0 to ((count HELPER_CURATOR_OBJ) -1) do {
		_ZeusPlyr = (HELPER_CURATOR_OBJ select _i) select 0;
		_ZeusObj = (HELPER_CURATOR_OBJ select _i) select 1;
		if ((vehicleVarName _player) == str(_ZeusPlyr)) then {
		//hint "ZeusHelper";
			removeAllCuratorAddons _ZeusObj;
			_ZeusObj addEventHandler ["CuratorObjectPlaced",{[_this,"CMM_CURATOROBJECTPLACED",_ZeusPlyr,false,false] call BIS_fnc_MP}];
			_ZeusObj addEventHandler ["CuratorObjectDeleted",{[_this,"CMM_CURATOROBJECTREMOVE",_ZeusPlyr,false,false] call BIS_fnc_MP}];
			_ZeusObj addEventHandler ["CuratorMarkerPlaced",{[_this,"CMM_CURATORMARKERPLACED",_ZeusPlyr,false,false] call BIS_fnc_MP}];
			_ZeusObj addEventHandler ["CuratorMarkerDeleted",{[_this,"CMM_CURATORMARKERREMOVE",_ZeusPlyr,false,false] call BIS_fnc_MP}];
			sleep 3;
			_player spawn CMM_ZEUSLOADOUT;
			_player setpos getpos RESPAWN_POSITION;
			_ZeusObj addCuratorAddons ZEUS_LOCKDOWN;
			"RETURN_MKR" setMarkerAlphaLocal 1;
		};
	};
true
};
CMM_NONZEUS = {
/*
	Name:			CMM_NONZEUS
	Author:			OzDeaDMeaT
	Description:	Player Mission Entry Title sequence
	Must spawn:		NO
    Usage Example:		player call CMM_NONZEUS;
	
	Parameters:
        Index		Type		Variable		Notes
		0			OBJECT		_player			Player Object
    Return:
					BOOL		true			Returns true when function is complete
*/
private ["_player"];
_player = _this;
	_player call CMM_STRIPPLAYER;
	3 setRadioMsg "NULL";
	4 setRadioMsg "NULL";
	5 setRadioMsg "NULL";
	6 setRadioMsg "NULL";
	7 setRadioMsg "NULL";
	8 setRadioMsg "NULL";
	9 setRadioMsg "NULL";
	10 setRadioMsg "NULL";
	"RETURN_MKR" setMarkerAlphaLocal 0;
true
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE STUFF
CMM_ENTRYTITLE = {
/*
	Name:			CMM_ENTRYTITLE
	Author:			OzDeaDMeaT
	Description:	Player Mission Entry Title sequence
	Must spawn:		NO
    Usage Example:			call CMM_ENTRYTITLE;
	
	Parameters:
        Index		Type		Variable		Notes

    Return:
					BOOL		true			Returns true when function is complete
*/
private ["_FD","_DAYS"];
#define DELAY_CHARACTER	0.25;
#define DELAY_CURSOR	1.5;
null = 		[[
			["Campaign:","<t align='center' size='1.4'>%1</t>"],
			[CAMPAIGN_NAME,"<t color='#619169' align='center' size='1.4'>%1</t><br/>"],
			["By","<t align='right' size='0.6'>%1</t>"],
			[CAMPAIGN_AUTHOR,"<t color='#C2B500' align='right' size='0.6'>%1</t><br/>"],
			["                                    ","<t align='right' size='0'>%1</t>"]
			]] spawn BIS_fnc_typeText;
true
};
CMM_TITLEDAYS = {
/*
	Name:			CMM_TITLEDAYS
	Author:			OzDeaDMeaT
	Description:	Title for day number change. Shows date and Day Count
	Must spawn:		NO
    Usage Example:	call CMM_TITLEDAYS;
	
	Parameters:
        Index		Type		Variable		Notes

    Return:
					BOOL		true			Returns true when function is complete
*/
private ["_FD","_DAYS"];
_FD = call CMM_FORMATDATE;
_DAYS = format ["%1", _this];
#define DELAY_CHARACTER	0.25;
#define DELAY_CURSOR	1.5;
null = 		[[
			[_FD,"<t align='center' size='1.1'>%1</t><br/>"],
			["Day:","<t align='center' size='1.2'>%1</t>"],
			[_DAYS,"<t align='center' size='1.2'>%1</t><br/>"]
			]] spawn BIS_fnc_typeText;
true
};	
CMM_MOVEMARKER = {
/*
	Name:			CMM_MOVEMARKER
	Author:			OzDeaDMeaT
	Description:	Moves Markers around based on particular object location. (Primarily used for Zeus Objects)
	Must spawn:		YES
    Usage Example:	["STRING",OBJECT,ANY] spawn CMM_MOVEMARKER;
	
	Parameters:
        Index		Type		Variable		Notes
		0			STRING		_marker			Marker Name
		1			OBJECT		_Object			Object for marker to track
		2			ANY			_LOCAL			Sets markers as local markers only
		
    Return:
					BOOL		true			Returns true when function is complete
*/
private ["_marker","_Object","_Drop"];
_marker = _this select 0;
_Object = _this select 1;
_LOCAL = If(count _this > 2) then {true} Else {False};
_Drop = false;

	while {!(_LOCAL)} do {
		If (Isnull _Object) then 
		{
			_Drop = true;
			_marker setMarkerText format ["%1 - OBJECT DELETED, NO FURTHER UPDATES", markerText _marker];
		} 
		Else
		{
		_mkrPOS = getMarkerPos _marker;
		_pos = getpos _object;
		If!(_pos isEqualTo _mkrPOS) then {_marker setMarkerPos _pos};
		};
		sleep 15;
		If(_Drop) exitwith {true};
	};
	while {(_LOCAL)} do {
		If (Isnull _Object) then 
		{
			_Drop = true;
			_marker setMarkerTextLocal format ["%1 - OBJECT DELETED, NO FURTHER UPDATES", markerText _marker];
		} 
		Else
		{
		_mkrPOS = getmarkerpos _marker;
		_pos = getpos _object;
		If!(_pos isEqualTo _mkrPOS) then {_marker setMarkerPosLocal _pos};
		};
		sleep 15;
		If(_Drop) exitwith {true};
	};
};
CMM_SERVERMARKERPROCESS = {
/*
	Name:			CMM_SERVERMARKERPROCESS
	Author:			OzDeaDMeaT
	Description:	Server Marker Process for updating Active Players and Day Marker
	Must spawn:		YES
    Usage Example:			spawn CMM_SERVERMARKERPROCESS;
	
	Parameters:
        Index		Type		Variable		Notes
		
    Return:
					BOOL		true			Returns true when function is complete
*/
private ["_txtold","_OLDdays","_txt","_days"];
	_txtold = "";
	CM_ACTIVEPLAYERS = count playableUnits;
	_txt = format ["Active Soldiers:  %1",CM_ACTIVEPLAYERS];
	CM_ACTIVEPLAYERSmkr setMarkerText _txt;
	sleep 10;
	_days = [CAMPAIGN_STARTDATE, date] call CMM_COUNTDAYS;
	CAMPAIGN_DAYSmkr setMarkerText format ["Campaign Days: %1", _days];
	sleep 110;
	_OLDdays = 0;
	while {true} do {
			_Checkdate = date;
			CM_ACTIVEPLAYERS = count playableUnits;
			_txt = format ["Active Soldiers:  %1",CM_ACTIVEPLAYERS];
			if(_txt != _txtold) then {
				CM_ACTIVEPLAYERSmkr setMarkerText _txt;
				_txtold = _txt;
				};
			_days = 0;
			_days = [CAMPAIGN_STARTDATE, date] call CMM_COUNTDAYS;
			If(_days != _OLDdays) then {
			CAMPAIGN_DAYSmkr setMarkerText format ["Campaign Days: %1", _days];
			[_days,"CMM_TITLEDAYS",true,false,true] call BIS_fnc_MP;
			_OLDdays = _days;
			sleep 60;
			};
		};
true
};
CMM_FORMATDATE = {
/*
	Name:			CMM_FORMATDATE
	Author:			OzDeaDMeaT
	Description:	Moves Markers around based on particular object location. (Primarily used for Zeus Objects)
	Must spawn:		YES
    Usage Example:			[YEAR,MONTH,DAY,HOUR,MINUTE] spawn CMM_MOVEMARKER;
	
	Parameters:
        Index				Type				Variable				Notes
		0					INTEGER				_Year					Year
		1					INTEGER				_Month					Month
		2					INTEGER				_Day					Day
		3					INTEGER				_Hours					Hours
		4					INTEGER				_Minutes				Minutes
		
    Return:
							STRING				_FormattedTime			Nicely formatted Text for date description
*/
private["_Year","_Month","_Day","_Hours","_Minutes","_MonthTxT","_DayTxT","_FormattedTime"];
_Year = date select 0;
_Month = date select 1;
_Day = date select 2;
_Hours = date select 3;
_Minutes = date select 4;
_Minutes = If(_Minutes < 10) then {format ["0%1",_Minutes]} Else {_Minutes};
_MonthTxT = Switch (true) do {
				case (_Month == 1)	:{"January"};
				case (_Month == 2)	:{"February"};
				case (_Month == 3)	:{"March"};
				case (_Month == 4)	:{"April"};
				case (_Month == 5)	:{"May"};
				case (_Month == 6)	:{"June"};
				case (_Month == 7)	:{"July"};
				case (_Month == 8)	:{"August"};
				case (_Month == 9)	:{"September"};
				case (_Month == 10)	:{"October"};
				case (_Month == 11)	:{"November"};
				case (_Month == 12)	:{"December"};
		default {"INVALID_MONTH"};
		};
_DayTxT = Switch (true) do {
				case (_Day == 1)	:{"st"};
				case (_Day == 2)	:{"nd"};
				case (_Day == 3)	:{"rd"};
				case (_Day == 4)	:{"th"};
				case (_Day == 5)	:{"th"};
				case (_Day == 6)	:{"th"};
				case (_Day == 7)	:{"th"};
				case (_Day == 8)	:{"th"};
				case (_Day == 9)	:{"th"};
				case (_Day == 10)	:{"th"};
				case (_Day == 11)	:{"th"};
				case (_Day == 12)	:{"th"};
				case (_Day == 13)	:{"th"};
				case (_Day == 14)	:{"th"};
				case (_Day == 15)	:{"th"};
				case (_Day == 16)	:{"th"};
				case (_Day == 17)	:{"th"};
				case (_Day == 18)	:{"th"};
				case (_Day == 19)	:{"th"};
				case (_Day == 20)	:{"th"};
				case (_Day == 21)	:{"st"};
				case (_Day == 22)	:{"nd"};
				case (_Day == 23)	:{"rd"};
				case(_Day ==  24)	:{"th"};
				case (_Day == 25)	:{"th"};
				case (_Day == 26)	:{"th"};
				case (_Day == 27)	:{"th"};
				case (_Day == 28)	:{"th"};
				case (_Day == 29)	:{"th"};
				case (_Day == 30)	:{"th"};
				case (_Day == 31)	:{"st"};
		default {""};
		};
	_FormattedTime = format ["%1%2 %3 %4 %5:%6",_Day,_DayTxT, _MonthTxT, _Year , _Hours, _Minutes];
//hint format ["%1",_FormattedTime];
	_FormattedTime
};
CMM_COUNTDAYS = {
/*
	Name:			CMM_COUNTDAYS
    Author:         Heeeere's Johnny!, adapted from an idea by OzDeaDMeaT
    Description:    Calculates the difference in days between two given dates, taking in account leap years.
    Must spawn:     No
	Usage Example:	[[STARTDATE],[ENDDATE]] spawn CMM_COUNTDAYS;
    
    Parameters:
        0 ARRAY     dateStart	start date in format [year, month, day]
        1 ARRAY     dateEnd		end date in format [year, month, day]
    
    Return:
        INTEGER		daysTotal	difference in days between the given dates
*/
private ["_dateStart","_dateEnd","_yearStart","_monthStart","_dayStart","_hourStart","_minStart","_yearEnd","_monthEnd","_dayEnd","_hourEnd","_minEnd","_daysTotal","_i","_isLeapYear","_daysSum","_daysOfMonths","_forEachIndex","_x"];
_dateStart    = _this select 0;    //[2016,2,21,6,45];
_dateEnd    = _this select 1;    //[2028,3,6,18,45];

_yearStart    = _dateStart select 0;
_monthStart    = _dateStart select 1;
_dayStart    = _dateStart select 2;
_hourStart    = _dateStart select 3;
_minStart    = _dateStart select 4;

_yearEnd    = _dateEnd select 0;
_monthEnd    = _dateEnd select 1;
_dayEnd        = _dateEnd select 2;
_hourEnd    = _dateEnd select 3;
_minEnd        = _dateEnd select 4;
_daysTotal    = 0;
for "_i" from _yearStart to (_yearEnd - 1) do
{
    /*
    Definition of a leap year:
    - if year is dividable by 4, it is a leap year
    - if year is dividable by 100, it is NOT a leap year
    - if year is dividable by 400, it is a leap year
    - else, it is NOT a leap year
    */
    _isLeapYear    = if(_i mod 4 == 0 && {_i mod 100 != 0 || _i mod 400 == 0}) then {true} else {false};
    if(_isLeapYear) then
    {
        _daysTotal = _daysTotal + 366;
    }
    else
    {
        _daysTotal = _daysTotal + 365;
    };
};
_isLeapYear    = if(_yearStart mod 4 == 0 && {_yearStart mod 100 != 0 || _yearStart mod 400 == 0}) then {true} else {false};
_daysSum    = 0;
_daysOfMonths    = [31, if(_isLeapYear) then {29} else {28}, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
{
    if(_monthStart isEqualTo (_forEachIndex + 1)) exitWith {};
    _daysSum = _daysSum - _x;
} forEach _daysOfMonths;

_isLeapYear    = if(_yearEnd mod 4 == 0 && {_yearEnd mod 100 != 0 || _yearEnd mod 400 == 0}) then {true} else {false};
_daysOfMonths    = [31, if(_isLeapYear) then {29} else {28}, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
{
    if(_monthEnd isEqualTo (_forEachIndex + 1)) exitWith {};
    _daysSum = _daysSum + _x;
} forEach _daysOfMonths;
_daysTotal = _daysTotal - _dayStart + _dayEnd + _daysSum;
_daysTotal
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Curator STUFF
CMM_ZEUSLOADOUT = {
/*
	Name:			CMM_ZEUSLOADOUT
    Author:         OzDeaDMeaT
    Description:    Loadout config for Zeus Player in game
    Must spawn:     YES
	Usage Example:	player spawn CMM_ZEUSLOADOUT;
    
	Parameters:
        Index		Type		Variable		Notes
		0			OBJECT		_Zeus			Zeus Player Object
		
    Return:
					BOOL		true			Returns true when function is complete
*/
private ["_SWRadio","_LRRadio","_Zeus"];
_Zeus = _this;
	sleep 0.5;
	removeAllWeapons _Zeus;
	_Zeus addweapon "RangeFinder";
	_Zeus forceAddUniform "U_BG_Guerilla2_1";
	_Zeus addVest "V_Chestrig_blk";
	_Zeus linkItem "ItemMap";
	_Zeus linkItem "ItemGPS";
	_Zeus linkItem "ItemWatch";
	_Zeus linkItem "AGM_NVG_Gen4";
	_SWRadio = [side player, 1] call TFAR_fnc_getSideRadio;
	_LRRadio = [side player, 0] call TFAR_fnc_getSideRadio;
	_Zeus linkItem _SWRadio;
	_Zeus addBackpack _LRRadio;
	_Zeus addItem "AGM_MapTools";
	_Zeus addItem "AGM_CableTie";
	_Zeus addItem "AGM_CableTie";
	_Zeus addItem "AGM_Bandage";
	_Zeus addItem "AGM_Bandage";
	_Zeus addItem "AGM_Bandage";
	_Zeus addItem "AGM_Bandage";
	_Zeus addItem "AGM_Bandage";
	_Zeus addItem "AGM_Bandage";
	_Zeus addItem "AGM_Bandage";
	_Zeus addItem "AGM_Bandage";
	_Zeus addItem "AGM_Bandage";
	_Zeus addItem "AGM_Bandage";
	_Zeus addItem "AGM_Morphine";
	_Zeus addItem "AGM_Morphine";
	_Zeus addItem "AGM_Morphine";
	_Zeus addItem "AGM_Morphine";
	_Zeus addItem "AGM_Morphine";
	_Zeus addItem "AGM_Epipen";
	_Zeus addItem "AGM_Epipen";
	_Zeus addItem "AGM_Epipen";
	_Zeus addItem "AGM_Epipen";
	_Zeus addItem "AGM_Epipen";
	_Zeus addItem "AGM_Bloodbag";
	_Zeus addItem "AGM_Bloodbag";
	_Zeus addItem "AGM_Bloodbag";
	_Zeus addItem "AGM_Bloodbag";
	_Zeus addItem "AGM_Bloodbag";
	_Zeus addHeadgear "H_Hat_camo";
	_Zeus addGoggles "G_Spectacles";
true;
};
CMM_GETPARTDMG = {
/*
	Name:			CMM_GETPARTDMG
	Author:			OzDeaDMeaT
	Description:	Reports Object Parts Damage in Array Format
	Must spawn:		NO
    Usage Example:			OBJECT call CMM_GETPARTDMG;
	
	Parameters:
        Index				Type				Variable				Notes
		0					OBJECT				_this					Object to collect damage information on
		
    Return:
							ARRAY				_array					Array = [[PART1,DMG],[PART2,DMG]]
*/
private ["_objtype","_array","_hit","_hitC","_cfg","_PartN","_HitP"];
//To use: Vehicle call CMM_GETPARTDMG; >> OutPut Array Similar to [["fuel_hit",0.5],["hull_hit",0.5],["engine_hit",0.5] etc etc]
    _objtype = typeOf _this; 
     _array = []; 
	_hitArray = ((configFile >> "CfgVehicles" >> _objtype >> "HitPoints") call Bis_fnc_getCfgSubClasses); 
	//diag_log format ["HitArray = %1", _hitArray];
    _hitC = (Count _hitArray) - 1;
    for "_i" from 0 to _hitC do { 
        _cfg = _hitArray select _i;
		//_cfg = (configFile >> "CfgVehicles" >> _objtype >> "HitPoints") select _i; 
        //_PartN = getText(_cfg >> "name");
		_HitP = _this getHitPointDamage _cfg; // Changed from _PartN
		if(IsNil "_HitP") then {_HitP = 0};
		_array set [_i,[_cfg,_HitP]];
    }; 
//Returns entire vehicles damage points and damage	
_array 
};
CMM_SETPARTDMG = {
/*
	Name:			CMM_SETPARTDMG
	Author:			OzDeaDMeaT
	Description:	Sets Object Parts Damage from Array
	Must spawn:		NO
    Usage Example:			[Vehicle,[CMM_GETPARTDMGArray]] call CMM_SETPARTDMG
	
	Parameters:
        Index				Type				Variable				Notes
		0					OBJECT				_obj					Object to set damage information on
		1					ARRAYS				_array					Array from CMM_GETPARTDMG
		
    Return:
							BOOL				true					Returns true when function is complete
*/
private ["_obj","_array","_count","_cfg","_PartN","_HitP"];
     _obj = _this select 0;
	 _array = _this select 1;
	 _count = (count _array) - 1;
	 for "_i" from 0 to _count do { 
        //_hitP = _array select _i;
		_obj setHitPointDamage (_array select _i);
    }; 
true
};
CMM_MAGCARGOLOAD = { 	
/*
	Name:			CMM_MAGCARGOLOAD
	Author:			OzDeaDMeaT
	Description:	Loads magazines into crates or Vehicles
	Must spawn:		NO
    Usage Example:			[<Object2Load>,[[MAGName],[Quantity]]] call CMM_MAGCARGOLOAD
	
	Parameters:
        Index				Type				Variable				Notes
		0					OBJECT				_crate					Object to add magazine cargo to
		1					ARRAY										[CLASSNAME,AMOUNT]
		
    Return:
							BOOL				true					Returns true when function is complete
*/
	private["_crate","_array","_count","_i"];
	_crate = _this select 0; //Object ClassNames are being loaded into
	_arr1 = (_this select 1) select 0; //ClassName
	_arr2 = (_this select 1) select 1; //Amount
	_count = count _arr1;
	for "_i" from 0 to (_count - 1) do {
		_crate addMagazineCargoGlobal [(_arr1 select _i),(_arr2 select _i)];
	};
true
};
CMM_WPNCARGOLOAD = {
/*
	Name:			CMM_WPNCARGOLOAD
	Author:			OzDeaDMeaT
	Description:	Sets weapon cargo from array
	Must spawn:		NO
	Usage Example:	[<Object2Load>,[[WeaponName],[QuantityArray]]] call CMM_WPNCARGOLOAD
	
	Parameters:
        Index				Type				Variable				Notes
		0					OBJECT				_crate					Object to add weapon cargo to
		1					ARRAY										[CLASSNAME,AMOUNT]
		
    Return:
					BOOL		true			Returns true when function is complete
*/
private["_crate","_arr1","_arr2","_count","_i"];
	_crate = _this select 0; //Object ClassNames are being loaded into
	_arr1 = (_this select 1) select 0; //ClassName
	_arr2 = (_this select 1) select 1; //Amount
	_count = count _arr1;
	for "_i" from 0 to (_count - 1) do {
		_crate addWeaponCargoGlobal [(_arr1 select _i),(_arr2 select _i)];};
};
CMM_ITMCARGOLOAD = {
/*
	Name:			CMM_ITMCARGOLOAD
	Author:			OzDeaDMeaT
	Description:	Sets item cargo from array
	Must spawn:		NO
    Usage:			[<Object2Load>,[[ItemName],[Quantity]]] call CMM_ITMCARGOLOAD
	
	Parameters:
        Index				Type				Variable				Notes
		0					OBJECT				_crate					Object to add item cargo to
		1					ARRAY										[CLASSNAME,AMOUNT]
		
    Return:
							BOOL				true					Returns true when function is complete
*/
private["_crate","_arr1","_arr2","_count","_i"];
	_crate = _this select 0; //Object ClassNames are being loaded into
	_arr1 = (_this select 1) select 0; //ClassName
	_arr2 = (_this select 1) select 1; //Amount
	_count = count _arr1;
	for "_i" from 0 to (_count - 1) do {
		_crate addItemCargoGlobal [(_arr1 select _i),(_arr2 select _i)];};
};
CMM_BKPCARGOLOAD = {
/*
	Name:			CMM_BKPCARGOLOAD
	Author:			OzDeaDMeaT
	Description:	Sets Backpack cargo from array
	Must spawn:		NO
    Usage:			[<Object2Load>,[[ItemName],[Quantity]]] call CMM_BKPCARGOLOAD
	
	Parameters:
        Index				Type				Variable				Notes
		0					OBJECT				_crate					Object to add backpack cargo to
		1					ARRAY										[CLASSNAME,AMOUNT]
		
    Return:
					BOOL		true			Returns true when function is complete
*/
private["_crate","_arr1","_arr2","_count","_i"];
	_crate = _this select 0; //Object ClassNames are being loaded into
	_arr1 = (_this select 1) select 0; //ClassName
	_arr2 = (_this select 1) select 1; //Amount
	_count = count _arr1;
	for "_i" from 0 to (_count - 1) do {
		_crate addBackpackCargoGlobal [(_arr1 select _i),(_arr2 select _i)];};
};
CMM_VEHICLEADD = {
/*
	Name:			CMM_VEHICLEADD
	Author:			OzDeaDMeaT
	Description:	Adds vehicle to Vehicle backup array
	Must spawn:		NO
    Usage:			vehicle call CMM_VEHICLEADD
	
	Parameters:
        Index				Type				Variable				Notes
		0					OBJECT				_this					Vehicle Object
		
    Return:
					BOOL		true			Returns true when function is complete
*/
private ["_this","_check","_TMPname"];
_TMPname = format ["MISSIONVEHICLE_%1",VEHICLE_COUNT];
missionNamespace setVariable [_TMPname,_this];
_this setVehicleVarName _TMPname;
VEHICLE_COUNT = VEHICLE_COUNT + 1;
if ((RESTORED_VEHICLE find (_this)) == -1) then {
	RESTORED_VEHICLE = RESTORED_VEHICLE + [_this];
	_check = true;
} Else {_check = false};
_check
};
CMM_OBJECTADD = {
/*
	Name:			CMM_OBJECTADD
	Author:			OzDeaDMeaT
	Description:	Adds object to Object backup array
	Must spawn:		NO
    Usage:			object call CMM_OBJECTADD
	
	Parameters:
        Index		Type		Variable		Notes
		0 			OBJECT		_this			Object to add to array
    
    Return:
					BOOL		_check			Returns true when function is complete
*/
private ["_this","_check","_TMPname"];
_TMPname = format ["MISSIONOBJ_%1",OBJECT_COUNT];
missionNamespace setVariable [_TMPname,_this];
_this setVehicleVarName _TMPname;
OBJECT_COUNT = OBJECT_COUNT + 1;
if ((RESTORED_OBJ find (_this)) == -1) then {
	RESTORED_OBJ = RESTORED_OBJ + [_this];
	_check = true;
} Else {_check = false};
_check
};
CMM_VEHICLEREMOVE = {
/*
	Name:			CMM_VEHICLEREMOVE
	Author:			OzDeaDMeaT
	Description:	Removes vehicle from backup array
	Must spawn:		NO
    Usage:			object call CMM_VEHICLEREMOVE
	
	Parameters:
        Index		Type		Variable		Notes
		0 			Object		_this			Object to remove from array
    
    Return:
					BOOL		true			Returns true when function is complete
*/
RESTORED_VEHICLE = RESTORED_VEHICLE - [_this];
true
};
CMM_OBJECTREMOVE = {
/*
	Name:			CMM_OBJECTREMOVE
	Author:			OzDeaDMeaT
	Description:	Removes Object from backup array
	Must spawn:		NO
    Usage:			object call CMM_OBJECTREMOVE
	
	Parameters:
        Index		Type		Variable		Notes
		0 			Object		_this			Object to remove from array
    
    Return:
					BOOL		true			Returns true when function is complete
*/
RESTORED_OBJ = RESTORED_OBJ - [_this];
true
};
CMM_MARKERADD = {
/*
	Name:			CMM_MARKERADD
	Author:			OzDeaDMeaT
	Description:	Adds Markers to backup markers backup array
	Must spawn:		NO
    Usage:			Marker call CMM_MARKERADD
	
	Parameters:
        Index		Type		Variable		Notes
		0 			STRING		_this			Marker to remove from backup array	
    
    Return:
					BOOL		_check			Returns true when function is complete
*/
private ["_this","_check"];
if ((RESTORED_MARKERS find (_this)) == -1) then {
	RESTORED_MARKERS = RESTORED_MARKERS + [_this];
	diag_log format ["Restore Markers Array == %1", RESTORED_MARKERS];
	_check = true;
} Else {_check = false};
_check
};
CMM_MARKERREMOVE = {
/*
	Name:			CMM_MARKERREMOVE
	Author:			OzDeaDMeaT
	Description:	Removes Markers from backup markers array
	Must spawn:		NO
    Usage:			Marker call CMM_MARKERREMOVE
	
	Parameters:
        Index		Type		Variable		Notes
		0 			String			_this				Marker to remove from backup array
    
    Return:
					BOOL		true			Returns true when function is complete
*/
RESTORED_MARKERS = RESTORED_MARKERS - [_this];
true
};
CMM_DEDUPARRAY = {
/*
	Name:			CMM_DEDUPARRAY
	Author:			OzDeaDMeaT
	Description:	Removes duplicate entries in array
	Must spawn:		NO
    Usage Example:	call CMM_GETCFGVEHICLE
	
	Parameters:
        Index		Type		Variable		Notes
		1			ARRAY		_array			Array of Items
		
    Return:
					ARRAY		_unduplicated	Returns an array without duplicates
*/
    private ["_array", "_unduplicated", "_original","_exists"];
    _array = _this;
    _unduplicated = [];
	_count = (count _array) - 1;
	for "_i" from 0 to _count do {
	_item = _array select _i;
	If!(_item In _unduplicated) then {_unduplicated set [count _unduplicated,_item]};
	};
_unduplicated
};  
CMM_GETCFGVEHICLE = {
/*
	Name:			CMM_GETCFGVEHICLE
	Author:			OzDeaDMeaT
	Description:	Adds Zeus Curator marker object to Backup DB
	Must spawn:		NO
    Usage Example:	call CMM_GETCFGVEHICLE
	
	Parameters:
        Index		Type		Variable		Notes
		1			STRING		_mkr			Vehicle Object
		
    Return:
					BOOL		true			Returns true when function is complete
*/
private ["_objtype","_array","_arrayC","_hitC","_cfg","_PartN","_HitP","_output","_nl","_item","_ClassName","_displayName","_vehicleC","_faction","_hiddenSelections","_hiddenSelectionsTextures","_picture","_UIF","_author","_add"];
//Gets ALL items from config
     _array = ((configFile >> "CfgVehicles") call Bis_fnc_getCfgSubClasses); 
	 _arrayC = (count _array) - 1;
	 _output = "";
	 _nl = "[NL]";
	 _output = format ["DisplayName,VehicleClass,Faction,HiddenSelection,HiddenTexture,UnitInfoType,Picture, %1",_nl];
	 //diag_log _output;
	 for "_i" from 0 to _arrayC do {
		_item = _array select _i;
		_ClassName = _item;
		_displayName = gettext (configFile >> "CfgVehicles" >> _item >> "displayName");
		_vehicleC = gettext (configFile >> "CfgVehicles" >> _item >> "vehicleClass");
		_faction = gettext (configFile >> "CfgVehicles" >> _item >> "faction");
		_hiddenSelections = getArray (configFile >> "CfgVehicles" >> _item >> "hiddenSelections");
		_hiddenSelectionsTextures = getArray (configFile >> "CfgVehicles" >> _item >> "hiddenSelectionsTextures");
		_picture = gettext (configFile >> "CfgVehicles" >> _item >> "picture");
		_UIF = gettext (configFile >> "CfgVehicles" >> _item >> "unitInfoType");
		_author = gettext (configFile >> "CfgVehicles" >> _item >> "author");
		_add = format ["%1_!_%2_!_%3_!_%4_!_%5_!_%6_!_%7_!_%8_!_%9%10",_displayName,_ClassName,_vehicleC,_faction,_hiddenSelections,_hiddenSelectionsTextures,_picture,_UIF,_author,_nl];
		//													1			2			3			4			5				6			7						8		9	10
		_output = _output + _add;
		//If(_vehicleC == _this) then {diag_log _add};
		};
_output
};
CMM_CURATORMARKERPLACED = {
/*
	Name:			CMM_CURATORMARKERPLACED
	Author:			OzDeaDMeaT
	Description:	Adds Zeus Curator marker object to Backup DB
	Must spawn:		NO
    Usage Example:	object call CMM_CURATORMARKERPLACED
	
	Parameters:
        Index		Type		Variable		Notes
		1			STRING		_mkr			Vehicle Object
		
    Return:
					BOOL		true			Returns true when function is complete
*/
private ["_mkr","_this"];
_mkr = _this select 1;
[_mkr,"CMM_MARKERADD",false,false,false] call BIS_fnc_MP;
//hint format ["%1", _check];
//diag_log format ["%1", _check];
true
};
CMM_CURATORMARKERREMOVE = {
/*
	Name:			CMM_CURATORMARKERREMOVE
	Author:			OzDeaDMeaT
	Description:	Zeus Curator marker removed, removes marker from Backup DB
	Must spawn:		NO
    Usage Example:	Marker call CMM_CURATORMARKERREMOVE
	
	Parameters:
        Index		Type		Variable		Notes
		1			STRING		_mkr			Marker
		
    Return:
					BOOL		true			Returns true when function is complete
*/
private ["_mkr","_this"];
_mkr = _this select 1;
[_mkr,"CMM_MARKERREMOVE",false,false,false] call BIS_fnc_MP;
true
};
CMM_CURATOROBJECTPLACED = {
/*
	Name:			CMM_CURATOROBJECTPLACED
	Author:			OzDeaDMeaT
	Description:	Zeus Curator object removed removes object from Backup DB
	Must spawn:		NO
    Usage Example:	object call CMM_CURATOROBJECTREMOVE
	
	Parameters:
        Index		Type		Variable		Notes
		1			OBJECT		_veh			Vehicle Object
		
    Return:
					BOOL		true			Returns true when function is complete
*/
private ["_veh","_vehicleC","_type","_DN"];
_veh = _this select 1;
_type = TypeOf _veh;
//hint format ["Curator-CheckPlaced = %1\nAddons = %2", _type, unitAddons (TypeOf _veh)];
_vehicleC = gettext (configFile >> "CfgVehicles" >> _type >> "vehicleClass");
_DN = gettext (configFile >> "CfgVehicles" >> _type >> "displayName");

if ((_veh iskindOf "LandVehicle") || (_veh iskindOf "Air") || (_veh iskindOf "Ship") && (alive _veh)) then {
	_veh setVariable ["AGM_Logistics_loadedItems",[], true];
	If ((Count (crew _veh)) == 0) then {
		[_veh,"CMM_VEHICLEADD",false,false,false] call BIS_fnc_MP;
		//diag_log format ["%1 Vehicle Added",_veh];
	};
};  
If(_vehicleC == "AGM_Repair_Items") then {[_veh,"CMM_OBJECTADD",false,false,false] call BIS_fnc_MP};
If(_vehicleC == "Ammo") then {[_veh,"CMM_CRATEADD",false,false,false] call BIS_fnc_MP; [_veh,"CMM_ADDCRATEACTION",true,false,true] call BIS_fnc_MP};
If (_type In NOTALLOWED) then {deleteVehicle _veh; SystemChat format ["Placement of '%1' is NOT allowed in this mission",_DN]};
If (_type == "ModuleEndMission_F") then {deleteVehicle _veh; SystemChat "Use Radio Buttons to End Mission"};
true
};
CMM_CURATOROBJECTREMOVE = {
/*
	Name:			CMM_CURATOROBJECTREMOVE
	Author:			OzDeaDMeaT
	Description:	Zeus Curator object removed removes object from Backup DB
	Must spawn:		NO
    Usage Example:	object call CMM_CURATOROBJECTREMOVE
	
	Parameters:
        Index		Type		Variable		Notes
		1			OBJECT		_veh			Vehicle Object
		
    Return:
					BOOL		true			Returns true when function is complete
*/
private ["_veh","_vehicleC","_type"];
_veh = _this select 1;
_type = TypeOf _veh;
_vehicleC = gettext (configFile >> "CfgVehicles" >> _type >> "vehicleClass");
if ((_veh iskindOf "LandVehicle") || (_veh iskindOf "Air") || (_veh iskindOf "Ship")) then {
	[_veh,"CMM_VEHICLEREMOVE",false,false,false] call BIS_fnc_MP;
	//diag_log format ["%1 Vehicle Removed",_veh];
};
If(_vehicleC == "Ammo") then {[_veh,"CMM_CRATEREMOVE",false,false,false] call BIS_fnc_MP};
true
};
CMM_CRATEADD = {
/*
	Name:			CMM_CRATEADD
	Author:			OzDeaDMeaT
	Description:	Removes crate from backup array
	Must spawn:		NO
    Usage Example:	crate call CMM_CRATEREMOVE
	
	Parameters:
        Index		Type		Variable		Notes
		0			OBJECT		_this			Crate Object
		
    Return:
					BOOL		true			Returns true when function is complete
*/
private ["_this","_check","_TMPname"];
_TMPname = format ["MISSIONCRATE_%1", CRATE_COUNT];
missionNamespace setVariable [_TMPname,_this];
_this setVehicleVarName _TMPname;
CRATE_COUNT = CRATE_COUNT + 1;
if ((RESTORED_CRATE find (_this)) == -1) then {
	RESTORED_CRATE = RESTORED_CRATE + [_this];
	OzDM_Srv setVariable ["RESTORED_CRATE", RESTORED_CRATE, true];
	_check = true;
} Else {_check = false};
_check
};
CMM_CRATEREMOVE = {
/*
	Name:			CMM_CRATEREMOVE
	Author:			OzDeaDMeaT
	Description:	Removes crate from backup array
	Must spawn:		NO
    Usage Example:	crate call CMM_CRATEREMOVE
	
	Parameters:
        Index		Type		Variable		Notes
		0			OBJECT		_this			Crate Object
		
    Return:
					BOOL		true			Returns true when function is complete
*/
RESTORED_CRATE = RESTORED_CRATE - [_this];
OzDM_Srv setVariable ["RESTORED_CRATE", RESTORED_CRATE, true];
true
};
CMM_JIP_ADDCRATEACTION = {
/*
	Name:			CMM_JIP_ADDCRATEACTION
	Author:			OzDeaDMeaT
	Description:	Adds Actions to Crates for players Joining in Progress
	Must spawn:		NO
    Usage Example:	call CMM_JIP_ADDCRATEACTION
	
	Parameters:
        Index		Type		Variable		Notes
		
    Return:
					ARRAY		_output			Returns Array of equipment / weapons
*/
private ["_Array","_crate"];
_Array = OzDM_Srv getVariable ["RESTORED_CRATE",[]];
for "_i" from 0 to ((count _Array) - 1) do {
	_crate = _Array select _i;
	if(_crate != objNull) then {_crate call CMM_ADDCRATEACTION};
	};
systemChat "AmmoCrates Initialized";
};
CMM_ADDCRATEACTION = {
/*
	Name:			CMM_ADDCRATEACTION
	Author:			OzDeaDMeaT
	Description:	Adds Actions to Crate
	Must spawn:		NO
    Usage Example:	crate call CMM_ADDCRATEACTION
	
	Parameters:
        Index		Type		Variable		Notes
		0			OBJECT		_crate			_crate Object
		
    Return:
					ARRAY		_output			Returns Array of equipment / weapons
*/
private ["_crate","_type"];
_crate = _this;
_type = typeOf _crate;
_crate addAction ["<t color='#889C1C'>Grab Equipment</t>", "_this call CMM_GETGEAR",[],0,false,true,"","((_target distance _this < 3.5) && (GET_SET_GEAR_VAR))"];
_crate addAction ["<t color='#9E5757'>Stow Equipment</t>", "_this call CMM_SETGEAR",[],0,false,true,"","((_target distance _this < 3.5) && !(GET_SET_GEAR_VAR))"];
_crate addAction ["<t color='#D12130'>Drop Equipment</t>", "_this call CMM_RETURNEQUIPMENT",[],0,false,true,"","(_target distance _this < 3.5)"];
	If(_type In ACTIONcrates) then {
		_crate addAction ["<t color='#5E6FCC'>Set Appearance</t>", "_this call CMM_SETAPPEARANCE",[],0,false,true,"","(_target distance _this < 5)"];
	};			//VirtualAmmoBox_1 call CMM_ADDCRATEACTION			hint format ["%1", GET_SET_GEAR_VAR] 		hint format ["%1", typeof cursorTarget]		Box_FIA_Support_F
true
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//PLAYER STUFF
CMM_PLAYERGEARARRAY = {
/*
	Name:			CMM_PLAYERGEARARRAY
	Author:			OzDeaDMeaT
	Description:	Formats array of current players loadout
	Must spawn:		NO
    Usage Example:	[crate,player] call CMM_PLAYERGEARARRAY (excludes uniform and assigned items)
	
	Parameters:
        Index		Type		Variable		Notes
		0			OBJECT		_player			Player Object
		
    Return:
					ARRAY		_output			Returns Array of equipment / weapons
*/
private ["_player", "_headgear","_goggles","_uniform","_uniformITEMS","_vest","_vestITEMS","_backpack","_backpackITEMS","_priW","_priWitems","_priWmag","_secW","_secWitems","_secWmag","_hgW","_hgWitems","_hgWmag","_assignedItems","_attire","_weapons","_weaponsITEMS","_weaponsMAGS","_inventory","_check","_output"];	
_player = _this;
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
//_assignedItems = assignedItems _player;
_attire = 		[_headgear, _goggles, _uniform, _vest, _backpack];
_weapons = 		[_priW,_secW,_hgW];
_weaponsITEMS = [_priWitems, _secWitems, _hgWitems];
_weaponsMAGS = 	[_priWmag, _secWmag, _hgWmag];
_inventory =	[_uniformITEMS, _vestITEMS, _backpackITEMS];
_output = [_weapons, _weaponsITEMS, _weaponsMAGS, _inventory];
_output
};
CMM_STRIPPLAYER = {
/*
	Name:			CMM_STRIPPLAYER
	Author:			OzDeaDMeaT
	Description:	Removes weapons and items from player leaving Assigned Items (excludes Assigned Item weapons - e.g. Binoculars)
	Must spawn:		NO
    Usage Example:	player call CMM_STRIPPLAYER;
	
	Parameters:
        Index		Type		Variable		Notes
		0			OBJECT		_player			Player Object
		
    Return:
					BOOL		true			Returns true when function is complete
*/
private ["_player"];
_player = _this;
removeAllWeapons _player; 
{_player removeItemFromBackpack _x} foreach (backpackItems _player);
{_player removeItemFromUniform _x} foreach (uniformItems _player);
{_player removeItemFromVest _x} foreach (vestItems _player);
};
CMM_RETURNEQUIPMENT = {
/*
	Name:			CMM_RETURNEQUIPMENT
	Author:			OzDeaDMeaT
	Description:	This Function dumps all inventory of a player including weapons (This includes binoculars Item Slot)
	Must spawn:		YES
    Usage Example:	[ammobox1,Unit123] spawn CMM_RETURNEQUIPMENT;
	
	Parameters:
        Index		Type		Variable		Notes
		0			OBJECT		_crate			Crate Object
		1			OBJECT		_unit			Player Object
		
    Return:
					BOOL		true			Returns true when function is complete
*/
private ["_crate","_player","_item","_mags","_weapons","_WeapARR","_weapon","_WeapSilencer",
"_WeapLight","_WeapScope","_BaseWeapon","_Mag1","_Mag2","_i","_j","_k","_txt"];
_crate = _this select 0;
_player = _this select 1;
	_mags = magazines _player;
	_weapons = weaponsItems _player;
	for "_i" from 0 to ((count _weapons) -1) do {
		_WeapARR = _weapons select _i;
		_weapon = _WeapARR select 0;
		_WeapSilencer = _WeapARR select 1;
		_WeapLight = _WeapARR select 2;
		_WeapScope = _WeapARR select 3;
		_BaseWeapon = [_weapon] call BIS_fnc_baseWeapon;
		//Loaded Mags in Selected Weapon
		_Mag1 = If((count _WeapARR) > 4) then {_WeapARR select 4} Else {[""]};
		_Mag2 = If((count _WeapARR) > 5) then {_WeapARR select 5} Else {[""]};
		If((count _Mag1) > 1) then {_crate addMagazineCargoGlobal [(_Mag1 select 0),1]};
		If((count _Mag2) > 1) then {_crate addMagazineCargoGlobal [(_Mag2 select 0),1]};
		//Selected Weapon and Items
		_crate addWeaponCargoGlobal [_BaseWeapon,1];
		If!(_WeapSilencer == "") then {_crate addItemCargoGlobal [_WeapSilencer,1]};
		If!(_WeapLight == "") then {_crate addItemCargoGlobal [_WeapLight,1]};
		If!(_WeapScope == "") then {_crate addItemCargoGlobal [_WeapScope,1]};
	};
	//Magazine Crate load
	_mags = magazines _player;
	for "_j" from 0 to ((count _mags) - 1) do
	{
		_mag = _mags select _j;
		_crate addMagazineCargoGlobal [_mag,1];
		//hint format ["Magainze Loop\nAdded %1\nLoopCount = %2",_mag, _j];
		_player removeMagazine _mag;
	};
	//{_player removeMagazine _x} foreach _mags;
	_inventory = ((backpackCargo _player) + (uniformitems _player) + (vestItems _player));
	for "_k" from 0 to ((count _inventory) -1) do {
		_item = _inventory select _k;
		_txt = getText (configfile >> "CfgWeapons" >> _item >> "tf_parent");
		If(_txt != "") then {
			_crate addItemCargoGlobal [_txt,1];
			_player removeItem _item;
			//hint format ["Item Loop\nAdded %1\nLoopCount = %2",_txt, _k];
		} Else {
			_crate addItemCargoGlobal [_item,1];
			_player removeItem _item;
			//hint format ["Item Loop\nAdded %1\nLoopCount = %2",_item, _k];
		};
	};
removeAllWeapons _player;
true
};
CMM_GETGEAR = {
/*
	Name:			CMM_GETGEAR
	Author:			OzDeaDMeaT
	Description:	Retrieves loadout from  profileNameSpace
	Must spawn:		NO
    Usage Example:	[ammobox1,Unit123] call CMM_GETGEAR;
	
	Parameters:
        Index		Type		Variable		Notes
		0			OBJECT		_arsenal		Crate Object
		1			OBJECT		_unit			Player Object
		
    Return:
					BOOL		true			Returns true when function is complete
*/
Private ["_unit", "_arsenal","_weapons","_magazines","_Player_UniformItems","_Player_vestItems","_Player_BackpackItems","_array","_priW","_secW","_hgW","_WeaponItems","_priWitems","_secWitems","_hgWitems","_WeaponMags","_priWmag","_secWmag","_hgWmag","_magArray","_Inventory","_uniformITEMS","_vestITEMS","_backpackITEMS"];
_arsenal = _this select 0;
_unit = _this select 1;
_array = profileNameSpace getVariable PlayerSTORE_VAR;
_WeaponMags = _array select 2;
	_priWmag = _WeaponMags select 0;
	_secWmag = _WeaponMags select 1;
	_hgWmag = _WeaponMags select 2;
	_magArray = _priWmag + _secWmag + _hgWmag;
	If (count _magArray != 0) then { {player addmagazine _x} foreach _magArray};
_weapons = _array select 0;
	_priW = _weapons select 0;
	_secW = _weapons select 1;
	_hgW = _weapons select 2;
	if (_priW != "") then {player addWeapon _priW};
	if (_secW != "") then {player addWeapon _secW};
	if (_hgW != "") then {player addWeapon _hgW};
_WeaponItems = _array select 1;
	_priWitems = _WeaponItems select 0;
	_secWitems = _WeaponItems select 1;
	_hgWitems = _WeaponItems select 2;
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
_Inventory = _array select 3;
	_uniformITEMS = _Inventory select 0;
	_vestITEMS = _Inventory select 1;
	_backpackITEMS = _Inventory select 2;
	If (count _uniformITEMS != 0) then { {player additemtoUniform _x} foreach _uniformITEMS};
	If (count _vestITEMS != 0) then { {player additemtoVest _x} foreach _vestITEMS};
	If (count _backpackITEMS != 0) then { {player additemtoBackpack _x} foreach _backpackITEMS};
profileNameSpace setVariable [PlayerSTORE_VAR,[]];
saveProfileNamespace;
systemchat "Equipment and Weapons collected";
GET_SET_GEAR_VAR = FALSE;
true
};
CMM_SETGEAR = {
/*
	Name:			CMM_SETGEAR
	Author:			OzDeaDMeaT
	Description:	Saves loadout to profileNameSpace
	Must spawn:		NO
    Usage Example:	[ammobox1,Unit123] call CMM_SETAPPEARANCE;
	
	Parameters:
        Index		Type		Variable		Notes
		0			OBJECT		_arsenal		Crate Object
		1			OBJECT		_unit			Player Object
		
    Return:
					BOOL		true			Returns true when function is complete
*/
Private ["_unit", "_arsenal","_weapons","_magazines","_Player_UniformItems","_Player_vestItems","_Player_BackpackItems","_array"];
_arsenal = _this select 0;
_unit = _this select 1;
_array = _unit call CMM_PLAYERGEARARRAY;
profileNameSpace setVariable [PlayerSTORE_VAR, _array];
saveProfileNamespace;
_unit call CMM_STRIPPLAYER;
systemchat "Equipment and Weapons removed";
GET_SET_GEAR_VAR = TRUE;
};
CMM_SETAPPEARANCE = {
/*
	Name:			CMM_SETAPPEARANCE
	Author:			OzDeaDMeaT
	Description:	Opens Arsenal Crate to allow player to change Appearance
	Must spawn:		NO
    Usage Example:	[ammobox1,Unit123] call CMM_SETAPPEARANCE;
	
	Parameters:
        Index		Type		Variable		Notes
		0			OBJECT		_arsenal		Crate Object
		1			OBJECT		_unit			Player Object
		
    Return:
					BOOL		true			Returns true when function is complete
*/
Private ["_unit", "_arsenal","_weapons","_magazines","_Player_UniformItems","_Player_vestItems","_Player_BackpackItems","_array"];
_arsenal = _this select 0;
_unit = _this select 1;
	_weapons = weapons _unit;
	_magazines = magazines _unit;
	_Player_UniformItems = uniformItems _unit;
	_Player_vestItems = vestItems _unit;
	_Player_BackpackItems = backpackItems _unit;
	_array = _weapons + _magazines + _Player_UniformItems + _Player_vestItems + _Player_BackpackItems;
	if((count _array) == 0) then {
		["Open",[nil,VirtualAmmoBox]] call bis_fnc_arsenal;
	} Else {
	systemChat "Please Stow your equipment before a Appearance";
	};
true
};
CMM_SYSTEMCHAT = {
/*
	Name:			CMM_SYSTEMCHAT
	Author:			OzDeaDMeaT
	Description:	SystemChat for use across the network using BIS_FNC_MP
	Must spawn:		NO
    Usage Example:	"Test Message" call CMM_SYSTEMCHAT;
	
	Parameters:
        Index		Type		Variable		Notes
		0			STRING		_msg			Message to be displayed by SystemChat command
		
    Return:
					BOOL		true			Returns true when function is complete
*/
Private ["_msg"];
_msg = _this;
systemChat _msg;
true
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//SCORE STUFF
CMM_SETPLAYERRANK = {
/*
	Name:			CMM_SETPLAYERRANK
	Author:			OzDeaDMeaT
	Description:	Sets Player Rank
	Must spawn:		NO
    Usage Example:	[player,"RankName"] call CMM_SETPLAYERRANK;
	
	Parameters:
        Index		Type		Variable		Notes
		0			OBJECT		_player			Player Object
		1			STRING		_rankName		Rank Name for new Player Object Rank
		
    Return:
					BOOL		true			Returns true when function is complete
*/
private["_player","_rankName","_this"];
_player = _this select 0;
_rankName = _this select 1;
diag_log format ["CMM_SETPLAYERRANK Info %1",_this ];
_player setRank _rankName;
true
};
CMM_CHECKRANK = {
/*
	Name:			CMM_CHECKRANK
	Author:			OzDeaDMeaT
	Description:	Shows Player Statistics 
	Must spawn:		NO
    Usage Example:	call CMM_SHOWMYSCORE;
	
	Parameters:
        Index		Type		Variable		Notes
    
    Return:
					BOOL		true			Returns true when function is complete
*/
private["_score","_i","_rankID","_RANKSCORE"];
	_score = _this;
	_rankID = 0;
	for "_i" from 0 to (count RANKSCORE -1) do {
		_RANKSCORE = RANKSCORE select _i;
		If(_score >= _RANKSCORE) then {_rankID = _i};
	};
_rankID
};
CMM_SHOWMYSCORE = {
/*
	Name:			CMM_SHOWMYSCORE
	Author:			OzDeaDMeaT
	Description:	Shows Player Statistics 
	Must spawn:		NO
    Usage Example:	call CMM_SHOWMYSCORE;
	
	Parameters:
        Index		Type		Variable		Notes
    
    Return:
					BOOL		true			Returns true when function is complete
*/
private["_name","_uid","_VARname","_score","_totalScore","_historyArray","_Missions","_PreviousScore","_SuccessfulMissions","_NextRankName","_NextRankTexture","_NextRankScore","_CurrentRankID","_CurrentRankTexture","_CurrentRankSN","_CurrentRankName","_EMTNR", "_AverageXP","_PreviousRankScore","_CurrentRankBaseScore","_oldRank","_PlayerVarName","_CurrentScore","_nextRankID","_XP2NextRank","_PlayerEntity"];
_name = name player;
_uid = getPlayerUID player;
_rankID = 0;
_VARname = format ["%1_HISTORY",_uid];
_historyArray = OzDM_Srv getVariable [_Varname,[0, 0, 0]];
_PlayerEntity = vehicleVarName player;
_PreviousScore = _historyArray select 0;
_Missions = _historyArray select 1;
_SuccessfulMissions = _historyArray select 2;
_score = score player;
_PlayerOBJ = objectFromNetId (netid player);
_totalScore = _PreviousScore + _score;
_oldRank = rankID player;
_CurrentRankID = _totalScore call CMM_CHECKRANK;
_CurrentRankBaseScore = (RANKSCORE select _CurrentRankID);
_CurrentScore = _totalScore - _CurrentRankBaseScore;
_PreviousRankScore = If((_CurrentRankID - 1) >= 0) then {RANKSCORE select (_CurrentRankID - 1)} Else {RANKSCORE select 0};
_CurrentRankTexture = getText (configFile >> "CfgRanks" >> (str _CurrentRankID) >> "texture");
_CurrentRankName = (RANKNAME select _CurrentRankID);
_CurrentRankSN = (RANKSN select _CurrentRankID);
if(_oldRank != _CurrentRankID) then {[[_PlayerOBJ,_CurrentRankName],"CMM_SETPLAYERRANK",true,false,true] call BIS_fnc_MP};
_nextRankID = If((_CurrentRankID + 1) > (count RANKSCORE - 1)) then {count RANKSCORE - 1} Else {_CurrentRankID + 1};
_NextRankTexture = getText (configFile >> "CfgRanks" >> (str _nextRankID) >> "texture");
_NextRankScore = (RANKSCORE select _nextRankID);
_NextRankName = (RANKNAME select _nextRankID);
_XP2NextRank = _NextRankScore - _CurrentRankBaseScore;
if(_Missions == 0) then {_Missions = 1};
if(_totalScore == 0) then {_totalScore = 1};
//Estimated Missions To Next Rank
_AverageXP = [(_totalScore / _Missions),2]  call BIS_fnc_cutDecimals;
_EMTNR = ceil((_NextRankScore - _totalScore) / _AverageXP);
hintSilent parseText format 
	[
	"<t color='#C2B500' align='center' size='1.75'><img size = '3.75' image='%1'/>
	<br />
	%2 %3</t>
	<br />
	<t color='#C2B500' align='center' size='2'>Service Record</t>
	<br />
	<t color='#436991' align='left' size='1'>Rank:  </t><t color='#E9F0F7' align='left' size='1'>%4</t>
	<br />
	<t color='#436991' align='left' size='1'>Name:  </t><t color='#E9F0F7' align='left' size='1'>%3</t>
	<br />
	<t color='#436991' align='left' size='1'>EntityID:  </t><t color='#E9F0F7' align='left' size='1'>%15</t>
	<br />
	<t color='#436991' align='left' size='1'>Serial#:  </t><t color='#E9F0F7' align='left' size='1'>%5</t>
	<br />
	<t color='#436991' align='left' size='1'>Current Mission XP:  </t><t color='#E9F0F7' align='left' size='1'>%6</t>
	<br />
	<t color='#436991' align='left' size='1'>Avg XP per mission:  </t><t color='#E9F0F7' align='left' size='1'>%7</t>
	<br />
		<t color='#436991' align='left' size='1'>Total Missions:  </t><t color='#E9F0F7' align='left' size='1'>%8</t>
	<br />
	<t color='#436991' align='left' size='1'>Successful Missions: </t><t color='#E9F0F7' align='left' size='1'>%9</t>
	<br />
	<t color='#436991' align='left' size='1'>XP To Level: </t><t color='#43914F' align='left' size='1'>%10</t><t color='#E9F0F7' align='left' size='1'> / </t><t color='#C2B500' align='left' size='1'>%11</t>
	<br />
	<t color='#436991' align='left' size='1'>Next Rank: </t><t color='#C2B500' align='left' size='1'>%12 <img size = '0.75' image='%13'/></t>
	<br />	
	<t color='#436991' align='left' size='1'>Estimated Missions to next Level #: </t><t color='#E9F0F7' align='left' size='1'>%14</t>
	<br />
	",_CurrentRankTexture, _CurrentRankSN, _name, _CurrentRankName, _uid, _score, _AverageXP, _Missions, _SuccessfulMissions, _CurrentScore, _XP2NextRank, _NextRankName, _NextRankTexture, _EMTNR,_PlayerEntity];
	//	1					2				3		4				5		6			7		8				9					10			11			12				13				14
};
CMM_SHOWSERVERSCORE = {
/*
	Name:			CMM_SHOWSERVERSCORE
	Author:			OzDeaDMeaT
	Description:	Shows Server Statistics
	Must spawn:		NO
    Usage Example:	call CMM_SHOWSERVERSCORE;
	
	Parameters:
        Index		Type		Variable		Notes
    
    Return:
					BOOL		true			Returns true when function is complete
*/
private["_name","_array","_Missions","_SuccessRate","_DeathsPerMission","_Deaths","_MissionsSuccess","_TotalPlayers","_Perc","_CampaignStartDate","_vehicleCount","_crateCount","_objectCount"];
_name = CAMPAIGN_NAME;
_array = OzDM_Srv getVariable "MISSION-History";
	if(count _array != 0) then {
		_Missions = _array select 0;
		_MissionsSuccess = _array select 1;
		_Deaths = _array select 2;
		_DeathsPerMission = 0;
		_SuccessRate = 0;
		If (_Deaths != 0) then {_DeathsPerMission = ([(_Deaths / _Missions),2] call BIS_fnc_cutDecimals)} Else {_DeathsPerMission = 0};
		_TotalPlayers =  _array select 3;
		_CampaignStartDate = _array select 4;
		_vehicleCount = _array select 5;
		_crateCount = _array select 6;
		_objectCount = _array select 7;
		_Perc = "%";
		If((_Missions == 0) || (_MissionsSuccess == 0)) then {_SuccessRate = 0} Else {_SuccessRate = ([((_MissionsSuccess / _Missions)*100),2] call BIS_fnc_cutDecimals)};
OzDM_Srv setVariable ["MISSION-History",[MISSION_HISTORY,MISSION_SUCCESS_HISTORY,DEATHS_HISTORY,Total_PDPlayers,CAMPAIGN_STARTDATE,VEHICLE_COUNT, CRATE_COUNT, OBJECT_COUNT],TRUE];
	hintSilent parseText format 
		[
		"<t color='#C2B500' align='center' size='2'>Server Record</t><br />
		<t color='#C2B500' align='center' size='1.5'>
		Campaign: 
		<br />
		%1</t>
		<br />
		<t color='#436991' align='left' size='1'>Missions Conducted:  </t><t color='#C2B500' align='left' size='1'>%2</t>
		<br />
		<t color='#436991' align='left' size='1'>Accomplished Mission:  </t><t color='#E9F0F7' align='left' size='1'>%3</t>
		<br />
		<t color='#436991' align='left' size='1'>Mission Success Rate:  </t><t color='#E9F0F7' align='left' size='1'>%4 %5</t>
		<br />
		<t color='#436991' align='left' size='1'>Campaign Fatalities:  </t><t color='#E9F0F7' align='left' size='1'>%6</t>
		<br />
		<t color='#436991' align='left' size='1'>Fatalities Per Mission#:  </t><t color='#E9F0F7' align='left' size='1'>%7</t>
		<br />
		<t color='#436991' align='left' size='1'>Registered Players:  </t><t color='#E9F0F7' align='left' size='1'>%8</t>
		<br />
		<t color='#436991' align='left' size='1'>Vehicles Created:  </t><t color='#E9F0F7' align='left' size='1'>%9</t>
		<br />
		<t color='#436991' align='left' size='1'>Crates Created:  </t><t color='#E9F0F7' align='left' size='1'>%10</t>
		<br />
		<t color='#436991' align='left' size='1'>Objects Created:  </t><t color='#E9F0F7' align='left' size='1'>%11</t>
		<br />				
		",_name, _Missions, _MissionsSuccess, _SuccessRate, _Perc, _Deaths, _DeathsPerMission, _TotalPlayers, _vehicleCount, _crateCount, _objectCount];
		//	1		2				3			4				5	6			7				8				9				10			11
	} Else {Hint "Server Data Unavailable"};
true
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//MARKER STUFF
CMM_SERVERDEATHCOUNT = {
/*
	Name:			CMM_SERVERDEATHCOUNT
	Author:			OzDeaDMeaT
	Description:	Utilized when a player dies. Adds 1 Death and removes 1 Life
	Must spawn:		NO
    Usage Example:	call CMM_SERVERDEATHCOUNT;
	
	Parameters:
        Index		Type		Variable		Notes
    
    Return:
					BOOL		true			Returns true when function is complete
*/
	if(IsServer) then {
		call CMM_ADDDEATH;
		call CMM_REMOVELIFE;
		diag_log format ["Death Added to Mission. Deaths = %1", CM_DEATHS];
	};
true
};
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//ADMIN STUFF
CMM_ADDDEATH = {
/*
	Name:			CMM_ADDDEATH
	Author:			OzDeaDMeaT
	Description:	Adds a Death from the Current Mission Deaths
	Must spawn:		NO
    Usage Example:	call CMM_ADDDEATH;
	
	Parameters:
        Index		Type		Variable		Notes
    
    Return:
					BOOL		true			Returns true when function is complete
*/
private ["_txt1"];
	if(IsServer) then {
		CM_DEATHS = (CM_DEATHS + 1);
		_txt1 = format ["Mission Deaths:  %1",CM_DEATHS];
		CM_DEATHSmkr setMarkerText _txt1;
	};
true
};
CMM_REMOVEDEATH = {
/*
	Name:			CMM_REMOVEDEATH
	Author:			OzDeaDMeaT
	Description:	Removes a Death from the Current Mission Deaths
	Must spawn:		NO
    Usage Example:	call CMM_REMOVEDEATH;
	
	Parameters:
        Index		Type		Variable		Notes
    
    Return:
					BOOL		true			Returns true when function is complete
*/
private ["_txt1"];
	if(IsServer) then {
		CM_DEATHS = (CM_DEATHS - 1);
		_txt1 = format ["Mission Deaths:  %1",CM_DEATHS];
		CM_DEATHSmkr setMarkerText _txt1;
		diag_log format ["Death Removed from Mission. Deaths = %1", CM_DEATHS];
	};
true
};
CMM_ADDLIFE = {
/*
	Name:			CMM_ADDLIFE
	Author:			OzDeaDMeaT
	Description:	Adds a Life from the Life Pool
	Must spawn:		NO
    Usage Example:	call CMM_ADDLIFE;
	
	Parameters:
        Index		Type		Variable		Notes
    
    Return:
					BOOL		true			Returns true when function is complete
*/
private ["_txt1"];
	if(IsServer) then {
		CM_LIVES = (CM_LIVES + 1);
		_txt1 = format ["Lives Remaining:  %1",CM_LIVES];
		CM_LIVESmkr setMarkerText _txt1;
	};
true
};
CMM_REMOVELIFE = {
/*
	Name:			CMM_REMOVELIFE
	Author:			OzDeaDMeaT
	Description:	Removes a Life from the Life Pool
	Must spawn:		NO
    Usage Example:	call CMM_REMOVELIFE;
	
	Parameters:
        Index		Type		Variable		Notes
    
    Return:
					BOOL		true			Returns true when function is complete
*/
private ["_txt1"];
	if(IsServer) then {
		CM_LIVES = (CM_LIVES - 1);
		_txt1 = format ["Lives Remaining:  %1",CM_LIVES];
		CM_LIVESmkr setMarkerText _txt1;
	};
true
};
CMM_MOVEZEUS = {
/*
	Name:			CMM_MOVEZEUS
	Author:			OzDeaDMeaT
	Description:	Moves Objects to location of Return Object
	Must spawn:		NO
    Usage Example:	player call CMM_MOVEZEUS;
	
	Parameters:
        Index		Type		Variable		Notes
		0 			OBJECT		_zeusPlayer		Object
    
    Return:
					BOOL		true			Returns true when function is complete
*/
private ["_zeusPlayer"];
_zeusPlayer = _this;
	If!(IsNull _zeusPlayer) then {
		If!(IsNull RETURN) then {
			_zeusPlayer setpos getpos RETURN;
			systemChat format ["%1 Moved", name _ZeusPlayer];
		} Else {
			systemchat "Location Object deleted, restart mission to re-enable this feature"
		};
	} Else {
		systemchat "Object Not Found, nothing to move";
	};
true
};		



//REMOVE
/*
setVehicleName = {
private ["_veh","_name"];
_veh = _this select 0;
_name = _this select 1;
_veh setVehicleVarName _name;
true
};
CheckPlaced = {
private ["_veh","_vehicleC"];
_veh = _this;
_type = TypeOf _veh;
_vehicleC = gettext (configFile >> "CfgVehicles" >> _type >> "vehicleClass");
If(_vehicleC == "Ammo") then {_veh call CMM_ADDCRATEACTION};
if ((_veh iskindOf "LandVehicle") || (_veh iskindOf "Air") || (_veh iskindOf "Ship") && (alive _veh)) then {If ((Count (crew _veh)) == 0) then {_veh call CMM_VEHICLEADD}};
};
CheckDeleted = {
_veh = _this;
_veh call CMM_VEHICLEREMOVE;
_veh call CMM_CRATEREMOVE;
};
