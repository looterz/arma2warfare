#include "profiler.h"
PROFILER_BEGIN("Service_AI_SquadRespawn");

private['_isForcedRespawn','_buildings','_closestRespawn','_deathLoc','_leader','_pos','_rd','_respawn','_respawnLoc','_side','_sideText','_team','_upgrades','_availablespawn','_createnewunit','_movemode','_update','_checks','_hq','_ran','_unittype','_rcm','_mobilerespawns','_range','_autonomous'];

	_team 	  = _this select 0;
	_deathLoc = _this select 1;
	_unitType = _this select 2;	

	_side = side _team;	
	_sideText = str _side;
	_respawnLoc = objNull;

	if (isNil "_team") exitWith {
		format["Service_SquadRespawnWork: Trying Respawn nil team", _this] call LogHigh;
	};
	
	if (isNull _team) exitWith {
		format["Service_SquadRespawnWork: Trying Respawn null team", _this] call LogHigh;
	};

	if (_side != west && _side != east) exitWith {
		format["Service_SquadRespawnWork: Trying Respawn guerilla team", _this] call LogHigh;
		WBE_AISQUAD_RESPAWN_QUEUE = WBE_AISQUAD_RESPAWN_QUEUE - [ _team ];
	};	
	
	_leader = leader _team;
	if (isNil "_leader") then { _leader = objNull };
	
	if (isPlayer _leader) exitWith {
	
		WBE_AISQUAD_RESPAWN_QUEUE = WBE_AISQUAD_RESPAWN_QUEUE - [ _team ];
	};

	format["AI_SquadRespawnWork: Unit: %1 Alive:%2", _leader, alive(_leader)] call LogHigh;

        _rd = 'WFBE_RESPAWNDELAY' Call GetNamespace;
        _rcm = 'WFBE_RESPAWNCAMPSMODE' Call GetNamespace;

	_respawn = (_team) Call GetTeamRespawn;

	_availableSpawn = [];
	_isForcedRespawn = false;
	if (typeName _respawn == 'STRING') then {if (_respawn == "forceRespawn") then {_isForcedRespawn = true}};

	//--- Towns.
	if (_rcm > 0 && !_isForcedRespawn) then {
		_availableSpawn = _availableSpawn + ([_deathLoc, _side] Call GetRespawnCamps);
	};

	_upgrades = (_sideText) Call GetSideUpgrades;
	
	//--- Mobile Respawn.
	if (paramMobileRespawn && !_isForcedRespawn) then {
		_mobileRespawns = Format ["WFBE_%1AMBULANCES",_sideText] Call GetNamespace;
		_range = (Format["WFBE_RESPAWNMOBILERANGE%1",(_upgrades select 7)] Call GetNamespace);
		
		format["AI_SquadRespawn: mobileRespawns:%1 range:%2", _mobileRespawns, _range] call LogHigh;		
		_checks = _deathLoc nearEntities[_mobileRespawns,_range];
		if (count _checks > 0) then {
			{if (alive _x) then {_availableSpawn = _availableSpawn + [_x]}} forEach _checks;
		};
	};
	
	_hq = (_sideText) Call GetSideHQ;
	_buildings = (_sideText) Call GetSideStructures;

	//--- Check whether AI has a spawn set or not.
	_update = false;
	switch (typeName _respawn) do {
		case "STRING": {
			_update = true;
			if (!_isForcedRespawn) then {[_team,""] Call SetTeamRespawn};
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

	_pos = [_respawnLoc,20,30] Call GetRandomPositionEx;
	_pos set [2,0];
	format["AI_SquadRespawnWork: Unit: %1 Respawn Location:", _leader, _pos] call LogHigh;

	
	if ( !(isPlayer (_leader)) || isNull(_leader) ) then {
	
		_createNewUnit = false;	
		if (!isMultiplayer && !(alive (_leader)) ) then {
			"AI_SquadRespawnWork: SP mode, and teamLeader is died, create TeamLeader" call LogHigh;
			_createNewUnit = true;
		};

		if (isNull _leader) then {
			format["AI_SquadRespawnWork: Team Leader is Null - Team %1", _team] call LogHigh;
			_createNewUnit = true;
		};
		
		if (_createNewUnit) then {

			_leader = [_unitType, _team, _pos, _side] Call CreateMan;
			_team selectLeader _leader;
			[_leader, _side] spawn SetAITeamKilledEventHandler;
		};

		format["AI_SquadRespawnWork: TeamLeader %1 SetPos=%2", _leader, _pos] call LogHigh;
		_leader setPos _pos;	

		if (isMultiplayer && !_createNewUnit) then {
			[_leader, _side] spawn ManagedUnitAdd;
		};

	//--- Assign fresh order (tbc).
	_autonomous = (_team) Call GetTeamAutonomous;
	if !(_autonomous) then {
		_moveMode = (_team) Call GetTeamMoveMode;
		if (_moveMode == "towns") then {[_team,"resetTowns"] Call SetTeamMoveMode};
		if (_moveMode == "move") then {[_team,"resetMove"] Call SetTeamMoveMode};
		if (_moveMode == "patrol") then {[_team,"resetPatrol"] Call SetTeamMoveMode};
		if (_moveMode == "defense") then {[_team,"resetDefense"] Call SetTeamMoveMode};
	};

		//--- Equip the AI.
		_ran = 1 + round(random(2));
		[_leader, Format ["WFBE_%1LEADERWEAPONS%2%3",_sideText,_upgrades select 13,_ran] Call GetNamespace, Format ["WFBE_%1LEADERAMMO%2%3",_sideText,_upgrades select 13,_ran] Call GetNamespace] Call EquipLoadout;
	};

	WBE_AISQUAD_RESPAWN_QUEUE = WBE_AISQUAD_RESPAWN_QUEUE - [ _team ];	
	
PROFILER_END();