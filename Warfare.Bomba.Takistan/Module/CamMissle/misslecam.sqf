private['_cam','_missile','_type','_pos','_lastpos','_dt','_base','_hud','_disp','_viewdist','_vel','_dir'];
disableSerialization;

// execVM "\scripts\su34.sqf"
// execVM "Module\CamMissle\action_misslecam.sqf"
// (vehicle player) call RearmVehicle
// (vehicle player) setDammage 0;

_missile = _this select 6;
_type = typeof _missile;

//_unit = _this select 0;
//_type = _this select 1;
_pos = [0,0,0];

format["MissleCamera Fired Begin: %1", _this] call LogTrace;

if (_type != "Bo_GBU12_LGB" and _type != "M_Sidewinder_AA" and _type != "M_Hellfire_AT" and _type != "M_Maverick_AT" and _type != "M_Vikhr_AT" and _type != "M_Ch29_AT" and _type != "M_R73_AA") exitwith {};
if ((date select 3) < 4 or (date select 3) > 20) then {camUseNVG true} else {camUseNVG false};
_hud = false;
_hud = createDialog "RscMissleCamera";

_viewDist = viewDistance;
//setViewDistance 1000;

_disp = findDisplay 50001;
_disp displaySetEventHandler["KeyDown", "camdestroy _cam;closeDialog 0;player cameraEffect [""terminate"",""back""];"];

//_missile = nearestObject[_unit, _type];
_cam = "camera" camCreate (position _missile);
_cam cameraEffect ["internal","front"];
_cam camSetTarget _missile;
_cam camSetRelPos [0,-2,0.7];
_cam camSetFOV 0.7;
showCinemaBorder false;
_cam camCommit 0;

_lastPos = position _missile;
_vel = velocity _missile;
_dir = getDir _missile;
_dt = 0;

_missile addEventHandler ["Dammaged", { hint format["TargetHit:%1", _this]; }];

while { ((alive player) && dialog && (alive _missile) && (!isNull _missile)) } do 
{	
	_pos = [] + position _missile;
	
	if ((_pos select 0) != 0 && 
		(_pos select 1) != 0) then 
	{
		_lastPos = _pos;
		_dt = 4 * accTime / (diag_fps);
	
		_cam camSetTarget _missile;
		_cam camSetRelPos [0,-4,2];
		_cam camCommit _dt;
	};
};
if (!dialog) exitwith  {camUseNVG false;camdestroy _cam;player cameraEffect ["terminate","back"]};

addCamShake [10, 1, 25];
enableCamShake true;

_base = "HeliHEmpty" createVehicleLocal [_lastPos select 0, _lastPos select 1, 0];
	
if(_type == "Bo_GBU12_LGB") then
{
	_cam camSetTarget _base;
	_cam camSetRelPos [0.0,0.0, 100.0];
	_cam camCommit 1;
	sleep 2.01;
} else {
	_cam camSetTarget _lastPos;
	_cam camSetRelPos [0, 0, 50];
	_cam camCommit 2.01;
};

sleep 2.01;
deleteVehicle _base;
camUseNVG false;
camdestroy _cam;
closeDialog 0;
player cameraEffect ["terminate","back"];