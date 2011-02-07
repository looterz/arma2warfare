/* ACR Configuration */
Private ['_c','_get','_i','_p'];

_c = [];
_i = [];

/* Infantry */
_c = _c + ['CZ_Soldier_Light_DES_EP1'];
_i = _i + [['','',125,4,-1,0,0,0.85,'Czech']];

_c = _c + ['CZ_Soldier_DES_EP1'];
_i = _i + [['','',150,4,-1,0,0,0.85,'Czech']];

_c = _c + ['CZ_Soldier_B_DES_EP1'];
_i = _i + [['','',150,4,-1,0,0,0.85,'Czech']];

_c = _c + ['CZ_Soldier_AT_DES_EP1'];
_i = _i + [['','',310,5,-1,0,0,0.87,'Czech']];

_c = _c + ['CZ_Soldier_AMG_DES_EP1'];
_i = _i + [['','',210,5,-1,1,0,0.85,'Czech']];

_c = _c + ['CZ_Soldier_MG_DES_EP1'];
_i = _i + [['','',220,5,-1,0,0,0.86,'Czech']];

_c = _c + ['CZ_Soldier_Sniper_EP1'];
_i = _i + [['','',280,5,-1,1,0,0.88,'Czech']];

_c = _c + ['CZ_Special_Forces_GL_DES_EP1'];
_i = _i + [['','',290,5,-1,3,0,0.90,'Czech']];

_c = _c + ['CZ_Special_Forces_MG_DES_EP1'];
_i = _i + [['','',310,5,-1,3,0,0.90,'Czech']];

_c = _c + ['CZ_Special_Forces_DES_EP1'];
_i = _i + [['','',285,5,-1,3,0,0.89,'Czech']];

_c = _c + ['CZ_Special_Forces_Scout_DES_EP1'];
_i = _i + [['','',305,5,-1,3,0,0.90,'Czech']];

_c = _c + ['CZ_Special_Forces_TL_DES_EP1'];
_i = _i + [['','',310,5,-1,3,0,0.91,'Czech']];

_c = _c + ['CZ_Soldier_Pilot_EP1'];
_i = _i + [['','',120,4,-1,0,0,0.86,'Czech']];

_c = _c + ['CZ_Soldier_Office_DES_EP1'];
_i = _i + [['','',240,5,-1,1,0,0.88,'Czech']];

_c = _c + ['CZ_Soldier_SL_DES_EP1'];
_i = _i + [['','',220,5,-1,2,0,0.87,'Czech']];

/* Light Vehicles */
_c = _c + ['ATV_CZ_EP1'];
_i = _i + [['','',175,15,1,0,1,0,'Czech']];

_c = _c + ['HMMWV_M1151_M2_CZ_DES_EP1'];
_i = _i + [['','',850,20,2,0,1,0,'Czech']];

_c = _c + ['LandRover_CZ_EP1'];
_i = _i + [['','',275,18,1,0,1,0,'Czech']];

_c = _c + ['LandRover_Special_CZ_EP1'];
_i = _i + [['','',700,20,3,0,1,0,'Czech']];

/* Air Vehicles */
_c = _c + ['Mi171Sh_CZ_EP1'];
_i = _i + [['','',7600,35,1,1,3,0,'Czech']];

_c = _c + ['Mi171Sh_rockets_CZ_EP1'];
_i = _i + [['','',26500,40,2,0,3,0,'Czech']];

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
		format["Core_ACR: Duplicated Element found '%1'",(_c select _z)] call LogHigh;
		};
	} else {
		format["Core_ACR: Element '%1' is not a valid class.",(_c select _z)] call LogHigh;
	};
};

Format ["Core_ACR: Initialization (%1 Elements) - [Done]",count _c]  call LogMedium;