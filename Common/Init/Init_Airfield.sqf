_location = _this select 0;

waitUntil {commonInitComplete};

if (isNil "Airfields") then {Airfields = []};
Airfields = Airfields + [_location];