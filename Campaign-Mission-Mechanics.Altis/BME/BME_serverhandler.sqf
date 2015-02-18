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
		BME_netcode_server_nameofyourvariable = { code to execute on server side };
	*/

	// Example function write log on server side
	BME_netcode_server_bme_log = {
		bme_log = _this select 0;
		hint format["BME: %1", bme_log];
		diag_log format["BME: %1", bme_log];
	};
	BME_netcode_server_CMM_ClientRequest_PPD = {
	CMM_ClientRequest_PPD = _this select 0;
	_player = CMM_ClientRequest_PPD select 0;
	_uid = CMM_ClientRequest_PPD select 1;
	_name = name _player;
	_clientId = owner _player;
	diag_log format ["Data Request for player %1 :: UID %2",_player,_uid];
	[_player, _clientId, _uid, _name] spawn iniDB_SendPlayerPD;
	};
	/*
	BME_netcode_server_PlayerHistory = {
	_player = _this;
	_clientId = owner _player;
	_VARname = format ["%1_SCORE",_UID];
	_player addEventHandler ["HandleScore",{_this call iniDB_ScoreHandler}];
	
	OzDM_Srv setVariable [_VARname, _score];
	};
	*/



	// return true when read
	true;