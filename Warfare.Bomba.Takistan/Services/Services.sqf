#define RegisterService(file) ServerServices = ServerServices + [ [(call compile preprocessFile ##file), 0] ]

ServerServices = [];

if (isServer) then {
	RegisterService("Server\TrashObject\Server_TrashInit.sqf");
	RegisterService("Server\EmptyVehicles\Server_EmptyVehInit.sqf");

	if (paramAI) then {
		RegisterService("Server\AI_SquadRespawn\Server_SquadRespawnInit.sqf");
	};
};

[] spawn compile preprocessFile "Server\Services\ServicesThread.sqf";

