#include "profiler.h"
PROFILER_BEGIN("Common_SetTeamType");

private ['_content','_cpt','_data','_dataRow','_i','_tConstruct','_turretPath','_vehicle'];
_vehicle = _this select 0;
_data = _this select 1;
_turretPath = if (count _this > 2) then {_this select 2} else {[]};
_cpt = count _turretPath;

_i = count _data;
while { _i != 0 } do {
	_i = _i - 1;
	
	_dataRow = _data select _i;	
	if (count _dataRow != 0) then {
		if (typeName _dataRow == 'ARRAY') then {
			_content = _dataRow select 0;
			//--- root.
			if (typeName _content == 'SCALAR') then {
				_turretPath set [_cpt,[_content]];
				_tConstruct = [];
				{_tConstruct = _tConstruct + _x} forEach _turretPath;
				{
					_vehicle addMagazineTurret [_x, _tConstruct];
				} forEach (_data select (_i+1));
				format ["Turret:%1 Mags:%2",_turretPath,_data select (_i+1)] call LogHigh;
			};
			//--- go deeper.
			if (typeName _content == 'ARRAY') then {
				[_vehicle,_dataRow,_turretPath] Call SetTurretsMags;
				_turretPath = [];
				_cpt = 0;
			};
		};
	};
};

PROFILER_END();