#include "profiler.h"
PROFILER_BEGIN("Common_HeadHunters");

Private ['_sideKiller', '_sideVictim', '_huntedProcessed', '_killerFunds', '_bounty', '_commanderId', '_commanderTeam', '_commanderKilled', '_bonusPerc', '_victim', '_killer', '_victimId', '_killerId', '_victimFunds', '_scoreSide', '_scoreVictim'];

_victim = _this select 0;
_killer = _this select 1;
_sideVictim = _this select 2;

_killerTeam = group _killer;
_killer = leader _killerTeam;

_huntedProcessed = false;

_victimId = _victim  Call GetClientID;
_killerId = _killer Call GetClientID;

format["Head Hunter Process: %1", _this ] call LogHigh;
format["Head Hunter Process: _victimId=%1", _victimId ] call LogHigh;
format["Head Hunter Process: _killerId=%1", _killerId ] call LogHigh;

if (!isPlayer(_killer)) exitWith { 
	PROFILER_END();
	_huntedProcessed; 
};

if (WF_DEBUG || (isPlayer(_victim) && _victimId > 0 && _killerId > 0 && _victimId != _killerId)) then {

	_sideKiller = side _killer;
	if (_sideKiller == sideEnemy) then {
		if (_killer isKindOf westSoldierBaseClass) then {_sideKiller = west};
		if (_killer isKindOf eastSoldierBaseClass) then {_sideKiller = east};
	};
	
	if (_sideVictim == sideEnemy) then {
		if (_victim isKindOf westSoldierBaseClass) then {_sideVictim = west};
		if (_victim isKindOf eastSoldierBaseClass) then {_sideVictim = east};
	};	

	_nameKiller = name _killer;
	_nameVictim = name _victim;

	format ["HeadHunting: %1(%2) kill %3(%4)", _nameKiller, _sideKiller, _nameVictim, _sideVictim] call LogHigh;
	
	if (_sideKiller != _sideVictim) then {
	
		_victimFunds = ([side _victim, _victimId] Call GetClientTeam) Call GetTeamFunds;
		if (WF_DEBUG) then { _victimFunds = 35000; };
		
		format ["HeadHunting: Victim Funds: %1", _victimFunds] call LogHigh;
		
		if (_victimFunds >= 1000) then {
		
			_scoreSide = scoreSide (side _victim);
			_scoreVictim = score _victim;
			
			_bonusPerc = 0.1;
			if (_scoreSide > 0) then {
			
				_scoreVictim = if (_scoreVictim > 0) then { _scoreVictim; } else { 0; };
				_bonusPerc = 0.05 + (0.1 * _scoreVictim / (_scoreSide / (WF_MAXPLAYERS/2)));				
			};
			
			_commanderKilled = false;
			_commanderTeam = (side _victim) Call GetCommanderTeam;
			if !(isNull _commanderTeam) then {
				_commanderId = (Leader _commanderTeam) Call GetClientID;
				
				if (_victimId == _commanderId) then {					
					_bonusPerc = 0.75;
					_commanderKilled = true;
				};					
			};

			_bounty = (ceil(0.5 + (_victimFunds * _bonusPerc /100)))*100;
			
			if (_bounty < 100)  then { _bounty = 100; };
			if (_bounty > 5000 && !_commanderKilled) then { _bounty = 5000; };
			if (_bounty > _victimFunds) then { _bounty = _victimFunds; };
			
			[_bounty,_sideKiller,_killerId] Call ChangeClientFunds;
			[-_bounty,_sideVictim,_victimId] Call ChangeClientFunds;

			WFBE_LocalizeMessage = [[_killerId, _sideKiller],'CLTFNCLOCALIZEMESSAGE',['HeadHunterReceiveBounty',_bounty, _nameVictim]];
			publicVariable 'WFBE_LocalizeMessage';
			if (local player || IsClientServer) then {[[_killerId, _sideKiller],'CLTFNCLOCALIZEMESSAGE',['HeadHunterReceiveBounty',_bounty, _nameVictim]] Spawn HandlePVF};
			
			WFBE_LocalizeMessage = [[_victimId, _sideVictim],'CLTFNCLOCALIZEMESSAGE',['HeadHunterSendBounty',_bounty, _nameKiller]];
			publicVariable 'WFBE_LocalizeMessage';
			if (local player || IsClientServer) then {[[_victimId, _sideVictim],'CLTFNCLOCALIZEMESSAGE',['HeadHunterSendBounty',_bounty, _nameKiller]] Spawn HandlePVF};
			
			_huntedProcessed = true;
		};				
	 } else { // -- teamkill bounty for victim;
	 
		_killerFunds = ([side _killer, _killerId] Call GetClientTeam) Call GetTeamFunds;
		if (WF_DEBUG) then { _killerFunds = 35000; };
		
		format ["HeadHunting: Killer Funds: %1", _killerFunds] call LogHigh;
		
		if (_killerFunds > 0) then {

			_huntedProcessed = true;
			_bounty = (ceil(0.5 + (_killerFunds * 0.1/500)))*500;	// 10% from killer cash
			if (_bounty < 500)  then { _bounty = 500; };
			if (_bounty > _killerFunds) then { _bounty = _killerFunds; };
							
			[-_bounty,_sideKiller,_killerId] Call ChangeClientFunds;
			[_bounty,_sideVictim,_victimId] Call ChangeClientFunds;
		
			WFBE_LocalizeMessage = [[_victimId, _sideVictim],'CLTFNCLOCALIZEMESSAGE',['HeadHunterReceiveRefund',_bounty, _nameKiller]];
			publicVariable 'WFBE_LocalizeMessage';
			if (local player || IsClientServer) then {[[_victimId, _sideVictim],'CLTFNCLOCALIZEMESSAGE',['HeadHunterReceiveRefund',_bounty, _nameKiller]] Spawn HandlePVF};			

			WFBE_LocalizeMessage = [[_killerId, _sideKiller],'CLTFNCLOCALIZEMESSAGE',['HeadHunterSendRefund',_bounty, _nameVictim]];
			publicVariable 'WFBE_LocalizeMessage';
			if (local player || IsClientServer) then {[[_killerId, _sideKiller],'CLTFNCLOCALIZEMESSAGE',['HeadHunterSendRefund',_bounty, _nameVictim]] Spawn HandlePVF};

		};
	 };		
};

format["Head Hunter Process Completed"] call LogHigh;

PROFILER_END();
_huntedProcessed;