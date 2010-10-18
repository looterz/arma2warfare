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

_selectedFactoryLockWeapon = {
private['_weapon'];

   _weapon = currentWeapon (vehicle player);
   
   if (_weapon isKindOf "2A42") exitWith { true; };
   if (_weapon isKindOf "M256") exitWith { true; };
   if (_weapon isKindOf "D81") exitWith { true; };
   
   false;
};

switch (true) do
{
	// disable command mode scanning
	case (paramSpacebar && ({_x in _pressedButtonArray} count (actionKeys "ForceCommandingMode")) > 0):
	{
		_keyHandled = true;
	};
	// disable radar lock
	case (paramStrictTankTargetLock && ({_x in _pressedButtonArray} count (actionKeys "LockTargets")) > 0):
	{
		if (player != (vehicle player) && (call _selectedFactoryLockWeapon)) then
		{
			_keyHandled = true;
		};
	};
	
	// disable infantry direct lock
	case (paramStrictTankTargetLock && ({_x in _pressedButtonArray} count (actionKeys "LockTarget")) > 0):
	{
		if (player != (vehicle player) && (call _selectedFactoryLockWeapon)) then
		{
			_keyHandled = true;
		};
	};
	// disable vehicle direct lock
	case (paramStrictTankTargetLock && ({_x in _pressedButtonArray} count (actionKeys "VehLockTargets")) > 0):
	{
		if (player != (vehicle player) && (call _selectedFactoryLockWeapon)) then
		{
			_keyHandled = true;
		};
	};	
};

_keyHandled;
