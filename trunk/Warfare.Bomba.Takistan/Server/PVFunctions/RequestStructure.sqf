#include "profiler.h"
PROFILER_BEGIN("RequestStructure");

private['_side','_index','_structuretype','_pos','_dir','_script'];
_side = _this select 0;
_structureType = _this select 1;
_pos = _this select 2;
_dir = _this select 3;

_index = (Format ["WFBE_%1STRUCTURENAMES",str _side] Call GetNamespace) find _structureType;
if (_index != -1) then {
	_script = (Format ["WFBE_%1STRUCTURESCRIPTS",str _side] Call GetNamespace) select _index;
	[_structureType,_side,_pos,_dir,_index] ExecVM (Format["Server\Construction\Construction_%1.sqf",_script]);
};

PROFILER_END();