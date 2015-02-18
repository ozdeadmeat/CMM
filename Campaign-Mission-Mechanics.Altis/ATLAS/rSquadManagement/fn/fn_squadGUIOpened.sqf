//Hywel
//Aug. 2014



//SIDE COLOR - ATLAS frame text
ATLAS_cargoGUIFrameColor =
{
switch (side player) do
	{
		case west: {ctrlShow [1202,true];ctrlShow [1204,false];ctrlShow [1201,false];}; //blue
		case east: {ctrlShow [1201,true];ctrlShow [1204,false];ctrlShow [1202,false];};	//red
		case resistance: {ctrlShow [1204,true];ctrlShow [1201,false];ctrlShow [1202,false];}; // green
		default {};
	};
};
call ATLAS_cargoGUIFrameColor;
//publicVariable "ATLAS_cargoGUIFrameColor";


//while open.. refresh data
[] spawn 
{
	while {!isNull (findDisplay 7230)} do 
	{
		[] call ATLAS_fnc_SquadManagement_refreshGroupGUI;
		sleep 1;
	};

};

