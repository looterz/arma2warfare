#include "profiler.h"
PROFILER_BEGIN("BuyUnit_OrderResponseHandle");

private['_clientId', '_unitData', '_response', '_order', '_data', '_unitType', '_description', '_txt', '_vehicle' ];
	
	//--- _clientId     = _this select 0;
	//--- _responseType = _this select 1;
	//--- _responseData = _this select 2;
	
	
	//--- _clientId = _order select 0;
	//--- _building = _order select 1;
	//--- _unitType = _order select 2; 
	//--- _side	    = _order select 3; 
	//--- _team     = _order select 4; 
	//--- _vehInfo  = _order select 5; 	
	
	_clientId = _this select 0;
	
	if ( !(_clientId == BuyUnit_ClientId) ) exitWith {
		PROFILER_END();	
	};

	_response  = _this select 1;
	_data      = _this select 2;

	_order = _data select 0;
	_unitType = _order select 2;
	_description = (_unitType Call GetNamespace) select QUERYUNITLABEL;	
	
	if (_response == BUYUNIT_RESPONSE_ORDERACCEPTED) exitWith {
		
		_txt = parseText(Format [localize "STR_WF_Queu",_description]);
		hint _txt;
		PROFILER_END();	
	};	
	
	if (_response == BUYUNIT_RESPONSE_BUILDBEGIN) exitWith {
	
		_txt = parseText(Format [localize "STR_WF_BuyEffective",_description]);
		hint _txt;
		PROFILER_END();	
	};

	if (_response == BUYUNIT_RESPONSE_ORDERCOMPLETED) exitWith {
		
		_vehicle = _data select 1;
		[_order, _vehicle] spawn BuyUnit_OrderComplete;
		
		_txt = parseText(Format [localize "STR_WF_Build_Complete",_description]);
		hint _txt;		
		PROFILER_END();	
	};	
	
	format["BuyUnit_OrderResponseHandle: Unknown response code. Data=%1", _this] call LogError;

	
PROFILER_END();