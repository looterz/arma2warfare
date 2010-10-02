Private ['_building','_dammages','_origin','_side','_side'];

_building = _this select 0;
_dammages = _this select 1;
_origin = _this select 2;
_sideBuilding = _this select 3;

_side = civilian;
if (side _origin == sideEnemy) then {
	if (_origin isKindOf westSoldierBaseClass) then {_side = west};
	if (_origin isKindOf eastSoldierBaseClass) then {_side = east};
} else {
	_side = side _origin;
};

if (baseFrendlyFire && (_sideBuilding == _side)) then { _dammages = 0 }; 

if (_dammages > 0) then {

		_totalDamage = _building getVariable '_totalDamage';
		if (isNil "_totalDamage") then {_totalDamage = 0};

		_totalDamage = _totalDamage + _dammages;
		_building setVariable ['_totalDamage', _totalDamage, false]; 
		
		if (_totalDamage - _dammages <= 5) then { 
			_dammages = 0;
		};		
};

_dammages