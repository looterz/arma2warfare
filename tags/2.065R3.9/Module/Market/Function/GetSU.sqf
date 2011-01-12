#include "profiler.h"
PROFILER_BEGIN("Market_GetSU");

Private ['_unitType','_su'];

//-- return standart unit;
	_unitType = _this;
	_su = 0;

	switch (_unitType) do {
		case "t": 	{ _su = 1000; };
		case "kg": 	{ _su = 1; };
		case "g": 	{ _su = 0.001; };
	};

PROFILER_END();
_su;