Private["_args","_side"];

_args = _this;
_side = _args select 1;

_uav = (_args select 2);
_exit = false;
_driver = driver _uav;
_gunner = gunner _uav;
_playerTeam = (_args select 3);
diag_log Format["[WFBE (INFORMATION)] Server_HandleSpecial: The %1 %2 Team (Leader: %3) has called an UAV",str _side,_playerTeam,name leader _playerTeam];
while {!_exit} do {
	sleep 5;
	if (!isPlayer leader _playerTeam || !alive _uav) then {_exit = true};
};

if (!isNull _driver) then {if (alive _driver) then {_driver setDammage 1};if (!(_driver in trashQueu)) then {trashQueu = trashQueu + [_driver];_driver Spawn TrashObject}};
if (!isNull _gunner) then {if (alive _gunner) then {_gunner setDammage 1};if (!(_gunner in trashQueu)) then { trashQueu = trashQueu + [_gunner];_gunner Spawn TrashObject}};
if (!isNull _uav) then {if (alive _uav) then {_uav setDammage 1};if (!(_uav in trashQueu)) then { trashQueu = trashQueu + [_uav];_uav Spawn TrashObject}};