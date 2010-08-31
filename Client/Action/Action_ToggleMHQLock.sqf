_MHQ = _this select 0;

_lock = if (locked _MHQ) then {false} else {true};

[CMDREQUESTVEHICLELOCK,_MHQ,_lock] Spawn CommandToServer;