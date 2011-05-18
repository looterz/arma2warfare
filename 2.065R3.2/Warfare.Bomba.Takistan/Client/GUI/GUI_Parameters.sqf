/* Ingame parameters dump. */

for [{_i = 0},{_i < (count (missionConfigFile/"Params"))},{_i = _i + 1}]  do {
	_paramName = (configName ((missionConfigFile >> "Params") select _i));
	_text = getText (missionConfigFile >> "Params" >> _paramName >> "title");
	_values = getArray (missionConfigFile >> "Params" >> _paramName >> "values");
	_texts = getArray (missionConfigFile >> "Params" >> _paramName >> "texts");
	
	_value = if (isMultiplayer) then {paramsArray select _i} else {getNumber (missionConfigFile >> "Params" >> _paramName >> "default")};
	_status = _texts select (_values find _value);

	lnbAddRow [22003,[_text,_status]];
};

_getTime = {
	Private ["_days","_hours","_minutes","_seconds","_uptime"];
	_days = 0;
	_hours = 0;
	_minutes = 0;
	_seconds = 0;
	
	_uptime = time;
	_days = floor(_uptime / 86400);
	_hours = floor((_uptime - (_days * 86400)) / 3600);
	_minutes = floor((_uptime - (_hours * 3600) - (_days * 86400)) / 60);
	_seconds = floor(_uptime - (_minutes * 60) - (_hours * 3600) -(_days * 86400));
	
	[_days,_hours,_minutes,_seconds]
};

while {alive player && dialog} do {
	_uptime = Call _getTime;
	ctrlSetText [22005,Format[localize 'STR_WF_Uptime',_uptime select 0,_uptime select 1,_uptime select 2, _uptime select 3]];
	
	sleep 0.1;
	if (side player != sideJoined) exitWith {closeDialog 0};
	if (!dialog) exitWith {};
};