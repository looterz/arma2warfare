#include "profiler.h"

CLIENTID_AI = "AI";

[] call compile preprocessFile "Module\NetSend\NetSend_InitService.sqf";
[] call compile preprocessFile "Module\BuyUnit\BuyUnit_InitService.sqf";

if (paramTrade) then {
	[] call compile preprocessFile "Module\Market\Init_Market.sqf";
};

"Init Modules - [Done]" call LogMedium;

