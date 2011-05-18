/* BAF (MTP) Configuration */
Private ['_c','_get','_i','_p','_z'];

_c = [];
_i = [];

/* Infantry */
_c = _c + ['BAF_Soldier_AA_MTP'];
_i = _i + [['','',410,6,-1,2,0,0.82,'British']];

_c = _c + ['BAF_Soldier_AAA_MTP'];
_i = _i + [['','',440,6,-1,2,0,0.81,'British']];

_c = _c + ['BAF_Soldier_AAT_MTP'];
_i = _i + [['','',370,4,-1,2,0,0.78,'British']];

_c = _c + ['BAF_Soldier_AHAT_MTP'];
_i = _i + [['','',850,6,-1,3,0,0.79,'British']];

_c = _c + ['BAF_Soldier_AAR_MTP'];
_i = _i + [['','',225,5,-1,2,0,0.82,'British']];

_c = _c + ['BAF_Soldier_AMG_MTP'];
_i = _i + [['','',220,6,-1,1,0,0.81,'British']];

_c = _c + ['BAF_Soldier_AT_MTP'];
_i = _i + [['','',360,6,-1,2,0,0.81,'British']];

_c = _c + ['BAF_Soldier_HAT_MTP'];
_i = _i + [['','',810,6,-1,3,0,0.83,'British']];

_c = _c + ['BAF_Soldier_AR_MTP'];
_i = _i + [['','',210,5,-1,2,0,0.79,'British']];

_c = _c + ['BAF_crewman_MTP'];
_i = _i + [['','',125,5,-1,0,0,0.77,'British']];

_c = _c + ['BAF_Soldier_EN_MTP'];
_i = _i + [['','',230,5,-1,0,0,0.78,'British']];

_c = _c + ['BAF_Soldier_GL_MTP'];
_i = _i + [['','',170,5,-1,0,0,0.78,'British']];

_c = _c + ['BAF_Soldier_FAC_MTP'];
_i = _i + [['','',375,6,-1,3,0,0.94,'British']];

_c = _c + ['BAF_Soldier_MG_MTP'];
_i = _i + [['','',210,5,-1,0,0,0.79,'British']];

_c = _c + ['BAF_Soldier_scout_MTP'];
_i = _i + [['','',340,6,-1,2,0,0.84,'British']];

_c = _c + ['BAF_Soldier_Marksman_MTP'];
_i = _i + [['','',370,6,-1,3,0,0.85,'British']];

_c = _c + ['BAF_Soldier_Medic_MTP'];
_i = _i + [['','',200,6,-1,0,0,0.8,'British']];

_c = _c + ['BAF_Soldier_Officer_MTP'];
_i = _i + [['','',265,6,-1,2,0,0.8,'British']];

_c = _c + ['BAF_Pilot_MTP'];
_i = _i + [['','',125,6,-1,0,0,0.78,'British']];

_c = _c + ['BAF_Soldier_MTP'];
_i = _i + [['','',155,6,-1,0,0,0.79,'British']];

_c = _c + ['BAF_ASoldier_MTP'];
_i = _i + [['','',160,6,-1,0,0,0.79,'British']];

_c = _c + ['BAF_Soldier_L_MTP'];
_i = _i + [['','',130,6,-1,0,0,0.79,'British']];

_c = _c + ['BAF_Soldier_N_MTP'];
_i = _i + [['','',175,6,-1,1,0,0.8,'British']];

_c = _c + ['BAF_Soldier_SL_MTP'];
_i = _i + [['','',235,6,-1,2,0,0.86,'British']];

_c = _c + ['BAF_Soldier_SniperN_MTP'];
_i = _i + [['','',390,6,-1,3,0,0.84,'British']];

_c = _c + ['BAF_Soldier_SniperH_MTP'];
_i = _i + [['','',420,6,-1,2,0,0.84,'British']];

_c = _c + ['BAF_Soldier_Sniper_MTP'];
_i = _i + [['','',395,6,-1,2,0,0.84,'British']];

_c = _c + ['BAF_Soldier_spotter_MTP'];
_i = _i + [['','',340,6,-1,2,0,0.82,'British']];

_c = _c + ['BAF_Soldier_spotterN_MTP'];
_i = _i + [['','',350,6,-1,2,0,0.82,'British']];

_c = _c + ['BAF_Soldier_TL_MTP'];
_i = _i + [['','',245,6,-1,1,0,0.85,'British']];

/* Air Vehicles */
_c = _c + ['BAF_Merlin_HC3_D'];
_i = _i + [['','',7500,45,1,0,3,0,'British']];

_c = _c + ['CH_47F_BAF'];
_i = _i + [['','',7000,40,2,0,3,0,'British']];

_c = _c + ['BAF_Apache_AH1_D'];
_i = _i + [['','',35000,60,2,2,3,0,'British']];

_c = _c + ['AW159_Lynx_BAF'];
_i = _i + [['','',19500,35,2,1,3,0,'British']];

for '_z' from 0 to (count _c)-1 do {
	_get = (_c select _z) Call GetNamespace;
	if (isNil '_get') then {
		if ((_i select _z) select 0 == '') then {(_i select _z) set [0, [_c select _z,'displayName'] Call GetConfigInfo]};
		_p = if ((_c select _z) isKindOf 'Man') then {'portrait'} else {'picture'};
		(_i select _z) set [1, [_c select _z,_p] Call GetConfigInfo];
		[_c select _z,_i select _z] Call SetNamespace;
	} else {
		Format ["Core_BAF: Duplicated Element found '%1'",(_c select _z)] call LogWarning;
	};
};

Format ["Core_BAF: Initialization (%1 Elements) - [Done]",count _c]  call LogMedium;