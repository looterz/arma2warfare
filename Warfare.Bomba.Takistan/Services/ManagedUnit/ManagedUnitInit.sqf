	
	ManagedUnitProc = Compile preprocessFile "Services\ManagedUnit\ManagedUnitProc.sqf";
	
	waitUntil { commonInitComplete };
	ManagedUnitList = [];
	ManagedUnitDataList = [];
	ManagedUnitListOperate = [];

[ManagedUnitProc, 10];