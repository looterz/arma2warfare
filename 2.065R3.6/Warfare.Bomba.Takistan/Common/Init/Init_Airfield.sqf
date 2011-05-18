_location = _this select 0;

waitUntil {commonInitComplete};

if (isNil "Airfields") then {Airfields = []};
Airfields = Airfields + [_location];

Format["Init_Airfield: Airfield '%1' initialization - [Done]",_location] call LogMedium;