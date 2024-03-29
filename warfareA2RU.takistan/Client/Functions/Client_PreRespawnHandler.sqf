Private ["_hq","_unit","_menuId"];

_unit = _this;

(_unit) Call WFBE_SK_FNC_Apply;
//[] ExecFSM "Client\FSM\updateactions.fsm";
//Options = _unit addAction ["<t color='#42b6ff'>" + (localize "STR_WF_Options") + "</t>","Client\Action\Action_Menu.sqf", "", 1, false, true, "", "_target == player"];

[] execVM "Addon\wheel\action\AddActions.sqf";
[] execVM "Addon\def_town_building\init.sqf";

[] spawn {
	sleep 5;
	_menuId = player getVariable "menuWFOptions";
	if (!isNil "_menuId") then {
		player removeAction _menuId;
		player setVariable ["menuWFOptions", nil];
	};
};

if (!isNull commanderTeam) then {
	_hq = (sideJoinedText) Call GetSideHQ;
	if (commanderTeam == group _unit) then {HQAction = _unit addAction [localize "STR_WF_BuildMenu","Client\Action\Action_Build.sqf", [_hq], 100, false, true, "", "hqInRange && canBuildWHQ && (_target == player)"]};
};

[sideJoinedText,'UnitsCreated',1] Call UpdateStatistics;