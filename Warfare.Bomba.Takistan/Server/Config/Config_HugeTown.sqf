private['_range','_town','_townname','_teams','_probability'];
_town = _this Select 0;
_townName = _this Select 1;

_range = 600;
if (Count _this > 3) then {_range = _this Select 3};

_teams = ['huge1'] Call Compile preprocessFile "Server\Functions\Server_SelectResTeam.sqf";

_probability = 65;

[_town,_townName,30,120,_range,_teams,_probability] ExecVM "Common\Init\Init_Location.sqf";