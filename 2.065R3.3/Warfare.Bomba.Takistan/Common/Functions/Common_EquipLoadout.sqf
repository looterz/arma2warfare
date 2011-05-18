#include "profiler.h"
PROFILER_BEGIN("Common_EquipLoadout");

Private['_ammo','_unit','_weapon','_weapons', '_classType', '_dogtags', '_label', '_role'];

	_unit = _this select 0;
	_weapons = _this select 1;
	_ammo = _this select 2;

	{_unit removeMagazine _x} forEach magazines _unit;	// remove all magazines prior add ammo to unit
	removeAllWeapons _unit;
	removeAllItems _unit;

	_dogtags = [];

	format["EquipLoadout:%1",_this] call LogTrace;

	{_unit addMagazine _x} forEach _ammo;
	{
		 _classType = (_x Call GetNamespace) select QUERYGEAR_BASETYPE;
		 if (isNil "_classType") then { _classType = _x; };
		 
		 if (_classType == "CDF_dogtags" && _classType != _x) then {
				_dogtags = _dogtags + [_x];
		 };
		
		_unit addWeapon _classType;
		
	} forEach _weapons;


	if ((count _dogtags) != 0) then {
		if (isNull (unitBackpack _unit)) then {

			_role = _dogtags select ((count _dogtags)-1);	
			_label = (_role Call GetNamespace) select QUERYGEARLABEL;			
			hint format[localize "STR_WF_RoleDogTags_Information", _label];
		};
	};

	_unit setVariable ["Dogtags", _dogtags];

	_weapon = primaryWeapon _unit;
	if (_weapon != '') then {_unit selectWeapon _weapon};

PROFILER_END();