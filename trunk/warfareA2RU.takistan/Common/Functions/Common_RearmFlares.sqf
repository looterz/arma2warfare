private['_upgrades', '_magazines', '_unit', '_side'];

if (!paramCounterMeasures) exitWith {};

	_unit = _this select 0;
	_side = _this select 1;	

	_isFlareMagazine = {
	private['_status','_flareType','_magazine'];
		_flareType = [configFile >> "CfgMagazines" >> "60Rnd_CMFlareMagazine"];
		_magazine = configFile >> "CfgMagazines" >> _this;
		_status = false;
		while { !_status && (isClass _magazine)  } do {
			if (_magazine in _flareType) then 
			{ 
				_status = true; 
			};
			_magazine = inheritsFrom _magazine;
		};   
		_status;
	};

	_upgrades = _side Call GetSideUpgrades;
	if ((_unit isKindOf 'Air') && (_upgrades select 9 == 0)) then {

		_magazines = [configFile >> 'CfgVehicles' >> typeOf _unit] call GetVehicleMags;
		_magazines = _magazines + (magazines _unit);
		_magazines = _magazines + (_unit magazinesTurret [-1]);
		{ 
			diag_log format["rearm magazine: %1, flare=%2", _x, (_x call _isFlareMagazine)];
		
			if (_x call _isFlareMagazine) then { 
				_unit removeMagazinesTurret [_x, [-1]];
				_unit removeMagazine _x;
			};
		} forEach _magazines;
	};