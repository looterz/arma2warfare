/*
	Script: Skill System by Benny.
	Description: Add special skills to players in function of their slots.
*/

_type = "";
_label = "";
_condition = "";

if (playerType in Skills_Engineers) then {_type = "Engineer";_label = localize "STR_WF_Action_Repair";_condition = "time - lastSkillUse > 60"};
if (playerType in Skills_Spot) then {_type = "Sniper";_label = localize "STR_WF_Action_Spot";_condition = "time - lastSkillUse > 10"};
if (playerType in Skills_Lockpick) then {_type = "SpecOps";_label = localize "STR_WF_Action_Lockpick";_condition = "time - lastSkillUse > 25"};
if ((playerType in Skills_MASH) && paramRespawnMASH) then {_type = "Officer";_label = localize "STR_WF_Action_DeployMASH";_condition = "time - lastSkillUse > 600"};

if (_type != "") then {
	_action = Format ["Client\Module\Skill\Skill_%1.sqf",_type];
	player addAction [_label,_action, [], 90, false, true, "", _condition];
};