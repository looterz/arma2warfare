private['_occTypeEast','_occTypeWest'];

_occTypeWest = ('WFBE_OCCUPATIONWESTFACTIONS' Call GetNamespace) select ('WFBE_OCCUPATIONWESTFACTION' Call GetNamespace);
_occTypeEast = ('WFBE_OCCUPATIONEASTFACTIONS' Call GetNamespace) select ('WFBE_OCCUPATIONEASTFACTION' Call GetNamespace);

[] Call Compile preprocessFile Format["Common\Config\Core_Occupation\Occupation_%1.sqf",_occTypeWest];
[] Call Compile preprocessFile Format["Common\Config\Core_Occupation\Occupation_%1.sqf",_occTypeEast];

format["Config_Occupation: Intialization of Occupation West: '%1', East: '%2' - [Done]", _occTypeWest,_occTypeEast] call LogHigh;