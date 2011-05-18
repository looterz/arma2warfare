#include "profiler.h"
PROFILER_BEGIN("Common_SortByDistance");
private["_u", "_object", "_objects", "_total", "_sorted", "_target"];
    
_object = _this select 0;
_objects = _this select 1;

_total = count _objects;
_sorted = [];

if (_total > 1) then { 

	_u = _total;
	while { _u != 0 } do {
		_u = _u - 1;
		_target = _objects select _u;
		_sorted = _sorted + [ [(_object distance _target), _target] ];
	};	
	_sorted call QuickSort;
	
	_u = _total;
	while { _u != 0 } do {
		_u = _u - 1;
		_sorted set [_u, ((_sorted select _u) select 1)];
	};	
} else {
	_sorted = _objects;
};

PROFILER_END();
_sorted;
