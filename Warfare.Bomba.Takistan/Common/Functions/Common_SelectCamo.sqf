#include "profiler.h"
PROFILER_BEGIN("Common_SelectCamo");

_fnSelectCamoTypeVehicle = {
	Private ["_vehicleTypes","_u","_vehType"];

	_vehicleTypes = _this;
	
	_u = 0;
	_vehType = "";
	
	if (WF_CamoType == 0 && (count _vehicleTypes) > 0 ) then {	// select green camo
		_vehType = _vehicleTypes select 0;
	};

	if (WF_CamoType == 1 && (count _vehicleTypes) > 1 ) then {	// select sand camo
		_vehType = _vehicleTypes select 1;
	};	
	
	_u = 0;	// select first not null vehicleType by default
	while { _u < count _vehicleTypes && _vehType == "" } do {
		_vehType = _vehicleTypes select _u;
		_u = _u + 1;
	};	
	if (_vehType == "") exitWith { objNull };
	_vehType;
};
	
	
_i = count _this;
while { _i != 0 } do {
	_i = _i - 1;
	_item = _this select _i;
	
	if (typeName _item == 'ARRAY') then {
		_selected = _item call _fnSelectCamoTypeVehicle;
		_this set [_i, _selected];
		
		format["%1 selected %2", _item, _selected] call LogHigh;
	};
};

_this = _this - [objNull];	
PROFILER_END();

