private['_vehicle','_dammages','_vehicles','_skip','_sorted'];
/*
	Script: Engineer Skill System by Benny.
	Description: Add special skills to the defined engineer.
*/

_vehicles = player nearEntities [["Car","Motorcycle","Tank","Ship","Air","StaticWeapon"],5];
if (count _vehicles < 1) exitWith {};

_sorted = [player,_vehicles] Call SortByDistance;
_vehicle = _sorted select 0;

_dammages = getDammage _vehicle;
if (_dammages <= 0) exitWith {};
WFBE_SK_V_LastUse_Repair = time;

_skip = false;
for [{_x = 0},{_x < 5},{_x = _x + 1}] do {
	sleep 0.5;
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 0.5;
	waitUntil {animationState player == "ainvpknlmstpslaywrfldnon_amovpknlmstpsraswrfldnon" || !alive player || vehicle player != player || !alive _vehicle || _vehicle distance player > 5};
	if (!alive player || vehicle player != player || !alive _vehicle || _vehicle distance player > 5) exitWith {_skip = true};
};

if (!_skip) then {
	_dammages = _dammages - 0.15;
	if (_dammages < 0) then {_dammages = 0};
	_vehicle setDammage _dammages;
};