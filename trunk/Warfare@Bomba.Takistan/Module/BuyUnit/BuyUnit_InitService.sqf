#include "profiler.h"

BUYUNIT_RESPONSE_ORDERACCEPTED  = 1;
BUYUNIT_RESPONSE_BUILDBEGIN     = 2;
BUYUNIT_RESPONSE_ORDERCOMPLETED = 3;
BUYUNIT_RESPONSE_ORDERCANCEL    = 4;

WBE_BUYUNIT_REQUEST  = objNull;
WBE_BUYUNIT_RESPONSE = objNull;

if (local player) then {

	BuyUnit_GetOrderQueueStatus = Compile preprocessFile "Module\BuyUnit\Client\BuyUnit_GetOrderQueueStatus.sqf";

	BuyUnit_OrderCreate   = Compile preprocessFile "Module\BuyUnit\Client\BuyUnit_OrderCreate.sqf";
	BuyUnit_OrderComplete = Compile preprocessFile "Module\BuyUnit\Client\BuyUnit_OrderComplete.sqf";
	BuyUnit_OrderCancel   = Compile preprocessFile "Module\BuyUnit\Client\BuyUnit_OrderCancel.sqf";
	
	BuyUnit_OrderResponseHandle = Compile preprocessFile "Module\BuyUnit\Client\BuyUnit_OrderResponseHandle.sqf";

	BuyUnit_ClientId = getPlayerUID player;
	"WBE_BUYUNIT_RESPONSE" addPublicVariableEventHandler {(_this select 1) spawn BuyUnit_OrderResponseHandle; };
};

if (isServer) then {
	WBE_BuyUnit_OrderQueue = [];
	
	BuyUnit_OrderQueueProcessing = Compile preprocessFile "Module\BuyUnit\Server\BuyUnit_OrderQueueProcessing.sqf";
	BuyUnit_OrderProcessing = Compile preprocessFile "Module\BuyUnit\Server\BuyUnit_OrderProcessing.sqf";
	BuyUnit_OrderRegister = Compile preprocessFile "Module\BuyUnit\Server\BuyUnit_OrderRegister.sqf";
	BuyUnit_OrderResponse = Compile preprocessFile "Module\BuyUnit\Server\BuyUnit_OrderResponse.sqf";
	
	BuyUnit_GetProductionTime = Compile preprocessFile "Module\BuyUnit\Server\BuyUnit_GetProductionTime.sqf";
	BuyUnit_BuildUnit = Compile preprocessFile "Module\BuyUnit\Server\BuyUnit_BuildUnit.sqf";
	BuyUnit_CreateUnit = Compile preprocessFile "Module\BuyUnit\Server\BuyUnit_CreateUnit.sqf";
	
	BuyUnit_UpdateOrderQueueStatus = Compile preprocessFile "Module\BuyUnit\Server\BuyUnit_UpdateOrderQueueStatus.sqf";
	
	"WBE_BUYUNIT_REQUEST" addPublicVariableEventHandler {(_this select 1) spawn BuyUnit_OrderRegister; };	
	
	// start service thread
	ExecVM "Module\BuyUnit\Server\BuyUnit_Service.sqf";
};

"BuyUnit_InitService - [Done]" call LogMedium;

