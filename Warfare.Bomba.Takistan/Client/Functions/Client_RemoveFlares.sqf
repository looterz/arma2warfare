private['_vehicle','_upgrades','_magazines','_magazine','_mag','_isselectedmagazineflare','_flaretypes'];

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

	_upgrades = (sideJoinedText) Call GetSideUpgrades;

	if ((_vehicle isKindOf 'Air') && (_upgrades select 9 == 0)) then {

		"Client_RemoveFlares" call LogHigh;

		_magazines = [configFile >> 'CfgVehicles' >> typeOf _vehicle] call GetVehicleMags;
		_magazines = _magazines + (_vehicle magazinesTurret [-1]);
		{ 
			_mag = _x;
			format["Client_RemoveFlares : magazine %1", _mag] call LogHigh;
			if ( (_mag call _IsSelectedMagazineFlare) ) then {
			
				format["Client_RemoveFlares : remove %1", _mag] call LogHigh;
				_vehicle removeMagazinesTurret [_mag, [-1]];
			};
		} forEach _magazines;
	};
