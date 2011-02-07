/* INS Configuration */
Private ['_c','_get','_i','_p','_z'];

_c = [];
_i = [];

/* Infantry */
_c = _c + ['Ins_Soldier_1'];
_i = _i + [['','',150,4,-1,0,0,0.61,'Insurgents']];

_c = _c + ['Ins_Soldier_2'];
_i = _i + [['','',160,4,-1,0,0,0.61,'Insurgents']];

_c = _c + ['Ins_Soldier_GL'];
_i = _i + [['','',175,4,-1,0,0,0.65,'Insurgents']];

_c = _c + ['Ins_Soldier_CO'];
_i = _i + [['','',210,5,-1,1,0,0.7,'Insurgents']];

_c = _c + ['Ins_Commander'];
_i = _i + [['','',250,5,-1,2,0,0.7,'Insurgents']];

_c = _c + ['Ins_Soldier_Medic'];
_i = _i + [['','',175,4,-1,0,0,0.62,'Insurgents']];

_c = _c + ['Ins_Soldier_AR'];
_i = _i + [['','',180,4,-1,1,0,0.61,'Insurgents']];

_c = _c + ['Ins_Soldier_MG'];
_i = _i + [['','',190,4,-1,0,0,0.60,'Insurgents']];

_c = _c + ['Ins_Soldier_AT'];
_i = _i + [['','',220,6,-1,1,0,0.60,'Insurgents']];

_c = _c + ['Ins_Soldier_AA'];
_i = _i + [['','',300,6,-1,2,0,0.62,'Insurgents']];

_c = _c + ['Ins_Soldier_Sniper'];
_i = _i + [['','',220,6,-1,1,0,0.66,'Insurgents']];

_c = _c + ['Ins_Soldier_Sapper'];
_i = _i + [['','',190,5,-1,2,0,0.64,'Insurgents']];

_c = _c + ['Ins_Soldier_Sab'];
_i = _i + [['','',180,5,-1,2,0,0.68,'Insurgents']];

_c = _c + ['Ins_Soldier_Pilot'];
_i = _i + [['','',130,5,-1,0,0,0.59,'Insurgents']];

_c = _c + ['Ins_Soldier_Crew'];
_i = _i + [['','',130,5,-1,0,0,0.58,'Insurgents']];

/* Light Vehicles */
_c = _c + ['TT650_Ins'];
_i = _i + [['','',150,15,1,0,1,0,'Insurgents']];

_c = _c + ['UAZ_INS'];
_i = _i + [['','',260,15,1,0,1,0,'Insurgents']];

_c = _c + ['UAZ_MG_INS'];
_i = _i + [['','',460,17,2,0,1,0,'Insurgents']];

_c = _c + ['UAZ_AGS30_INS'];
_i = _i + [['','',585,25,2,1,1,0,'Insurgents']];

_c = _c + ['UAZ_SPG9_INS'];
_i = _i + [['','',650,20,2,2,1,0,'Insurgents']];

_c = _c + ['Ural_INS'];
_i = _i + [['','',300,20,1,0,1,0,'Insurgents']];

_c = _c + ['BRDM2_INS'];
_i = _i + [['','',1100,25,2,2,1,0,'Insurgents']];

_c = _c + ['BRDM2_ATGM_INS'];
_i = _i + [['','',1650,25,2,3,1,0,'Insurgents']];

_c = _c + ['Ural_ZU23_INS'];
_i = _i + [['','',1750,20,2,2,1,0,'Insurgents']];

_c = _c + ['GRAD_INS'];
_i = _i + [['','',4200,35,2,2,1,0,'Insurgents']];

/* Heavy Vehicles */
_c = _c + ['BMP2_Ambul_INS'];
_i = _i + [['','',950,20,1,1,2,0,'Insurgents']];

_c = _c + ['BMP2_INS'];
_i = _i + [['','',2600,30,3,if (WF_A2_Vanilla) then {0} else {1},2,0,'Insurgents']];

_c = _c + ['ZSU_INS'];
_i = _i + [['','',3400,35,3,1,2,0,'Insurgents']];

_c = _c + ['T72_INS'];
_i = _i + [['','',4900,35,3,2,2,0,'Insurgents']];

/* Air Vehicles */
_c = _c + ['Mi17_Ins'];
_i = _i + [['','',7000,35,2,0,3,0,'Insurgents']];

_c = _c + ['Su25_Ins'];
_i = _i + [['','',46750,55,1,3,3,0,'Insurgents']];

/* Static Defenses */
_c = _c + ['SPG9_Ins'];
_i = _i + [['','',475,0,1,0,'Defense',0,'Insurgents']];

_c = _c + ['ZU23_Ins'];
_i = _i + [['','',945,0,1,0,'Defense',0,'Insurgents']];

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
			diag_log Format ["[WFBE (INIT)][frameno:%2 | ticktime:%3] Core_INS: Duplicated Element found '%1'",(_c select _z),diag_frameno,diag_tickTime];
		};
	} else {
		diag_log Format ["[WFBE (ERROR)][frameno:%2 | ticktime:%3] Core_INS: Element '%1' is not a valid class.",(_c select _z),diag_frameno,diag_tickTime];
	};
};

diag_log Format ["[WFBE (INIT)][frameno:%2 | ticktime:%3] Core_INS: Initialization (%1 Elements) - [Done]",count _c,diag_frameno,diag_tickTime];