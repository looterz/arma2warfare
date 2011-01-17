Private ['_u'];

/* US Light Vehicles */
_u 			= ['MMT_USMC'];
_u = _u		+ [['M1030', 'M1030_US_DES_EP1']];
_u = _u		+ ['ATV_US_EP1'];
_u = _u		+ ['Zodiac'];

_u = _u		+ [['HMMWV', 'HMMWV_DES_EP1']];
_u = _u		+ [['HMMWV_M2', 'HMMWV_M1035_DES_EP1']];
_u = _u		+ [['HMMWV_Armored', 'HMMWV_Terminal_EP1']];
_u = _u		+ [['HMMWV_MK19', 'HMMWV_MK19_DES_EP1']];
_u = _u		+ [['HMMWV_M998A2_SOV_DES_EP1']];
_u = _u		+ [['HMMWV_M1151_M2_DES_EP1']];
_u = _u		+ [['HMMWV_M998_crows_M2_DES_EP1']];
_u = _u		+ [['HMMWV_M998_crows_MK19_DES_EP1']];
_u = _u		+ [['HMMWV_TOW', 'HMMWV_TOW_DES_EP1']];
_u = _u		+ [['HMMWV_Avenger', 'HMMWV_Avenger_DES_EP1']];
_u = _u		+ [['HMMWV_Ambulance', 'HMMWV_Ambulance_DES_EP1']];

_u = _u		+ [['MTVR', 'MTVR_DES_EP1']];
_u = _u		+ [['MtvrRepair', 'MtvrRepair_DES_EP1']];
_u = _u		+ [['WarfareReammoTruck_USMC', 'MtvrReammo_DES_EP1']];
_u = _u		+ [['MtvrRefuel', 'MtvrRefuel_DES_EP1']];
if (('WFBE_SUPPLYSYSTEM' Call GetNamespace) == 0) then {
	_u = _u	+ [['WarfareSupplyTruck_USMC', 'MtvrSupply_DES_EP1']];
};

_u = _u		+ ['RHIB'];
_u = _u		+ ['RHIB2Turret'];
_u = _u		+ ['LAV25'];
if (paramDLCBAF) then {
	_u = _u		+ ['BAF_ATV_W'];
	_u = _u		+ ['BAF_Offroad_W'];
	_u = _u		+ ['BAF_Jackal2_GMG_W'];
	_u = _u		+ ['BAF_Jackal2_L2A1_W'];
	_u = _u		+ ['BAF_ATV_D'];
	_u = _u		+ ['BAF_Offroad_D'];
	_u = _u		+ ['BAF_Jackal2_GMG_D'];
	_u = _u		+ ['BAF_Jackal2_L2A1_D'];
};

if (paramDLCPMC) then {		
	_u = _u		+ ['SUV_PMC'];
	_u = _u		+ ['SUV_PMC_BAF'];
	_u = _u		+ ['ArmoredSUV_PMC'];
};

_u call SelectCamo;
_u