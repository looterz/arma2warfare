private['_location'];

_location = _this select 0;

waitUntil {commonInitComplete};

if (isNil "Airfields") then {Airfields = []};
Airfields = Airfields + [_location];

Format["Init_Airfield: Airfield initialization (position: %1 - item: %2) - [Done]",getPos _location,_location] call LogMedium;