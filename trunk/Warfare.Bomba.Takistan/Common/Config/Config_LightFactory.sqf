Private['_c','_u'];

/* Overall configuration */
['WFBE_WESTREPAIRTRUCKS',['MtvrRepair_DES_EP1','MtvrRepair'],true] Call SetNamespace;
['WFBE_WESTSUPPLYTRUCKS',['MtvrSupply_DES_EP1','WarfareSupplyTruck_USMC'],true] Call SetNamespace;
['WFBE_EASTREPAIRTRUCKS',['UralRepair_TK_EP1','KamazRepair'],true] Call SetNamespace;
['WFBE_EASTSUPPLYTRUCKS',['UralSupply_TK_EP1','WarfareSupplyTruck_RU'],true] Call SetNamespace;

/* WEST - Light */
_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + WFBE_V_UnitsRootVersion + 'Units_Light_' + WFBE_V_West_Faction + '.sqf');
['WFBE_WESTLIGHTUNITS',_u,true] Call SetNamespace;
if (local player) then {['LIGHT','WEST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

/* EAST - Light */
_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + WFBE_V_UnitsRootVersion + 'Units_Light_' + WFBE_V_East_Faction + '.sqf');
['WFBE_EASTLIGHTUNITS',_u,true] Call SetNamespace;
if (local player) then {['LIGHT','EAST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

/* RESISTANCE - Light */
_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + WFBE_V_UnitsRootVersion + 'Units_Light_' + WFBE_V_Resistance_Faction + '.sqf');
['WFBE_GUERLIGHTUNITS',_u,true] Call SetNamespace;

/* Allies */
if (paramAllies) then {
	//--- CDF Allies.
	_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + 'Vanilla\Units_Light_CDF.sqf');
	['WFBE_WESTALLIESLIGHTUNITS',_u,true] Call SetNamespace;

	//--- Insurgent Allies.
	_u = Call Compile preprocessFile (WFBE_V_UnitsRoot + 'Vanilla\Units_Light_INS.sqf');
	['WFBE_EASTALLIESLIGHTUNITS',_u,true] Call SetNamespace;
} else {
	['WFBE_WESTALLIESLIGHTUNITS',[],true] Call SetNamespace;
	['WFBE_EASTALLIESLIGHTUNITS',[],true] Call SetNamespace;
};

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