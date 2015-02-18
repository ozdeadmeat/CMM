//TaskForceRadio Config	START
player setVariable ["tf_receivingDistanceMultiplicator", 6];
player setVariable ["tf_sendingDistanceMultiplicator", 6];
//TaskForceRadio Config END

//Prep Arrays and Systems
//Campaign Mission Mechanics INIT (SERVER / CLIENT)
#include "CMM\CMM_init.sqf";
#include "CMM\CMM_functions.sqf";
call compilefinal preprocessFileLineNumbers "BME\init.sqf";

_player = _this select 0;
_didJIP =  _this select 1;

_player spawn CMM_PLAYER_STARTUP; //Function in Misc Functions
sleep 15;
null = [] spawn CMM_JIP_ADDCRATEACTION; //Loads Actions for all current Crates in game
