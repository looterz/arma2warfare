if (!isServer || local player) then {
	waitUntil {!isNull(player)};
};

[] execVM "Addon\Ballistic\precompile.sqf";
[] execVM "Addon\wheel\action\AddActions.sqf";
[] execVM "Addon\def_town_building\init.sqf";