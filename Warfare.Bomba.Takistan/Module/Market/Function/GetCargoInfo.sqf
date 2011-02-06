#include "profiler.h"
PROFILER_BEGIN("Market_GetCargoInfo");

private["_cargo", "_crew", "_u", "_count", "_crewman", "_hq", "_cargoFreeSpace", "_cargoUnitType", "_found", "_vehType", "_type", "_cargoSU", "_cargoFreeSpaceSU", "_cargoMaxSpaceSU", "_cargoItems", "_pid", "_su" ];

	_cargo = _this;

	if (_cargo != player) then {

		_crew = crew _cargo;
		_u = 0;
		_count = 0;
		while { _u < count _crew } do {
		
			_crewman = _crew select _u;
			if (_crewman != player && (isPlayer _crewman)) then { _count = _count +1; };		
			_u = _u +1;		
		};
		
		if (_count != 0) then { _cargo = player; };	
	};

	_hq = (sideJoinedText) Call GetSideHQ;
	if (_cargo == _hq) then { _cargo = player; };
	
	_cargoFreeSpace = 0;
	_cargoUnitType = "kg";

	_u = (count marketTransportVehicleTypes);
	_found = false;
	while { _u != 0 } do {
		_u = _u - 1;

		_vehType = marketTransportVehicleTypes select _u;
		
		_type = _vehType select 0;
		if (_cargo isKindOf _type) then {
		
			_cargoFreeSpace = _vehType select 1;
			_cargoUnitType   = _vehType select 2;
			_u = 0;
		};	
	};

	_cargoSU    = ["", _cargoUnitType,  0, 0, 0, 1] call marketGetSU;
	_cargoMaxSpaceSU = _cargoFreeSpace * _cargoSU;
	
	_cargoFreeSpaceSU = _cargoMaxSpaceSU;
	_cargoItems = (_cargo) call marketGetContainerItems;

	_u = 0;
	{ 
		_pid = marketProductCollection select _u;
		_su =  (_pid) call marketGetSU;
		_cargoFreeSpaceSU = _cargoFreeSpaceSU - (_x * _su); 
		_u = _u+1;
	} forEach _cargoItems;
	if (_cargoFreeSpaceSU < 0) then { _cargoFreeSpaceSU = 0; };	

PROFILER_END();
[_cargo, _cargoItems, _cargoMaxSpaceSU, _cargoFreeSpaceSU, _cargoSU, _cargoUnitType];