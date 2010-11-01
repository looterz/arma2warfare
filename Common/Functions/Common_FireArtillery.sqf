Private["_magazine", "_ammo","_angle","_arcDistance","_artillery","_destination","_direction","_distance","_minRange","_maxRange","_position","_radius","_shell","_side","_type","_velocity","_weapon","_x","_y"];

_artillery = _this Select 0;
_destination = _this Select 1;
_side = _this Select 2;
_radius = _this Select 3;
_index = _this select 4;

if (_index == -1) exitWith {
	Format ["Common_FireArtillery.sqf: No artillery types were found for '%1'.",_artillery] call LogError;
};

_gravityConst = 9.81; // m/s2

if (isNil 'StopArtyCalc') then { StopArtyCalc = false; };

_procGetEndHeight = {
private['_tetha', '_velocity', '_time', '_H'];
	_tetha = (_this select 0);
	_velocity = (_this select 1);
	_distance = (_this select 2);
	
	_time = _distance / (_velocity * cos (_tetha));
	_H = (_velocity * sin(_tetha) * _time) - (0.5 * _gravityConst * _time * _time);
	_H;
};

_procCalculateTheta = {
private['_velocity', '_dH1', '_H', '_dH', '_tetha', '_step', '_height', '_distance'];
	_velocity = (_this select 0);
	_distance = (_this select 1);
	_height   = (_this select 2);
	
	_step = if (paramArtilleryHighBallistic) then { 15 } else { -15 };
	_tetha = 45;
	
	_H = [_tetha, _velocity, _distance] call _procGetEndHeight;
	_dH = _height - _H;
	
	while {  abs(_dH) > 5 && _tetha > 0 && _tetha <= 90 && (abs(_step) > 0.0005) && !StopArtyCalc   } do {
		
		_H = [_tetha + _step, _velocity, _distance] call _procGetEndHeight;		
		_dH1 = _height - _H;
		
		if ( abs(_dH1) > abs(_dH) ) then {
			_step = _step / 2;
		} else {
			_tetha = _tetha + _step;
			_dH = _dH1;
		};
	};

	format["Theta: V=%1 Dist=%2 Height=%3 --> tetha=%4 dH=%5", _velocity, _distance, _height, _tetha, _dH ] call LogHigh;
	_tetha;
};

_procTraceBallisticTraectory = {
private['_hitPoint', '_destination', '_speed', '_aslH', '_shell', '_posASL1', '_timeMax', '_shellPos', '_x0', '_y0', '_z0', '_vel', '_dx', '_dy', '_R', '_H', '_theta', '_vx', '_vy', '_sinQ', '_cosQ', '_time', '_endTraectory', '_timeFlight', '_halfG', '_velXY', '_velY', '_dL', '_dH', '_posASL2'  ];

	_shell = _this select 0;
	_destination = _this select 1;

	_speed = velocity _shell;
	_shellPos = getPosASL _shell;
	_shell setPos [(_destination select 0), (_destination select 1), 2000];
	_shell SetVelocity [0,0,0];	
	
	_aslH = ((getPosASL _shell) select 2) - 2000;

	_x0 = (_shellPos Select 0);
	_y0 = (_shellPos Select 1);
	_z0 = (_shellPos Select 2);
	
	_vel = sqrt ( (_speed select 0)^2 + (_speed select 1)^2 + (_speed select 2)^2 );
	_dx = (_destination Select 0) - _x0;
	_dy = (_destination Select 1) - _y0;
	_R = sqrt(_dx*_dx + _dy*_dy);
	_H = _aslH - _z0;
	
	format["FireArtillery: Position shell = [%1, %2, %3]", _x0, _y0, _z0] call LogHigh;
	format["FireArtillery: Velocity shell = %1 m/s", _vel] call LogHigh;
	format["FireArtillery: Distance = %1 m", _R] call LogHigh;
	format["FireArtillery: Target Height over Sea = %1 m", _aslH] call LogHigh;
	format["FireArtillery: Arty Height over Sea = %1 m", _z0] call LogHigh;
	format["FireArtillery: Target height relative Arty = %1 m", _H] call LogHigh;
	
	_theta = [_vel, _R, _H] call _procCalculateTheta;
	
	_vx = _dx / _R;
	_vy = _dy / _R;
	
	_posASL1 = _shellPos;
	
	if (isNil 'artyHitPointCount') then { artyHitPointCount = 0; };
	
	
	_hitPoint = format["artilleryAreaMarker%1", artyHitPointCount];
	CreateMarkerLocal [_hitPoint, _posASL1];
	_hitPoint SetMarkerShapeLocal "Ellipse";
	_hitPoint setMarkerColorLocal "ColorYellow";
	_hitPoint setMarkerSizeLocal [10, 10];
	artyHitPointCount = artyHitPointCount + 1;
	
	if (_theta > 45 && !paramArtilleryHighBallistic) then { 
	
		_oldTheta = _theta;
		_timeFlight = ceil(_R / (_vel*cos(_theta)));
		format["FireArtillery: Restrict use high ballistic: _timeFlight=%1 _vel=%2 _R=%3", _timeFlight, _vel, _R] call LogHigh;
		
		_theta = 45; 
		_vel = _R / (_timeFlight * cos(_theta));
		
		format["FireArtillery: Restrict use high ballistic traectory: theta=%1 --> willUse theta = %2, newVelocity=%3", _oldTheta, _theta, _vel] call LogHigh;
	};
	
	
	_timeFlight = ceil(_R / (_vel*cos(_theta)));
	format["FireArtillery: _timeFlight=%1 _vel=%2 _R=%3", _timeFlight, _vel, _R] call LogHigh;
	
	_velXY = _R / _timeFlight;
	_velZ = (_H + (0.5 * _gravityConst * _timeFlight * _timeFlight)) / _timeFlight;
	
	_shellType = typeof _shell;
	format["FireArtillery: Theta=%1, Velocity=%2 FlightTime=%3", _theta, _vel, _timeFlight] call LogHigh;
	format["FireArtillery: Effective Theta theta=%1 Vxy=%2 Vz=%3", atan(_velZ / _velXY), _velXY, _velZ] call LogHigh;
	
	deleteVehicle _shell;
	
	_fireTarget = "FireSectorTarget" createVehicleLocal  (position _artillery);
	_fireTarget setVectorDir [_vx, _vy, 0];
	
	_endTracePoint = _destination;
	
	_time = 0;
	_endTraectory = false;
	_traceH = 0;
	_dT = 0.010;
	while { !_endTraectory && _time <= _timeFlight } do {

		_time = _time + _dT;

		_dL = _velXY * _time;
		_dH = _velZ * _time - (0.5 * _gravityConst * _time*_time);
		_tracePos = _fireTarget modelToWorld [ 0, _dL, _dH ];		
		
		_traceH = (_tracePos select 2);
		
		_dT = _traceH / 10000;
		if (_dT > 5.00) then { _dT = 5.0;  };
		if (_dT < 0.05) then { _dT = 0.05; };
		
		if ( _traceH < 0) then { 
			_endTraectory = true;
			_endTracePoint = _tracePos;
			_timeFlight = _time;
		};
	};	

	format["FireArtillery: Tracing traectory and ground collision: Target=%1, HitPosition=%2", _destination, _endTracePoint] call LogHigh;
	
	_time = 0;
	while { _time < _timeFlight } do {
	
		sleep (0.15);
		_time = _time + 0.15;
		if (_time > _timeFlight) then { _time = _timeFlight; };
		
		_dL = _velXY * _time;
		_hitPoint setMarkerPosLocal [(_x0 + _dL * _vx), (_y0 + _dL * _vy) ];
	};

	deleteVehicle _fireTarget;
	_hitPoint setMarkerPosLocal _endTracePoint;
	
	_shellVx = _velXY * _vx;
	_shellVy = _velXY * _vy;
	_shellVz = _velZ - _gravityConst * _timeFlight;
	
	format["FireArtillery: prehitting target: shellVx=%1 shellVy=%2 shellVz=%3", _shellVx, _shellVy, _shellVz] call LogHigh;
	
	_shellNew = _shellType createVehicle [(_endTracePoint select 0) - _shellVx , (_endTracePoint select 1) - _shellVy, -_shellVz];
	_shellNew SetVelocity [_shellVx, _shellVy, _shellVz];
	
	_hitPoint setMarkerColorLocal "ColorRed";
	sleep 10;
	deleteMarkerLocal _hitPoint;
	
};


_minRange = artilleryMinRanges Select _index;
_maxRange = artilleryMaxRanges Select _index;
_weapon = artilleryWeapons Select _index;
_ammo = artilleryAmmos Select _index;
_velocity = artilleryVelocities Select _index;
_dispersion = artilleryDispersions Select _index;

_magazine = currentMagazine _artillery;
_ammo = getText (configFile >> "CfgMagazines" >> _magazine >> "ammo");

if (IsNull Gunner _artillery) exitWith {
	Format ["Common_FireArtillery.sqf: Artillery '%1' gunner is null.",_artillery] call LogHigh;
};
if (IsPlayer Gunner _artillery) exitWith {
	Format ["Common_FireArtillery.sqf: Artillery '%1' gunner is player.",_artillery] call LogHigh;
};

_position = getPosASL _artillery;
_x = (_destination Select 0) - (_position Select 0);
_y = (_destination Select 1) - (_position Select 1);

_direction =  -(((_y atan2 _x) + 270) % 360);
if (_direction < 0) then {_direction = _direction + 360};

_watchPosition = [(_position Select 0) + (sin _direction) * 50,(_position Select 1) + (cos _direction) * 50, 75];
Gunner _artillery DoWatch _watchPosition;
sleep 2;


_distance = sqrt ((_x ^ 2) + (_y ^ 2)) - _minRange;

if (_distance < 0 || _distance + _minRange > _maxRange) ExitWith {};


_amount = _artillery Ammo _weapon;

if (_amount > 0) then {

	_radialR = Random (_distance / _maxRange * 100) + Random _radius;
	_radialAlpha = Random 360;
	_destination = [(_destination Select 0)+((sin _radialAlpha)*_radialR),(_destination Select 1)+((cos _radialAlpha)*_radialR), 2000];
	
	_artillery Fire _weapon;

	waitUntil {_artillery ammo _weapon < _amount};

	_shell = nearestObject [_artillery, _ammo];
	
	if (!(isNull _shell)) then  {
		format["FireArtillery: Artillery=%1", _artillery] call LogHigh;
		format["FireArtillery: AmmoType=%1", _ammo] call  LogHigh;
		format["FireArtillery: Destination=%1", _destination] call  LogHigh;
		format["FireArtillery: Nearest Shell=%1", _shell] call LogHigh;
		
		[_shell, _destination] call _procTraceBallisticTraectory;
	};
	
	Gunner _artillery DoWatch _watchPosition;
}