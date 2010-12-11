#include "profiler.h"
PROFILER_BEGIN("Common_UnitKilled");

Private ["_bounty","_get","_group","_isMan","_killed","_killer","_killerID","_killername","_killerTeam","_killertype","_killeruid","_lost","_objects","_objectType","_side","_sideVictim","_uid"];
_killed = _this select 0;
_killer = _this select 1;
_sideVictim = _this select 2;
_sideKiller = side _killer;

_group = group _killed;
_killerTeam = group _killer;
_objectType = typeOf _killed;
_killertype = "";
_killeruid = "";
_killername = "";
_killeduid = "";
_killedname = "";
_iskilledplayer = false;
_iskillerplayer = false;

if ((local player) && !IsClientServer) exitWith {

	// player deaths must be handled on client machines;
	PROFILER_END();
};

_isMan = true;
//--- Ghost Fix (Invincible soldiers wanking around, not fighting back and not moving).
if !(_killed isKindOf "Man") then {
	_crew = crew _killed;
	_isMan = false;
	if (count _crew > 0) then {{_x setPos [(getPos _killed select 0) - 2 + random(4),(getPos _killed select 1)- 2 + random(4), 0]} forEach _crew};
};

if (mysql) then {
	_killertype = typeOf _killer;
	_iskilledplayer = if (isPlayer _killed) then {true} else {false};
	_iskillerplayer = if (isPlayer _killer) then {true} else {false};
	_killeruid = if (_iskillerplayer) then {getPlayerUID(_killer)} else {"0"};
	_killeduid = if (_iskilledplayer) then {getPlayerUID(_killed)} else {"0"};
	_killername = if (_iskillerplayer) then {name _killer} else {"nil"};
	_killedname = if (_iskilledplayer) then {name _killed} else {"nil"};
};

//--- Renegade.
if (_sideKiller == sideEnemy) then {
	if (_killer isKindOf westSoldierBaseClass) then {_sideKiller = west};
	if (_killer isKindOf eastSoldierBaseClass) then {_sideKiller = east};
};
if (_sideVictim == sideEnemy) then {
	if (_killed isKindOf westSoldierBaseClass) then {_sideVictim = west};
	if (_killed isKindOf eastSoldierBaseClass) then {_sideVictim = east};
};

_killed spawn TrashObject;

[NETSEND_MSGID_UPDATESTATS, [_killed, _sideVictim, -1]] spawn NetSend_ToServer;

_killerID = Leader _killerTeam Call GetClientID;
_get = _objectType Call GetNamespace;

//--- Normal kill.
if (!isNull _killerTeam && !isNil '_get' && (_sideKiller != sideEnemy) && (_sideKiller != _sideVictim) && (_sideKiller != Civilian)) then {
	if (_killerID > 0 && isPlayer(leader _killerTeam)) then {
		if (paramBounty) then {
			WFBE_AwardBounty = [[_killerID,_sideKiller],'CLTFNCAWARDBOUNTY',_objectType];
			publicVariable 'WFBE_AwardBounty';
			if (IsClientServer) then {[[_killerID,_sideKiller],'CLTFNCAWARDBOUNTY',_objectType] Spawn HandlePVF};
		};
	};
	
	if (paramAI && _killerID > 0 && !(isPlayer(leader _killerTeam))) then {
		if (isServer) then {
			_bounty = (_get select QUERYUNITPRICE) * ('WFBE_BOUNTYMODIFIER' Call GetNamespace);
			_bounty = _bounty - (_bounty % 1);
			[_bounty,_sideKiller,_killerID] Call ChangeClientFunds;
		};
	};
};

_processedUnitKillPenalty = false;
if (paramEnabledHeadHunters) then {
	_processedUnitKillPenalty = [_killed, _killer, _sideVictim] call HeadHunters;
};

//--- Teamkill.
if (!_processedUnitKillPenalty && !isNull _killerTeam && !isNil '_get' && (_sideKiller != sideEnemy) && (_sideKiller == _sideVictim) && (_sideKiller != Civilian) && _isMan) then {


	if (_killerID > 0 && isPlayer(leader _killerTeam)) then {
		WFBE_LocalizeMessage = [[_killerID,_sideKiller],'CLTFNCLOCALIZEMESSAGE',['Teamkill']];
		publicVariable 'WFBE_LocalizeMessage';
		if (IsClientServer) then {[[_killerID,_sideKiller],'CLTFNCLOCALIZEMESSAGE',['Teamkill']] Spawn HandlePVF};
	};
};

PROFILER_END();