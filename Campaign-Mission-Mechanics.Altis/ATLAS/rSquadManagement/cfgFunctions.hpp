class rSquadManagement
{

	class SquadManagement_init
	{
		//ATLAS_fnc_SquadManagement_init
		description="start squad manager";
		postInit = 1;
		file = "ATLAS\rSquadManagement\fn\init.sqf";
	};
	
	class SquadManagement_checkGroup
	{
		//ATLAS_fnc_SquadManagement_checkGroup
		description="Check if group is real,locked etc";
		file = "ATLAS\rSquadManagement\fn\fn_checkGroup.sqf";
	};
	
	class SquadManagement_createGroup
	{
		//ATLAS_fnc_SquadManagement_createGroup
		description="Create a joinable group";
		file = "ATLAS\rSquadManagement\fn\fn_createGroup.sqf";
	};
	
	class SquadManagement_joinGroup
	{
		//ATLAS_fnc_SquadManagement_joinGroup
		description="Join a group";
		file = "ATLAS\rSquadManagement\fn\fn_joinGroup.sqf";
	};
	
	class SquadManagement_kickFromGroup
	{
		//ATLAS_fnc_SquadManagement_kickFromGroup
		description="Kick player from your group";
		file = "ATLAS\rSquadManagement\fn\fn_kickFromGroup.sqf";
	};
	
	class SquadManagement_leaveGroup
	{
		//ATLAS_fnc_SquadManagement_leaveGroup
		description="Leave current group";
		file = "ATLAS\rSquadManagement\fn\fn_leaveGroup.sqf";
	};
	
	
	class SquadManagement_lockGroup
	{
		//ATLAS_fnc_SquadManagement_lockGroup
		description="Lock or unlock group";
		file = "ATLAS\rSquadManagement\fn\fn_lockGroup.sqf";
	};
	
	class SquadManagement_makeGroupLeader
	{
		//ATLAS_fnc_SquadManagement_makeGroupLeader
		description="Prmote unit to leader of group";
		file = "ATLAS\rSquadManagement\fn\fn_makeGroupLeader.sqf";
	};
	
	class SquadManagement_refreshGroupGUI
	{
		//ATLAS_fnc_SquadManagement_refreshGroupGUI
		description="Refresh entire group GUI";
		file = "ATLAS\rSquadManagement\fn\fn_refreshGroupGUI.sqf";
	};
	
	class SquadManagement_refreshGroupList
	{
		//ATLAS_fnc_SquadManagement_refreshGroupList
		description="Refresh list of groups";
		file = "ATLAS\rSquadManagement\fn\fn_refreshGroupList.sqf";
	};
	
	class SquadManagement_refreshGroupMembers
	{
		//ATLAS_fnc_SquadManagement_refreshGroupMembers
		description="Refresh List of group's members";
		file = "ATLAS\rSquadManagement\fn\fn_refreshGroupMembers.sqf";
	};
	
	class SquadManagement_squadGUIOpened
	{
		//ATLAS_fnc_SquadManagement_squadGUIOpened
		description="Fired when squad GUI is opened";
		file = "ATLAS\rSquadManagement\fn\fn_squadGUIOpened.sqf";
	};

	class SquadManagement_forwardNetMessage
	{
		//ATLAS_fnc_SquadManagement_forwardNetMessage
		description="Relay info to client";
		file = "ATLAS\rSquadManagement\fn\fn_forwardNetMessage.sqf";
	};
	
	class SquadManagement_receiveNetMessage
	{
		//ATLAS_fnc_SquadManagement_receiveNetMessage
		description="receive info (player joined your squad etc)";
		file = "ATLAS\rSquadManagement\fn\fn_receiveNetMessage.sqf";
	};
	
	class SquadManagement_showNotification
	{
		//ATLAS_fnc_SquadManagement_showNotification
		description="display info (player joined your squad etc)";
		file = "ATLAS\rSquadManagement\fn\fn_showNotification.sqf";
	};
	
	
	
};




