#include "profiler.h"
PROFILER_BEGIN("Server_AI_SquadRespawn");

Private ["_buildings","_closestRespawn","_deathLoc","_leader","_pos","_rd","_rmr","_rr","_respawn","_respawnLoc","_side","_sideText","_slot","_team","_upgrades"];

	_team = _this;

	_side = side _team;	
	_sideText = str _side;
	_deathLoc = objNull;
	_respawnLoc = objNull;

	_rd = 'WFBE_RESPAWNDELAY' Call GetNamespace;
	_rr = 'WFBE_RESPAWNRANGE' Call GetNamespace;
	_rmr = 'WFBE_RESPAWNMINRANGE' Call GetNamespace;
	
	if (isNil "_team") exitWith {
		format["AI_SquadRespawn Initialized: Trying Respawn nil team", _this] call LogHigh;
	};
	
	if (isNull _team) exitWith {
		format["AI_SquadRespawn Initialized: Trying Respawn null team", _this] call LogHigh;
	};

	if (_side != west && _side != east) exitWith {
		format["AI_SquadRespawn Initialized: Trying Respawn guerilla team", _this] call LogHigh;
	};	
	
	_leader = leader _team;
	if (isPlayer _leader || alive (_leader)) exitWith {
	};

	format["AI_SquadRespawn Initialized: %1", _this] call LogHigh;
	
	_deathLoc = getPos (leader _team);
	_respawn = (_team) Call GetTeamRespawn;
	
	_unitType = typeof _leader;
	
	
	format["AI_SquadRespawn: deathLoc:%1", _deathLoc] call LogHigh;
	format["AI_SquadRespawn: respawn:%1", _respawn] call LogHigh;
	
	//--- Place the AI.

	_leader removeAllEventHandlers "Killed";
	Call Compile Format ["_leader addEventHandler ['Killed',{[_this select 0,_this select 1,%1] Spawn UnitKilled}]",_side];
	
	if (isMultiplayer) then {
		_leader setPos getMarkerPos Format["%1TempRespawnMarker",_sideText];
	};

	_availableSpawn = [];
	//--- Towns.
	if (paramCampRespawn && _respawn != "forceRespawn") then {
		_town = [_deathLoc,_side] Call GetClosestLocation;
		if (!isNull _town) then {
			if (_town distance _deathLoc  < _rr) then {
				_camps = [_town,_side] Call GetFriendlyCamps;
				if (count _camps > 0) then {
					if (paramCampRespawnRule) then {
						_closestCamps = [_deathLoc,_camps] Call SortByDistance;
						_closestCamp = _closestCamps select 0;
						_objects = _closestCamp nearEntities[[eastSoldierBaseClass,westSoldierBaseClass,"Car","Motorcycle","Tank","Air"],_rmr];
						_objs = _objects;
						{if (!(_x isKindOf "Man")) then {if (count (crew _x) == 0) then {_objects = _objects - [_x]}}} forEach _objs;
						_hostiles = if (_side == west) then {East countSide _objects} else {West countSide _objects};
						if (_deathLoc distance _closestCamp < _rmr && _hostiles > 0) then {_camps = _camps - [_closestCamp]};
					};
					_availableSpawn = _availableSpawn + _camps;
				};
			};
		};
	};
	
	_upgrades = (_sideText) Call GetSideUpgrades;
	
	//--- Mobile Respawn.
	if (paramMobileRespawn && _respawn != "forceRespawn") then {
		_mobileRespawns = Format ["WFBE_%1AMBULANCES",_sideText] Call GetNamespace;
		_range = (Format["WFBE_RESPAWNMOBILERANGE%1",(_upgrades select 7)] Call GetNamespace);
		
		format["AI_SquadRespawn: mobileRespawns:%1", _mobileRespawns] call LogHigh;
		format["AI_SquadRespawn: range:%1", _range] call LogHigh;
		
		_checks = _deathLoc nearEntities[_mobileRespawns,_range];
		
		format["AI_SquadRespawn: respawnPoints:%1", _checks] call LogHigh;
		
		{
			if (alive _x) then { _availableSpawn = _availableSpawn + [_x]; }
		} forEach _checks;
	};
	
	format["AI_SquadRespawn: selected respawnPoints:%1", _availableSpawn] call LogHigh;
	format["AI_SquadRespawn: respawndelay:%1", _rd] call LogHigh;
	
	if (WF_DEBUG) then {
		_rd = 5;
	};
	
	sleep _rd;
	
	format["AI_SquadRespawn: begin respawn:%1", _rd] call LogHigh;
	
	_hq = (_sideText) Call GetSideHQ;
	_buildings = (_sideText) Call GetSideStructures;

	//--- Check whether AI has a spawn set or not.
	_update = false;
	switch (typeName _respawn) do {
		case "STRING": {
			_update = true;
			if (_respawn == "forceRespawn") then {[_team,""] Call SetTeamRespawn};
		}; //--- Not defined.
		case "OBJECT": {
			_respawnLoc = _respawn;
			if (!alive _respawn || isNull _respawn) then {
				[_team, ""] Call SetTeamRespawn;
				_update = true;
			};	//--- Defined.
		};
	};
	
	//--- Default respawn.
	if (_update) then {
		_respawnLoc = _hq;
		if (count _buildings > 0) then {
			_closestRespawn = [_hq,_buildings] Call SortByDistance;
			_respawnLoc = _closestRespawn select 0;
		};
	};
	
	//--- Alternative spawn location.
	if (count _availableSpawn > 0) then {
		_respawnLoc = _availableSpawn select (round(random((count _availableSpawn)-1)));
	};

	_pos = [getPos _respawnLoc,20,30] Call GetRandomPosition;
	_pos set [2,0];
		
	if ( !(isPlayer (leader _team)) ) then {
	
		if (!isMultiplayer) then {
			_leader = [_unitType, _team, _pos, _side] Call CreateMan;	
			_team selectLeader _leader;
		};

		_leader setPos _pos;		
		_built = WF_Logic getVariable Format ["%1UnitsCreated",_sideText];
		_built = _built + 1;
		WF_Logic setVariable [Format["%1UnitsCreated",_sideText],_built,true];
	};

		//--- Equip the AI.
	_ran = 1 + round(random(2));
	[_leader, Format ["WFBE_%1LEADERWEAPONS%2%3",_sideText,_upgrades select 13,_ran] Call GetNamespace, Format ["WFBE_%1LEADERAMMO%2%3",_sideText,_upgrades select 13,_ran] Call GetNamespace] Call EquipLoadout;
	
PROFILER_END();