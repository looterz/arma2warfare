#define RegisterService(file, name) \
ServerServices = ServerServices + [ [(call compile preprocessFile ##file), 0, nil, ##name] ]

ServerServices = [];

if (isServer) then {
	RegisterService("Services\TrashObject\TrashInit.sqf", "Trash");
	RegisterService("Services\EmptyVehicles\EmptyVehInit.sqf", "EmptyVeh");
	RegisterService("Services\ManagedUnit\ManagedUnitInit.sqf", "ManagedUnit");
	RegisterService("Services\ServerMonitor\ServerMonitorInit.sqf", "Monitor");

	if (paramAI) then {
		RegisterService("Services\AI_SquadRespawn\SquadRespawnInit.sqf", "AIRespawn");
	};
};

if (local player) then {
	RegisterService("Services\TrackMapMarker\TrackMapMarkerInit.sqf", "TrackMarkers");
};

//-- register service functions, which can called from client and from server;
TrashObject = Compile preprocessFile "Services\TrashObject\TrashObject.sqf";
ManagedUnitAdd = Compile preprocessFile "Services\ManagedUnit\ManagedUnitAdd.sqf";

[] ExecVM "Services\ServicesThread.sqf";
ServicesInit = true;

"Services Init - [Done]" call LogHigh;