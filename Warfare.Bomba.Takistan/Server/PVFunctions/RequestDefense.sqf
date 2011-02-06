#include "profiler.h"
PROFILER_BEGIN("RequestDefense");

private['_defenseType','_dir','_index','_manned','_pos','_side','_noammo'];
_side = _this select 0;
_defenseType = _this select 1;
_pos = _this select 2;
_dir = _this select 3;
_manned = _this select 4;
_noammo = if (count _this > 5) then { _this select 5 } else { false };

_index = (Format["WFBE_%1DEFENSENAMES",str _side] Call GetNamespace) find _defenseType;
if (_index != -1) then {
	[_defenseType,_side,_pos,_dir,_index,_manned, _noammo] ExecVM "Server\Construction\Construction_StationaryDefense.sqf";
};

PROFILER_END();