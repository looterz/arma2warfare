private["_display", "_pressedMouseButton","_pressedControl","_return","_userKeyMessage","_actionKeysImages","_pressedMouseButtonArray"];

_return = false;
// ------------------ Parse Arguments -----------------

_display = _this select 0;
_pressedMouseButton = _this select 1;
//_xCoord = _this select 2;
//_yCoord = _this select 3;
_pressedShift = _this select 4;
_pressedControl = _this select 5;
_pressedAlt = _this select 6;

_pressedMouseButtonArray = [];

// -------------------- Key Char codes ----------------

KEYSCODE_MOUSE_0	= 0;//LMB (1)
KEYSCODE_MOUSE_1	= 1;//RMB (2)
KEYSCODE_MOUSE_2	= 2;//Middle MB (3)
KEYSCODE_MOUSE_3	= 3;//DOWN MB (4)
KEYSCODE_MOUSE_4	= 4;//UP MB (5)

switch (_pressedMouseButton) do
{
	case KEYSCODE_MOUSE_0:
	{
		_pressedMouseButtonArray =
		[
			65536,	//LMB
			65792	//double LMB
		];
		if (_pressedControl) then
		{
			_pressedMouseButtonArray set [count _pressedMouseButtonArray,487653376];// LCTRL + LMB
		};
	};
	case KEYSCODE_MOUSE_1:
	{
		_pressedMouseButtonArray =
		[
			65537,	//RMB
			65665,	//not HOLD RMB
			65793	//double RMB
		];
		if (_pressedControl) then
		{
			_pressedMouseButtonArray set [count _pressedMouseButtonArray,487653504];// LCTRL + RMB
		};
	};
	case KEYSCODE_MOUSE_2:
	{
		_pressedMouseButtonArray =
		[
			65538,	//MMB
			65794	//double MMB
		];
		if (_pressedControl) then
		{
			_pressedMouseButtonArray set [count _pressedMouseButtonArray,487653378];// LCTRL + MMB
		};
	};
	
    default
    {
		_pressedMouseButtonArray =
		[
			65536 + _pressedMouseButton,
			65792 + _pressedMouseButton
		];
		if (_pressedControl) then
		{
			_pressedMouseButtonArray set [count _pressedMouseButtonArray, (487653376 + _pressedMouseButton)];
		};
    };	
};


{ if (!_return) then { _return = [_display, _x, _pressedShift, _pressedControl, _pressedAlt] call KeyboardButtonDown; };
} forEach _pressedMouseButtonArray;

//format ["Client_MouseButtonDown: %1: Handled: %2", _this, _return] call LogTrace;
_return;
