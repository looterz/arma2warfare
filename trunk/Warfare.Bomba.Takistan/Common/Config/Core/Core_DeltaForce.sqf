/* Spetsnaz Configuration */
Private ['_c','_get','_i','_p'];

_c = [];
_i = [];

/* Infantry */
_c = _c + ['US_Delta_Force_EP1'];
_i = _i + [['','',300,6,-1,3,0,0.99,'US Delta Force']];

_c = _c + ['US_Delta_Force_TL_EP1'];
_i = _i + [['','',360,6,-1,3,0,1.00,'US Delta Force']];

_c = _c + ['US_Delta_Force_Medic_EP1'];
_i = _i + [['','',320,6,-1,3,0,0.98,'US Delta Force']];

_c = _c + ['US_Delta_Force_Assault_EP1'];
_i = _i + [['','',335,6,-1,3,0,0.99,'US Delta Force']];

_c = _c + ['US_Delta_Force_SD_EP1'];
_i = _i + [['','',345,6,-1,3,0,0.99,'US Delta Force']];

_c = _c + ['US_Delta_Force_MG_EP1'];
_i = _i + [['','',340,6,-1,3,0,0.99,'US Delta Force']];

_c = _c + ['US_Delta_Force_AR_EP1'];
_i = _i + [['','',330,6,-1,3,0,0.99,'US Delta Force']];

_c = _c + ['US_Delta_Force_Night_EP1'];
_i = _i + [['','',315,6,-1,3,0,0.99,'US Delta Force']];

_c = _c + ['US_Delta_Force_Marksman_EP1'];
_i = _i + [['','',320,6,-1,3,0,0.99,'US Delta Force']];

_c = _c + ['US_Delta_Force_M14_EP1'];
_i = _i + [['','',310,6,-1,3,0,0.99,'US Delta Force']];

_c = _c + ['US_Delta_Force_Air_Controller_EP1'];
_i = _i + [['','',350,6,-1,3,0,1.0,'US Delta Force']];

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
		format["Core_DeltaForce: Duplicated Element found '%1'",(_c select _z)] call LogHigh;
		};
	} else {
		format["Core_DeltaForce: Element '%1' is not a valid class.",(_c select _z)] call LogHigh;
	};
};

Format ["Core_DeltaForce: Initialization (%1 Elements) - [Done]",count _c]  call LogMedium;