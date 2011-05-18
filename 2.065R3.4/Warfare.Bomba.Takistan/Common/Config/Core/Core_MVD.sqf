/* MVD Configuration */
Private ['_c','_get','_i','_p','_z'];

_c = [];
_i = [];

/* Infantry */
_c = _c + ['MVD_Soldier_GL'];
_i = _i + [['','',310,7,-1,3,0,0.91,'MVD']];

_c = _c + ['MVD_Soldier_MG'];
_i = _i + [['','',320,7,-1,3,0,0.92,'MVD']];

_c = _c + ['MVD_Soldier_Marksman'];
_i = _i + [['','',330,7,-1,3,0,0.97,'MVD']];

_c = _c + ['MVD_Soldier_AT'];
_i = _i + [['','',345,7,-1,3,0,0.96,'MVD']];

_c = _c + ['MVD_Soldier_Sniper'];
_i = _i + [['','',350,7,-1,3,0,0.98,'MVD']];

_c = _c + ['MVD_Soldier_TL'];
_i = _i + [['','',360,7,-1,3,0,1.00,'MVD']];

for '_z' from 0 to (count _c)-1 do {
	_get = (_c select _z) Call GetNamespace;
	if (isNil '_get') then {
		if ((_i select _z) select 0 == '') then {(_i select _z) set [0, [_c select _z,'displayName'] Call GetConfigInfo]};
		_p = if ((_c select _z) isKindOf 'Man') then {'portrait'} else {'picture'};
		(_i select _z) set [1, [_c select _z,_p] Call GetConfigInfo];
		[_c select _z,_i select _z] Call SetNamespace;
	} else {
		Format ["Core_MVD: Duplicated Element found '%1'",(_c select _z)] call LogMedium;
	};
};

Format ["Core_MVD: Initialization (%1 Elements) - [Done]",count _c] call LogMedium;