#include "profiler.h"
PROFILER_BEGIN("Server_BuildingHandleDamages");

Private ['_building','_dammages','_origin','_side','_side', '_stones', '_killerId', '_sideKiller', '_funds'];

_building = _this select 0;
_dammages = _this select 1;
_origin = _this select 2;
_sideBuilding = _this select 3;

_side = civilian;
if (side _origin == sideEnemy) then {
	if (_origin isKindOf westSoldierBaseClass) then {_side = west};
	if (_origin isKindOf eastSoldierBaseClass) then {_side = east};
} else {
	_side = side _origin;
};

if (baseFrendlyFire && (_sideBuilding == _side)) then { _dammages = 0 };

if (_dammages > 0 && paramBaseHuntingTimeout > 0 && (time < paramBaseHuntingTimeout * 60)) then {

	_dammages = 0;
	(vehicle _origin) setDamage 1;
	
	if (isPlayer _origin) then {
		_killerId = _origin Call GetClientID;
		_sideKiller = side _origin;
		
		_funds = ([_sideKiller, _killerId] Call GetClientTeam) Call GetTeamFunds;
		[ -_funds, _sideKiller,_killerId] Call ChangeClientFunds;
		
		WFBE_LocalizeMessage = [nil,'CLTFNCLOCALIZEMESSAGE',['BaseHuntingRestriction', name _origin]];
		publicVariable 'WFBE_LocalizeMessage';
		if (IsClientServer) then {[nil,'CLTFNCLOCALIZEMESSAGE',['BaseHuntingRestriction', name _origin]] Spawn HandlePVF};
	};
}; 
 

if (paramTrade && _dammages > 0) then {

	_lastDamageTime = _building getVariable '_lastDamageTime';
	if (isNil "_totalDamage") then {_totalDamage = 0};
	if (isNil "_lastDamageTime") then {_lastDamageTime = 0};
		
	_dT = time - _lastDamageTime;	
	if (_dT > 10 && _dammages > 0.05) then {
		["IsUnderAttack",TypeOf _building, _sideBuilding] Spawn SideMessage;
	};
	_building setVariable ['_lastDamageTime', time, false];

	_stones = [_building, marketProductIdStones] call marketGetProductValue;
	
	if (_stones != 0) then {
	
		_dammages  = _dammages * 100;
		_currentStones = _stones;

		if (_stones >= _dammages) then {
			_stones  = _stones - _dammages;
			_dammages = 0;
		};
	
		if ( _stones < _dammages) then {
			_dammages = _dammages - _stones;
			_stones = 0;		
		};
		
		_stones = floor(_stones);
		if (_stones < _currentStones) then {
			_delta = _currentStones - _stones;
			[_building, marketProductIdStones, -_delta] call marketUpdateProductValue;
		};		
		_dammages = _dammages / 100;
	};
};

PROFILER_END();
_dammages;