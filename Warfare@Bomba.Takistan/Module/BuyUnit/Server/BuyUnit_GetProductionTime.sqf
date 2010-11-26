#include "profiler.h"
PROFILER_BEGIN("BuyUnit_GetProductionTime");

private['_order', "_clientId", "_building", "_unitType", "_team", "_productionTime", "_clientId2", "_buildTime" ];

	//--- _orderId		  = _orderInfo select 0;
	//--- _productionTime = _orderInfo select 1;
	//--- _order	      = _orderInfo select 2;  	
	
	//--- _clientId = _order select 0;
	//--- _building = _order select 1;
	//--- _unitType = _order select 2; 
	//--- _side		= _order select 3; 
	//--- _team     = _order select 4; 
	//--- _vehInfo  = _order select 5;	

	_order 	= _this;
	
	_clientId = _order select 0;
	_building = _order select 1;
	_unitType = _order select 2; 
	_team     = _order select 4;

	_productionTime = -1;
	
	if ( (alive _building) && !(isNull _building) ) then {

		_clientId2 = if (isPlayer(leader _team)) then { getPlayerUID (leader _team) } else { WBE_NETSEND_CLIENTID_AI };
		if (_clientId == _clientId2) then {

			_buildTime = (_unitType Call GetNamespace) select QUERYUNITTIME;
			_productionTime = time + _buildTime;
		};
	};
	
PROFILER_END();	
_productionTime;
	
