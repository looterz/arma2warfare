/* TK SF Configuration */
Private ['_c','_get','_i','_p','_z'];

_c = [];
_i = [];

/* Infantry */
_c = _c + ['TK_Special_Forces_EP1'];
_i = _i + [['','',280,6,-1,2,0,0.82,'Takistani Special Forces']];

_c = _c + ['TK_Special_Forces_TL_EP1'];
_i = _i + [['','',300,6,-1,2,0,0.85,'Takistani Special Forces']];

_c = _c + ['TK_Special_Forces_MG_EP1'];
_i = _i + [['','',305,6,-1,2,0,0.81,'Takistani Special Forces']];

for '_z' from 0 to (count _c)-1 do {
	_get = (_c select _z) Call GetNamespace;
	if (isNil '_get') then {
		if ((_i select _z) select 0 == '') then {(_i select _z) set [0, [_c select _z,'displayName'] Call GetConfigInfo]};
		_p = if ((_c select _z) isKindOf 'Man') then {'portrait'} else {'picture'};
		(_i select _z) set [1, [_c select _z,_p] Call GetConfigInfo];
		[_c select _z,_i select _z] Call SetNamespace;
	} else {
		Format ["Core_TKSF: Duplicated Element found '%1'",(_c select _z)] call LogMedium;
	};
};

Format ["Core_TKSF: Initialization (%1 Elements) - [Done]",count _c] call LogMedium;