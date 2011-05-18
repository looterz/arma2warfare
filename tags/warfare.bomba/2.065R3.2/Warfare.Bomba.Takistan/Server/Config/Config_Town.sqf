waitUntil { !isNil "initJIP" };

	_location = _this Select 0;
	_locationName = _this Select 1;
	_configScripts = _this Select 2;

	if (isNull _location) exitWith {
		Format ["Config_Town.sqf: (A) Town '%1' was removed by server side from TownTemplates or not initialized over JIP", _locationName] call LogMedium;
	};

	waitUntil {townModeSet};
	if ((str _location) in TownTemplate) exitWith {
		Format ["Config_Town.sqf: Removing town %1 (%2) since the town is removed in the towns templates.",_location,_locationName] call LogHigh;
		if (isServer) then {deleteVehicle _location};
	};

	waitUntil{commonInitComplete};

	if (isNull _location) exitWith {
		Format ["Config_Town.sqf: (B) Town '%1' was removed by server side from TownTemplates or not initialized over JIP", _locationName] call LogMedium;
	};

	_range = 600;
	if (Count _this > 4) then {_range = _this Select 4};

	_total = Count _configScripts;
	_script = _configScripts Select (Random (_total - 1));
	_params = [_location,_locationName];
	if (Count _this > 4) then {_params = _params + [_range]};

	_params ExecVM Format["Server\Config\Config_%1.sqf",_script];