waitUntil {commonInitComplete};

ServerMonitorProc = Compile preprocessFile "Services\ServerMonitor\ServerMonitorProc.sqf";
[ServerMonitorProc, 10];