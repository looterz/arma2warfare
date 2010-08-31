_vehicle = _this select 0;

_lock = true;
if (Locked _vehicle) then {_lock = false};

[_vehicle,_lock] Call CLTFNCSetVehicleLock;