

_sender = (_this select 0);
_group = (_this select 1);
_type = (_this select 2);
_value = (_this select 3);


_params = [];

switch (_type) do 
{
    case "lock": {if(_value == 1) then {_params = [_sender,"STR_ATLAS_groupLocked"];} else {_params = [_sender,"STR_ATLAS_groupUnLocked"];};};
    case "kick": {_params = [_value,"STR_ATLAS_playerKicked"];};
    case "join": {_params = [_sender,"STR_ATLAS_playerJoined"];};
    case "leave": {_params = [_sender,"STR_ATLAS_playerLeft"];};
	case "newLeader": {_params = [_value,("STR_ATLAS_newLeader")];};
    default {};
};

_params call ATLAS_fnc_SquadManagement_showNotification;