_MHQ = _this select 0;

_lock = if (locked _MHQ) then {false} else {true};

WFBE_RequestVehicleLock = ['SRVFNCREQUESTVEHICLELOCK',[_MHQ,_lock]];
publicVariable 'WFBE_RequestVehicleLock';
if (!isMultiplayer || (isServer && local player)) then {['SRVFNCREQUESTVEHICLELOCK',[_MHQ,_lock]] Spawn HandleSPVF};
