#define RegisterService(file) ServerServices = ServerServices + [ [(call compile preprocessFile ##file), 0] ]

ServerServices = [];

if (isServer) then {
	RegisterService("Services\TrashObject\TrashInit.sqf");
	RegisterService("Services\EmptyVehicles\EmptyVehInit.sqf");

	if (paramAI) then {
		RegisterService("Services\AI_SquadRespawn\SquadRespawnInit.sqf");
	};
};

[] spawn compile preprocessFile "Services\ServicesThread.sqf";

