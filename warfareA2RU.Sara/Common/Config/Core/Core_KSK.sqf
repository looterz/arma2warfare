/* KSK Configuration */
Private ['_c','_get','_i','_p','_z'];

_c = [];
_i = [];

/* Infantry */
_c = _c + ['GER_Soldier_MG_EP1'];
_i = _i + [['','',340,6,-1,2,0,0.95,'KSK']];

_c = _c + ['GER_Soldier_Medic_EP1'];
_i = _i + [['','',325,6,-1,2,0,0.94,'KSK']];

_c = _c + ['GER_Soldier_EP1'];
_i = _i + [['','',310,6,-1,2,0,0.94,'KSK']];

_c = _c + ['GER_Soldier_Scout_EP1'];
_i = _i + [['','',345,6,-1,2,0,0.96,'KSK']];

_c = _c + ['GER_Soldier_TL_EP1'];
_i = _i + [['','',355,6,-1,2,0,0.98,'KSK']];

for '_z' from 0 to (count _c)-1 do {
	_get = (_c select _z) Call GetNamespace;
	if (isNil '_get') then {
		if ((_i select _z) select 0 == '') then {(_i select _z) set [0, [_c select _z,'displayName'] Call GetConfigInfo]};
		if (WF_Debug) then {(_i select _z) set [3,1]};
		_p = if ((_c select _z) isKindOf 'Man') then {'portrait'} else {'picture'};
		(_i select _z) set [1, [_c select _z,_p] Call GetConfigInfo];
		[_c select _z,_i select _z] Call SetNamespace;
	} else {
		diag_log Format ["[WFBE (INIT)][frameno:%2 | ticktime:%3] Core_KSK: Duplicated Element found '%1'",(_c select _z),diag_frameno,diag_tickTime];
	};
};

diag_log Format ["[WFBE (INIT)][frameno:%2 | ticktime:%3] Core_KSK: Initialization (%1 Elements) - [Done]",count _c,diag_frameno,diag_tickTime];