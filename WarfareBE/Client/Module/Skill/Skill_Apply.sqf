/*
	Script: Skill Application System by Benny.
	Description: Skill Application.
*/

switch (WFBE_SK_V_Type) do {
	case 'Engineer': {
		/* Repair Ability */
		player addAction [
			localize 'STR_WF_Action_Repair',
			(WFBE_SK_V_Root + 'Engineer' + '.sqf'), 
			[], 
			80, 
			false, 
			true, 
			"", 
			"time - WFBE_SK_V_LastUse_Repair > WFBE_SK_V_Reload_Repair"
		];
	};
	case 'Officer': {
		/* MASH Ability require that the MASH parameter is enabled */
		if (paramRespawnMASH) then {
			/* MASH Ability */
			player addAction [
				localize 'STR_WF_Action_DeployMASH',
				(WFBE_SK_V_Root + 'Officer' + '.sqf'), 
				[], 
				80, 
				false, 
				true, 
				"", 
				"time - WFBE_SK_V_LastUse_MASH > WFBE_SK_V_Reload_MASH"
			];
		};
	};
	case 'SpecOps': {
		/* Lockpicking Ability */
		player addAction [
			localize 'STR_WF_Action_Lockpick',
			(WFBE_SK_V_Root + 'SpecOps' + '.sqf'), 
			[], 
			80, 
			false, 
			true, 
			"", 
			"time - WFBE_SK_V_LastUse_Lockpick > WFBE_SK_V_Reload_Lockpick"
		];
	};
	case 'Spotter': {
		/* Spotting Ability */
		player addAction [
			localize 'STR_WF_Action_Spot',
			(WFBE_SK_V_Root + 'Sniper' + '.sqf'), 
			[], 
			80, 
			false, 
			true, 
			"", 
			"time - WFBE_SK_V_LastUse_Spot > WFBE_SK_V_Reload_Spot"
		];
	};
};