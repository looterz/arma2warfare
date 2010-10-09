Private["_index", "_slot"];

_slot = effectiveCommander _this;
_index = ('WFBE_EASTSLOTNAMES' Call GetNamespace) find (vehicleVarName _slot);
if (_index < 0) then {_index = ('WFBE_WESTSLOTNAMES' Call GetNamespace) find (vehicleVarName _slot)};

_index + 1