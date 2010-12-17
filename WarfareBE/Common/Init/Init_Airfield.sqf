_location = _this select 0;

waitUntil {commonInitComplete};

if (isNil "Airfields") then {Airfields = []};
Airfields = Airfields + [_location];

diag_log Format["[WFBE (INIT)] Init_Airfield: Airfield initialization (position: %1 - item: %2) - [Done]",getPos _location,_location];