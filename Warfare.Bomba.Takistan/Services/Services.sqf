#define RegisterService(file, name) \
ServerServices = ServerServices + [ [(call compile preprocessFile ##file), 0, nil, ##name] ]

ServerServices = [];

if (isServer) then {
	RegisterService("Services\TrashObject\TrashInit.sqf", "Trash");
	RegisterService("Services\EmptyVehicles\EmptyVehInit.sqf", "EmptyVeh");

	if (paramAI) then {
		RegisterService("Services\AI_SquadRespawn\SquadRespawnInit.sqf", "AIRespawn");
	};
	
	waitUntil { serverInitComplete };
};

if (local player) then {
	RegisterService("Services\TrackMapMarker\TrackMapMarkerInit.sqf", "TrackMarkers");
};

//-- register service functions, which can called from client and from server;
TrashObject = Compile preprocessFile "Services\TrashObject\TrashObject.sqf";

[] ExecVM "Services\ServicesThread.sqf";

