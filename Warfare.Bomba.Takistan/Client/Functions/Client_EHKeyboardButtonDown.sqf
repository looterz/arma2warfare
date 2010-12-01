private["_pressedButton","_pressedShift","_pressedControl","_pressedAlt","_return","_userKeyMessage","_actionKeysImages","_pressedButtonArray"];

// ------------------ Parse Arguments -----------------

_pressedButton = _this select 1;
_pressedShift = _this select 2;
_pressedControl = _this select 3;
_pressedAlt = _this select 4;

_keyHandled = false;
_userKeyMessage = "";
_actionKeysImages = "";
_pressedButtonArray = [_pressedButton];//standard button

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
		if (_weapon in _tankGuns) then 
		{ 
			_status = true; 
		};
		_weapon = inheritsFrom _weapon;
	};   
    _status;
};

switch (true) do
{
	// disable command mode scanning
	case (!paramSpacebar): 
	{
		if (({_x in _pressedButtonArray} count (actionKeys "ForceCommandingMode")) != 0) then {
			_keyHandled = true;
		};
	};
	// disable radar lock
	case (!paramTabLock):
	{
		if (({_x in _pressedButtonArray} count (actionKeys "LockTargets")) != 0) then {
			if (call _IsSelectedFactoryLockWeapon) then {
				_keyHandled = true;
			};
		};
	};
	
	// disable infantry direct lock
	case (!paramTabLock):
	{
		if (({_x in _pressedButtonArray} count (actionKeys "LockTarget")) != 0) then {
			if (call _IsSelectedFactoryLockWeapon) then {
				_keyHandled = true;
			};
		};
	};
	// disable vehicle direct lock
	case (!paramTabLock):
	{
		if (({_x in _pressedButtonArray} count (actionKeys "VehLockTargets")) != 0) then {
			if (call _IsSelectedFactoryLockWeapon) then {
				_keyHandled = true;
			};
		};
	};

	// disable tactical view
	case (!paramTacView):
	{
		if (({_x in _pressedButtonArray} count (actionKeys "TacticalView")) != 0) then {
			_keyHandled = true;
		};
	};	
};

//format ["Client_KeyButtonDown: %1: Handled: %2", _this, _keyHandled] call LogTrace;
_keyHandled;
