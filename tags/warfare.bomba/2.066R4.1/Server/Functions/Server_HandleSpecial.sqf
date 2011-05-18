#include "profiler.h"
PROFILER_BEGIN("Server_HandleSpecial");

Private["_args","_side"];

_args = _this;
_side = _args select 1;

switch (_args select 0) do {
	case "Paratroops": {
		_args spawn KAT_Paratroopers;
	};
	
	case "ParaVehi": {
		_args spawn KAT_ParaVehicles;
	};
	
	case "ParaAmmo": {
		_args spawn KAT_ParaAmmo;
	};
	
	case "RespawnST": {
		_st = Format ["WFBE_%1_AISupplyTrucks",Str _side] Call GetNamespace;
		{if (!isNull (driver _x)) then {driver _x setDammage 1};_x setDammage 1} forEach _st;
		Format["Server_HandleSpecial: The %1 supply trucks have been respawned",str _side]  call LogInform;
	};
	
	case "uav": {
		_args spawn KAT_UAV;
	};
	
	case "upgrade": {["NewIntelAvailable","",_side,""] Spawn SideMessage};
	
	case "ICBM": {
		_base = (_args select 2);
		_target = (_args select 3);
		_playerTeam = (_args select 4);
		Format["Server_HandleSpecial: The %1 %2 Team (Leader: %3) has called an ICBM",str _side,_playerTeam,name leader _playerTeam] call LogNotify;
		if (isNull _target || !alive _target) exitWith {};
		_dropPosX = getPos _base select 0;
		_dropPosY = getPos _base select 1;
		_dropPosZ = getPos _base select 2;
		_droppos1 = [_dropPosX + 4, _dropPosY + 4, _dropPosZ];
		_droppos2 = [_dropPosX + 8, _dropPosY + 8, _dropPosZ];
		waitUntil { alive _target && !(isNull _target) } do {
			sleep 0.5;
		};
		det1 = "BO_GBU12_LGB" createVehicle [(getpos _target select 0),(getpos _target select 1), 0];
		det2 = createVehicle ["BO_GBU12_LGB",_droppos1,[], 0, "None"];
		det3 = createVehicle ["BO_GBU12_LGB",_droppos2,[], 0, "None"];
		[_base] Spawn NukeDammage;
	};
};

PROFILER_END("Server_HandleSpecial");