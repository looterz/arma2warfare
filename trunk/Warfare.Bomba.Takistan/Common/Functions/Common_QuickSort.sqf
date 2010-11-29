#include "profiler.h"
PROFILER_BEGIN("Common_QuickSort");

private['_count'];

	_count = (count _this) - 1;
	if (_count > 0) then {
		[_this, 0, _count] call QuickSortIterator;
		[_this, 0, _count] call QuickSortInsertion;
	};

PROFILER_END();	
_this;

