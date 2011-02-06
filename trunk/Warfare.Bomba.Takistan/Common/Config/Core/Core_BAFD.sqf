/* BAF (Desert) Configuration */
Private ['_c','_get','_i','_p'];

_c = [];
_i = [];

/* Infantry */
_c = _c + ['BAF_Soldier_AA_DDPM'];
_i = _i + [['','',410,6,-1,2,0,0.88,'British (Desert)']];

_c = _c + ['BAF_Soldier_AAA_DDPM'];
_i = _i + [['','',440,6,-1,2,0,0.87,'British (Desert)']];

_c = _c + ['BAF_Soldier_AAT_DDPM'];
_i = _i + [['','',190,4,-1,2,0,0.84,'British (Desert)']];

_c = _c + ['BAF_Soldier_AHAT_DDPM'];
_i = _i + [['','',190,6,-1,3,0,0.85,'British (Desert)']];

_c = _c + ['BAF_Soldier_AAR_DDPM'];
_i = _i + [['','',190,5,-1,2,0,0.88,'British (Desert)']];

_c = _c + ['BAF_Soldier_AMG_DDPM'];
_i = _i + [['','',190,6,-1,1,0,0.87,'British (Desert)']];

_c = _c + ['BAF_Soldier_AT_DDPM'];
_i = _i + [['','',360,6,-1,2,0,0.87,'British (Desert)']];

_c = _c + ['BAF_Soldier_HAT_DDPM'];
_i = _i + [['','',810,6,-1,3,0,0.89,'British (Desert)']];

_c = _c + ['BAF_Soldier_AR_DDPM'];
_i = _i + [['','',210,5,-1,2,0,0.85,'British (Desert)']];

_c = _c + ['BAF_crewman_DDPM'];
_i = _i + [['','',125,5,-1,0,0,0.83,'British (Desert)']];

_c = _c + ['BAF_Soldier_EN_DDPM'];
_i = _i + [['','',230,5,-1,0,0,0.84,'British (Desert)']];

_c = _c + ['BAF_Soldier_GL_DDPM'];
_i = _i + [['','',170,5,-1,0,0,0.84,'British (Desert)']];

_c = _c + ['BAF_Soldier_FAC_DDPM'];
_i = _i + [['','',375,6,-1,3,0,0.98,'British (Desert)']];

_c = _c + ['BAF_Soldier_MG_DDPM'];
_i = _i + [['','',210,5,-1,0,0,0.85,'British (Desert)']];

_c = _c + ['BAF_Soldier_scout_DDPM'];
_i = _i + [['','',340,6,-1,2,0,0.9,'British (Desert)']];

_c = _c + ['BAF_Soldier_Marksman_DDPM'];
_i = _i + [['','',370,6,-1,3,0,0.91,'British (Desert)']];

_c = _c + ['BAF_Soldier_Medic_DDPM'];
_i = _i + [['','',200,6,-1,0,0,0.86,'British (Desert)']];

_c = _c + ['BAF_Soldier_Officer_DDPM'];
_i = _i + [['','',265,6,-1,2,0,0.86,'British (Desert)']];

_c = _c + ['BAF_Pilot_DDPM'];
_i = _i + [['','',125,6,-1,0,0,0.84,'British (Desert)']];

_c = _c + ['BAF_Soldier_DDPM'];
_i = _i + [['','',155,6,-1,0,0,0.85,'British (Desert)']];

_c = _c + ['BAF_ASoldier_DDPM'];
_i = _i + [['','',160,6,-1,0,0,0.85,'British (Desert)']];

_c = _c + ['BAF_Soldier_L_DDPM'];
_i = _i + [['','',130,6,-1,0,0,0.85,'British (Desert)']];

_c = _c + ['BAF_Soldier_N_DDPM'];
_i = _i + [['','',175,6,-1,1,0,0.86,'British (Desert)']];

_c = _c + ['BAF_Soldier_SL_DDPM'];
_i = _i + [['','',235,6,-1,2,0,0.92,'British (Desert)']];

_c = _c + ['BAF_Soldier_TL_DDPM'];
_i = _i + [['','',245,6,-1,1,0,0.91,'British (Desert)']];

/* Light Vehicles */
_c = _c + ['BAF_ATV_D'];
_i = _i + [['','',175,12,1,0,1,0,'British (Desert)']];

_c = _c + ['BAF_Offroad_D'];
_i = _i + [['','',375,13,1,0,1,0,'British (Desert)']];

_c = _c + ['BAF_Jackal2_GMG_D'];
_i = _i + [['','',525,20,3,1,1,0,'British (Desert)']];

_c = _c + ['BAF_Jackal2_L2A1_D'];
_i = _i + [['','',465,21,3,0,1,0,'British (Desert)']];

/* Heavy Vehicles */
_c = _c + ['BAF_FV510_D'];
_i = _i + [['','',4750,30,2,2,2,0,'British (Desert)']];

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
		format["Core_BAFD: Duplicated Element found '%1'",(_c select _z)] call LogHigh;
		};
	} else {
		format["Core_BAFD: Element '%1' is not a valid class.",(_c select _z)] call LogHigh;
	};
};

Format ["Core_BAFD: Initialization (%1 Elements) - [Done]",count _c]  call LogMedium;