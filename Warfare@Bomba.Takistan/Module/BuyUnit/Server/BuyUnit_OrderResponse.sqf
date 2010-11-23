#include "profiler.h"
PROFILER_BEGIN("BuyUnit_OrderResponse");

private['_clientId', '_responseType', '_responseData'];

	_clientId      = _this select 0; 
	_responseType  = _this select 1; 
	_responseData  = _this select 2;	
	
	if (_clientId == "AI") exitWith {
		
		PROFILER_END();	
	};
	
	WBE_BUYUNIT_RESPONSE = [_clientId, _responseType, _responseData];
	publicVariable "WBE_BUYUNIT_RESPONSE";
	if (IsClientServer) then { (WBE_BUYUNIT_RESPONSE) spawn BuyUnit_OrderResponseHandle;  };				
	
PROFILER_END();
