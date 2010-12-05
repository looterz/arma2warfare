/* Private Military Company Addon Configuration */
Private ['_c','_get','_i','_p','_z'];

_c = [];
_i = [];

/* Light Vehicles */
_c = _c + ['SUV_PMC'];
_i = _i + [['','',260,6,-1,3, 0, 0.96,'PMC']];

_c = _c + ['SUV_PMC_BAF'];
_i = _i + [['','',340,6,-1,3, 0, 1.00,'PMC']];

_c = _c + ['ArmoredSUV_PMC'];
_i = _i + [['','',440,6,-1,3, 0, 1.00,'PMC']];


/* Air Forces */
_c = _c + ['Ka137_PMC'];
_i = _i + [['','',  8250, 35, 1, 1, 3, 0,'PMC']];	// cost | build time | crew | up-level |  ??? | ??? | GroupName

_c = _c + ['Ka137_MG_PMC'];
_i = _i + [['','', 11000, 45, 2, 2, 3, 0,'PMC']];

_c = _c + ['Ka60_PMC'];
_i = _i + [['','',  8250, 45, 1, 0, 3, 0,'PMC']];

_c = _c + ['Ka60_GL_PMC'];
_i = _i + [['','', 16500, 45, 2, 1, 3, 0,'PMC']];

for '_z' from 0 to (count _c)-1 do {
	_get = (_c select _z) Call GetNamespace;
	if (isNil '_get') then {
		if ((_i select _z) select 0 == '') then {(_i select _z) set [0, [_c select _z,'displayName'] Call GetConfigInfo]};
		_p = if ((_c select _z) isKindOf 'Man') then {'portrait'} else {'picture'};
		(_i select _z) set [1, [_c select _z,_p] Call GetConfigInfo];
		[_c select _z,_i select _z] Call SetNamespace;
	} else {
		Format ["Core_PMC: Duplicated Element found '%1'",_get] call LogMedium;
	};
};

Format ["Core_PMC: Initialization (%1 Elements) - [Done]",count _c] call LogMedium;