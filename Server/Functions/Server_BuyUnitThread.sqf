#include "profiler.h"

WBE_BuyUnitQueue = [];

_fnProcessBuyUnitQueue = {
private['_u', '_dirty', '_queueItem', '_ticketId', '_building', '_openTicketId', '_timeout', '_unitData', '_unitType', '_buildTime', '_team'];
PROFILER_BEGIN("Server_BuyUnitThread::ProcessBuyUnitQueue");

	_dirty = false;
	_u = count WBE_BuyUnitQueue;

	format["ProcessBuyUnitQueue: WBE_BuyUnitQueue.Count=%1", (count WBE_BuyUnitQueue)] call LogHigh;	
	
	while { _u != 0 } do {
		_u = _u - 1;
		
		_queueItem  = WBE_BuyUnitQueue select _u;
		_ticketId = _queueItem select 0;
		_building = _queueItem select 1;
		_unitData = _queueItem select 3;
		
		_team = _unitData select 4;		
		
		if ( (alive _building)  && !(isNull _building) ) then {
			_openTicketId = _building getVariable "buyUnitOpenTicketId";
			if (_openTicketId == _ticketId) then {
			
				_timeout = _queueItem select 2;
				
				if (_timeout == 0) then {

					_unitType = _unitData select 2;
					_buildTime = (_unitType Call GetNamespace) select QUERYUNITTIME;
					
					if ( (alive _building) && !(isNull _building) && !(isPlayer(leader _team))) then { 
						_timeout = time + _buildTime;  
					} else {
						_timeout = -1;	// don't build anything: buiding is dead or unit is player;
					};
					
					_queueItem set[2, _timeout];				
				};
				
				if (_timeout < time) then {
					
					if (_timeout > 0) then { _unitData spawn BuyUnitCreateUnit;	};
					_building setVariable ["buyUnitOpenTicketId", (_openTicketId + 1), true];
					WBE_BuyUnitQueue set [_u, objNull ];
					
					_team setVariable ["canOrderUnit", 1];
					_dirty = true;
				};
			};
		} else {
			WBE_BuyUnitQueue set [_u, objNull ];
			
			_team setVariable ["canOrderUnit", 1];
			_dirty = true;
		};
	};
	
	if (_dirty) then {
		WBE_BuyUnitQueue = WBE_BuyUnitQueue - [ objNull ];
	};
PROFILER_END();
};

while { !gameOver } do {
	sleep 10;
	[] call _fnProcessBuyUnitQueue;
};
