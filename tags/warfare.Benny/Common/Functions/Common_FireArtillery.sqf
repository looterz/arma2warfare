Private["_ammo","_artillery","_destination","_dispersion","_direction","_distance","_gunner","_minRange","_maxRange","_position","_radius","_side","_type","_velocity","_weapon","_x","_y"];

_artillery = _this select 0;
_destination = _this select 1;
_side = _this select 2;
_radius = _this select 3;
_index = _this select 4;

_gunner = gunner _artillery;
if (_index == -1) exitWith {diag_log Format ["[WFBE (INFORMATION)][frameno:%2 | ticktime:%3] Common_FireArtillery.sqf: No artillery types were found for '%1'.",_artillery,diag_frameno,diag_tickTime]};
if (isNull _gunner) exitWith {diag_log Format ["[WFBE (INFORMATION)][frameno:%2 | ticktime:%3] Common_FireArtillery.sqf: Artillery '%1' gunner is null.",_artillery,diag_frameno,diag_tickTime]};
if (isPlayer _gunner) exitWith {diag_log Format ["[WFBE (INFORMATION)][frameno:%2 | ticktime:%3] Common_FireArtillery.sqf: Artillery '%1' gunner is player.",_artillery,diag_frameno,diag_tickTime]};

_minRange = (Format ["WFBE_%1_ARTILLERY_MINRANGES",_side] Call GetNamespace) select _index;
_maxRange = (Format ["WFBE_%1_ARTILLERY_MAXRANGES",_side] Call GetNamespace) select _index;
_weapon = (Format ["WFBE_%1_ARTILLERY_WEAPONS",_side] Call GetNamespace) select _index;
_ammo = (Format ["WFBE_%1_ARTILLERY_AMMOS",_side] Call GetNamespace) select _index;
_velocity = (Format ["WFBE_%1_ARTILLERY_VELOCITIES",_side] Call GetNamespace) select _index;
_dispersion = (Format ["WFBE_%1_ARTILLERY_DISPERSIONS",_side] Call GetNamespace) select _index;

//--- Artillery Calculations.
_position = getPos _artillery;
_x = (_destination select 0) - (_position select 0);
_y = (_destination select 1) - (_position select 1);
_direction =  -(((_y atan2 _x) + 270) % 360);
if (_direction < 0) then {_direction = _direction + 360};
_distance = sqrt ((_x ^ 2) + (_y ^ 2)) - _minRange;
_angle = _distance / (_maxRange - _minRange) * 100 + 15;
if (_angle > 70) then {_angle = 70};
if (_distance < 0 || _distance + _minRange > _maxRange) exitWith {};

_FEH = Call Compile Format ["_artillery addEventHandler ['Fired',{[_this select 4,_this select 6,%1,%2,%3,%4,%5,%6,%7,%8,%9,%10] Spawn HandleArtillery}];",_ammo,_destination,_velocity,_dispersion,_shellpos,getPos _artillery,_distance,_radius,_maxRange,sideJoinedText];

(_gunner) disableAI "TARGET";
(_gunner) disableAI "AUTOTARGET";
_watchPosition = [_destination select 0, _destination select 1, (_artillery distance _destination)/(tan(90-_angle))];
(_gunner) doWatch _watchPosition;

sleep 10;
if !(alive (_gunner)) exitWith {if !(isNull _artillery) then {_artillery removeEventHandler ['Fired',_FEH]}};
if !(alive _artillery) exitWith {
	if (alive (_gunner)) then {
		(_gunner) enableAI 'TARGET';
		(_gunner) enableAI 'AUTOTARGET';
	};
};

_reloadTime = (Format ["WFBE_%1_ARTILLERY_RELOADTIME",_side] Call GetNamespace) select _index;
_burst = (Format ["WFBE_%1_ARTILLERY_BURST",_side] Call GetNamespace) select _index;

for [{_i = 0},{_i < _burst},{_i = _i + 1}] do {
	sleep _reloadTime;
	if (!alive (_gunner) || !alive _artillery) exitWith {};
	
	_artillery fire _weapon;
};

if (alive (_gunner)) then {
	(_gunner) enableAI 'TARGET';
	(_gunner) enableAI 'AUTOTARGET';
};
if !(isNull _artillery) then {
	_artillery removeEventHandler ['Fired',_FEH];
};