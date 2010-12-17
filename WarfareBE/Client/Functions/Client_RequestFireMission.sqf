_destination = _this Select 0;
_index = _this Select 1;
_type = 0;

ScopeName "FireMission";

_units = [Group player,_destination,false,_index] Call GetTeamArtillery;

if (count _units < 1) exitWith {};
_type = (artilleryNames select _index) find (typeOf (_units select 0));

if (_type < 0) exitWith {_type};
_reloadTime = artilleryReloadTimes select _index;
_burst = artilleryBurst select _index;

{[_x] Call ARTY_Prep} forEach _units;

for [{_count1 = 0},{_count1 < _burst},{_count1 = _count1 + 1}] do {
	_units = [Group player,_destination,false,_index] Call GetTeamArtillery;
	if (Count _units < 1) then {BreakTo "FireMission"};

	for [{_count = Count _units - 1},{_count >= 0},{_count = _count - 1}] do {
		[_units Select _count,_destination,Side player,artyRange,_index] Spawn FireArtillery;
	};

	sleep _reloadTime;
};

//Keep weapons reloaded.
_units = [Group player,_destination,true,_index] Call GetTeamArtillery;
{if (!someAmmo _x) then {_x Call RearmVehicle}} ForEach _units;

{[_x] Call ARTY_Finish} forEach _units;