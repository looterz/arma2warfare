private['_action','_actionID','_caller','_index','_lifter','_sorted','_type','_vehicle','_vehicles','_pos','_position','_isattached'];

_lifter = _this select 0;
_caller = _this select 1;
_actionID = _this select 2;

if (_caller != driver _lifter) exitWith {};
if ((typeOf _lifter) in Zeta_Special) then {
	if (speed _lifter > 20) exitWith {};
} else {
	if ((speed _lifter > 20)||((getpos _lifter select 2)<2)) exitWith {};
};
//--- nearEntities handle living units.
_vehicles = _lifter nearEntities [Zeta_Types, 10];
if (count _vehicles < 1) exitWith {};

_sorted = [_lifter,_vehicles] Call SortByDistance;
_vehicle = _sorted select 0;
_type = typeOf _lifter;
_position = Zeta_DefaultPos;
_index = Zeta_Special find _type;
if (_index != -1) then {_position = Zeta_SpecialPosition select _index};

if (count crew(_vehicle) > 0) exitWith {hint (localize 'STR_WF_Hook_Manned')};

_vehicle attachTo [_lifter,_position];
_lifter setVariable ["Attached",true,false];
_lifter removeAction _actionID;

_action = _lifter addAction [localize "STR_WF_Lift_Detach","Client\Module\ZetaCargo\Zeta_Unhook.sqf"];

while {!gameOver} do {
	sleep 2;
	_isAttached = _lifter getVariable "Attached";
	
	if ( (getDammage _lifter > 0.3) || !_isAttached || isNull (driver _lifter) || ((position _vehicle) select 2) < 0) exitWith {
		detach _vehicle;
		_lifter removeAction _action;
		if (alive _lifter) then {_lifter addAction [localize "STR_WF_Lift","Client\Module\ZetaCargo\Zeta_Hook.sqf"]};
		
		_pos = position _vehicle;
		if ((_pos select 2) < 0) then {
			_pos set [2, 0];
			_vehicle setPos _pos;
		};
		
		
	};
};