#include "profiler.h"
PROFILER_BEGIN("BuyUnit_OrderCancel");

Private ["_building","_built","_cpt","_commander","_crew","_currentUnit","_description","_direction","_distance","_driver","_factoryType","_group","_gunner","_index","_isMan","_locked","_longest","_position","_queu","_queu2","_ret","_soldier","_waitTime","_type","_unique","_unitType","_vehi","_vehicle","_vehicles"];

	waitUntil { !isNil "initJIP" };

	//--- _clientId = _order select 0;
	//--- _building = _order select 1;
	//--- _unitType = _order select 2; 
	//--- _side	  	= _order select 3; 
	//--- _team     = _order select 4; 
	//--- _vehInfo  = _order select 5; 

	_order 	 = _this;

	_unitType = _order select 2;
	_vehInfo  = _order select 5;
	
	if ( (count _vehInfo) > 0 ) then {  if (_vehInfo select 0) then { unitQueu = unitQueu - 1; }; };	//-- buy crew driver
	if ( (count _vehInfo) > 1 ) then {  if (_vehInfo select 1) then { unitQueu = unitQueu - 1; }; };	//-- buy crew gunner
	if ( (count _vehInfo) > 2 ) then {  if (_vehInfo select 2) then { unitQueu = unitQueu - 1; }; };	//-- buy crew commander;
	if (_unitType isKindOf "Man") then { unitQueu = unitQueu - 1; };	//-- buy soldier
	
	if (unitQueu < 0) then { unitQueu = 0; };	//-- just fix errors with unit queue;
	
PROFILER_END();	