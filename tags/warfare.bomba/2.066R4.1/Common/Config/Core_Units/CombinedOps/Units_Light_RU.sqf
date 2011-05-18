Private ['_u'];

/* Russian Light Vehicles */
_u 			= ['MMT_Civ'];
_u = _u		+ ['TT650_Ins'];
_u = _u		+ ['SUV_TK_EP1'];

_u = _u		+ [[ 'UAZ_RU', 		'UAZ_Unarmed_TK_EP1']];
_u = _u		+ [[ 'UAZ_MG_INS', 	'UAZ_MG_TK_EP1'] ];
_u = _u		+ [[ 'UAZ_AGS30_RU', 'UAZ_AGS30_TK_EP1']];

_u = _u		+ ['LandRover_MG_TK_EP1'];
_u = _u		+ [['UAZ_SPG9_INS', 'LandRover_SPG9_TK_EP1']];

_u = _u		+ [['Kamaz', 'V3S_TK_EP1']];
_u = _u		+ [['KamazRepair', 'UralRepair_TK_EP1']];
_u = _u		+ [['WarfareReammoTruck_RU', 'UralReammo_TK_EP1']];
_u = _u		+ [['KamazRefuel', 'UralRefuel_TK_EP1']];

if (('WFBE_SUPPLYSYSTEM' Call GetNamespace) == 0) then {
	_u = _u + [['WarfareSupplyTruck_RU', 'UralSupply_TK_EP1']];
};

_u = _u		+ [['BRDM2_INS', 'BRDM2_TK_EP1']];
_u = _u		+ [['BRDM2_ATGM_INS', 'BRDM2_ATGM_TK_EP1']];

_u = _u		+ ['GAZ_Vodnik'];
_u = _u		+ [['GAZ_Vodnik_HMG', 'BTR60_TK_EP1']];
_u = _u		+ [['GAZ_Vodnik_MedEvac', 'M113Ambul_TK_EP1']];

_u = _u		+ [['Ural_ZU23_INS', 'Ural_ZU23_TK_EP1']];
_u = _u		+ ['BTR90'];
_u = _u		+ [['GRAD_RU', 'GRAD_TK_EP1']];

if (paramExtraUnits) then {
	_u = _u		+ ['V3S_Open_TK_EP1'];
	_u = _u		+ ['PBX'];
};

_u call SelectCamo;
_u