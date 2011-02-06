#include "profiler.h"
PROFILER_BEGIN("Market_GetSU");

Private ['_unitType','_su'];

	if (isNil "_this") exitWith { 
		PROFILER_END();
		1 
	};

//-- return standart unit;
	_unit = _this;
	_unitType   = _unit select 1;
	_unitWeight = _unit select 5;
	
	if (isNil "_unitWeight") then { _unitWeight = 1; };
	
	_su = 0;

	switch (_unitType) do {
		case "t"   : 	{ _su = 1000 * _unitWeight; };
		case "kg"  : 	{ _su = 1 * _unitWeight; };
		case "g"   : 	{ _su = 0.001 * _unitWeight; };
		case "piece": 	{ _su = 1 * _unitWeight; };
	};

PROFILER_END();
_su;