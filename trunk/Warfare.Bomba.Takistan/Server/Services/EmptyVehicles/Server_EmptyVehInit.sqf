waitUntil {commonInitComplete};

WBE_HandleEmptyVehicleCollection = [];
WBE_HandleEmptyVehicleOperation = [];
WFBE_EMPTYVEHICLETIMER = 'WFBE_ABANDONVEHICLETIMER' Call GetNamespace;

HandleEmptyVehicle = Compile preprocessFile "Server\Services\EmptyVehicles\Server_HandleEmptyVehicle.sqf";

EmptyVehicleIsEmpty = Compile preprocessFile "Server\Services\EmptyVehicles\Server_EmptyVehIsEmpty.sqf";
EmptyVehicleProc = Compile preprocessFile "Server\Services\EmptyVehicles\Server_EmptyVehProc.sqf";

[EmptyVehicleProc, 10];