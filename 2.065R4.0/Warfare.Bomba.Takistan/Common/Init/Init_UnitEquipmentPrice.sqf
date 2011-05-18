#include "profiler.h"
PROFILER_BEGIN("Init_UnitEquipmentPrice");

"Init_UnitEquipmentPrice" call LogHigh;

if (isServer && !IsClientServer) exitWith {};

WBE_Equipment = (WF_Logic getVariable 'primaryClasses') + 
				(WF_Logic getVariable 'secondaryClasses') + 
				(WF_Logic getVariable 'sidearmClasses') + 
				(WF_Logic getVariable 'miscClasses') + 
				(WF_Logic getVariable 'magazineClasses');
	
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