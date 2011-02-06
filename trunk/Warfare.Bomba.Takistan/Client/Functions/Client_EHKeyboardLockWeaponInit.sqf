EH_KeyboardLockWeaponTypes = 
[ 	(configFile >> "CfgWeapons" >> "M256"), 
	(configFile >> "CfgWeapons" >> "2A42"), 
	(configFile >> "CfgWeapons" >> "D81"),
	(configFile >> "CfgWeapons" >> "FFARLauncher"),
	(configFile >> "CfgWeapons" >> "M230")
];

EH_KeyboardLockWeapon = {
private['_weapon','_types','_status'];

	_weapon = configFile >> "CfgWeapons" >> (currentWeapon (vehicle player));
	_status = false;
	while { !_status && (isClass _weapon)  } do {
		if (_weapon in EH_KeyboardLockWeaponTypes) then { 
			_status = true; 
		} else {
			_weapon = inheritsFrom _weapon;
		};
	};   
	_status;
};
