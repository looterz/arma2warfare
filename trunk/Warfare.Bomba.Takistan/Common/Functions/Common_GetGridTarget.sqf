#include "profiler.h"
PROFILER_BEGIN("Common_GetGridTarget");
private['_target','_minRadius','_maxRadius','_pos','_gridName','_grid','_gridData','_posname'];

	_target    = _this select 0;
	_minRadius = _this select 1;
	_maxRadius = _this select 2;

	_pos = position _target;	
	_grid = objNull;
	
	_gridName = format["GRID-%1x%2", floor(_maxRadius / 10), floor(_minRadius / 10)];
	_posName = format["%1x%2", floor((_pos select 0) / 50), floor((_pos select 1) / 50)];

	format["GetGridTarget: Target: %1, Pos=%2 Rmin=%3 Rmax=%4", _target, _pos, _minRadius, _maxRadius] call LogHigh;	
	format["GetGridTarget: GridName=%1 PosName=%2", _gridName, _posName] call LogHigh;	
	
	_gridData = _target getVariable _gridName;
	if (isNil "_gridData") then {
		_gridData = ["", nil]; // create empty;
	};

	if ( !((_gridData select 0) == _posName) ) then {		// target has new position
		
		_gridData = [_posName, nil];
		_target setVariable [_gridName, _gridData];
		
		format["GetGridTarget: Begin Build Grid Target: %1, Pos=%2 Rmin=%3 Rmax=%4", _target, _pos, _minRadius, _maxRadius] call LogHigh;	
		_grid = [position _target, _minRadius, _maxRadius] call GetGridPosition;

		_gridData set [1, _grid];
		_target setVariable [_gridName, _gridData];
	} else {

		_grid = _gridData select 1;
		while { isNil "_grid" } do {
			format["GetGridTarget: %1 Grid %2  is Builded waiting... ", _target, _gridName] call LogHigh;
			sleep(1);
			_grid = _gridData select 1;
		};
	};
	
PROFILER_END();
_grid;