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

		_upgrades = WF_Logic getVariable Format ["%1Upgrades",sideJoinedText];
		_barrackUpgradeLevel = _upgrades select 0;
		
		_strengthLevel = 1;
		if (_barrackUpgradeLevel == 2) then { _strengthLevel = 3; };
		if (_barrackUpgradeLevel == 3) then { _strengthLevel = 5; };

		_totalDamage = _building getVariable '_totalDamage';
		_lastDamageTime = _building getVariable '_lastDamageTime';
		
		if (isNil "_totalDamage") then {_totalDamage = 0};
		if (isNil "_lastDamageTime") then {_lastDamageTime = 0};
		
		_dT = time - _lastDamageTime;
		if (_dT >= 10*60) then {						// after 10 mins from last attack factory factory begin autorepair
			_repairLevel = (_dT - 10*60) / (30*60);		// 30 mins for total repair factory;
			_totalDamage = _totalDamage - (_repairLevel * _strengthLevel);
			if (_totalDamage < 0) then { _totalDamage = 0; };
		};
		
		if (_dT > 15 && _dammages > 0.05) then {
			["IsUnderAttack",TypeOf _building, _sideBuilding] Spawn SideMessage;
		};

		_totalDamage = _totalDamage + _dammages;
		_building setVariable ['_totalDamage', _totalDamage, false]; 
		_building setVariable ['_lastDamageTime', time, false];
		
		if (_totalDamage - _dammages <= _strengthLevel) then { 
			_dammages = 0;
		};	
};

_dammages