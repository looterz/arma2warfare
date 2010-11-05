Private['_unit', '_currentWeapons', '_currentMagazines', '_dogtags', '_u', '_i', '_weaponType'];

_unit = _this;

_currentWeapons = weapons _unit;
_currentMagazines = magazines _unit;

_dogtags = _unit getVariable "Dogtags";
if (isNil "_dogtags") then { _dogtags = []; };

_u = 0;
_i = 0;

while { _u < (count _currentWeapons) && _i < (count _dogtags) } do {

	_weaponType = _currentWeapons select _u;
	 if (_weaponType == "CDF_dogtags") then {
			_currentWeapons set [_u, (_dogtags select _i)];
			_i = _i + 1;
	 };	

	_u = _u + 1;
};

[_currentWeapons, _currentMagazines];