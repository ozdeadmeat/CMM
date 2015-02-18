


//FOR MAP
//class rGUI_map: ATLAS_RscMapControl

class rGUI_squadGUI
{
	idd = 7230;
	onLoad = "_this spawn ATLAS_fnc_SquadManagement_squadGUIOpened"; 
	//onUnload = "";
	movingEnable = 0;
	

controls[]=
{
	IGUIBack_2200,
	ATLAS_RscPicture_1201,
	ATLAS_RscPicture_1202,
	ATLAS_RscPicture_1204,
	ATLAS_RscPicture_1205,
	ATLAS_RscButton_1600,
	ATLAS_RscButton_1601,
	ATLAS_RscButton_1602,
	ATLAS_RscButton_1603,
	ATLAS_RscButton_1604,
	ATLAS_RscButton_1605,
	ATLAS_RscButton_1606,
	ATLAS_RscListbox_1500,
	ATLAS_RscListbox_1501,
	ATLAS_RscEdit_1400,
	ATLAS_RscCombo_2100,
	ATLAS_RscText_1000
	
	
};


////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by {RW} Hywel, v1.063, #Dexotu)
////////////////////////////////////////////////////////

class IGUIBack_2200: IGUIBack
{
	idc = -1;

	x = 0.251892 * safezoneW + safezoneX;
	y = 0.191961 * safezoneH + safezoneY;
	w = 0.507865 * safezoneW;
	h = 0.679964 * safezoneH;
	colorBackground[] = {0,0,0,0.85};
};
class ATLAS_RscPicture_1201: ATLAS_RscPicture
{
	idc = 1201;
	text = "#(argb,8,8,3)color(1,0,0,0.85)";
	x = 0.417845 * safezoneW + safezoneX;
	y = 0.0920216 * safezoneH + safezoneY;
	w = 0.156841 * safezoneW;
	h = 0.118994 * safezoneH;
};
class ATLAS_RscPicture_1202: ATLAS_RscPicture
{
	idc = 1202;
	text = "#(argb,8,8,3)color(0,0,1,0.85)";
	x = 0.417845 * safezoneW + safezoneX;
	y = 0.0920216 * safezoneH + safezoneY;
	w = 0.164309 * safezoneW;
	h = 0.118994 * safezoneH;
};
class ATLAS_RscPicture_1204: ATLAS_RscPicture
{
	idc = 1204;
	text = "#(argb,8,8,3)color(0,1,0,0.85)";
	x = 0.417845 * safezoneW + safezoneX;
	y = 0.0920216 * safezoneH + safezoneY;
	w = 0.164309 * safezoneW;
	h = 0.118994 * safezoneH;
};
class ATLAS_RscPicture_1205: ATLAS_RscPicture
{
	idc = 1205;
	text = "ATLAS\rGUI_BASE\logFrame.paa";
	x = 0.183663 * safezoneW + safezoneX;
	y = 0.0659448 * safezoneH + safezoneY;
	w = 0.6423 * safezoneW;
	h = 0.883953 * safezoneH;
};
class ATLAS_RscButton_1600: ATLAS_RscButton
{
	action = "(lbCurSel 1501) call ATLAS_fnc_SquadManagement_joinGroup;";

	idc = 1600;
	text = $STR_ATLAS_JoinGroup;
	x = 0.333542 * safezoneW + safezoneX;
	y = 0.6128 * safezoneH + safezoneY;
	w = 0.0636458 * safezoneW;
	h = 0.0376 * safezoneH;
};
class ATLAS_RscListbox_1500: ATLAS_RscListbox
{
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * (1.35 - (getResolution select 5)))";

	idc = 1500;
	x = 0.309063 * safezoneW + safezoneX;
	y = 0.3026 * safezoneH + safezoneY;
	w = 0.112604 * safezoneW;
	h = 0.3008 * safezoneH;
	colorBackground[] = {0,0,0,0.5};
};
class ATLAS_RscButton_1601: ATLAS_RscButton
{
	action = closeDialog 0;

	idc = 1601;
	text = $STR_ATLAS_CLOSE;
	x = 0.475521 * safezoneW + safezoneX;
	y = 0.7162 * safezoneH + safezoneY;
	w = 0.0448116 * safezoneW;
	h = 0.0339982 * safezoneH;
};
class ATLAS_RscListbox_1501: ATLAS_RscListbox
{
	onLBSelChanged = "[] call ATLAS_fnc_SquadManagement_refreshGroupMembers";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * (1.5 - (getResolution select 5)))";
	idc = 1501;
	x = 0.431458 * safezoneW + safezoneX;
	y = 0.2744 * safezoneH + safezoneY;
	w = 0.254583 * safezoneW;
	h = 0.329 * safezoneH;
};
class ATLAS_RscButton_1602: ATLAS_RscButton
{
	action = "[] call ATLAS_fnc_SquadManagement_createGroup;";

	idc = 1602;
	text = $STR_ATLAS_CreateGroup;
	x = 0.333542 * safezoneW + safezoneX;
	y = 0.6598 * safezoneH + safezoneY;
	w = 0.0636458 * safezoneW;
	h = 0.0376 * safezoneH;
};
class ATLAS_RscEdit_1400: ATLAS_RscEdit
{
	idc = 1400;
	x = 0.406979 * safezoneW + safezoneX;
	y = 0.6598 * safezoneH + safezoneY;
	w = 0.141979 * safezoneW;
	h = 0.0376 * safezoneH;
};
class ATLAS_RscButton_1603: ATLAS_RscButton
{
	action =	"[] call ATLAS_fnc_SquadManagement_leaveGroup;";

	idc = 1603;
	text = $STR_ATLAS_LeaveGroup;
	x = 0.333542 * safezoneW + safezoneX;
	y = 0.6128 * safezoneH + safezoneY;
	w = 0.0636458 * safezoneW;
	h = 0.0376 * safezoneH;
};
class ATLAS_RscText_1000: ATLAS_RscText
{
	idc = 1000;
	text = $STR_ATLAS_GroupName;
	x = 0.309063 * safezoneW + safezoneX;
	y = 0.265 * safezoneH + safezoneY;
	w = 0.112604 * safezoneW;
	h = 0.0376 * safezoneH;
};
class ATLAS_RscButton_1604: ATLAS_RscButton
{
	action =	"(lbcursel 1500) call ATLAS_fnc_SquadManagement_kickFromGroup;";

	idc = 1604;
	text = $STR_ATLAS_KICK;
	x = 0.431458 * safezoneW + safezoneX;
	y = 0.3026 * safezoneH + safezoneY;
	w = 0.05875 * safezoneW;
	h = 0.0282 * safezoneH;
	
};
class ATLAS_RscButton_1605: ATLAS_RscButton
{
	action =	"(lbcursel 1500) call ATLAS_fnc_SquadManagement_makeGroupLeader;";

	idc = 1605;
	text = $STR_ATLAS_MakeLeader;
	x = 0.431458 * safezoneW + safezoneX;
	y = 0.3402 * safezoneH + safezoneY;
	w = 0.05875 * safezoneW;
	h = 0.0282 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * (1.4 - (getResolution select 5)))";
};
class ATLAS_RscCombo_2100: ATLAS_RscCombo
{
	onLBSelChanged = "[] call ATLAS_fnc_SquadManagement_lockGroup";

	idc = 2100;
	text = $STR_ATLAS_GroupOpen;
	x = 0.431458 * safezoneW + safezoneX;
	y = 0.3778 * safezoneH + safezoneY;
	w = 0.127292 * safezoneW;
	h = 0.0282 * safezoneH;
};
class ATLAS_RscButton_1606: ATLAS_RscButton
{
	action = "[] call ATLAS_fnc_SquadManagement_refreshGroupGUI";

	idc = 1606;
	text = $STR_ATLAS_Refresh;
	x = 0.656667 * safezoneW + safezoneX;
	y = 0.688 * safezoneH + safezoneY;
	w = 0.0391667 * safezoneW;
	h = 0.047 * safezoneH;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////





	
	
	
	
	
	
	





};


