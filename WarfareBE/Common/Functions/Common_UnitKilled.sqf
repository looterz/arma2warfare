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

_isMan = true;
//--- Ghost Fix (Invincible soldiers wanking around, not fighting back and not moving).
if !(_killed isKindOf "Man") then {
	_crew = crew _killed;
	_isMan = false;
	if (count _crew > 0) then {{_x setPos [(getPos _killed select 0)-random(2)+random(4),(getPos _killed select 1)-random(2)+random(4),getPos _killed select 2]} forEach _crew};
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

//--- Benny's Garbage Collector.
if (!(isServer) || local player) then {
	_objects = (WF_Logic getVariable "trash") + [_killed];
	WF_Logic setVariable ["trash",_objects,true];
} else {
	trashQueu = trashQueu + [_killed];
	_killed Spawn TrashObject;
};

sleep random(2)+random(4);

if (_isMan && (_sideVictim == west || _sideVictim == east)) then {
	_lost = WF_Logic getVariable Format ["%1Casualties",str _sideVictim];
	_lost = _lost + 1;
	WF_Logic setVariable [Format["%1Casualties",str _sideVictim],_lost,true];	
};
if (!_isMan && (_sideVictim == west || _sideVictim == east)) then {
	_lost = WF_Logic getVariable Format ["%1VehiclesLost",str _sideVictim];
	_lost = _lost + 1;
	WF_Logic setVariable [Format["%1VehiclesLost",str _sideVictim],_lost,true];	
};

_killerID = Leader _killerTeam Call GetClientID;
_get = _objectType Call GetNamespace;

//--- Normal kill.
if (!isNull _killerTeam && !isNil '_get' && (_sideKiller != sideEnemy) && (_sideKiller != _sideVictim) && (_sideKiller != Civilian)) then {
	if (_killerID > 0 && isPlayer(leader _killerTeam)) then {
		if (paramBounty) then {
			WFBE_AwardBounty = [[_killerID,_sideKiller],'CLTFNCAWARDBOUNTY',_objectType];
			publicVariable 'WFBE_AwardBounty';
			if (!isMultiplayer || (isServer && local player)) then {[[_killerID,_sideKiller],'CLTFNCAWARDBOUNTY',_objectType] Spawn HandlePVF};
		};
		if (mysql) then {
			_sta = switch (true) do {
				case (_objectType isKindOf "Infantry"): {1};
				case (_objectType isKindOf "Car"): {2};
				case (_objectType isKindOf "Ship"): {2};
				case (_objectType isKindOf "Motorcycle"): {1};
				case (_objectType isKindOf "Tank"): {4};
				case (_objectType isKindOf "Helicopter"): {6};
				case (_objectType isKindOf "Plane"): {8};
				case (_objectType isKindOf "StaticWeapon"): {3};
				case (_objectType isKindOf "Building"): {3};
				default {1};
			};
			if (isServer) then {
				if (_iskilledplayer) then {
					WF_Logic setVariable ["WF_MYSQL_SERVER",(WF_Logic getVariable "WF_MYSQL_SERVER") + [Format ["MYSQLDATA�WFBE_InsertOrUpdate_PKP�%1�%2�%3�%4�%5",_killeduid,_killedname,_killeruid,_killername,worldName]]];
					WF_Logic setVariable ["WF_MYSQL_SERVER",(WF_Logic getVariable "WF_MYSQL_SERVER") + [Format ["MYSQLDATA�WFBE_InsertOrUpdate_PKAI�%1�%2�%3�%4�%5�%6",_killertype,_killeduid,_killedname,"killedby",_sta,worldName]]];
				} else {
					WF_Logic setVariable ["WF_MYSQL_SERVER",(WF_Logic getVariable "WF_MYSQL_SERVER") + [Format ["MYSQLDATA�WFBE_InsertOrUpdate_PKAI�%1�%2�%3�%4�%5�%6",_objectType,_killeruid,_killername,"killed",_sta,worldName]]];
				};
			} else {
				if (_iskilledplayer) then {
					WF_Logic setVariable ["WF_MYSQL_CLIENT",(WF_Logic getVariable "WF_MYSQL_CLIENT") + [Format ["MYSQLDATA�WFBE_InsertOrUpdate_PKP�%1�%2�%3�%4�%5",_killeduid,_killedname,_killeruid,_killername,worldName]],true];
					WF_Logic setVariable ["WF_MYSQL_CLIENT",(WF_Logic getVariable "WF_MYSQL_CLIENT") + [Format ["MYSQLDATA�WFBE_InsertOrUpdate_PKAI�%1�%2�%3�%4�%5�%6",_killertype,_killeduid,_killedname,"killedby",_sta,worldName]],true];
				} else {
					WF_Logic setVariable ["WF_MYSQL_CLIENT",(WF_Logic getVariable "WF_MYSQL_CLIENT") + [Format ["MYSQLDATA�WFBE_InsertOrUpdate_PKAI�%1�%2�%3�%4�%5�%6",_objectType,_killeruid,_killername,"killed",_sta,worldName]],true];
				};
			};
		};
	};
	
	if (mysql) then {
		if !(isPlayer(leader _killerTeam)) then {
			if (isServer) then {
				if (mysql && _iskilledplayer) then {
					WF_Logic setVariable ["WF_MYSQL_SERVER",(WF_Logic getVariable "WF_MYSQL_SERVER") + [Format ["MYSQLDATA�WFBE_InsertOrUpdate_PKAI�%1�%2�%3�%4�0�%5",_killertype,_killeduid,_killedname,"killedby",worldName]]];
				};
			} else {
				if (mysql && _iskilledplayer) then {
					WF_Logic setVariable ["WF_MYSQL_CLIENT",(WF_Logic getVariable "WF_MYSQL_CLIENT") + [Format ["MYSQLDATA�WFBE_InsertOrUpdate_PKAI�%1�%2�%3�%4�0�%5",_killertype,_killeduid,_killedname,"killedby",worldName]],true];
				};
			};
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

//--- Teamkill.
if (!isNull _killerTeam && !isNil '_get' && (_sideKiller != sideEnemy) && (_sideKiller == _sideVictim) && (_sideKiller != Civilian) && _isMan) then {
	if (_killerID > 0 && isPlayer(leader _killerTeam)) then {
		WFBE_LocalizeMessage = [[_killerID,_sideKiller],'CLTFNCLOCALIZEMESSAGE',['Teamkill']];
		publicVariable 'WFBE_LocalizeMessage';
		if (!isMultiplayer || (isServer && local player)) then {[[_killerID,_sideKiller],'CLTFNCLOCALIZEMESSAGE',['Teamkill']] Spawn HandlePVF};
		if (mysql) then {
			if (isServer) then {
				WF_Logic setVariable ["WF_MYSQL_SERVER",(WF_Logic getVariable "WF_MYSQL_SERVER") + [Format ["MYSQLDATA�WFBE_Update�%1�%2�teamkill�%3",_killeruid,_killername,worldName]]];
			} else {
				WF_Logic setVariable ["WF_MYSQL_CLIENT",(WF_Logic getVariable "WF_MYSQL_CLIENT") + [Format ["MYSQLDATA�WFBE_Update�%1�%2�teamkill�%3",_killeruid,_killername,worldName]],true];
			};
		};
	};
};
