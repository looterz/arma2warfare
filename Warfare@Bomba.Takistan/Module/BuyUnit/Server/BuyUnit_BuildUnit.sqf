#include "profiler.h"
PROFILER_BEGIN("BuyUnit_BuildUnit");

private['_orderInfo', '_order', '_team', '_unitData', '_productionTime', '_clientId', '_teamClientId', '_unitCreated', '_responseData'];

	//--- _orderId		  = _orderInfo select 0;
	//--- _productionTime = _orderInfo select 1;
	//--- _order	      = _orderInfo select 2;  	
	
	//--- _clientId = _order select 0;
	//--- _building = _order select 1;
	//--- _unitType = _order select 2; 
	//--- _side		= _order select 3; 
	//--- _team     = _order select 4; 
	//--- _vehInfo  = _order select 5;	
	
	_orderInfo 	= _this;

	_productionTime = _orderInfo select 1;
	_order	    	= _orderInfo select 2;
	
	_clientId = _order select 0;
	_team     = _order select 4;
	
	_teamClientId = if (isPlayer(leader _team)) then { getPlayerUID (leader _team) } else { WBE_NETSEND_CLIENTID_AI };
	
	if ( !(_clientId == _teamClientId) ) exitWith {
		format["BuyUnit_BuildUnit cancelled: Different clientId '%1' -neq '%2'", _clientId, _teamClientId] call LogHigh;
		PROFILER_END();
	};
	
	if (_productionTime == -1) exitWith {
	
		format["BuyUnit_BuildUnit cancelled: Timeout=-1"] call LogHigh;
		[_clientId, BUYUNIT_RESPONSE_ORDERCANCEL, [_order] ] spawn BuyUnit_OrderResponse;				
		PROFILER_END();
	};
		
	_unitCreated = _order call BuyUnit_CreateUnit;
	_responseData = [_order, _unitCreated ];
	[_clientId, BUYUNIT_RESPONSE_ORDERCOMPLETED, _responseData] spawn BuyUnit_OrderResponse;
	
PROFILER_END();
