Private['_ammo','_unit','_weapon','_weapons', '_classType', '_dogtags', '_label'];

_unit = _this;

_loadout = (_unit) call GetEquipLoadout;
_currentWeapons = (_loadout select 0);

_cost = 0;
_u = 0;
_i = 0;

while { _u < (count _currentWeapons) } do {

	_weaponType = ((_currentWeapons select _u) call GetNamespace) select QUERYGEAR_BASETYPE;
			_cost = _cost + (_docTagType select QUERYGEARCOST);
			_i = _i + 1;
	 };	

	_u = _u + 1;
};

[_currentWeapons, _currentMagazines];