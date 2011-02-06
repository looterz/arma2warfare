#include "profiler.h"
PROFILER_BEGIN("Server_BuyUnit");

private['_building','_team','_unittype','_side','_vehinfo'];
	_building = _this select 1;
	_unitType = _this select 2;
	_side	  = _this select 3;
	_team 	  = _this select 4;
	_vehInfo  = if ( (count _this) >= 5) then { _this select 5 } else { [] };

	["AI", _building, _unitType, _side, _team, _vehInfo] spawn BuyUnit_OrderCreate;
	
PROFILER_END();