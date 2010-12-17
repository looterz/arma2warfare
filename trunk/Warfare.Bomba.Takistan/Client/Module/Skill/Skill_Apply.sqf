/*
	Script: Skill Application System by Benny.
	Description: Skill Application.
*/

_playerSkill = WFBE_SK_V_Type;
_conditionExtra = "";

_dogTags = player call GetEquipDogTags;


if (count _dogTags > 0) then {
	_dogTag = _dogTags select ((count _dogTags) - 1);
	
	if (_dogTag == "DogtagsEngineer" ) then { _playerSkill = 'Engineer'; };
	if (_dogTag == "DogtagsSaboteur" ) then { _playerSkill = 'Spotter'; };
	if (_dogTag == "DogtagsLockpick" ) then { _playerSkill = 'SpecOps'; };
	if (_dogTag == "DogtagsCommander") then { _playerSkill = 'Officer'; };
	if (_dogTag == "DogtagsMedic"    ) then { _playerSkill = 'Medic'; };
	
	if ( (WF_A2_Arrowhead || WF_A2_CombinedOps) ) then {
		_conditionExtra = " && (!(isNull (unitBackpack player))) && (count (player call GetEquipDogTags) > 0)";
	} else {
		_conditionExtra = " && (count (player call GetEquipDogTags) > 0)";
	};
};

if (WFBE_SK_SkillActionId != -1) then {
	player removeAction WFBE_SK_SkillActionId; 
};

switch (_playerSkill) do {
	case 'Engineer': {
		/* Repair Ability */
		WFBE_SK_SkillActionId = player addAction [
			localize 'STR_WF_Action_Repair',
			(WFBE_SK_V_Root + 'Engineer' + '.sqf'), 
			[], 
			80, 
			false, 
			true, 
			"", 
			"(time - WFBE_SK_V_LastUse_Repair > WFBE_SK_V_Reload_Repair)" + _conditionExtra
		];
	};
	case 'Officer': {
		/* MASH Ability require that the MASH parameter is enabled */
		if (paramRespawnMASH) then {
			/* MASH Ability */
			WFBE_SK_SkillActionId = player addAction [
				localize 'STR_WF_Action_DeployMASH',
				(WFBE_SK_V_Root + 'Officer' + '.sqf'), 
				[], 
				80, 
				false, 
				true, 
				"", 
				"(time - WFBE_SK_V_LastUse_MASH > WFBE_SK_V_Reload_MASH)" + _conditionExtra
			];
		};
	};
	case 'SpecOps': {
		/* Lockpicking Ability */
		WFBE_SK_SkillActionId = player addAction [
			localize 'STR_WF_Action_Lockpick',
			(WFBE_SK_V_Root + 'SpecOps' + '.sqf'), 
			[], 
			80, 
			false, 
			true, 
			"", 
			"(time - WFBE_SK_V_LastUse_Lockpick > WFBE_SK_V_Reload_Lockpick)" + _conditionExtra
		];
	};
	case 'Spotter': {
		/* Spotting Ability */
		WFBE_SK_SkillActionId = player addAction [
			localize 'STR_WF_Action_Spot',
			(WFBE_SK_V_Root + 'Sniper' + '.sqf'), 
			[], 
			80, 
			false, 
			true, 
			"", 
			"(time - WFBE_SK_V_LastUse_Spot > WFBE_SK_V_Reload_Spot)" + _conditionExtra
		];
	};
	
	case 'Medic': {
		/* Medic Ability */
		WFBE_SK_SkillActionId = player addAction [
			localize 'STR_WF_Action_Heal',
			(WFBE_SK_V_Root + 'Medic' + '.sqf'), 
			[], 
			80, 
			false, 
			true, 
			"", 
			"(time - WFBE_SK_V_LastUse_Medic > WFBE_SK_V_Reload_Medic)" + _conditionExtra
		];
	};	
	
};