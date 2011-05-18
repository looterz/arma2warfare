#include "profiler.h"
PROFILER_BEGIN("Common_GetGridTarget");

Private["_target","_minRadius","_maxRadius","_pos","_names", "_center", "_gridName", "_id", "_grid"];

	_target    = _this select 0;
	_minRadius = _this select 1;
	_maxRadius = _this select 2;

	_pos = position _target;	
	
	_names = _target getVariable "GridArrayNames";
	if (isNil "_names") then {
		_names = [];
		_target setVariable["GridArrayNames", _names];
	};
	
	_center = _target getVariable "GridArrayCenter";	
	if ( (isNil "_center") ) then {
		_center = _pos;
		_target setVariable ["GridArrayCenter", _center];	
	};
	
	// if new position further to 50 meters, than the old position, so clear old values and begin rebuild grid;
	if ( (_center distance _pos) > 50 ) then {
	
		{  _target setVariable [_x, objNull ];   } foreach _names;

		_names = [];
		_center = _pos;		
		_target setVariable["GridArrayNames", _names];	
		_target setVariable ["GridArrayCenter", _center];	
	};
	
	_gridName = format["GRID-%1x%2", floor(_maxRadius / 10), floor(_minRadius / 10)];

	_id = _names find _gridName;
	if (_id == -1) then {

		_grid = [position _target, _minRadius, _maxRadius] call GetGridPosition;
		_names = _names + [_gridName];
		_target setVariable["GridArrayNames", _names];
		_target setVariable[_gridName , _grid];
	} else {
		_grid = _target getVariable _gridName;	
	};
	
PROFILER_END();
_grid;