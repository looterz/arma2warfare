private["_pressedButton","_pressedShift","_pressedControl","_pressedAlt","_return","_userKeyMessage","_actionKeysImages","_pressedButtonArray"];

// ------------------ Parse Arguments -----------------

_pressedButton = _this select 1;
_pressedShift = _this select 2;
_pressedControl = _this select 3;
_pressedAlt = _this select 4;

_keyHandled = false;
_userKeyMessage = "";
_actionKeysImages = "";

	_IsSelectedFactoryLockWeapon = {
	private['_weapon','_types','_status'];

		_tankGuns = [ 	(configFile >> "CfgWeapons" >> "M256"), 
						(configFile >> "CfgWeapons" >> "2A42"), 
						(configFile >> "CfgWeapons" >> "D81"),
						(configFile >> "CfgWeapons" >> "FFARLauncher"),
						(configFile >> "CfgWeapons" >> "M230")
					];

		_weapon = configFile >> "CfgWeapons" >> (currentWeapon (vehicle player));
		_status = false;
		while { !_status && (isClass _weapon)  } do {
			if (_weapon in _tankGuns) then { 
				_status = true; 
			} else {
				_weapon = inheritsFrom _weapon;
			};
		};   
		_status;
	};

	if (!paramSpacebar) then
	{
		if ( _pressedButton in (actionKeys "ForceCommandingMode") ) then {
			_keyHandled = true;
		};
	};

	if (!_keyHandled && !paramTacView) then
	{
		if ( _pressedButton in (actionKeys "TacticalView") ) then {
			_keyHandled = true;
		};
	};	
	
	if (!_keyHandled && !paramTabLock) then
	{
		if ( _pressedButton in (actionKeys "LockTargets") ) then {
			if (call _IsSelectedFactoryLockWeapon) then {
				_keyHandled = true;
			};
		};
		
		if ( !_keyHandled && _pressedButton in (actionKeys "LockTarget") ) then {
			if (call _IsSelectedFactoryLockWeapon) then {
				_keyHandled = true;
			};
		};

		if ( !_keyHandled && _pressedButton in (actionKeys "VehLockTargets") ) then {
			if (call _IsSelectedFactoryLockWeapon) then {
				_keyHandled = true;
			};
		};		
	};	

//hint format ["Client_KeyButtonDown: %1: Handled: %2", _this, _keyHandled];
//format ["Client_KeyButtonDown: %1: Handled: %2", _this, _keyHandled] call LogTrace;
_keyHandled;
