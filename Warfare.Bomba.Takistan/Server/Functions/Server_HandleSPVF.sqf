/*
	description:
	 - New network system handler.
	note:
	 - addPublicVariableEventHandler is triggered everywhere BUT on the caller.
	usage:
	 - [server PVF to run, parameters]
*/
#include "profiler.h"
PROFILER_BEGIN("Server_HandleSPVF");

Private ["_parameters","_publicVar","_script"];
_publicVar = _this;

_script = _publicVar select 0;
_parameters = if (count _publicVar > 1) then {_publicVar select 1} else {[]};

_parameters Spawn (Call Compile _script);

PROFILER_END();