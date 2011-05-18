#include "profiler.h"
PROFILER_BEGIN("Service_ManagedUnitAdd");

Private ["_countArgs", "_markerType", "_markerColor", "_markerSize", "_markerText", "_markerName", "_tracked", "_refreshRate", "_trackDeath", "_deathMarkerType", "_deathMarkerColor", "_deletePrevious", "_side", "_deathMarkerSize", "_condition", "_markerInfo" ];

	if (!isServer) exitWith {
		[NETSEND_MSGID_MANAGEDUNITADD, _this] spawn NetSend_ToServer;
		PROFILER_END();
	};

	if (!(_this isKindOf "Man")) then {
		_this spawn HandleEmptyVehicle;		// register track empty vehicles
	};

	waitUntil { !isNil "ManagedUnitListOperate" };
	ManagedUnitListOperate = ManagedUnitListOperate + [ _this ];
	
	format["ManagedUnitAdd: %1", _this] call LogHigh;
	
PROFILER_END();