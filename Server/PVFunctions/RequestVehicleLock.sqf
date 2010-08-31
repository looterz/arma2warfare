Private["_client","_locked","_side","_vehicle"];

_side = _this select 0;
_client = _this select 1;
_vehicle = _this select 2;
_locked = _this select 3;

_vehicle lock _locked;

[CMDSETVEHICLELOCK,_vehicle,_locked] Spawn CommandToClients;