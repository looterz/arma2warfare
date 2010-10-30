/* CDF Configuration */
Private ['_c','_get','_i','_p','_z'];

_c = [];
_i = [];

/* Infantry */
_c = _c + ['CDF_Soldier'];
_i = _i + [['','',150,4,-1,0,0,0.65,'CDF']];

_c = _c + ['CDF_Soldier_Engineer'];
_i = _i + [['','',225,5,-1,0,0,0.66,'CDF']];

_c = _c + ['CDF_Soldier_Light'];
_i = _i + [['','',175,4,-1,0,0,0.65,'CDF']];

_c = _c + ['CDF_Soldier_GL'];
_i = _i + [['','',180,4,-1,0,0,0.65,'CDF']];

_c = _c + ['CDF_Soldier_Militia'];
_i = _i + [['','',160,3,-1,0,0,0.62,'CDF']];

_c = _c + ['CDF_Soldier_Medic'];
_i = _i + [['','',210,4,-1,0,0,0.69,'CDF']];

_c = _c + ['CDF_Soldier_Sniper'];
_i = _i + [['','',230,5,-1,1,0,0.72,'CDF']];

_c = _c + ['CDF_Soldier_Spotter'];
_i = _i + [['','',240,6,-1,1,0,0.71,'CDF']];

_c = _c + ['CDF_Soldier_Marksman'];
_i = _i + [['','',235,7,-1,3,0,0.69,'CDF']];

_c = _c + ['CDF_Soldier_RPG'];
_i = _i + [['','',250,6,-1,2,0,0.64,'CDF']];

_c = _c + ['CDF_Soldier_Strela'];
_i = _i + [['','',400,6,-1,2,0,0.68,'CDF']];

_c = _c + ['CDF_Soldier_AR'];
_i = _i + [['','',165,6,-1,1,0,0.64,'CDF']];

_c = _c + ['CDF_Soldier_MG'];
_i = _i + [['','',180,5,-1,0,0,0.65,'CDF']];

_c = _c + ['CDF_Soldier_TL'];
_i = _i + [['','',210,6,-1,2,0,0.73,'CDF']];

_c = _c + ['CDF_Soldier_Officer'];
_i = _i + [['','',230,7,-1,1,0,0.74,'CDF']];

_c = _c + ['CDF_Commander'];
_i = _i + [['','',280,7,-1,3,0,0.75,'CDF']];

_c = _c + ['CDF_Soldier_Pilot'];
_i = _i + [['','',130,5,-1,0,0,0.62,'CDF']];

_c = _c + ['CDF_Soldier_Crew'];
_i = _i + [['','',130,5,-1,0,0,0.63,'CDF']];

/* Light Vehicles */
_c = _c + ['UAZ_CDF'];
_i = _i + [['','',150,15,1,0,1,0,'CDF']];

_c = _c + ['UAZ_MG_CDF'];
_i = _i + [['','',310,17,2,0,1,0,'CDF']];

_c = _c + ['UAZ_AGS30_CDF'];
_i = _i + [['','',475,25,2,1,1,0,'CDF']];

_c = _c + ['Ural_CDF'];
_i = _i + [['','',300,20,1,0,1,0,'CDF']];

_c = _c + ['BRDM2_CDF'];
_i = _i + [['','',900,25,2,2,1,0,'CDF']];

_c = _c + ['BRDM2_ATGM_CDF'];
_i = _i + [['','',1550,25,2,3,1,0,'CDF']];

_c = _c + ['Ural_ZU23_CDF'];
_i = _i + [['','',1600,20,2,2,1,0,'CDF']];

_c = _c + ['GRAD_CDF'];
_i = _i + [['','',3200,35,2,2,1,0,'CDF']];

/* Heavy Vehicles */
_c = _c + ['BMP2_Ambul_CDF'];
_i = _i + [['','',850,20,1,1,2,0,'CDF']];

_c = _c + ['BMP2_CDF'];
_i = _i + [['','',2400,30,3,1,2,0,'CDF']];

_c = _c + ['ZSU_CDF'];
_i = _i + [['','',2800,35,3,2,2,0,'CDF']];

_c = _c + ['T72_CDF'];
_i = _i + [['','',3900,35,3,2,2,0,'CDF']];

/* Air Vehicles */
_c = _c + ['Mi17_CDF'];
_i = _i + [['','',5000,35,2,0,3,0,'CDF']];

_c = _c + ['Mi24_D'];
_i = _i + [['','',25500,40,2,1,3,0,'CDF']];

for '_z' from 0 to (count _c)-1 do {
	_get = (_c select _z) Call GetNamespace;
	if (isNil '_get') then {
		if ((_i select _z) select 0 == '') then {(_i select _z) set [0, [_c select _z,'displayName'] Call GetConfigInfo]};
		_p = if ((_c select _z) isKindOf 'Man') then {'portrait'} else {'picture'};
		(_i select _z) set [1, [_c select _z,_p] Call GetConfigInfo];
		[_c select _z,_i select _z] Call SetNamespace;
	} else {
		Format ["Core_CDF: Duplicated Element found '%1'",(_c select _z)] call LogMedium;
	};
};

Format ["Core_CDF: Initialization (%1 Elements) - [Done]",count _c] call LogMedium;