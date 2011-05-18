waitUntil { commonInitComplete };

WBE_TrashObjectCollection = [];
WBE_TrashObjectOperation = [];
WFBE_UNITREMOVEDLAY = 'WFBE_UNITREMOVEDLAY' Call GetNamespace;

TrashDeleteObject = Compile preprocessFile "Services\TrashObject\TrashDeleteObject.sqf";
TrashHideBody = Compile preprocessFile "Services\TrashObject\TrashHideBody.sqf";
TrashProc = Compile preprocessFile "Services\TrashObject\TrashProc.sqf";

TrashObject = Compile preprocessFile "Services\TrashObject\TrashObject.sqf";

[TrashProc, 10];