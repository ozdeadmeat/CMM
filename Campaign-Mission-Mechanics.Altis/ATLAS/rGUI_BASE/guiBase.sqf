//
//	script by loki
//	Oct. 2013
//	Aug. 2014
//
//	rBankCheck.sqf
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if (!local Player) exitWith {};
closedialog 0;

createDialog "rGUI_guiBase";

//start fresh in infoBox
((uiNamespace getVariable "rGUI_guiBase") displayCtrl 1100) ctrlSetStructuredText parseText "";

fn_rBankDisplayStats =
{
	disableSerialization; 
	
	//infoBox stuff
	_text = ["
			
			<t size='1' align='center'>Welcome to the BASE GUI %1:<br/><br/>
			<t size='1' align='center'>Here you can do whatever.</t><br/>
			
			",
			name player

			
			];

	((uiNamespace getVariable "rGUI_bank") displayCtrl 1100) ctrlSetStructuredText parseText format _text;

	
};

call fn_rBankDisplayStats;



