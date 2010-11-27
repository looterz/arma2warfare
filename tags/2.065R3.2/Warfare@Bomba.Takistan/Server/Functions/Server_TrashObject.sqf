/* 
	Author: Benny
	Name: Server_TrashObject.sqf
	Parameters:
	  0 - Object
	Description:
	  This function will remove an object after the defined amount of time.
*/

#include "profiler.h"
PROFILER_BEGIN("Server_TrashObject");

Private ["_alive","_group","_isMan","_object"];
_object = _this;

if (isNil "_object") exitWith { PROFILER_END(); };
if (isNull _object)  exitWith { PROFILER_END(); };

waitUntil { !(isNil "WBE_TrashObjectCollection") };

if ( !(_object in WBE_TrashObjectCollectionQueu) ) then {
	WBE_TrashObjectCollectionQueu = WBE_TrashObjectCollectionQueu + [_object];
	WBE_TrashObjectCollection = WBE_TrashObjectCollection + [ [_object, 0, 0] ];
};

PROFILER_END();