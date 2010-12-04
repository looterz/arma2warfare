Private['_c','_u'];

['WFBE_WESTREPAIRTRUCKS',['MtvrRepair_DES_EP1','MtvrRepair'],true] Call SetNamespace;
['WFBE_WESTSUPPLYTRUCKS',['MtvrSupply_DES_EP1','WarfareSupplyTruck_USMC'],true] Call SetNamespace;
['WFBE_EASTREPAIRTRUCKS',['UralRepair_TK_EP1','KamazRepair'],true] Call SetNamespace;
['WFBE_EASTSUPPLYTRUCKS',['UralSupply_TK_EP1','WarfareSupplyTruck_RU'],true] Call SetNamespace;

_u = [];

//WEST
if (WF_A2_Vanilla) then {
	_u 			= ['MMT_USMC'];
	_u = _u		+ ['M1030'];
	_u = _u		+ ['HMMWV'];
	_u = _u		+ ['Zodiac'];
	_u = _u		+ ['HMMWV_M2'];
	_u = _u		+ ['HMMWV_Armored'];
	_u = _u		+ ['HMMWV_MK19'];
	_u = _u		+ ['HMMWV_TOW'];
	_u = _u		+ ['HMMWV_Avenger'];
	_u = _u		+ ['HMMWV_Ambulance'];
	_u = _u		+ ['MTVR'];
	_u = _u		+ ['MtvrRepair'];
	_u = _u		+ ['WarfareReammoTruck_USMC'];
	_u = _u		+ ['MtvrRefuel'];
	if (('WFBE_SUPPLYSYSTEM' Call GetNamespace) == 0) then {_u = _u		+ ['WarfareSupplyTruck_USMC']};
	_u = _u		+ ['RHIB'];
	_u = _u		+ ['RHIB2Turret'];
	_u = _u		+ ['LAV25'];
};

if (WF_A2_Arrowhead) then {
	_u 			= ['M1030_US_DES_EP1'];
	_u = _u		+ ['ATV_US_EP1'];
	_u = _u		+ ['HMMWV_DES_EP1'];
	_u = _u		+ ['HMMWV_M1035_DES_EP1'];
	_u = _u		+ ['HMMWV_Terminal_EP1'];
	_u = _u		+ ['HMMWV_MK19_DES_EP1'];
	_u = _u		+ ['HMMWV_M998A2_SOV_DES_EP1'];
	_u = _u		+ ['HMMWV_M1151_M2_DES_EP1'];
	_u = _u		+ ['HMMWV_M998_crows_M2_DES_EP1'];
	_u = _u		+ ['HMMWV_M998_crows_MK19_DES_EP1'];
	_u = _u		+ ['HMMWV_TOW_DES_EP1'];
	_u = _u		+ ['HMMWV_Avenger_DES_EP1'];
	_u = _u		+ ['HMMWV_Ambulance_DES_EP1'];
	_u = _u		+ ['MTVR_DES_EP1'];
	_u = _u		+ ['MtvrRepair_DES_EP1'];
	_u = _u		+ ['MtvrReammo_DES_EP1'];
	_u = _u		+ ['MtvrRefuel_DES_EP1'];
	if (('WFBE_SUPPLYSYSTEM' Call GetNamespace) == 0) then {_u = _u		+ ['MtvrSupply_DES_EP1']};
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
};

if (WF_A2_CombinedOps) then {
	_u 			= ['MMT_USMC'];
	_u = _u		+ ['M1030'];
	_u = _u		+ ['M1030_US_DES_EP1'];
	_u = _u		+ ['ATV_US_EP1'];
	_u = _u		+ ['Zodiac'];
	_u = _u		+ ['M1126_ICV_M2_EP1'];
	_u = _u		+ ['M1126_ICV_mk19_EP1'];
	_u = _u		+ ['M1129_MC_EP1'];
	_u = _u		+ ['M1135_ATGMV_EP1'];
	_u = _u		+ ['M1128_MGS_EP1'];
	_u = _u		+ ['M1133_MEV_EP1'];
	_u = _u		+ ['HMMWV_DES_EP1'];
	_u = _u		+ ['HMMWV_M1035_DES_EP1'];
	_u = _u		+ ['HMMWV_Terminal_EP1'];
	_u = _u		+ ['HMMWV_MK19_DES_EP1'];
	_u = _u		+ ['HMMWV_M998A2_SOV_DES_EP1'];
	_u = _u		+ ['HMMWV_M1151_M2_DES_EP1'];
	_u = _u		+ ['HMMWV_M998_crows_M2_DES_EP1'];
	_u = _u		+ ['HMMWV_M998_crows_MK19_DES_EP1'];
	_u = _u		+ ['HMMWV_TOW_DES_EP1'];
	_u = _u		+ ['HMMWV_Avenger_DES_EP1'];
	_u = _u		+ ['HMMWV_Ambulance_DES_EP1'];
	_u = _u		+ ['HMMWV'];
	_u = _u		+ ['HMMWV_M2'];
	_u = _u		+ ['HMMWV_Armored'];
	_u = _u		+ ['HMMWV_MK19'];
	_u = _u		+ ['HMMWV_TOW'];
	_u = _u		+ ['HMMWV_Avenger'];
	_u = _u		+ ['HMMWV_Ambulance'];
	_u = _u		+ ['MTVR_DES_EP1'];
	_u = _u		+ ['MtvrRepair_DES_EP1'];
	_u = _u		+ ['MtvrReammo_DES_EP1'];
	_u = _u		+ ['MtvrRefuel_DES_EP1'];
	if (('WFBE_SUPPLYSYSTEM' Call GetNamespace) == 0) then {_u = _u		+ ['MtvrSupply_DES_EP1']};
	_u = _u		+ ['MTVR'];
	_u = _u		+ ['MtvrRepair'];
	_u = _u		+ ['WarfareReammoTruck_USMC'];
	_u = _u		+ ['MtvrRefuel'];
	if (('WFBE_SUPPLYSYSTEM' Call GetNamespace) == 0) then {_u = _u		+ ['WarfareSupplyTruck_USMC']};
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
};

['WFBE_WESTLIGHTUNITS',_u,true] Call SetNamespace;
if (local player) then {['LIGHT','WEST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

if (paramAllies) then {
	//--- CDF Allies.
	_u			= ['UAZ_CDF'];
	_u = _u		+ ['Ural_CDF'];
	_u = _u		+ ['UAZ_MG_CDF'];
	_u = _u		+ ['UAZ_AGS30_CDF'];
	_u = _u		+ ['BRDM2_CDF'];
	_u = _u		+ ['BRDM2_ATGM_CDF'];
	_u = _u		+ ['Ural_ZU23_CDF'];
	_u = _u		+ ['GRAD_CDF'];

	['WFBE_WESTALLIESLIGHTUNITS',_u,true] Call SetNamespace;

	//--- Insurgent Allies.
	_u			= ['UAZ_INS'];
	_u = _u		+ ['Ural_INS'];
	_u = _u		+ ['UAZ_MG_INS'];
	_u = _u		+ ['UAZ_AGS30_INS'];
	_u = _u		+ ['UAZ_SPG9_INS'];
	_u = _u		+ ['BRDM2_INS'];
	_u = _u		+ ['BRDM2_ATGM_INS'];
	_u = _u		+ ['Ural_ZU23_INS'];
	_u = _u		+ ['GRAD_INS'];

	['WFBE_EASTALLIESLIGHTUNITS',_u,true] Call SetNamespace;
} else {
	['WFBE_WESTALLIESLIGHTUNITS',[],true] Call SetNamespace;
	['WFBE_EASTALLIESLIGHTUNITS',[],true] Call SetNamespace;
};

//EAST
if (WF_A2_Vanilla) then {
	_u 			= ['MMT_Civ'];
	_u = _u		+ ['TT650_Ins'];
	_u = _u		+ ['UAZ_RU'];
	_u = _u		+ ['PBX'];
	_u = _u		+ ['UAZ_MG_INS'];
	_u = _u		+ ['UAZ_AGS30_RU'];
	_u = _u		+ ['UAZ_SPG9_INS'];
	_u = _u		+ ['Kamaz'];
	_u = _u		+ ['KamazRepair'];
	_u = _u		+ ['WarfareReammoTruck_RU'];
	_u = _u		+ ['KamazRefuel'];
	if (('WFBE_SUPPLYSYSTEM' Call GetNamespace) == 0) then {_u = _u		+ ['WarfareSupplyTruck_RU']};
	_u = _u		+ ['GAZ_Vodnik_MedEvac'];
	_u = _u		+ ['BRDM2_INS'];
	_u = _u		+ ['BRDM2_ATGM_INS'];
	_u = _u		+ ['GAZ_Vodnik'];
	_u = _u		+ ['GAZ_Vodnik_HMG'];
	_u = _u		+ ['Ural_ZU23_INS'];
	_u = _u		+ ['BTR90'];
	_u = _u		+ ['GRAD_RU'];
};

if (WF_A2_Arrowhead) then {
	_u 			= ['TT650_TK_EP1'];
	_u = _u		+ ['UAZ_Unarmed_TK_EP1'];
	_u = _u		+ ['SUV_TK_EP1'];
	_u = _u		+ ['UAZ_MG_TK_EP1'];
	_u = _u		+ ['UAZ_AGS30_TK_EP1'];
	_u = _u		+ ['LandRover_MG_TK_EP1'];
	_u = _u		+ ['LandRover_SPG9_TK_EP1'];
	_u = _u		+ ['V3S_TK_EP1'];
	_u = _u		+ ['V3S_Open_TK_EP1'];
	_u = _u		+ ['UralRepair_TK_EP1'];
	_u = _u		+ ['UralReammo_TK_EP1'];
	_u = _u		+ ['UralRefuel_TK_EP1'];
	if (('WFBE_SUPPLYSYSTEM' Call GetNamespace) == 0) then {_u = _u		+ ['UralSupply_TK_EP1']};
	_u = _u		+ ['M113Ambul_TK_EP1'];
	_u = _u		+ ['BRDM2_TK_EP1'];
	_u = _u		+ ['BRDM2_ATGM_TK_EP1'];
	_u = _u		+ ['BTR60_TK_EP1'];
	_u = _u		+ ['Ural_ZU23_TK_EP1'];
	_u = _u		+ ['GRAD_TK_EP1'];
};

if (WF_A2_CombinedOps) then {
	_u 			= ['MMT_Civ'];
	_u = _u		+ ['TT650_Ins'];
	_u = _u		+ ['UAZ_Unarmed_TK_EP1'];
	_u = _u		+ ['UAZ_MG_TK_EP1'];
	_u = _u		+ ['UAZ_AGS30_TK_EP1'];
	_u = _u		+ ['UAZ_RU'];
	_u = _u		+ ['PBX'];
	_u = _u		+ ['UAZ_MG_INS'];
	_u = _u		+ ['UAZ_AGS30_RU'];
	_u = _u		+ ['UAZ_SPG9_INS'];
	_u = _u		+ ['BTR40_TK_INS_EP1'];
	_u = _u		+ ['BTR40_MG_TK_INS_EP1'];
	_u = _u		+ ['LandRover_MG_TK_EP1'];
	_u = _u		+ ['LandRover_SPG9_TK_EP1'];
	_u = _u		+ ['SUV_TK_EP1'];
	_u = _u		+ ['Kamaz'];
	_u = _u		+ ['V3S_TK_EP1'];
	_u = _u		+ ['V3S_Open_TK_EP1'];
	_u = _u		+ ['UralRepair_TK_EP1'];
	_u = _u		+ ['UralReammo_TK_EP1'];
	_u = _u		+ ['UralRefuel_TK_EP1'];
	if (('WFBE_SUPPLYSYSTEM' Call GetNamespace) == 0) then {_u = _u		+ ['UralSupply_TK_EP1']};
	_u = _u		+ ['KamazRepair'];
	_u = _u		+ ['WarfareReammoTruck_RU'];
	_u = _u		+ ['KamazRefuel'];
	if (('WFBE_SUPPLYSYSTEM' Call GetNamespace) == 0) then {_u = _u		+ ['WarfareSupplyTruck_RU']};
	_u = _u		+ ['M113Ambul_TK_EP1'];
	_u = _u		+ ['GAZ_Vodnik_MedEvac'];
	_u = _u		+ ['BRDM2_TK_EP1'];
	_u = _u		+ ['BRDM2_ATGM_TK_EP1'];
	_u = _u		+ ['BRDM2_INS'];
	_u = _u		+ ['BRDM2_ATGM_INS'];
	_u = _u		+ ['GAZ_Vodnik'];
	_u = _u		+ ['GAZ_Vodnik_HMG'];
	_u = _u		+ ['BTR60_TK_EP1'];
	_u = _u		+ ['Ural_ZU23_TK_EP1'];
	_u = _u		+ ['Ural_ZU23_INS'];
	_u = _u		+ ['BTR90'];
	_u = _u		+ ['GRAD_TK_EP1'];
	_u = _u		+ ['GRAD_RU'];
};

['WFBE_EASTLIGHTUNITS',_u,true] Call SetNamespace;
if (local player) then {['LIGHT','EAST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

//RESISTANCE
if (WF_A2_Vanilla || WF_A2_CombinedOps) then {
	_u 			= ['TT650_Gue'];
	_u = _u		+ ['V3S_Gue'];
	_u = _u		+ ['Pickup_PK_GUE'];
	_u = _u		+ ['Offroad_DSHKM_Gue'];
	_u = _u		+ ['Offroad_SPG9_Gue'];
	_u = _u		+ ['BRDM2_Gue'];
	_u = _u		+ ['Ural_ZU23_Gue'];
};

if (WF_A2_Arrowhead || WF_A2_CombinedOps) then {
	_u 			= ['V3S_TK_GUE_EP1'];
	_u = _u		+ ['Pickup_PK_TK_GUE_EP1'];
	_u = _u		+ ['Offroad_DSHKM_TK_GUE_EP1'];
	_u = _u		+ ['Offroad_SPG9_TK_GUE_EP1'];
	_u = _u		+ ['BRDM2_TK_GUE_EP1'];
	_u = _u		+ ['BTR40_TK_GUE_EP1'];
	_u = _u		+ ['BTR40_MG_TK_GUE_EP1'];
	_u = _u		+ ['Ural_ZU23_TK_GUE_EP1'];
};
	
['WFBE_GUERLIGHTUNITS',_u,true] Call SetNamespace;

if (WF_A2_Vanilla) then {
	['WFBE_WESTREPAIRTRUCK','MtvrRepair',true] Call SetNamespace;
	['WFBE_WESTSUPPLYTRUCK','WarfareSupplyTruck_USMC',true] Call SetNamespace;
	['WFBE_WESTAMBULANCES',['HMMWV_Ambulance'],true] Call SetNamespace;

	['WFBE_EASTREPAIRTRUCK','KamazRepair',true] Call SetNamespace;
	['WFBE_EASTSUPPLYTRUCK','WarfareSupplyTruck_RU',true] Call SetNamespace;
	['WFBE_EASTAMBULANCES',['GAZ_Vodnik_MedEvac'],true] Call SetNamespace;
};

if (WF_A2_Arrowhead) then {
	['WFBE_WESTREPAIRTRUCK','MtvrRepair_DES_EP1',true] Call SetNamespace;
	['WFBE_WESTSUPPLYTRUCK','MtvrSupply_DES_EP1',true] Call SetNamespace;
	['WFBE_WESTAMBULANCES',['HMMWV_Ambulance_DES_EP1','M1133_MEV_EP1'],true] Call SetNamespace;
	
	['WFBE_EASTREPAIRTRUCK','UralRepair_TK_EP1',true] Call SetNamespace;
	['WFBE_EASTSUPPLYTRUCK','UralSupply_TK_EP1',true] Call SetNamespace;
	['WFBE_EASTAMBULANCES',['M113Ambul_TK_EP1'],true] Call SetNamespace;
};

if (WF_A2_CombinedOps) then {
	['WFBE_WESTREPAIRTRUCK',if (WF_Camo) then {'MtvrRepair'} else {'MtvrRepair_DES_EP1'},true] Call SetNamespace;
	['WFBE_WESTSUPPLYTRUCK',if (WF_Camo) then {'WarfareSupplyTruck_USMC'} else {'MtvrSupply_DES_EP1'},true] Call SetNamespace;
	['WFBE_WESTAMBULANCES',['HMMWV_Ambulance','HMMWV_Ambulance_DES_EP1','M1133_MEV_EP1'],true] Call SetNamespace;

	['WFBE_EASTREPAIRTRUCK',if (WF_Camo) then {'KamazRepair'} else {'UralRepair_TK_EP1'},true] Call SetNamespace;
	['WFBE_EASTSUPPLYTRUCK',if (WF_Camo) then {'WarfareSupplyTruck_RU'} else {'UralSupply_TK_EP1'},true] Call SetNamespace;
	['WFBE_EASTAMBULANCES',['GAZ_Vodnik_MedEvac','M113Ambul_TK_EP1'],true] Call SetNamespace;
};

_longestLightBuildTime = 0;
{
	_c = _x Call GetNamespace;
	if !(isNil '_c') then {
		if ((_c select QUERYUNITTIME) > _longestLightBuildTime) then {
			_longestLightBuildTime = (_c select QUERYUNITTIME);
		};
	} else {
		Format ["Config_LightFactory: '%1' is not defined in the Core files.",_x] call LogError;
	};
} forEach (('WFBE_EASTLIGHTUNITS' Call GetNamespace) + ('WFBE_WESTLIGHTUNITS' Call GetNamespace) + ('WFBE_GUERLIGHTUNITS' Call GetNamespace));

['WFBE_LONGESTLIGHTBUILDTIME',_longestLightBuildTime,true] Call SetNamespace;
"Config_LightFactory: Initialization - [Done]"  call LogMedium;