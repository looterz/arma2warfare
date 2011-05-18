#include "profiler.h"
PROFILER_BEGIN("Common_GetEquipDogTags");

Private['_unit', '_currentWeapons', '_dogTags', '_u', '_weaponType', '_baseType'];

_unit = _this;
_currentWeapons = (((_unit) call GetEquipLoadout) select 0);

_dogTags = [];
_u = count _currentWeapons;

while { _u != 0 } do {

	_u = _u - 1;
	_weaponType = _currentWeapons select _u;
	_baseType = (_weaponType call GetNamespace) select QUERYGEAR_BASETYPE;
	
	if (isNil "_baseType") then { _baseType = _weaponType; };
	
	 if (_baseType == "CDF_dogtags") then {
			_dogTags = _dogTags + [_weaponType];
	 };
};

PROFILER_END();
_dogTags;