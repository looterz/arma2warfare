disableSerialization;
_display = _this select 0;
MenuAction = -1;
mouseButtonUp = -1;

_cameraModes = ["Internal","External","Gunner","Group"];

_n = 1;
{lbAdd[21002,Format["[%1] %2",_n,name (leader _x)]];_n = _n + 1} forEach clientTeams;
_id = clientTeams find playerTeam;
lbSetCurSel[21002,_id];
_currentUnit = player;
_currentMode = "Internal";
(vehicle player) switchCamera _currentMode;
_units = (Units (group player) - [player]) Call GetLiveUnits;
{lbAdd[21004,Format["(%1) %2",GetText (configFile >> "CfgVehicles" >> (typeOf (vehicle _x)) >> "displayName"),name _x]];_n = _n + 1} forEach _units;

_type = if (!(difficultyEnabled "3rdPersonView")) then {["Internal"]} else {["Internal","External","Ironsight","Group"]};
{lbAdd[21006,_x]} forEach _type;
lbSetCurSel[21006,0];

_map = _display DisplayCtrl 21007;
_map CtrlMapAnimAdd [0,.25,GetPos player];
CtrlMapAnimCommit _map;

while {true} do {
	sleep 0.1;
	
	_cameraSwap = false;
	if (Side player != sideJoined) exitWith {(vehicle player) switchCamera _currentMode;closeDialog 0};
	if (!dialog) exitWith {(vehicle player) switchCamera _currentMode};

	//--- Map click.
	if (mouseButtonUp == 0) then {
		mouseButtonUp = -1;
		_near = _map PosScreenToWorld[mouseX,mouseY];
		_list = _near nearEntities [["Man","Car","Motorcycle","Ship","Tank","Air"],200];
		if (count _list > 0) then {
			_objects = [];
			{if (!(_x isKindOf "Man") && side _x != sideJoined) then {if (count (crew _x) == 0) then {_objects = _objects - [_x]}};if (side _x == sideJoined) then {_objects = _objects + [_x]}} forEach _list;
			if (count _objects > 0) then {
				_units = [_near,_objects] Call SortByDistance;
				_currentUnit = if (vehicle _currentUnit != _currentUnit) then {vehicle _currentUnit} else {_units select 0};
				_cameraSwap = true;
			};
		};
	};	
	
	//--- Leader Selection.
	if (MenuAction == 101) then {
		MenuAction = -1;
		_currentUnit = if (vehicle _currentUnit != _currentUnit) then {vehicle _currentUnit} else {leader (clientTeams select (lbCurSel 21002))};
		_n = 0;
		_units = (Units (group _currentUnit) - [_currentUnit]) Call GetLiveUnits;
		lbClear 21004;
		{lbAdd[21004,Format["(%1) %2",GetText (configFile >> "CfgVehicles" >> (typeOf (vehicle _x)) >> "displayName"),name _x]];_n = _n + 1} forEach _units;
		_cameraSwap = true;
	};
	
	//--- Leader commands AIs.
	if (MenuAction == 102) then {
		MenuAction = -1;
		_currentUnit = if (vehicle _currentUnit != _currentUnit) then {vehicle _currentUnit} else  {_units select (lbCurSel 21004)};
		_cameraSwap = true;
	};
	
	//--- Camera Modes
	if (MenuAction == 103) then {
		MenuAction = -1;
		_currentMode = (_cameraModes select (lbCurSel 21006));
		_cameraSwap = true;
	};
	
	//--- Update the Camera.
	if (_cameraSwap) then {
		CtrlMapAnimClear _map;
		_map CtrlMapAnimAdd [2,.25,GetPos _currentUnit];
		CtrlMapAnimCommit _map;
		_currentUnit switchCamera _currentMode
	};
};