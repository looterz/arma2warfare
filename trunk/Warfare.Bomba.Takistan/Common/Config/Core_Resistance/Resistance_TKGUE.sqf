private['_u','_n'];

_n		= ["Group"];
_u		= ["TK_GUE_Warlord_EP1"];
_u = _u + ["TK_GUE_Soldier_4_EP1"];
_u = _u + ["TK_GUE_Soldier_AR_EP1"];
_u = _u + ["TK_GUE_Soldier_EP1"];
_u = _u + ["TK_GUE_Soldier_5_EP1"];
_u = _u + ["TK_GUE_Soldier_5_EP1"];
_u = _u + ["TK_GUE_Bonesetter_EP1"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["GroupAssault"];
_u		= ["TK_GUE_Warlord_EP1"];
_u = _u + ["TK_GUE_Soldier_4_EP1"];
_u = _u + ["TK_GUE_Soldier_AT_EP1"];
_u = _u + ["TK_GUE_Soldier_AR_EP1"];
_u = _u + ["TK_GUE_Soldier_MG_EP1"];
_u = _u + ["TK_GUE_Soldier_HAT_EP1"];
_u = _u + ["TK_GUE_Soldier_5_EP1"];
_u = _u + ["TK_GUE_Bonesetter_EP1"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["GroupWeapons"];
_u		= ["TK_GUE_Soldier_5_EP1"];
_u = _u + ["TK_GUE_Soldier_MG_EP1"];
_u = _u + ["TK_GUE_Soldier_AT_EP1"];
_u = _u + ["TK_GUE_Soldier_4_EP1"];
_u = _u + ["TK_GUE_Soldier_AT_EP1"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["Patrol1"];
_u		= ["TK_GUE_Soldier_5_EP1"];
_u = _u + ["TK_GUE_Soldier_MG_EP1"];
_u = _u + ["TK_GUE_Soldier_AT_EP1"];
_u = _u + ["TK_GUE_Soldier_4_EP1"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["Patrol2"];
_u		= ["TK_GUE_Soldier_EP1"];
_u = _u + ["TK_GUE_Soldier_AR_EP1"];
_u = _u + ["TK_GUE_Soldier_4_EP1"];
_u = _u + ["TK_GUE_Soldier_HAT_EP1"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["ATTeam"];
_u		= ["TK_GUE_Soldier_AT_EP1"];
_u = _u + ["TK_GUE_Soldier_AT_EP1"];
_u = _u + ["TK_GUE_Soldier_AR_EP1"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["AATeam"];
_u		= ["TK_GUE_Warlord_EP1"];
_u = _u + ["TK_GUE_Soldier_AA_EP1"];
_u = _u + ["TK_GUE_Soldier_AA_EP1"];
_u = _u + ["TK_GUE_Soldier_AR_EP1"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["SniperTeam"];
_u		= ["TK_GUE_Soldier_Sniper_EP1"];
_u = _u + ["TK_GUE_Soldier_2_EP1"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["Militia"];
_u		= ["TK_GUE_Soldier_2_EP1"];
_u = _u + ["TK_GUE_Soldier_3_EP1"];
_u = _u + ["TK_GUE_Soldier_4_EP1"];
_u = _u + ["TK_GUE_Soldier_5_EP1"];
_u = _u + ["TK_GUE_Bonesetter_EP1"];
_u = _u + ["TK_GUE_Soldier_EP1"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["Technical"];
_u		= ["TK_GUE_Warlord_EP1"];
_u = _u + ["Offroad_DSHKM_TK_GUE_EP1"];
_u = _u + ["Offroad_SPG9_TK_GUE_EP1"];
_u = _u + ["Pickup_PK_TK_GUE_EP1"];
_u = _u + ["TK_GUE_Soldier_MG_EP1"];
_u = _u + ["TK_GUE_Soldier_5_EP1"];
_u = _u + ["TK_GUE_Soldier_Sniper_EP1"];
_u = _u + ["TK_GUE_Soldier_HAT_EP1"];
_u = _u + ["TK_GUE_Soldier_AR_EP1"];
_u = _u + ["TK_GUE_Bonesetter_EP1"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["MotorizedGroup"];
_u		= ["TK_GUE_Warlord_EP1"];
_u = _u + ["V3S_TK_GUE_EP1"];
_u = _u + ["TK_GUE_Soldier_4_EP1"];
_u = _u + ["TK_GUE_Soldier_AT_EP1"];
_u = _u + ["TK_GUE_Soldier_EP1"];
_u = _u + ["TK_GUE_Soldier_AR_EP1"];
_u = _u + ["TK_GUE_Soldier_MG_EP1"];
_u = _u + ["TK_GUE_Soldier_HAT_EP1"];
_u = _u + ["TK_GUE_Bonesetter_EP1"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["MotorizedAATeam"];
_u		= ["TK_GUE_Warlord_EP1"];
_u = _u + ["Ural_ZU23_TK_GUE_EP1"];
_u = _u + ["TK_GUE_Soldier_4_EP1"];
_u = _u + ["TK_GUE_Soldier_AA_EP1"];
_u = _u + ["TK_GUE_Soldier_EP1"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["MechanizedPatrol"];
_u		= ["TK_GUE_Soldier_AR_EP1"];
_u = _u + ["BTR40_MG_TK_GUE_EP1"];
_u = _u + ["BRDM2_TK_GUE_EP1"];
_u = _u + ["TK_GUE_Soldier_4_EP1"];
_u = _u + ["TK_GUE_Soldier_EP1"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["MechanizedGroup"];
_u		= ["TK_GUE_Warlord_EP1"];
_u = _u + ["T34_TK_GUE_EP1"];
_u = _u + ["BTR40_MG_TK_GUE_EP1"];
_u = _u + ["TK_GUE_Soldier_MG_EP1"];
_u = _u + ["TK_GUE_Soldier_4_EP1"];
_u = _u + ["TK_GUE_Soldier_HAT_EP1"];
_u = _u + ["TK_GUE_Soldier_AR_EP1"];
_u = _u + ["TK_GUE_Soldier_Sniper_EP1"];
_u = _u + ["TK_GUE_Soldier_AT_EP1"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["LightArmor"];
_u		= ["TK_GUE_Warlord_EP1"];
_u = _u + ["T34_TK_GUE_EP1"];
_u = _u + ["T34_TK_GUE_EP1"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["HeavyArmor"];
_u		= ["TK_GUE_Warlord_EP1"];
_u = _u + ["T55_TK_GUE_EP1"];
_u = _u + ["T55_TK_GUE_EP1"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

"Resistance_TKGUE: Initialization - [Done]" call LogHigh;