#include "profiler.h"
PROFILER_BEGIN("Server_BuyUnit");

Private ["_building", "_openTicketId", "_ticketId"];
_building = _this select 1;

Format["Server_BuyUnit: AI Team %1 has purchased a '%2'",_team,_unitType] call LogInform;

waitUntil { !(isNil "WBE_BuyUnitQueue") };

_openTicketId = _building getVariable "buyUnitOpenTicketId";
if (isNil "_openTicketId") then { 
	_openTicketId = 0;
	_building setVariable["buyUnitOpenTicketId", _openTicketId, true];
};

_ticketId = _building getVariable "buyUnitNextTicketId";
if (isNil "_ticketId") then { _ticketId = 0; };

_building setVariable["buyUnitNextTicketId", _ticketId + 1, true];

WBE_BuyUnitQueue = WBE_BuyUnitQueue + [ [_ticketId, _building, 0, _this] ];

PROFILER_END();