private['_u','_n'];

_n		= ["Group"];
_u		= ["Soldier_TL_PMC"];
_u = _u + ["Soldier_Bodyguard_AA12_PMC"];
_u = _u + ["Soldier_Bodyguard_M4_PMC"];
_u = _u + ["Soldier_PMC"];
_u = _u + ["Soldier_GL_PMC"];
_u = _u + ["Soldier_GL_PMC"];
_u = _u + ["Soldier_Medic_PMC"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["GroupAssault"];
_u		= ["Soldier_TL_PMC"];
_u = _u + ["Soldier_Bodyguard_AA12_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_u = _u + ["Soldier_Bodyguard_M4_PMC"];
_u = _u + ["Soldier_MG_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_u = _u + ["Soldier_Engineer_PMC"];
_u = _u + ["Soldier_Medic_PMC"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["GroupWeapons"];
_u		= ["Soldier_GL_PMC"];
_u = _u + ["Soldier_MG_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_u = _u + ["Soldier_Bodyguard_AA12_PMC"];
_u = _u + ["Soldier_AT_PMC"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["Patrol1"];
_u		= ["Soldier_GL_PMC"];
_u = _u + ["Soldier_MG_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_u = _u + ["Soldier_Sniper_KSVK_PMC"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["Patrol2"];
_u		= ["Soldier_PMC"];
_u = _u + ["Soldier_Bodyguard_M4_PMC"];
_u = _u + ["Soldier_Bodyguard_AA12_PMC"];
_u = _u + ["Soldier_AT_PMC"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["ATTeam"];
_u		= ["Soldier_AT_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_u = _u + ["Soldier_Bodyguard_M4_PMC"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["AATeam"];
_u		= ["Soldier_TL_PMC"];
_u = _u + ["Soldier_AA_PMC"];
_u = _u + ["Soldier_AA_PMC"];
_u = _u + ["Soldier_Bodyguard_M4_PMC"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["SniperTeam"];
_u		= ["Soldier_Sniper_KSVK_PMC"];
_u = _u + ["Soldier_Engineer_PMC"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["Militia"];
_u		= ["Soldier_Engineer_PMC"];
_u = _u + ["Soldier_M4A3_PMC"];
_u = _u + ["Soldier_Sniper_PMC"];
_u = _u + ["Soldier_GL_PMC"];
_u = _u + ["Soldier_Medic_PMC"];
_u = _u + ["Soldier_PMC"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["Technical"];
_u		= ["Soldier_TL_PMC"];
_u = _u + ["Offroad_DSHKM_TK_GUE_EP1"];
_u = _u + ["Offroad_SPG9_TK_GUE_EP1"];
_u = _u + ["ArmoredSUV_PMC"];
_u = _u + ["Soldier_MG_PMC"];
_u = _u + ["Soldier_GL_PMC"];
_u = _u + ["Soldier_Sniper_KSVK_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_u = _u + ["Soldier_Bodyguard_M4_PMC"];
_u = _u + ["Soldier_Medic_PMC"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["MotorizedGroup"];
_u		= ["Soldier_TL_PMC"];
_u = _u + ["ArmoredSUV_PMC"];
_u = _u + ["Soldier_Bodyguard_AA12_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_u = _u + ["Soldier_PMC"];
_u = _u + ["Soldier_Bodyguard_M4_PMC"];
_u = _u + ["Soldier_MG_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_u = _u + ["Soldier_Medic_PMC"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["MotorizedAATeam"];
_u		= ["Soldier_TL_PMC"];
_u = _u + ["Ural_ZU23_TK_GUE_EP1"];
_u = _u + ["Soldier_Sniper_PMC"];
_u = _u + ["Soldier_AA_PMC"];
_u = _u + ["Soldier_PMC"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["MechanizedPatrol"];
_u		= ["Soldier_Bodyguard_M4_PMC"];
_u = _u + ["BTR40_MG_TK_GUE_EP1"];
_u = _u + ["BRDM2_TK_GUE_EP1"];
_u = _u + ["Soldier_Bodyguard_AA12_PMC"];
_u = _u + ["Soldier_PMC"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["MechanizedGroup"];
_u		= ["Soldier_TL_PMC"];
_u = _u + ["T34_TK_GUE_EP1"];
_u = _u + ["ArmoredSUV_PMC"];
_u = _u + ["Soldier_MG_PMC"];
_u = _u + ["Soldier_Bodyguard_AA12_PMC"];
_u = _u + ["Soldier_AT_PMC"];
_u = _u + ["Soldier_Bodyguard_M4_PMC"];
_u = _u + ["Soldier_Sniper_KSVK_PMC"];
_u = _u + ["Soldier_AT_PMC"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["LightArmor"];
_u		= ["Soldier_TL_PMC"];
_u = _u + ["T34_TK_GUE_EP1"];
_u = _u + ["T34_TK_GUE_EP1"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["HeavyArmor"];
_u		= ["Soldier_TL_PMC"];
_u = _u + ["T55_TK_GUE_EP1"];
_u = _u + ["T55_TK_GUE_EP1"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

"Resistance_PMC: Initialization - [Done]" call LogHigh;