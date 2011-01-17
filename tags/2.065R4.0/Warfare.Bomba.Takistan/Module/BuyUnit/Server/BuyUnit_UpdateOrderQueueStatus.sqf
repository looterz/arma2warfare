#include "profiler.h"
PROFILER_BEGIN("BuyUnit_OrderQueueStatusUpdate");

private['_building', '_orderId', '_nextOrderId', '_newOrderQueue', "_orderQueue" ];
	
	_building = _this;

	_orderId = _building getVariable "orderId";
	if (isNil "_orderId") then { 
		_orderId = 0;
		_building setVariable["orderId", _orderId];
	};

	_nextOrderId = _building getVariable "nextOrderId";
	if (isNil "_nextOrderId") then { _nextOrderId = 0; };

	_newOrderQueue = _nextOrderId - _orderId;
	
	_orderQueue = _building getVariable "orderQueue";
	if (isNil "orderQueue") then { 
		_orderQueue = -1; 
	};
	
	if (_newOrderQueue != _orderQueue) then {
		_building setVariable["orderQueue", _newOrderQueue, true];
	};

PROFILER_END();