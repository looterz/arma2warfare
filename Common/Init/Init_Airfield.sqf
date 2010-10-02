_location = _this select 0;

waitUntil {commonInitComplete};

if (isNil "Airfields") then {Airfields = []};
Airfields = Airfields + [_location];

diag_log Format["[WFBE (INIT)] Init_Airfield: Airfield '%1' initialization - [Done]",_location];