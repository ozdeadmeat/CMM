

class rGUI_squadNotification
{
	idd = 7240;
	duration = 7;
	onLoad = "uiNamespace setVariable [""ATLAS_squadManagerNotification"", _this select 0]";
	//onUnload = "";
	movingEnable = 0;
	

controls[]=
{
	IGUIBack_2200,
	ATLAS_RscPicture_1200,
	ATLAS_RscFrame_1800,
	ATLAS_RscText_1000,
	ATLAS_RscStructuredText_1100
	
	
};

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by {RW} Hywel, v1.063, #Dufeti)
////////////////////////////////////////////////////////

class IGUIBack_2200: IGUIBack
{
	idc = 2200;
	x = 0.876979 * safezoneW + safezoneX;
	y = 0.9136 * safezoneH + safezoneY;
	w = 0.122396 * safezoneW;
	h = 0.0846 * safezoneH;
};
class ATLAS_RscFrame_1800: ATLAS_RscFrame
{
	idc = 1800;
	x = 0.876979 * safezoneW + safezoneX;
	y = 0.9136 * safezoneH + safezoneY;
	w = 0.122396 * safezoneW;
	h = 0.0846 * safezoneH;
};
class ATLAS_RscPicture_1200: ATLAS_RscPicture
{
	idc = 1200;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	x = 0.881875 * safezoneW + safezoneX;
	y = 0.923 * safezoneH + safezoneY;
	w = 0.029375 * safezoneW;
	h = 0.047 * safezoneH;
};
class ATLAS_RscText_1000: ATLAS_RscText
{
	idc = 1000;
	text = "nameOfPlayer"; //--- ToDo: Localize;
	x = 0.921042 * safezoneW + safezoneX;
	y = 0.9136 * safezoneH + safezoneY;
	w = 0.0636458 * safezoneW;
	h = 0.0188 * safezoneH;
};
class ATLAS_RscStructuredText_1100: ATLAS_RscStructuredText
{
	idc = 1100;
	text = "aaaaaaaaaaaaaaaaaaaaaaaaaaa"; //--- ToDo: Localize;
	x = 0.916146 * safezoneW + safezoneX;
	y = 0.9324 * safezoneH + safezoneY;
	w = 0.0783333 * safezoneW;
	h = 0.0564 * safezoneH;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////




};


