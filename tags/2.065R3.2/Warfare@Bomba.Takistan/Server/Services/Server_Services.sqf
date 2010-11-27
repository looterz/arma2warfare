#define RegisterService(file) ServerServices = ServerServices + [ [(call compile preprocessFile ##file), 0] ]

ServerServices = [];
RegisterService("Server\Services\TrashObject\Server_TrashInit.sqf");
RegisterService("Server\Services\EmptyVehicles\Server_EmptyVehInit.sqf");

if (paramAI) then {
	RegisterService("Server\Services\AI_SquadRespawn\Server_SquadRespawnInit.sqf");
};

[] spawn compile preprocessFile "Server\Services\Server_ServicesThread.sqf";

