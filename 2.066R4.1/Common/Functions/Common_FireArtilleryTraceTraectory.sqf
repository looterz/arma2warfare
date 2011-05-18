private['_arty', '_pos', '_hitPoint', '_target', '_speed', '_aslH', '_shell', '_posASL1', '_timeMax', '_artyPos', '_x0', '_y0', '_z0', '_vel', '_dx', '_dy', '_R', '_H', '_theta', '_vx', '_vy', '_sinQ', '_cosQ', '_time', '_endTraectory', '_timeFlight', '_halfG', '_velXY', '_velY', '_dL', '_dH', '_posASL2'  ];

_gravityConst = 9.81; // m/s2

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
private['_velocity', '_dH1', '_H', '_dH1', '_dH2', '_dH', '_tetha', '_step', '_height', '_distance'];
	_velocity = (_this select 0);
	_distance = (_this select 1);
	_height   = (_this select 2);
	
	format["CalcTheta: V=%1 Dist=%2 Height=%3", _velocity, _distance, _height ] call LogHigh;
	
	_step = -15;
	_tetha = 45;
	
	_H = [_tetha, _velocity, _distance] call _procGetEndHeight;
	_dH = _height - _H;
	
	if (paramArtilleryHighBallistic) then {
		_dH1 = ([_tetha + 15, _velocity, _distance] call _procGetEndHeight) - _H;
		_dH2 = ([_tetha - 15, _velocity, _distance] call _procGetEndHeight) - _H;
		
		_step = if ( abs(_dH1) < abs(_dH2) ) then { 15 } else { -15 };
	};
	
	while {  abs(_dH) > 5 && _tetha > 0 && _tetha <= 90 && (abs(_step) > 0.0005) } do {
		
		_H = [_tetha + _step, _velocity, _distance] call _procGetEndHeight;		
		_dH1 = _height - _H;
		
		if ( abs(_dH1) > abs(_dH) ) then {
			_step = _step / 2;
		} else {
			_tetha = _tetha + _step;
			_dH = _dH1;
		};
	};
	
	if (_tetha < 20) then {
		_tetha = 20;	
	};

	format["Theta: V=%1 Dist=%2 Height=%3 --> tetha=%4 dH=%5", _velocity, _distance, _height, _tetha, _dH ] call LogHigh;
	_tetha;
};

_arty = _this select 0;
_shell = _this select 1;
_target = _this select 2;

_speed = velocity _shell;
_shellType = typeof _shell;
deleteVehicle _shell;

_artyPos = getPosASL _arty;
_fireTarget = "FireSectorTarget" createVehicleLocal ([_target select 0, _target select 1, 0]);
_aslTarget = getPosASL _fireTarget;
deleteVehicle _fireTarget;

_aslH = (_aslTarget select 2);

_x0 = (_artyPos Select 0);
_y0 = (_artyPos Select 1);
_z0 = (_artyPos Select 2);

_vel = sqrt ( (_speed select 0)^2 + (_speed select 1)^2 + (_speed select 2)^2 );
_dx = (_target Select 0) - _x0;
_dy = (_target Select 1) - _y0;
_R = sqrt(_dx*_dx + _dy*_dy);
_H = _aslH - _z0;

"-------------------------" call LogHigh;
format["FireArtillery: Arty Pos = %1", _artyPos] call LogHigh;
format["FireArtillery: Target = %1", _aslTarget] call LogHigh;
format["FireArtillery: Position shell = [%1, %2, %3]", _x0, _y0, _z0] call LogHigh;
format["FireArtillery: Velocity shell = %1 m/s", _vel] call LogHigh;
format["FireArtillery: Distance = %1 m", _R] call LogHigh;
format["FireArtillery: Target Height over Sea = %1 m", _aslH] call LogHigh;
format["FireArtillery: Arty Height over Sea = %1 m", _z0] call LogHigh;
format["FireArtillery: Target height relative Arty = %1 m", _H] call LogHigh;

_theta = [_vel, _R, _H] call _procCalculateTheta;

_vx = _dx / _R;
_vy = _dy / _R;

_posASL1 = _artyPos;

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

if (atan(_velZ / _velXY) < 15) then {
	_velZ = tan(15) * _velXY;
};

format["FireArtillery: Theta=%1, Velocity=%2 FlightTime=%3", _theta, _vel, _timeFlight] call LogHigh;
format["FireArtillery: Effective Theta theta=%1 Vxy=%2 Vz=%3", atan(_velZ / _velXY), _velXY, _velZ] call LogHigh;




_fireTarget = "FireSectorTarget" createVehicleLocal (position _arty);	//need create target and set vector
_fireTarget setVectorDir [_vx, _vy, 0];

_endTracePoint = _target;

format["FireArtillery: Pos0=%1", atan(_velZ / _velXY), _velXY, _velZ] call LogHigh;

_time = 0;
_endTraectory = false;
_traceH = 0;
_dT = 0.15;
while { !_endTraectory && _time <= _timeFlight } do {

	_time = _time + _dT;

	_dL = _velXY * _time;
	_dH = _velZ * _time - (0.5 * _gravityConst * _time*_time);
	_tracePos = _fireTarget modelToWorld [ 0, _dL, _dH ];		
	
	_traceH = (_tracePos select 2);
	format["FireArtillery: dT=%1, dL=%2, dH=%3, aslH=%4", _time, _dL, _dH, _traceH] call LogHigh;
	
	//_dT = _traceH / 10000;
	//if (_dT > 5.00) then { _dT = 5.0;  };
	//if (_dT < 0.05) then { _dT = 0.05; };
	
	if ( _traceH < 0) then { 
		_endTraectory = true;
		_endTracePoint = _tracePos;
		_timeFlight = _time;
	};
};	

format["FireArtillery: Tracing traectory and ground collision: Target=%1, HitPosition=%2", _target, _endTracePoint] call LogHigh;

if (!WF_DEBUG) then {
	_time = 0;
	while { _time < _timeFlight } do {

		sleep (0.15);
		
		_time = _time + 0.15;
		if (_time > _timeFlight) then { _time = _timeFlight; };
		
		_dL = _velXY * _time;
		_hitPoint setMarkerPosLocal [(_x0 + _dL * _vx), (_y0 + _dL * _vy) ];
	};
};

_fireTarget setPos [_endTracePoint select 0, _endTracePoint select 1, 0];
_aslTarget = getPosASL _fireTarget;

deleteVehicle _fireTarget;
_hitPoint setMarkerPosLocal _endTracePoint;

_dT = if (WF_A2_Vanilla) then { 0 } else { 1 };
//_shellVx = _velXY * _vx;
//_shellVy = _velXY * _vy;
//_shellVz = _velZ - _gravityConst * (_timeFlight - (_dT));

//if (_shellVz > -50) then { _shellVz = -50; };
//_pos = [ (_aslTarget select 0) - _shellVx*_dT , (_aslTarget select 1) - _shellVy*_dT, 50+(_aslTarget select 2)-_shellVz*_dT ];
_pos = [ (_aslTarget select 0) , (_aslTarget select 1), 0.0 ];

//format["FireArtillery: prehit shell speed: shellVx=%1 shellVy=%2 shellVz=%3", _shellVx, _shellVy, _shellVz] call LogHigh;
//format["FireArtillery: prehit begin coords: %1", _pos] call LogHigh;
//format["FireArtillery: prehit end coords: %1", _aslTarget] call LogHigh;
//format["FireArtillery: shellType=%1", _shellType] call LogHigh;
//format["FireArtilleryR: pos=%1", _pos] call LogHigh;

_shellnew =  createVehicle [_shelltype, _pos, [], 0, ""];
_shellnew setVelocity [0, 0, _velocity];

_hitPoint setMarkerColorLocal "ColorRed";
sleep 10;
deleteMarkerLocal _hitPoint;


