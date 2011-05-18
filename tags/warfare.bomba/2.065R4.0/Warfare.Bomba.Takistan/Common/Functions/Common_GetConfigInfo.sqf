#include "profiler.h"
PROFILER_BEGIN("Common_GetConfigInfo");

Private ['_element','_object', '_value'];
_object = _this select 0;
_element = _this select 1;
_from = if (count _this > 2) then {_this select 2} else {'CfgVehicles'};

if (typeName _object == 'OBJECT') then {_object = typeOf(_object)};

_value = getText (configFile >> _from >> _object >> _element);

PROFILER_END();
if (!isNil "_value") exitWith { _value; };