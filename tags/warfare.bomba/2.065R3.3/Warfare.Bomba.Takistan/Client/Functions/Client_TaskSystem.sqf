Private ["_location","_locations","_sideID","_sorted","_type"];
_type = _this select 0;
_location = _this select 1;

switch (_type) do {
	case "TownAdd": {
		townTask = player createSimpleTask ["TakeTowns"];
		townTask setSimpleTaskDescription [Format[localize "STR_WF_TaskTown",_location getVariable "name"], Format [localize "STR_WF_TaskTown_Display",_location getVariable "name"], Format [localize "STR_WF_TaskTown_Display",_location getVariable "name"]];
		townTask setSimpleTaskDestination (getPos _location);
		if (!isNull comTask) then {//--- Don't override the commander order.
			if (taskState comTask == "Succeeded") then {player setCurrentTask townTask};
		} else {
			player setCurrentTask townTask;
		};
	};
	case "TownRemove": {player removeSimpleTask townTask};
	case "TownSuccess": {townTask setTaskState "Succeeded"};
	case "TownHintNew": {taskHint [format [localize "str_taskNew" + "\n%1",Format [localize "STR_WF_TaskTown_Display",_location getVariable "name"]], [1,1,1,1], "taskNew"]};
	case "TownHintDone": {taskHint [format [localize "str_taskAccomplished" + "\n%1",Format [localize "STR_WF_TaskTown_Display",_location getVariable "name"]], [1,1,1,1], "taskDone"]};
	case "TownAddComplete": {
		sleep 5;
		_locations = [];
		{_sideID = _x getVariable "sideID";if (_sideID != sideID) then {_locations = _locations + [_x]}} forEach towns;
		_sorted = [player,_locations] Call SortByDistance;
		if (count _sorted != 0) then {
			currentMission = _sorted select 0;
			["TownAdd",currentMission] Spawn TaskSystem;
			["TownHintNew",currentMission] Spawn TaskSystem;
		};		
	};
};