/* Spetsnaz Configuration */
Private ['_c','_get','_i','_p','_z'];

_c = [];
_i = [];

/* Infantry */
_c = _c + ['RUS_Soldier1'];
_i = _i + [['','',250,6,-1,2,0,0.98,'Russians Spetsnaz']];

_c = _c + ['RUS_Soldier2'];
_i = _i + [['','',260,6,-1,3,0,0.98,'Russians Spetsnaz']];

_c = _c + ['RUS_Soldier_GL'];
_i = _i + [['','',270,6,-1,3,0,0.99,'Russians Spetsnaz']];

_c = _c + ['RUS_Soldier_Marksman'];
_i = _i + [['','',290,6,-1,3,0,0.99,'Russians Spetsnaz']];

_c = _c + ['RUS_Soldier3'];
_i = _i + [['','',295,6,-1,3,0,0.98,'Russians Spetsnaz']];

_c = _c + ['RUS_Soldier_TL'];
_i = _i + [['','',300,6,-1,3,0,1.0,'Russians Spetsnaz']];

for '_z' from 0 to (count _c)-1 do {
	if (isClass (configFile >> 'CfgVehicles' >> (_c select _z))) then {
		_get = (_c select _z) Call GetNamespace;
		if (isNil '_get') then {
			if ((_i select _z) select 0 == '') then {(_i select _z) set [0, [_c select _z,'displayName'] Call GetConfigInfo]};
			if (WF_Debug) then {(_i select _z) set [3,1]};
			_p = if ((_c select _z) isKindOf 'Man') then {'portrait'} else {'picture'};
			(_i select _z) set [1, [_c select _z,_p] Call GetConfigInfo];
			[_c select _z,_i select _z] Call SetNamespace;
		} else {
		format["Core_Spetznaz: Duplicated Element found '%1'",(_c select _z)] call LogHigh;
		};
	} else {
		format["Core_Spetznaz: Element '%1' is not a valid class.",(_c select _z)] call LogHigh;
	};
};

Format ["Core_Spetsnaz: Initialization (%1 Elements) - [Done]",count _c] call LogMedium;