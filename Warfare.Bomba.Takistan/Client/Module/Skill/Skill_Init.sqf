/*
	Script: Skill System by Benny.
	Description: Skill Initialization.
*/

/* Skills Root */
WFBE_SK_V_Root = 'Client\Module\Skill\Skill_';

/* Functions */
WFBE_SK_FNC_Apply = Compile preprocessFile "Client\Module\Skill\Skill_Apply.sqf";

/* Define which classname belong to which skill group */
WFBE_SK_V_Engineers = ['USMC_SoldierS_Engineer','MVD_Soldier_TL','US_Soldier_Engineer_EP1','TK_Soldier_Engineer_EP1'];
WFBE_SK_V_Officers = ['FR_Commander','RUS_Commander','US_Soldier_SL_EP1','TK_Soldier_SL_EP1'];
WFBE_SK_V_Soldiers = ['FR_R','RUS_Soldier1','US_Delta_Force_EP1','TK_Special_Forces_EP1'];
WFBE_SK_V_SpecsOps = ['FR_TL','RUS_Soldier_TL','US_Delta_Force_TL_EP1','TK_Special_Forces_TL_EP1'];
WFBE_SK_V_Spotters = ['USMC_SoldierS_Sniper','RU_Soldier_Sniper','US_Soldier_Sniper_EP1','TK_Soldier_Sniper_EP1'];

/* Skills Variables */
WFBE_SK_V_LastUse_Medic = -1200;
WFBE_SK_V_LastUse_Repair = -1200;
WFBE_SK_V_LastUse_MASH = -1200;
WFBE_SK_V_LastUse_Lockpick = -1200;
WFBE_SK_V_LastUse_Spot = -1200;

/* Skills Timeout */
WFBE_SK_V_Reload_Medic = 15;
WFBE_SK_V_Reload_Repair = 65;
WFBE_SK_V_Reload_MASH = 600;
WFBE_SK_V_Reload_Lockpick = 25;
WFBE_SK_V_Reload_Spot = 8;

/* Find the player type */
WFBE_SK_V_BaseType = "";

if (playerType in WFBE_SK_V_Engineers) then {WFBE_SK_V_BaseType = "Engineer"};
if (playerType in WFBE_SK_V_Officers) then {WFBE_SK_V_BaseType = "Officer"};
if (playerType in WFBE_SK_V_Soldiers) then {WFBE_SK_V_BaseType = "Soldier"};
if (playerType in WFBE_SK_V_SpecsOps) then {WFBE_SK_V_BaseType = "SpecOps"};
if (playerType in WFBE_SK_V_Spotters) then {WFBE_SK_V_BaseType = "Spotter"};

WFBE_SK_V_Type = WFBE_SK_V_BaseType;

/* Special one time init */
/* The soldier can hire more units than the others leader */
if (WFBE_SK_V_Type == 'Soldier') then {['WFBE_MAXGROUPSIZE',('WFBE_MAXGROUPSIZE' Call GetNameSpace) + ('WFBE_MAXGZBONUSSKILL' Call GetNamespace),true] Call SetNamespace};
