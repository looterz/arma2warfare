private['_camera','_blist','_vehi','_base','_sectarget','_side','_stats','_track','_position','_hq','_nvgstate','_camshotorder'];

_side = _this Select 0;
_blist = _this Select 1;
_stats = _this Select 2;

[_side, _stats] ExecVM "Client\GUI\GUI_EndOfGameStats.sqf";
_track = if (WF_A2_Vanilla) then {"Track21_Rise_Of_The_Fallen"} else {"EP1_Track15"};
playMusic _track;
_base = WestMHQ;
_secTarget = EastMHQ;
if (_side == West) then {_base = EastMHQ;_secTarget = WestMHQ};
_position = getPos _base;

_blist = [_secTarget,_blist] Call SortByDistance;
_blist = [_secTarget] + _blist;

//--- Safety Pos.
_HQ = (sideJoinedText) Call GetSideHQ;
_vehi = vehicle player;
if (_vehi != player) then {player action ["EJECT", _vehi];_vehi = player};
_vehi setVelocity [0,0,-0.1];
_vehi setPos ([_HQ, 20, 30] Call GetRandomPositionEx);

if (!isNil "DeathCamera") then {
	DeathCamera cameraEffect["TERMINATE","BACK"];
	camDestroy DeathCamera;
	"colorCorrections" ppEffectEnable false;
	"dynamicBlur" ppEffectEnable false;
};

_camera = "camera" camCreate _position;
_camera camSetDir 0;
_camera camSetFov 0.200;
_camera cameraEffect["Internal","back"];
_camera camSetTarget getPos _base;
_camera camSetRelPos [160.80,130.29,140.07];
_camera camCommit 0;
_nvgstate = if (daytime > 18.5 || daytime < 5.5) then {true} else {false};
camUseNVG _nvgstate;

waitUntil {camCommitted _camera};

_camera camSetRelPos [-190.71,190.55,180.94];
_camera camCommit 10;

waitUntil {camCommitted _camera};

_camShotOrder = [[0,100,35],[50,0,20],[0,-50,20],[-50,0,20]];

{
	_camera camSetPos getPos _x;
	_camera camSetTarget getPos _x;
	
	{
		_camera camSetRelPos _x;
		_camera camCommit 5;
	waitUntil {camCommitted _camera};
	} forEach _camShotOrder;
	
	_camera camSetRelPos [0,100,35];
	_camera camCommit 5;
	waitUntil {camCommitted _camera};
} forEach _blist;

sleep 3;
failMission "END1";