Private ['_probability','_range','_teams','_town','_townName'];

_town = _this Select 0;
_townName = _this Select 1;

_range = 600;
if (Count _this > 3) then {_range = _this Select 3};

_teams = ['light2'] Call Compile preprocessFile "Server\Functions\Server_SelectResTeam.sqf";

_probability = 78;

[_town,_townName,10,50,_range,_teams,_probability] ExecVM "Common\Init\Init_Location.sqf";