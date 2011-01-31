#include "profiler.h"
PROFILER_BEGIN("Common_CompileFile");
private["_compiled"];
	format["compile preprocessFile %1", _this] call LogHigh;
	_compiled = compile preprocessFile _this;
PROFILER_END();
_compiled;