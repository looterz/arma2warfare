waitUntil { commonInitComplete };

WBE_TrashObjectCollection = [];
WBE_TrashObjectOperation = [];
WFBE_UNITREMOVEDLAY = 'WFBE_UNITREMOVEDLAY' Call GetNamespace;

TrashDeleteObject = Compile preprocessFile "Server\Services\TrashObject\Server_TrashDeleteObject.sqf";
TrashHideBody = Compile preprocessFile "Server\Services\TrashObject\Server_TrashHideBody.sqf";
TrashProc = Compile preprocessFile "Server\Services\TrashObject\Server_TrashProc.sqf";

TrashObject = Compile preprocessFile "Server\Services\TrashObject\Server_TrashObject.sqf";

[TrashProc, 10];