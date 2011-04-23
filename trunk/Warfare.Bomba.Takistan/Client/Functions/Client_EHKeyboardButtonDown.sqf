private ["_pressedButton","_keyhandled"];

// ------------------ Parse Arguments -----------------

_pressedButton = _this select 1;
//_pressedShift = _this select 2;
//_pressedControl = _this select 3;
//_pressedAlt = _this select 4;

_keyHandled = false;
//--- _userKeyMessage = "";
//--- _actionKeysImages = "";

	if (EH_BTNUpdateTimeout < time) then {
	
		EH_BTN_ForceCommandingMode = actionKeys "ForceCommandingMode";
		EH_BTN_TacticalView = actionKeys "TacticalView";
		EH_BTN_TabLock = (actionKeys "LockTargets") + (actionKeys "LockTarget") + (actionKeys "VehLockTargets");
		
		EH_BTNUpdateTimeout = time + 10;
	};

	if (!paramSpacebar) then
	{
		if ( _pressedButton in EH_BTN_ForceCommandingMode ) then {
			_keyHandled = true;
		};
	};

	if (!_keyHandled && !paramTacView) then
	{
		if ( _pressedButton in EH_BTN_TacticalView ) then {
			_keyHandled = true;
		};
	};	
	
	if (!_keyHandled && !paramTabLock) then
	{
		if ( _pressedButton in EH_BTN_TabLock ) then {
			if (call EH_KeyboardLockWeapon) then {
				_keyHandled = true;
			};
		};	
	};	

//hint format ["Client_KeyButtonDown: %1: Handled: %2", _this, _keyHandled];
//format ["Client_KeyButtonDown: %1: Handled: %2", _this, _keyHandled] call LogTrace;
_keyHandled;
