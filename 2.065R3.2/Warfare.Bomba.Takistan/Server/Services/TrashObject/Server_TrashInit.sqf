WBE_TrashObjectCollection = [];
WBE_TrashObjectCollectionQueu = [];
WFBE_UNITREMOVEDLAY = 'WFBE_UNITREMOVEDLAY' Call GetNamespace;

TrashDeleteObject = Compile preprocessFile "Server\Services\TrashObject\Server_TrashDeleteObject.sqf";
TrashHideBody = Compile preprocessFile "Server\Services\TrashObject\Server_TrashHideBody.sqf";
TrashProc = Compile preprocessFile "Server\Services\TrashObject\Server_TrashProc.sqf";

[TrashProc, 10];