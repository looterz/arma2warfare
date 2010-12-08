#include "profiler.h"
PROFILER_BEGIN("BuyUnit_OrderCreate");
	private['_unitType', '_team', '_order', '_clientId', '_vehInfo', '_args' ];
	
	//--- _clientId = _order select 0;
	//--- _building = _order select 1;
	//--- _unitType = _order select 2; 
	//--- _side		= _order select 3; 
	//--- _team     = _order select 4; 
	//--- _vehInfo  = _order select 5;

	_order = _this;
	
	_unitType = _order select 2; 
	_team     = _order select 4;
	_vehInfo  = _order select 5;
	
	_clientId = if (isPlayer(leader _team)) then { getPlayerUID (leader _team) } else { CLIENTID_AI };
	_order set [0, _clientId];
	
	if ( _clientId != CLIENTID_AI ) then {
		
		_args = count _vehInfo;
		if ( _args > 0 ) then {  if (_vehInfo select 0) then { unitQueu = unitQueu + 1; }; };	//-- buy crew driver
		if ( _args > 1 ) then {  if (_vehInfo select 1) then { unitQueu = unitQueu + 1; }; };	//-- buy crew gunner
		if ( _args > 2 ) then {  if (_vehInfo select 2) then { unitQueu = unitQueu + 1; }; };	//-- buy crew commander;
		if (_unitType isKindOf "Man") then { unitQueu = unitQueu + 1; };	//-- buy soldier
	};
	
	[NETSEND_MSGID_BUYUNIT, _order] spawn NetSend_ToServer;	
	Format["BuyUnit_OrderCreate: Team %1 create order to '%2': %3", _team, _unitType, _order] call LogInform;

PROFILER_END();
