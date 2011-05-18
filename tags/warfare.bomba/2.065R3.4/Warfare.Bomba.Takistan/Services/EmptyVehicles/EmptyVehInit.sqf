waitUntil {commonInitComplete};

WBE_HandleEmptyVehicleCollection = [];
WBE_HandleEmptyVehicleOperation = [];
WFBE_EMPTYVEHICLETIMER = 'WFBE_ABANDONVEHICLETIMER' Call GetNamespace;

HandleEmptyVehicle = Compile preprocessFile "Services\EmptyVehicles\HandleEmptyVehicle.sqf";

EmptyVehicleIsEmpty = Compile preprocessFile "Services\EmptyVehicles\EmptyVehIsEmpty.sqf";
EmptyVehicleProc = Compile preprocessFile "Services\EmptyVehicles\EmptyVehProc.sqf";

[EmptyVehicleProc, 10];