// execVM "Addon\def_town_building\init.sqf"

DefenceAddonPath = "Addon\def_town_building\";		// Путь

DefenceCreate = compile preprocessFile (DefenceAddonPath + "DefenceCreate.sqf");
DefenceGetServerDefence = compile preprocessFile (DefenceAddonPath + "DefenceGetServerDefence.sqf");
DefenceHandleEvent = compile preprocessFile (DefenceAddonPath + "DefenceHandleEvent.sqf");

call compile preprocessFile (DefenceAddonPath + "DefenceConfig.sqf"); // Массивы для строительства
call compile preprocessFile (DefenceAddonPath + "DefenceCondition.sqf");

if (!isNil "DefencePlayerAction") then {
	{ player removeAction _x } foreach DefencePlayerAction;
	DefenceActiveScript = false;
	player removeEventHandler ['Killed', DefencePlayerKilledEH];
	sleep 2;	
};

DefencePlayerKilledEH = objNull;
DefencePlayerAction = [];
DefenceActiveScript = true;
player setVariable ["DefencePreview", objNull];
player setVariable ["DefenceTaken", objNull];

DefencePlayerKilledEH = player addEventHandler["Killed", {
	_previewDefence = player getVariable "DefencePreview";
	if (!isNull(_previewDefence)) then {
		call compile preprocessFile DefenceAddonPath + "DefenceActionCancel.sqf";
	};
	_takenDefence = player getVariable "DefenceTaken";
	if (!isNull(_takenDefence)) then {
		call compile preprocessFile DefenceAddonPath + "DefenceActionDrop.sqf";
	};	
} ];

_menuFormat = "<t color='#d67e00'>%1</t>";

_actionId = player addAction [format[_menuFormat, localize "PC_create_object"], DefenceAddonPath+"DefenceActionBuy.sqf" ,  "", 1, false, true, "",  "call DefenceConditionBuy"];
DefencePlayerAction = DefencePlayerAction + [_actionId];
_actionId = player addAction [format[_menuFormat, localize "PC_remove_object"], DefenceAddonPath+"DefenceActionSell.sqf" , "", 1, false, true, "",  "call DefenceConditionSell"];
DefencePlayerAction = DefencePlayerAction + [_actionId];
_actionId = player addAction [format[_menuFormat, localize "PC_set_object"]   , DefenceAddonPath+"DefenceActionPlace.sqf", "", 1, false, true, "",  "call DefenceConditionPlace"];
DefencePlayerAction = DefencePlayerAction + [_actionId];
_actionId = player addAction [format[_menuFormat, localize "PC_cancel"]       , DefenceAddonPath+"DefenceActionCancel.sqf", "", 1, false, true, "", "call DefenceConditionCancel"];
DefencePlayerAction = DefencePlayerAction + [_actionId];
_actionId = player addAction [format[_menuFormat, localize "PC_take_object"]  , DefenceAddonPath+"DefenceActionTake.sqf"  , "", 1, false, true, "", "call DefenceConditionTake"];
DefencePlayerAction = DefencePlayerAction + [_actionId];
_actionId = player addAction [format[_menuFormat, localize "PC_set_object"]   , DefenceAddonPath+"DefenceActionDrop.sqf"  , "", 1, false, true, "", "call DefenceConditionDrop"];
DefencePlayerAction = DefencePlayerAction + [_actionId];

DefenceMarkerIdCounter = 0;

[] spawn {

	_timeout = time + 5;
	while { !gameOver && DefenceActiveScript } do {
		if (vehicle player != player && !isNull(player getVariable "DefencePreview")) then {
			execVM DefenceAddonPath + "cancel.sqf";
		};
		
		if (vehicle player != player && !isNull(player getVariable "DefenceTaken")) then {
			commandGetOut player;
		};		
		
		if (_timeout < time) then {
			[] call DefencePrintStats;	
			_timeout = time + 5;			
		};	
		sleep 0.5;
	};
};
