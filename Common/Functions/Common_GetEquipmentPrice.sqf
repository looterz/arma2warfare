#include "profiler.h"
PROFILER_BEGIN("Common_GetEquipmentPrice");

private['_equipmentPrice', '_unitId','_unitEquipment', '_index', '_unit'];

_unit = _this;

if (isNil 'WBE_Equipment') then {

	WBE_Equipment = (WF_Logic getVariable 'primaryClasses') + (WF_Logic getVariable 'secondaryClasses') + (WF_Logic getVariable 'sidearmClasses') + (WF_Logic getVariable 'miscClasses') + (WF_Logic getVariable 'magazineClasses');

	WBE_EquipmentPrice = (WF_Logic getVariable 'primaryCosts') + ( WF_Logic getVariable 'secondaryCosts') + (WF_Logic getVariable 'sidearmCosts') + ( WF_Logic getVariable 'miscCosts') + (WF_Logic getVariable 'magazineCosts');
	
	WBE_UnitEquipment = [];
	WBE_UnitEquipmentPrice = [];
};

_equipmentPrice = 0;
_unitId = WBE_UnitEquipment find _this;
if (_unitId == -1) then {

	_unitEquipment = (getArray (configFile >> "CfgVehicles" >> _unit >> "weapons")) + (getArray (configFile >> "CfgVehicles" >> _unit >> "magazines"));

	{
		_index = WBE_Equipment find _x;
		if (_index != -1) then {
			_equipmentPrice = _equipmentPrice + (WBE_EquipmentPrice select _index);
		};

	} forEach _unitEquipment;
	
	WBE_UnitEquipment = WBE_UnitEquipment + [_unit];
	WBE_UnitEquipmentPrice = WBE_UnitEquipmentPrice + [_equipmentPrice];
} else {
	_equipmentPrice = WBE_UnitEquipmentPrice select _unitId;
};

PROFILER_END();
_equipmentPrice;