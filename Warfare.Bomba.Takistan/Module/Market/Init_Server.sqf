#include "profiler.h"
PROFILER_BEGIN("Market_InitServer");

private['_isinited'];

_isInited = WF_Logic getVariable "marketInitialized";
if (isNil "_isInited") then { _isInited = 0; };

if  (_isInited == 1) exitWith {};

if (!paramTrade) exitWith {
	"Initialization Market :: Marketing are disabled by game settings"  call LogMedium;
};

"Initialization Market :: Wait town inited"  call LogHigh;
waitUntil {townInit};

{
	format["Market town initialization: %1", _x]  call LogHigh;
	_x call marketInitMarketStorage;

} forEach towns;

WF_Logic setVariable ["marketInitialized", 1, true];
"Initialization Market - Done" call LogMedium;

execVM "Module\Market\Server\ServerTrade.sqf";

PROFILER_END();

