Private ['_resType'];
_resType = 'WFBE_RESISTANCEFACTION' Call GetNamespace;
if (isNil '_resType') then {_resType = -1};

	_n		= ["Group"];
	_u		= [["GUE_Soldier_CO", "TK_GUE_Warlord_EP1"]];
	_u = _u + [["GUE_Soldier_GL","TK_GUE_Soldier_4_EP1"]];
	_u = _u + [["GUE_Soldier_AR","TK_GUE_Soldier_AR_EP1"]];
	_u = _u + [["GUE_Soldier_1","TK_GUE_Soldier_EP1"]];
	_u = _u + [["GUE_Soldier_3","TK_GUE_Soldier_5_EP1"]];
	_u = _u + [["GUE_Soldier_2","TK_GUE_Soldier_5_EP1"]];
	_u = _u + [["GUE_Soldier_Medic","TK_GUE_Bonesetter_EP1"]];
	_u call SelectCamo;
	[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;
	
	_n = _n + ["GroupAssault"];
	_u		= [["GUE_Soldier_CO","TK_GUE_Warlord_EP1"]];
	_u = _u + [["GUE_Soldier_GL","TK_GUE_Soldier_4_EP1"]];
	_u = _u + [["GUE_Soldier_AT","TK_GUE_Soldier_AT_EP1"]];
	_u = _u + [["GUE_Soldier_AR","TK_GUE_Soldier_AR_EP1"]];
	_u = _u + [["GUE_Soldier_MG","TK_GUE_Soldier_MG_EP1"]];
	_u = _u + [["GUE_Soldier_AT","TK_GUE_Soldier_HAT_EP1"]];
	_u = _u + [["GUE_Soldier_2","TK_GUE_Soldier_5_EP1"]];
	_u = _u + [["GUE_Soldier_Medic","TK_GUE_Bonesetter_EP1"]];
	_u call SelectCamo;
	[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

	_n = _n + ["GroupWeapons"];
	_u		= [["GUE_Soldier_2","TK_GUE_Soldier_5_EP1"]];
	_u = _u + [["GUE_Soldier_MG","TK_GUE_Soldier_MG_EP1"]];
	_u = _u + [["GUE_Soldier_AT","TK_GUE_Soldier_AT_EP1"]];
	_u = _u + [["GUE_Soldier_GL","TK_GUE_Soldier_4_EP1"]];
	_u = _u + [["GUE_Soldier_Sab","TK_GUE_Soldier_AT_EP1"]];
	_u call SelectCamo;
	[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

	_n = _n + ["Patrol1"];
	_u		= [["GUE_Soldier_2","TK_GUE_Soldier_5_EP1"]];
	_u = _u + [["GUE_Soldier_MG","TK_GUE_Soldier_MG_EP1"]];
	_u = _u + [["GUE_Soldier_AT","TK_GUE_Soldier_AT_EP1"]];
	_u = _u + [["GUE_Soldier_GL","TK_GUE_Soldier_4_EP1"]];
	_u call SelectCamo;
	[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

	_n = _n + ["Patrol2"];
	_u		= [["GUE_Soldier_1","TK_GUE_Soldier_EP1"]];
	_u = _u + [["GUE_Soldier_AR","TK_GUE_Soldier_AR_EP1"]];
	_u = _u + [["GUE_Soldier_GL","TK_GUE_Soldier_4_EP1"]];
	_u = _u + [["GUE_Soldier_2","TK_GUE_Soldier_HAT_EP1"]];
	_u call SelectCamo;
	[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

	_n = _n + ["ATTeam"];
	_u		= [["GUE_Soldier_AT","TK_GUE_Soldier_AT_EP1"]];
	_u = _u + [["GUE_Soldier_AT","TK_GUE_Soldier_AT_EP1"]];
	_u = _u + [["GUE_Soldier_AR","TK_GUE_Soldier_AR_EP1"]];
	_u call SelectCamo;
	[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;
	
	_n = _n + ["AATeam"];
	_u		= [["GUE_Soldier_CO","TK_GUE_Warlord_EP1"]];
	_u = _u + [["GUE_Soldier_AA", "TK_GUE_Soldier_AA_EP1"]];
	_u = _u + [["GUE_Soldier_AA","TK_GUE_Soldier_AA_EP1"]];
	_u = _u + [["GUE_Soldier_AR","TK_GUE_Soldier_AR_EP1"]];
	_u call SelectCamo;	
	[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;
	
	_n = _n + ["SniperTeam"];
	_u		= [["GUE_Soldier_Sniper","TK_GUE_Soldier_Sniper_EP1"]];
	_u = _u + [["GUE_Soldier_Scout","TK_GUE_Soldier_2_EP1"]];
	_u call SelectCamo;
	[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

	_n = _n + ["Militia"];
	_u		= [["GUE_Worker2","TK_GUE_Soldier_2_EP1"]];
	_u = _u + [["GUE_Woodlander3","TK_GUE_Soldier_3_EP1"]];
	_u = _u + [["GUE_Villager3","TK_GUE_Soldier_4_EP1"]];
	_u = _u + [["GUE_Woodlander2","TK_GUE_Soldier_5_EP1"]];
	_u = _u + [["GUE_Woodlander1","TK_GUE_Bonesetter_EP1"]];
	_u = _u + [["GUE_Villager4","TK_GUE_Soldier_EP1"]];
	_u call SelectCamo;	
	[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

	_n = _n + ["Technical"];
	_u		= [["GUE_Soldier_CO","TK_GUE_Warlord_EP1"]];
	_u = _u + [["Offroad_DSHKM_Gue","Offroad_DSHKM_TK_GUE_EP1"]];
	_u = _u + [["Offroad_SPG9_Gue","Offroad_SPG9_TK_GUE_EP1"]];
	_u = _u + [["Pickup_PK_GUE","Pickup_PK_TK_GUE_EP1"]];
	_u = _u + [["GUE_Soldier_MG","TK_GUE_Soldier_MG_EP1"]];
	_u = _u + [["GUE_Soldier_3","TK_GUE_Soldier_5_EP1"]];
	_u = _u + [["GUE_Soldier_Sniper","TK_GUE_Soldier_Sniper_EP1"]];
	_u = _u + [["GUE_Soldier_AR","TK_GUE_Soldier_AR_EP1"]];
	_u = _u + [["GUE_Soldier_Medic","TK_GUE_Bonesetter_EP1"]];
	_u call SelectCamo;	
	[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;
	
	_n = _n + ["MotorizedGroup"];
	_u		= [["GUE_Soldier_CO","TK_GUE_Warlord_EP1"]];
	_u = _u + [["V3S_GUE","V3S_TK_GUE_EP1"]];
	_u = _u + [["GUE_Soldier_GL","TK_GUE_Soldier_4_EP1"]];
	_u = _u + [["GUE_Soldier_AT","TK_GUE_Soldier_AT_EP1"]];
	_u = _u + [["GUE_Soldier_1","TK_GUE_Soldier_EP1"]];
	_u = _u + [["GUE_Soldier_AR","TK_GUE_Soldier_AR_EP1"]];
	_u = _u + [["GUE_Soldier_MG","TK_GUE_Soldier_MG_EP1"]];
	_u = _u + [["GUE_Soldier_AT","TK_GUE_Soldier_HAT_EP1"]];
	_u = _u + [["GUE_Soldier_Medic","TK_GUE_Bonesetter_EP1"]];
	_u call SelectCamo;	
	[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

	_n = _n + ["MotorizedAATeam"];
	_u		= [["GUE_Soldier_CO","TK_GUE_Warlord_EP1"]];
	_u = _u + [["Ural_ZU23_Gue","Ural_ZU23_TK_GUE_EP1"]];
	_u = _u + [["GUE_Soldier_GL","TK_GUE_Soldier_4_EP1"]];
	_u = _u + [["GUE_Soldier_AA","TK_GUE_Soldier_AA_EP1"]];
	_u = _u + [["GUE_Soldier_1","TK_GUE_Soldier_EP1"]];
	_u call SelectCamo;	
	[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

	_n = _n + ["MechanizedPatrol"];
	_u		= [["GUE_Soldier_AR","TK_GUE_Soldier_AR_EP1"]];
	_u = _u + [["BRDM2_GUE","BTR40_MG_TK_GUE_EP1"]];
	_u = _u + [["GUE_Soldier_GL", "TK_GUE_Soldier_4_EP1"]];
	_u = _u + [["GUE_Soldier_1","TK_GUE_Soldier_EP1"]];
	_u call SelectCamo;	
	[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

	_n = _n + ["MechanizedGroup"];
	_u		= [["GUE_Soldier_CO", "TK_GUE_Warlord_EP1"]];
	_u = _u + [["BMP2_GUE", "T34_TK_GUE_EP1"]];
	_u = _u + [["GUE_Soldier_MG", "TK_GUE_Soldier_MG_EP1"]];
	_u = _u + [["GUE_Soldier_GL","TK_GUE_Soldier_4_EP1"]];
	_u = _u + [["GUE_Soldier_AR","TK_GUE_Soldier_AR_EP1"]];
	_u = _u + [["GUE_Soldier_Sniper", "TK_GUE_Soldier_Sniper_EP1"]];
	_u = _u + [["GUE_Soldier_AT","TK_GUE_Soldier_AT_EP1"]];
	_u call SelectCamo;	
	[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

	_n = _n + ["LightArmor"];
	_u		= [["GUE_Soldier_CO", "TK_GUE_Warlord_EP1"]];
	_u = _u + [["BMP2_GUE", "T34_TK_GUE_EP1"]];
	_u = _u + [["BMP2_GUE", "T34_TK_GUE_EP1"]];
	_u call SelectCamo;	
	[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

	_n = _n + ["HeavyArmor"];
	_u		= [["GUE_Soldier_CO", "TK_GUE_Warlord_EP1"]];
	_u = _u + [["T72_GUE", "T55_TK_GUE_EP1"]];
	_u = _u + [["T72_GUE", "T55_TK_GUE_EP1"]];
	_u call SelectCamo;
	[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

"Config_Resistance: Intialization - [Done]" call LogMedium;