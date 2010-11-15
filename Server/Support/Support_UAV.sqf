#include "profiler.h"
PROFILER_BEGIN("RequestChangeScore");

Private["_args","_side"];

_args = _this;
_side = _args select 1;

_uav = (_args select 2);
_exit = false;
_driver = driver _uav;
_gunner = gunner _uav;
_playerTeam = (_args select 3);

Format["Server_HandleSpecial: The %1 %2 Team (Leader: %3) has called an UAV",str _side,_playerTeam,name leader _playerTeam] call LogInform;

while {!_exit} do {
	sleep 5;
	if (!isPlayer leader _playerTeam || !alive _uav) then {_exit = true};
};

if (!isNull _driver) then {
	if (alive _driver) then {
		_driver setDammage 1
	};
	_driver Spawn TrashObject;
};

if (!isNull _gunner) then {
	if (alive _gunner) then {
		_gunner setDammage 1
	};
	_gunner Spawn TrashObject;
};

if (!isNull _uav) then {
	if (alive _uav) then {
		_uav setDammage 1;
	};
	_uav Spawn TrashObject;
};

PROFILER_END();