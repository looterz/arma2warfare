#include "profiler.h"
PROFILER_BEGIN("BuyUnit_OrderRegister");

private['_order', '_clientId', '_building', '_orderId', '_orderInfo'];
	
	//--- _orderId		  = _orderInfo select 0;
	//--- _productionTime = _orderInfo select 1;
	//--- _order	      = _orderInfo select 2;  	
	
	//--- _clientId = _order select 0;
	//--- _building = _order select 1;
	//--- _unitType = _order select 2; 
	//--- _side		= _order select 3; 
	//--- _team     = _order select 4; 
	//--- _vehInfo  = _order select 5;
	
	format["BuyUnit_OrderRegister: this=%1", _this] call LogHigh;

	_order = _this;	
	
	_clientId = _order select 0;
	_building = _order select 1;

	waitUntil { !(isNil "WBE_BuyUnit_OrderQueueOperation") };

	// initialize current orderId
	_orderId = _building getVariable "orderId";
	if (isNil "_orderId") then { 
		_orderId = 0;
		_building setVariable["orderId", _orderId];
	};
	
	_orderId = _building getVariable "nextOrderId";
	if (isNil "_orderId") then { _orderId = 0; };
	
	_building setVariable["nextOrderId", _orderId + 1];
	(_building) spawn BuyUnit_UpdateOrderQueueStatus;
	
	WBE_BuyUnit_OrderQueueOperation = WBE_BuyUnit_OrderQueueOperation + [ [_orderId, 0, _order] ];

	[_clientId, BUYUNIT_MSGID_ORDERACCEPTED, (_order select 2) ] spawn BuyUnit_OrderResponse;
	format["BuyUnit_OrderRegister: Order#%1, %2", _orderId, _order] call LogHigh;
	
PROFILER_END();