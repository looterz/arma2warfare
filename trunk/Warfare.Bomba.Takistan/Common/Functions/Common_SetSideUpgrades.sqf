#include "profiler.h"
PROFILER_BEGIN("Common_SetSideUpgrades");

private['_value', '_side'];

_value = _this select 0;
_side = _this select 1;

switch (_side) do {
	case "WEST": { WESTUpgrades = _value; publicVariable "WESTUpgrades"; }; 
	case "EAST": { EASTUpgrades = _value; publicVariable "EASTUpgrades"; };
	default    { format["Common_SetSideUpgrades unknown side: '%1'", _this] call LogError; };
};

PROFILER_END();
