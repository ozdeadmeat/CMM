_user = (_this select 0);
_text = (_this select 1);




("rGUI_squadNotification" call BIS_fnc_rscLayer) cutRsc ["rGUI_squadNotification","PLAIN",6];
_display = uiNamespace getVariable "ATLAS_squadManagerNotification";
(_display displayCtrl 1000) ctrlSetText (name _user);
(_display displayCtrl 1100) ctrlSetText (localize _text);
(_display displayCtrl 1200) ctrlSetText (((squadParams _user) select 0) select 4);
