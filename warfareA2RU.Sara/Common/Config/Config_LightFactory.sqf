Private['_balancePrice','_c','_longestLightBuildTime','_u'];

_balancePrice = 'WFBE_BALANCEPRICE' Call GetNamespace;

/* WEST - Light */
_u = Call Compile preprocessFile Format["Common\Config\Core_Units\%1\Units_Light_%2.sqf",WFBE_V_West_UnitsRootVersion,WFBE_V_West_Faction];
['WFBE_WESTLIGHTUNITS',_u,true] Call SetNamespace;
if (local player) then {['LIGHT','WEST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

/* EAST - Light */
_u = Call Compile preprocessFile Format["Common\Config\Core_Units\%1\Units_Light_%2.sqf",WFBE_V_East_UnitsRootVersion,WFBE_V_East_Faction];
['WFBE_EASTLIGHTUNITS',_u,true] Call SetNamespace;
if (local player) then {['LIGHT','EAST',_u] Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};

/* RESISTANCE - Light */
_u = Call Compile preprocessFile Format["Common\Config\Core_Units\%1\Units_Light_%2.sqf",WFBE_V_Resistance_UnitsRootVersion,WFBE_V_Resistance_Faction];
['WFBE_GUERLIGHTUNITS',_u,true] Call SetNamespace;

/* Allies */
if (('WFBE_ALLIES' Call GetNamespace) > 0) then {
	//--- CDF Allies.
	_u = Call Compile preprocessFile "Common\Config\Core_Units\Vanilla\Units_Light_CDF.sqf";
	['WFBE_WESTALLIESLIGHTUNITS',_u,true] Call SetNamespace;

	//--- Insurgent Allies.
	_u = Call Compile preprocessFile "Common\Config\Core_Units\Vanilla\Units_Light_INS.sqf";
	['WFBE_EASTALLIESLIGHTUNITS',_u,true] Call SetNamespace;
} else {
	['WFBE_WESTALLIESLIGHTUNITS',[],true] Call SetNamespace;
	['WFBE_EASTALLIESLIGHTUNITS',[],true] Call SetNamespace;
};

/* Overall configuration */
['WFBE_WESTAMBULANCES',['HMMWV_Ambulance','HMMWV_Ambulance_DES_EP1','M1133_MEV_EP1','BMP2_Ambul_CDF'],true] Call SetNamespace;
['WFBE_WESTREPAIRTRUCKS',['MtvrRepair_DES_EP1','MtvrRepair','UralRepair_CDF'],true] Call SetNamespace;
['WFBE_WESTSALVAGETRUCK',['WarfareSalvageTruck_USMC','MtvrSalvage_DES_EP1','WarfareSalvageTruck_CDF'],true] Call SetNamespace;
['WFBE_WESTSUPPLYTRUCKS',['MtvrSupply_DES_EP1','WarfareSupplyTruck_USMC','WarfareSupplyTruck_CDF'],true] Call SetNamespace;

['WFBE_EASTAMBULANCES',['GAZ_Vodnik_MedEvac','M113Ambul_TK_EP1','BMP2_Ambul_INS'],true] Call SetNamespace;
['WFBE_EASTREPAIRTRUCKS',['UralRepair_TK_EP1','KamazRepair','UralRepair_INS'],true] Call SetNamespace;
['WFBE_EASTSALVAGETRUCK',['WarfareSalvageTruck_RU','UralSalvage_TK_EP1','WarfareSalvageTruck_INS'],true] Call SetNamespace;
['WFBE_EASTSUPPLYTRUCKS',['UralSupply_TK_EP1','WarfareSupplyTruck_RU','WarfareSupplyTruck_INS'],true] Call SetNamespace;

_longestLightBuildTime = 0;
{
	_c = _x Call GetNamespace;
	if !(isNil '_c') then {
		if ((_c select QUERYUNITTIME) > _longestLightBuildTime) then {
			_longestLightBuildTime = (_c select QUERYUNITTIME);
		};
		
		if (_balancePrice in [1,3]) then {
			_c set [QUERYUNITPRICE, (_c select QUERYUNITPRICE)*2];
		};
	} else {
		diag_log Format ["[WFBE (ERROR)][frameno:%2 | ticktime:%3] Config_LightFactory: '%1' is not defined in the Core files.",_x,diag_frameno,diag_tickTime];
	};
} forEach (('WFBE_EASTLIGHTUNITS' Call GetNamespace) + ('WFBE_WESTLIGHTUNITS' Call GetNamespace) + ('WFBE_GUERLIGHTUNITS' Call GetNamespace));

['WFBE_LONGESTLIGHTBUILDTIME',_longestLightBuildTime,true] Call SetNamespace;
diag_log Format ["[WFBE (INIT)][frameno:%1 | ticktime:%2] Config_LightFactory: Initialization - [Done]",diag_frameno,diag_tickTime];