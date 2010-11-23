#include "profiler.h"
PROFILER_BEGIN("Common_InitUnit");

Private ["_finalNumber","_numbers","_side","_text","_unit", "_deadSize", "_attempts"];
	_unit = _this select 0;
	_side = _this select 1;

	if ( (isNull _unit) || (sideJoined != _side)) exitWith {
		PROFILER_END();
	};
	waitUntil {commonInitComplete};
	sleep 2;

	_type = "Vehicle";
	_color = "ColorGreen";
	_size = [5,5];
	_txt = "";
	if ((typeOf _unit) in (Format['WFBE_%1SUPPLYTRUCKS',str _side] Call GetNamespace)) then {_type = "SupplyVehicle";_size = [1,1]};
	if ((typeOf _unit) in (Format['WFBE_%1REPAIRTRUCKS',str _side] Call GetNamespace)) then {_type = "RepairVehicle"};
	_markerName = Format ["unitMarker%1",unitMarker];
	unitMarker = unitMarker + 1;
	if (local _unit && isMultiplayer) then {_color = "ColorOrange"};

	_deadSize = [2,2];

	if (_unit isKindOf "Man") then {
		_color = "ColorYellow";
		_type = "mil_dot";
		_size = [0.5,0.5];
		_deadSize = [1,1];
		if (group _unit == group player) then {
		
			_color = "ColorOrange";
			_attempts = 5;
			while { _attempts != 0 } do {
				_text = toArray(str _unit);
				_amount = count _text;
				_val = _text select (_amount-2);
				_val2 = _text select (_amount-1);
				_ainumber = if (_val == 58) then {[_val2]} else {[_val, _val2]};
				_txt = toString(_ainumber);
				
				_attempts = _attempts - 1;
				if ( !(_txt == "TE") ) then { 
					_attempts = 0; 
				} else {
					sleep 1;
				};
			};
		};
	};

	_params = [_type,_color,_size,_txt,_markerName,_unit,1,true,"DestroyedVehicle",_color,false,_side, _deadSize];
	_params Spawn MarkerUpdate;

PROFILER_END();