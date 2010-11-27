#include "profiler.h"
PROFILER_BEGIN("BuyUnit_OrderQueueProcessing");

	private['_dirty', '_u', '_i', '_orderInfo', "_order", "_team" ];

	//--- _orderId		  = _orderInfo select 0;
	//--- _productionTime = _orderInfo select 1;
	//--- _order	      = _orderInfo select 2;  	
	
	//--- _clientId = _order select 0;
	//--- _building = _order select 1;
	//--- _unitType = _order select 2; 
	//--- _side		= _order select 3; 
	//--- _team     = _order select 4; 
	//--- _vehInfo  = _order select 5;	
	
	_dirty = false;
	_u = count WBE_BuyUnit_OrderQueue;

	format["BuyUnit::QueueProcessing WBE_BuyUnit_OrderQueue Length=%1", _u] call LogHigh;	
	
	_i = 0;
	while { _u != 0 } do {
		_u = _u - 1;
		
		_orderInfo  = WBE_BuyUnit_OrderQueue select _i;
		if ( (_orderInfo call BuyUnit_OrderProcessing) ) then { 
		
			WBE_BuyUnit_OrderQueue set [_i, objNull ];
			
			_order = _orderInfo select 2; 
			_team  = _order select 4;
			
			_team setVariable ["canOrderUnit", 1];
			_dirty = true; 
		};
		_i = _i + 1;
	};
	
	if (_dirty) then {
		WBE_BuyUnit_OrderQueue = WBE_BuyUnit_OrderQueue - [ objNull ];
	};
PROFILER_END();