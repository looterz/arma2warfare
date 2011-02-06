/* FR Configuration */
Private ['_c','_get','_i','_p'];

_c = [];
_i = [];

/* Infantry */
_c = _c + ['FR_GL'];
_i = _i + [['','',260,6,-1,2,0,0.98,'USMC Force Recon']];

_c = _c + ['FR_Corpsman'];
_i = _i + [['','',270,6,-1,2,0,0.98,'USMC Force Recon']];

_c = _c + ['FR_Commander'];
_i = _i + [['','',295,6,-1,2,0,1.00,'USMC Force Recon']];

_c = _c + ['FR_Assault_R'];
_i = _i + [['','',280,6,-1,2,0,0.99,'USMC Force Recon']];

_c = _c + ['FR_Assault_GL'];
_i = _i + [['','',285,6,-1,2,0,0.99,'USMC Force Recon']];

_c = _c + ['FR_AR'];
_i = _i + [['','',290,6,-1,2,0,0.98,'USMC Force Recon']];

_c = _c + ['FR_R'];
_i = _i + [['','',300,6,-1,2,0,0.98,'USMC Force Recon']];

_c = _c + ['FR_Sapper'];
_i = _i + [['','',310,6,-1,2,0,0.98,'USMC Force Recon']];

_c = _c + ['FR_AC'];
_i = _i + [['','',320,6,-1,2,0,1.0,'USMC Force Recon']];

_c = _c + ['FR_Marksman'];
_i = _i + [['','',340,6,-1,2,0,0.99,'USMC Force Recon']];

/* Infantry - Special Characters */
_c = _c + ['FR_Miles'];
_i = _i + [['','',400,6,-1,3,0,1.0,'USMC Force Recon']];

_c = _c + ['FR_OHara'];
_i = _i + [['','',400,6,-1,3,0,1.0,'USMC Force Recon']];

_c = _c + ['FR_Rodriguez'];
_i = _i + [['','',400,6,-1,3,0,1.0,'USMC Force Recon']];

_c = _c + ['FR_Sykes'];
_i = _i + [['','',400,6,-1,3,0,1.0,'USMC Force Recon']];

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
		format["Core_FR: Duplicated Element found '%1'",(_c select _z)] call LogHigh;
		};
	} else {
		format["Core_FR: Element '%1' is not a valid class.",(_c select _z)] call LogHigh;
	};
};

Format ["Core_FR: Initialization (%1 Elements) - [Done]",count _c] call LogMedium;