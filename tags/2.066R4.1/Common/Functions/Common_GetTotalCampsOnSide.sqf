#include "profiler.h"
PROFILER_BEGIN("Common_GetTotalCampsOnSide");

Private["_camps","_side","_sideID","_total","_town"];

_town = _this select 0;
_side = _this select 1;

_sideID = _side Call GetSideID;

_camps = _town getVariable "camps";
if (isNil '_camps') exitWith {1};
_total = 0;

{if ((_x getVariable "sideID") == _sideID) then {_total = _total + 1}} forEach _camps;

PROFILER_END();
_total;