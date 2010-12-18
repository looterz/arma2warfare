#include "profiler.h"
PROFILER_BEGIN("Common_GetTurretsMags");

/* Adapted from BIS turret's function. */
private ['_subEntry', '_entry','_turretIndex','_turrets','_turretIndex', '_u'];
_entry = _this select 0;

_turrets = [];
_turretIndex = 0;

//Explore all turrets and sub-turrets recursively.

_u = count _entry;
while { !(_u == 0) } do
{
	_u = _u - 1;
	_subEntry = _entry select _u;
	if (isClass _subEntry) then
	{
		private ['_hasGunner'];
		_hasGunner = [_subEntry, 'hasGunner'] call BIS_fnc_returnConfigEntry;

		//Make sure the entry was found.
		if (!(isNil '_hasGunner')) then 
		{
			if (_hasGunner == 1) then 
			{
				_turrets = _turrets + [[_turretIndex],getArray(_subEntry >> 'magazines')];
				
				//Include sub-turrets, if present.
				if (isClass (_subEntry >> 'Turrets')) then 
				{
					_turrets = _turrets + [[_subEntry >> 'Turrets'] call GetTurretsMags];
				} 
				else 
				{
					_turrets = _turrets + [[]];
				};
			};
		};

		_turretIndex = _turretIndex + 1;
	};
};

PROFILER_END();
_turrets