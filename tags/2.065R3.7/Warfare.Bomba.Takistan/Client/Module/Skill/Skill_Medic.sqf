/*
	Script: Medic Skill System by Bomba.
	Description: Add special skills to the defined medic.
*/

_units = [];

{ if (_x != player) then { _units = _units + [_x]; }  } forEach (player NearEntities [["Man"],5]);

if (count _units < 1) exitWith {};

_unit = ([player, _units] Call SortByDistance) select 0;
_dammages = getDammage _unit;

format["Heal Unit: %1, HasDammages=%2", _unit, _dammages] call LogTrace;
if (_dammages <= 0) exitWith {};

WFBE_SK_V_LastUse_Medic = time;

_skip = false;
for [{_x = 0},{_x < 2},{_x = _x + 1}] do {
	sleep 0.5;
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 0.5;
	waitUntil {animationState player == "ainvpknlmstpslaywrfldnon_amovpknlmstpsraswrfldnon" || !alive player || vehicle player != player || !alive _unit || _unit distance player > 5};
	if (!alive player || vehicle player != player || !alive _unit || _unit distance player > 5) exitWith {_skip = true};
};

if (!_skip) then {
	_dammages = _dammages - 0.5;
	if (_dammages < 0) then {_dammages = 0};
	_unit setDammage _dammages;
};