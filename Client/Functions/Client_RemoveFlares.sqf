Private['_vehicle', '_upgrades', '_magazines'];

_vehicle = _this;

_IsSelectedMagazineFlare = {
private['_weapon','_types','_status'];

	_flareTypes = [ 	(configFile >> "CfgMagazines" >> "60Rnd_CMFlareMagazine")
				];

	_magazine = configFile >> "CfgMagazines" >> _this;
	_status = false;
	while { !_status && (isClass _magazine)  } do {
		if (_magazine in _flareTypes) then 
		{ 
			_status = true; 
		};
		_magazine = inheritsFrom _magazine;
	};   
    _status;
};

_upgrades = WF_Logic getVariable Format ["%1Upgrades",sideJoinedText];

if ((_vehicle isKindOf 'Air') && (_upgrades select 9 == 0)) then {

	_magazines = [configFile >> 'CfgVehicles' >> typeOf _vehicle] call GetVehicleMags;
	{ 
		_mag = _x;
		if ( (_x call _IsSelectedMagazineFlare) ) then {
			_vehicle removeMagazinesTurret [_x, [-1]];
		};
	} forEach _magazines;
};