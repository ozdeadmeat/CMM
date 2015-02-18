//Hywel
//Aug. 2014






if(((side _this) == (side player)) && (group player != _this) && (_this getVariable ["ATLAS_squadManagement_realGroup",false])) then
	{ //group is defined as a player created group and is on players side
	
		//if (({ isPlayer _x} count units _this) > 0) then 
		
		if(true) exitWith {[_this,(_this getVariable ["ATLAS_squadManagement_lockState",1])]; }; 
		
		
		
		
		
		

	};
