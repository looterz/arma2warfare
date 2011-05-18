#include "profiler.h"
PROFILER_BEGIN("Common_UpdateSideStats");

private['_varName', '_unit', '_side', '_alive'];
	_unit  = _this select 0;
	_side  = _this select 1;
	_alive = _this select 2;
	
	if (!isServer) exitWith {
		[NETSEND_MSGID_UPDATESTATS, _this] spawn NetSend_ToServer;
		PROFILER_END();
	};	

	format["Common_UpdateSideStats: %1", _this] call LogHigh;
	
	if (_alive > 0) then {
		_varName = if (_unit isKindOf "Man") then { format ["%1UnitsCreated", _side]; } else { format ["%1VehiclesCreated", _side]; };
	} else {
		_varName = if (_unit isKindOf "Man") then { format ["%1Casualties", _side]; } else { format ["%1VehiclesLost", _side]; };
	};
	
	_built = WF_Logic getVariable _varName;
	if (isNil "_built") then { _built = 0 };	
	WF_Logic setVariable [_varName, _built + 1];

PROFILER_END();