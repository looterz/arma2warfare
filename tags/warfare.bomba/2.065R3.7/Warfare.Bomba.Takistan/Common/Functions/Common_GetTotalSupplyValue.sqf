#include "profiler.h"
PROFILER_BEGIN("Common_GetTotalSupplyValue");

Private["_count","_held","_side","_supplyValue","_sideID","_town"];

_side = _this;
_sideID = _side Call GetSideID;
_SV = 0;

_count = totalTowns;

while { !(_count == 0) } do {
	_count = _count - 1;
	
	_town = towns Select _count;
	if ((_town getVariable "sideID") == _sideID) then	{
		_supplyValue = _town getVariable "supplyValue";
		
		if (!isNil "_supplyValue") then {
			_SV = _SV + _supplyValue;
		};
	};
};

PROFILER_END();
_SV;