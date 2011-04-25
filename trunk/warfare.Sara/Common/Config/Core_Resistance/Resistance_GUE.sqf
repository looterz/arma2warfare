Private ["_n","_u"];

_n		= ["Group"];
_u		= ["GUE_Soldier_CO"];
_u = _u + ["GUE_Soldier_GL"];
_u = _u + ["GUE_Soldier_AR"];
_u = _u + ["GUE_Soldier_1"];
_u = _u + ["GUE_Soldier_3"];
_u = _u + ["GUE_Soldier_2"];
_u = _u + ["GUE_Soldier_Medic"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["GroupAssault"];
_u		= ["GUE_Soldier_CO"];
_u = _u + ["GUE_Soldier_GL"];
_u = _u + ["GUE_Soldier_AT"];
_u = _u + ["GUE_Soldier_AR"];
_u = _u + ["GUE_Soldier_MG"];
_u = _u + ["GUE_Soldier_AT"];
_u = _u + ["GUE_Soldier_2"];
_u = _u + ["GUE_Soldier_Medic"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["GroupWeapons"];
_u		= ["GUE_Soldier_2"];
_u = _u + ["GUE_Soldier_MG"];
_u = _u + ["GUE_Soldier_AT"];
_u = _u + ["GUE_Soldier_GL"];
_u = _u + ["GUE_Soldier_Sab"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["Patrol1"];
_u		= ["GUE_Soldier_2"];
_u = _u + ["GUE_Soldier_MG"];
_u = _u + ["GUE_Soldier_AT"];
_u = _u + ["GUE_Soldier_GL"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["Patrol2"];
_u		= ["GUE_Soldier_1"];
_u = _u + ["GUE_Soldier_AR"];
_u = _u + ["GUE_Soldier_GL"];
_u = _u + ["GUE_Soldier_2"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["ATTeam"];
_u		= ["GUE_Soldier_AT"];
_u = _u + ["GUE_Soldier_AT"];
_u = _u + ["GUE_Soldier_AR"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["AATeam"];
_u		= ["GUE_Soldier_CO"];
_u = _u + ["GUE_Soldier_AA"];
_u = _u + ["GUE_Soldier_AA"];
_u = _u + ["GUE_Soldier_AR"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["SniperTeam"];
_u		= ["GUE_Soldier_Sniper"];
_u = _u + ["GUE_Soldier_Scout"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["Militia"];
_u		= ["GUE_Worker2"];
_u = _u + ["GUE_Woodlander3"];
_u = _u + ["GUE_Villager3"];
_u = _u + ["GUE_Woodlander2"];
_u = _u + ["GUE_Woodlander1"];
_u = _u + ["GUE_Villager4"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["Technical"];
_u		= ["GUE_Soldier_CO"];
_u = _u + ["Offroad_DSHKM_Gue"];
_u = _u + ["Offroad_SPG9_Gue"];
_u = _u + ["Pickup_PK_GUE"];
_u = _u + ["GUE_Soldier_MG"];
_u = _u + ["GUE_Soldier_3"];
_u = _u + ["GUE_Soldier_Sniper"];
_u = _u + ["GUE_Soldier_AR"];
_u = _u + ["GUE_Soldier_Medic"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["MotorizedGroup"];
_u		= ["GUE_Soldier_CO"];
_u = _u + ["V3S_GUE"];
_u = _u + ["GUE_Soldier_GL"];
_u = _u + ["GUE_Soldier_AT"];
_u = _u + ["GUE_Soldier_1"];
_u = _u + ["GUE_Soldier_AR"];
_u = _u + ["GUE_Soldier_MG"];
_u = _u + ["GUE_Soldier_AT"];
_u = _u + ["GUE_Soldier_Medic"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["MotorizedAATeam"];
_u		= ["GUE_Soldier_CO"];
_u = _u + ["Ural_ZU23_Gue"];
_u = _u + ["GUE_Soldier_GL"];
_u = _u + ["GUE_Soldier_AA"];
_u = _u + ["GUE_Soldier_1"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["MechanizedPatrol"];
_u		= ["GUE_Soldier_AR"];
_u = _u + ["BRDM2_GUE"];
_u = _u + ["GUE_Soldier_GL"];
_u = _u + ["GUE_Soldier_1"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["MechanizedGroup"];
_u		= ["GUE_Soldier_CO"];
_u = _u + ["BMP2_GUE"];
_u = _u + ["GUE_Soldier_MG"];
_u = _u + ["GUE_Soldier_GL"];
_u = _u + ["GUE_Soldier_3"];
_u = _u + ["GUE_Soldier_AR"];
_u = _u + ["GUE_Soldier_Sniper"];
_u = _u + ["GUE_Soldier_AT"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["LightArmor"];
_u		= ["GUE_Soldier_CO"];
_u = _u + ["BMP2_GUE"];
_u = _u + ["BMP2_GUE"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

_n = _n + ["HeavyArmor"];
_u		= ["GUE_Soldier_CO"];
_u = _u + ["T72_GUE"];
_u = _u + ["T72_GUE"];
[Format["WFBE_RES%1UNITS",_n select (count _n - 1)],_u,true] Call SetNamespace;

diag_log Format ["[WFBE (INIT)][frameno:%1 | ticktime:%2] Resistance_GUE: Initialization - [Done]",diag_frameno,diag_tickTime];