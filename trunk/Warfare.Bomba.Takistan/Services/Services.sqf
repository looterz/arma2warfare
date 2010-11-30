#define RegisterService(file, name) ServerServices = ServerServices + [ [(call compile preprocessFile ##file), 0, nil, ##name] ]

ServerServices = [];

if (isServer) then {
	RegisterService("Services\TrashObject\TrashInit.sqf", "Trash");
	RegisterService("Services\EmptyVehicles\EmptyVehInit.sqf", "EmptyVeh");

	if (paramAI) then {
		RegisterService("Services\AI_SquadRespawn\SquadRespawnInit.sqf", "AIRespawn");
	};
	
	waitUntil { serverInitComplete };
};

RegisterService("Services\TrackMapMarker\TrackMapMarkerInit.sqf", "TrackMarkers");

[] ExecVM "Services\ServicesThread.sqf";

