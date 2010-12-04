/*
	Script: Skill System by Benny.
	Description: Add special skills to players in function of their slots.
*/

_type = "";
_label = "";
_condition = "";

if (isNil "lastUseSkill") then {

	// 0 - engineer
	// 1 - spot
	// 2 - lockpick
	// 3 - medic
	// 4 - mash

	lastUseSkill = [0, 0, 0, 0, -600, 0, 0, 0, 0, 0];
};

playerType = typeof player;
	
_dogTags = player call GetEquipDogTags;
_dogTagCondition = "";

if (count _dogTags > 0) then {
	_dogTag = _dogTags select ((count _dogTags) - 1);
	
	if (_dogTag == "DogtagsEngineer" ) then { playerType = (Skills_Engineers select 0); };
	if (_dogTag == "DogtagsSaboteur" ) then { playerType = (Skills_Spot select 0); };
	if (_dogTag == "DogtagsLockpick" ) then { playerType = (Skills_Lockpick select 0) };
	if (_dogTag == "DogtagsMedic"    ) then { playerType = (Skills_Medic select 0); };
	if (_dogTag == "DogtagsCommander") then { playerType = (Skills_MASH select 0) };
	
	if ( (WF_A2_Arrowhead || WF_A2_CombinedOps) ) then {
		_dogTagCondition = "(!(isNull (unitBackpack player))) && (count (player call GetEquipDogTags) > 0)";
	} else {
		_dogTagCondition = "(count (player call GetEquipDogTags) > 0)";
	};
	
};


if (playerType in Skills_Engineers) then {_type = "Engineer";_label = localize "STR_WF_Action_Repair";_condition = "time - (lastUseSkill select 0) > 60"};
if (playerType in Skills_Spot) then {_type = "Sniper";_label = localize "STR_WF_Action_Spot";_condition = "time - (lastUseSkill select 1) > 10"};
if (playerType in Skills_Lockpick) then {_type = "SpecOps";_label = localize "STR_WF_Action_Lockpick";_condition = "time - (lastUseSkill select 2) > 25"};
if (playerType in Skills_Medic) then {_type = "Medic";_label = localize "STR_WF_Action_Heal";_condition = "time - (lastUseSkill select 3) > 25"};
if ((playerType in Skills_MASH) && paramRespawnMASH) then {_type = "Officer";_label = localize "STR_WF_Action_DeployMASH";_condition = "time - (lastUseSkill select 4) > 600"};

if (!isNil "skillActionId") then {
	player removeAction skillActionId; 
};

if (_type != "") then {
	if (_dogTagCondition != "") then { _condition = "(" + _condition + ") && (" + _dogTagCondition + ")";  };
	_action = Format ["Client\Module\Skill\Skill_%1.sqf",_type];
	skillActionId = player addAction [_label,_action, [], 90, false, true, "", _condition];
};

format["InitSkill: DogTags: %1", _dogTags] call LogTrace;
format["InitSkill: %1 Condition: %2", _type, _condition] call LogTrace;