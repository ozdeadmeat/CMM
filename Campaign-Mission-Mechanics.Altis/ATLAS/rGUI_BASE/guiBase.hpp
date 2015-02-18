


//FOR MAP
//class rGUI_map: ATLAS_RscMapControl

class rGUI_guiBase
{
	idd = 7200;
	onLoad = "uiNamespace setVariable ['rGUI_guiBase', (_this select 0)]"; 
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
	ATLAS_RscListbox_1500,
	ATLAS_RscStructuredText_1100,
	ATLAS_RscButton_1601
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by LOKI, v1.063, #Bihelo)
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
	action = [x_selectedRole] call ATLAS_fnc_changeRoles;

	idc = 1600;
	text = "Change Role"; //--- ToDo: Localize;
	x = 0.305816 * safezoneW + safezoneX;
	y = 0.618994 * safezoneH + safezoneY;
	w = 0.10456 * safezoneW;
	h = 0.0509973 * safezoneH;
};
class ATLAS_RscListbox_1500: ATLAS_RscListbox
{
	sizeEx = 0.025;

	idc = 1500;
	x = 0.298348 * safezoneW + safezoneX;
	y = 0.279012 * safezoneH + safezoneY;
	w = 0.126966 * safezoneW;
	h = 0.322983 * safezoneH;
	colorBackground[] = {0,0,0,0.5};
};
class ATLAS_RscStructuredText_1100: ATLAS_RscStructuredText
{
	idc = 1100;
	x = 0.434049 * safezoneW + safezoneX;
	y = 0.279012 * safezoneH + safezoneY;
	w = 0.285324 * safezoneW;
	h = 0.462059 * safezoneH;
	colorBackground[] = {0,0,0,0.5};
};
class ATLAS_RscButton_1601: ATLAS_RscButton
{
	action = closeDialog 0;

	idc = 1601;
	text = "EXIT"; //--- ToDo: Localize;
	x = 0.332527 * safezoneW + safezoneX;
	y = 0.682023 * safezoneH + safezoneY;
	w = 0.0448116 * safezoneW;
	h = 0.0339982 * safezoneH;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

	
	
	
	
	
	
	





};


