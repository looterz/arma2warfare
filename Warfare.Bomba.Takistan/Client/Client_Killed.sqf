private['_killer','_isinertobject','_sidevictim','_istkfriendly'];

//--- Prevent double death.
if (playerDead) exitWith {};
playerDead = true;

if (local player && paramEnabledHeadHunters) then {
	//_killed = _this select 0;
	_killer = _this select 1;
	_sideVictim = _this select 2;
	[player, _killer, _sideVictim] spawn HeadHunters;
};

player removeAction 0;
player removeAction 1;
player removeAction 2;
player removeAction 3;
if !(isNil "HQAction") then {player removeAction HQAction};
player removeAction Options;

deathLocation = getPos player;

if (mysql) then {
	_killer = _this select 1;
	_isTKFriendly = if (side _killer == sideJoined && !isPlayer(_killer)) then {true} else {false};
	_isInertObject = false;
	if (vehicle _killer == _killer) then {
		_isInertObject = if (count(crew _killer) == 0) then {true} else {false};
	};

	if (_this select 0 == _killer || _isTKFriendly || _isInertObject) then {
		WF_Logic setVariable ["WF_MYSQL_CLIENT",(WF_Logic getVariable "WF_MYSQL_CLIENT") + [Format ["MYSQLDATA_WFBE_Update%1%2suicide%3",getPlayerUID(player),name player,worldName]],true];
	};
};

closeDialog 0;

"dynamicBlur" ppEffectEnable true;
"dynamicBlur" ppEffectAdjust [1];
"dynamicBlur" ppEffectCommit 0.1;  
"colorCorrections" ppEffectAdjust [1, 1, 0, [0.1, 0.0, 0.0, 1], [1.0, 0.5, 0.5, 0.1], [0.199, 0.587, 0.114, 0.0]];
"colorCorrections" ppEffectCommit 0.1;
"colorCorrections" ppEffectEnable true;
"colorCorrections" ppEffectAdjust [1, 1, 0, [0.1, 0.0, 0.0, 0.5], [1.0, 0.5, 0.5, 0.1], [0.199, 0.587, 0.114, 0.0]];
"colorCorrections" ppEffectCommit 0.3;

DeathCamera = "camera" camCreate deathLocation;
DeathCamera camSetDir 0;
DeathCamera camSetFov 1;
DeathCamera cameraEffect["Internal","TOP"];

DeathCamera camSetTarget deathLocation;
DeathCamera camSetPos [deathLocation select 0,(deathLocation select 1) + 2,5];
DeathCamera camCommit 0;

waitUntil {camCommitted DeathCamera};

DeathCamera camSetPos [deathLocation select 0,(deathLocation select 1) + 2,30];
DeathCamera camCommit ('WFBE_RESPAWNDELAY' Call GetNamespace)+2;

createDialog "RscRespawnMenu";