#include "profiler.h"
PROFILER_BEGIN("Init_UnitEquipmentPrice");

"Init_UnitEquipmentPrice" call LogHigh;

if (isServer && !(local player)) exitWith {};

LoadEquipmentClass = {
private['_data', '_className', '_array'];

	_className = _this select 0;
	_array = _this select 1;

	format["Init_UnitEquipmentPrice: LoadEquipmentClass %1", _className] call LogHigh;	
	
	_data = WF_Logic getVariable _className;
	while { isNil "_data" } do {
		_data = WF_Logic getVariable _className;
		if ( !(isNil "_data") ) then {
			if (isNull _data) then { _data = nil; };			
		};
	};
	
	_array = _array + _data;
};

WBE_Equipment = [];
['primaryClasses', WBE_Equipment] 	call LoadEquipmentClass;
['secondaryClasses', WBE_Equipment] call LoadEquipmentClass;
['sidearmClasses', WBE_Equipment] 	call LoadEquipmentClass;
['miscClasses', WBE_Equipment] 		call LoadEquipmentClass;
['magazineClasses', WBE_Equipment] 	call LoadEquipmentClass;

WBE_EquipmentPrice = [];
	
{
	_get = _x Call GetNamespace;
	_cost = (_get Select QUERYGEARCOST);
	WBE_EquipmentPrice = WBE_EquipmentPrice + [_cost];
} forEach WBE_Equipment;

	
WBE_UnitEquipment = [];
WBE_UnitEquipmentPrice = [];

initUnitEquipmentPrice = true;

InitEquipmentPriceData = {

	"InitEquipmentPriceData - Begin" call LogHigh;

	{  _x call GetUnitEquipmentPrice; } forEach ("WFBE_WESTBARRACKSUNITS" Call GetNamespace);
	{  _x call GetUnitEquipmentPrice; } forEach ("WFBE_EASTBARRACKSUNITS" Call GetNamespace);
	
	"InitEquipmentPriceData - [Done]" call LogHigh;
};

[] spawn InitEquipmentPriceData;

"Init_UnitEquipmentPrice - [Done]" call LogMedium;
PROFILER_END();