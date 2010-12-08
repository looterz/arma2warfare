#include "profiler.h"
PROFILER_BEGIN("BuyUnit_OrderProcessing");

private[ "_orderInfo", "_order", "_building", "_completed", "_orderId", "_team", "_factoryOrderId", "_productionTime", "_clientId" ];

	//--- _orderId		  = _orderInfo select 0;
	//--- _productionTime = _orderInfo select 1;
	//--- _order	      = _orderInfo select 2;  	
	
	//--- _clientId = _order select 0;
	//--- _building = _order select 1;
	//--- _unitType = _order select 2; 
	//--- _side		= _order select 3; 
	//--- _team     = _order select 4; 
	//--- _vehInfo  = _order select 5;	

	_orderInfo = _this;
	_order	   = _orderInfo select 2;
	
	_building = _order select 1;
	_completed = false;
	
	if ( (alive _building)  && !(isNull _building) ) then {

		_orderId  = _orderInfo select 0;
		_team     = _order select 4;
	
		_factoryOrderId = _building getVariable "orderId";
		if (_orderId == _factoryOrderId) then {
		
			_productionTime = _orderInfo select 1;
			
			if (_productionTime == 0) then {
			
				_productionTime = (_order) call BuyUnit_GetProductionTime;
				
				_clientId = _order select 0;
				if (WF_DEBUG && _clientId != CLIENTID_AI) then {
					_productionTime = time + 5;
				};
				
				_orderInfo set[1, _productionTime];
				if ( _productionTime != -1 ) then {	// if production will produced so notify player about this
					
					_unitType = _order select 2;
					[_clientId, BUYUNIT_RESPONSE_BUILDBEGIN, _unitType ] spawn BuyUnit_OrderResponse;
				};
			};
			
			if (_productionTime < time) then {
				(_orderInfo) spawn BuyUnit_BuildUnit;		
				
				_building setVariable["orderId", _orderId+1];	// set process next order
				(_building) spawn BuyUnit_UpdateOrderQueueStatus;
				_completed = true;
			};
		};
	} else {
		_completed = true;
	};
	
PROFILER_END();	
_completed;
