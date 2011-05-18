#include "profiler.h"
PROFILER_BEGIN("Common_GetPositionFrom");

Private["_destination","_distance","_direction","_position", "_value"];

_position = _this Select 0;
if (typeName _position != "ARRAY") then {_position = position _position};

_distance = _this Select 1;

_direction = _this Select 2;
if (typeName _direction != "SCALAR") then {_direction = [_position,_direction] Call GetDirTo};

_value = [(_position Select 0)+((sin _direction)*_distance),(_position Select 1)+((cos _direction)*_distance),(_position Select 2)];

PROFILER_END();
_value;