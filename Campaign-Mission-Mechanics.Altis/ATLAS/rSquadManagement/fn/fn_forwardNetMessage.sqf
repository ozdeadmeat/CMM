_sender = (_this select 0);
_group = (_this select 1);
_type = (_this select 2);
_value = (_this select 3);







{
	if((isPlayer _x) && (_x != _sender)) then
	{
		if(local _x) then
		{
			_this call ATLAS_fnc_SquadManagement_receiveNetMessage;
		
		} else
		{
			ATLAS_squadManagementNetMessage = _this;
			(owner _x) publicVariableClient "ATLAS_squadManagementNetMessage";
		};

	};


} forEach (units _group);