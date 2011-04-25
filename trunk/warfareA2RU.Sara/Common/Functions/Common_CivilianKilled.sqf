Private ["_killed","_killer","_killerID","_killerTeam","_sideKiller"];
_killed = _this select 0;
_killer = _this select 1;
_sideKiller = side _killer;
_killerTeam = group _killer;

//--- Renegade.
if (_sideKiller == sideEnemy) then {
	if (_killer isKindOf westSoldierBaseClass) then {_sideKiller = west};
	if (_killer isKindOf eastSoldierBaseClass) then {_sideKiller = east};
};

//--- Benny's Garbage Collector.
if (WF_A2_Vanilla) then {
	trashQueu = trashQueu + [_killed];
	_killed Spawn TrashObject;
};

sleep random(2)+random(4);

_killerID = leader _killerTeam Call GetClientID;

//--- Civilian's death.
if (!isNull _killerTeam && (_sideKiller == west) || (_sideKiller == east)) then {
	if (_killerID > 0 && isPlayer (leader _killerTeam)) then {
		/* Penalty */
		WFBE_Penalty = [[_killerID,_sideKiller],'CLTFNCPENALTY'];
		publicVariable 'WFBE_Penalty';
		if (!isMultiplayer || (isServer && local player)) then {[[_killerID,_sideKiller],'CLTFNCPENALTY'] Spawn HandlePVF};
	};
};