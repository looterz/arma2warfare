if (!isServer || local player) then {
	waitUntil {!isNull(player)};
};

_cnt=count paramsArray;
for [{_i=0},{_i<_cnt},{_i=_i+1}] do
{
	if ((configName((missionConfigFile >> "Params") select _i))=="enableShellBallistics") then
	{
		if ((paramsArray select _i)==1) exitWith
		{			
			call compile preprocessFile "Addon\Ballistic\precompile.sqf";
		};
	};
};

[] execVM "Addon\wheel\action\AddActions.sqf";
[] execVM "Addon\def_town_building\init.sqf";