	
	ManagedUnitProc = Compile preprocessFile "Services\ManagedUnit\ManagedUnitProc.sqf";
	
	waitUntil { commonInitComplete };
	ManagedUnitList = [];
	ManagedUnitListOperate = [];

[ManagedUnitProc, 10];