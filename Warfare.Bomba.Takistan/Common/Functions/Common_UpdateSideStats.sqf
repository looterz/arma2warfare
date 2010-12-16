#include "profiler.h"
PROFILER_BEGIN("Common_UpdateSideStats");

private['_varName', '_unit', '_side', '_man', '_count', '_built', '_inc', '_changeTo'];
	_unit  = _this select 0;
	_side  = _this select 1;
	_inc = _this select 2;
	
	if (!isServer) exitWith {
		[NETSEND_MSGID_UPDATESTATS, _this] spawn NetSend_ToServer;
		PROFILER_END();
	};	

	format["Common_UpdateSideStats: %1", _this] call LogHigh;
	
	_man = if (count _this > 3) then { _this select 3 } else { _unit isKindOf "Man" };

	_changeTo = abs(_inc);
	
	if (isNull _unit && _inc < 0) then { 	// this is just for remove from stats cities defences units that are removed after some inactive town time
		_changeTo = -_changeTo;
		_inc = 1;
	};
	
	if (_inc > 0) then {
		_varName = if (_man) then { format ["%1UnitsCreated", _side]; } else { format ["%1VehiclesCreated", _side]; };
	} else {
		_varName = if (_man) then { format ["%1Casualties", _side]; } else { format ["%1VehiclesLost", _side]; };
	};
	
	_built = WF_Logic getVariable _varName;
	if (isNil "_built") then { _built = 0 };	
	WF_Logic setVariable [_varName, _built + _changeTo];

PROFILER_END();