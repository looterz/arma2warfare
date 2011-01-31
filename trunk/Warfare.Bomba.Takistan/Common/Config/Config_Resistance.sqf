Private ['_resType'];

_resType = ('WFBE_RESISTANCEFACTIONS' Call GetNamespace) select ('WFBE_RESISTANCEFACTION' Call GetNamespace);

[] Call Compile preprocessFile Format["Common\Config\Core_Resistance\Resistance_%1.sqf",_resType];

format["Config_Resistance: Intialization of Resistance '%1' - [Done]",_resType] call LogHigh;