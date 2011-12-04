if (!paramHandWeaponBallistic) exitWith {};

#include "Config_Subsystems.sqf";

System_CurrentGPSightLevel=2;
System_CurrentATSightLevel=2;
System_BallisticMissileAngles=[];

Func_System_AdjustGrenadeBallistics = compile preprocessFile "Addon\Ballistic\Func_System_AdjustGrenadeBallistics.sqf";
Func_System_AdjustMissileBallistics = compile preprocessFile "Addon\Ballistic\Func_System_AdjustMissileBallistics.sqf";
Func_System_Fired = compile preprocessFile "Addon\Ballistic\Func_System_Fired.sqf";
Func_System_GetPitchBank = compile preprocessFile "Addon\Ballistic\Func_System_GetPitchBank.sqf";
Func_System_KeyPressed = compile preprocessFile "Addon\Ballistic\Func_System_KeyPressed.sqf";
Func_System_SetPitchBank = compile preprocessFile "Addon\Ballistic\Func_System_SetPitchBank.sqf";

[] spawn 
{	
	waitUntil{(!isNull (findDisplay 46))};
	
	(findDisplay 46) displayAddEventHandler ["KeyDown","_this call Func_System_KeyPressed"];
	player addEventHandler ["fired","_this call Func_System_Fired"];
	
	//Interpriting missile ballistics data to be more convinient
	_i=0;
	{
		System_BallisticMissileAngles set [_i,[_x select 1,_x select 2,_x select 3,_x select 4,_x select 5]];
		System_BallisticMissileTypes set [_i,_x select 0];
		_i=_i+1;
	} forEach System_BallisticMissileTypes;
	//End missile ballistics data	
};