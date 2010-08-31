Private ["_buildings","_closestRespawn","_deathLoc","_leader","_order","_orderAI","_pos","_rd","_rmr","_rr","_respawn","_respawnLoc","_side","_sideText","_slot","_team","_upgrades"];
_side = _this select 0;
_team = _this select 1;
_slot = _this select 2;
_sideText = str _side;
_deathLoc = objNull;
_respawnLoc = objNull;

_orderAI = Format ["%1AITeam%2Order",_sideText,_slot + 1];
_rd = 'WFBE_RESPAWNDELAY' Call GetNamespace;
_rr = 'WFBE_RESPAWNRANGE' Call GetNamespace;
_rmr = 'WFBE_RESPAWNMINRANGE' Call GetNamespace;

sleep (random 0.5);

while {!gameOver} do {
	if (isPlayer leader _team) exitWith {};
	_built = WF_Logic getVariable Format ["%1UnitsCreated",_sideText];
	_built = _built + 1;
	WF_Logic setVariable [Format["%1UnitsCreated",_sideText],_built,true];
	waitUntil {!alive leader _team || isPlayer leader _team};
	_deathLoc = getPos (leader _team);
	if (isPlayer leader _team) exitWith {};
	waitUntil {alive leader _team || isPlayer leader _team};
	if (isPlayer leader _team) exitWith {};
	
	_order = Call Compile _orderAI;
	Call Compile Format ["%1 = ''",_orderAI];
	_respawn = (_team) Call GetTeamRespawn;
	
	//--- Place the AI.
	_leader = leader _team;
	_leader removeAllEventHandlers "Killed";
	Call Compile Format ["_leader addEventHandler ['Killed',{[_this select 0,_this select 1,%1] Spawn UnitKilled}]",_side];
	_leader setPos getMarkerPos Format["%1TempRespawnMarker",_sideText];

	_availableSpawn = [];
	//--- Towns.
	if (campRespawn && _respawn != "forceRespawn") then {
		_town = [_deathLoc,_side] Call GetClosestLocation;
		if (!isNull _town) then {
			if (_town distance _deathLoc  < _rr) then {
				_camps = [_town,_side] Call GetFriendlyCamps;
				if (count _camps > 0) then {
					if (campRespawnRule) then {
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
	
	_upgrades = WF_Logic getVariable Format ["%1Upgrades",_sideText];
	
	//--- Mobile Respawn.
	if (mobileRespawn && _respawn != "forceRespawn") then {
		_mobileRespawns = Format ["WFBE_%1AMBULANCES",_sideText] Call GetNamespace;
		_range = (Format["WFBE_RESPAWNMOBILERANGE%1",(_upgrades select 7)] Call GetNamespace);
		_checks = _deathLoc nearEntities[_mobileRespawns,_range];
		if (count _checks > 0) then {
			{if (alive _x) then {_availableSpawn = _availableSpawn + [_x]}} forEach _checks;
		};
	};
	
	sleep _rd;

	//--- Equip the AI.
	_ran = 1 + round(random(2));
	[_leader,Format ["WFBE_%1LEADERWEAPONS%2%3",_sideText,_upgrades select 13,_ran] Call GetNamespace, Format ["WFBE_%1LEADERAMMO%2%3",_sideText,_upgrades select 13,_ran] Call GetNamespace] Call EquipLoadout;
	_hq = WF_Logic getVariable Format ["%1MHQ",_sideText];
	_buildings = WF_Logic getVariable Format ["%1BaseStructures",_sideText];

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
	_leader setPos _pos;
	
	Call Compile Format ["%1 = _order",_orderAI];
};