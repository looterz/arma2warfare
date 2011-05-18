#include "profiler.h"
PROFILER_BEGIN("Server_SetCampsToSide");

Private["_camp","_camps","_u","_notifyAllSides","_objects","_previousSide","_side","_sideID","_startingSV","_town"];

_town = _this Select 0;
_side = _this Select 1;
_previousSide = _this Select 2;

_sideID = _side Call GetSideID;
_camps = _town getVariable "camps";
_startingSV = _town getVariable "supplyValue";

_u = count _camps;
_texture = Format["WFBE_%1FLAG",str _side] Call GetNamespace;

while { !(_u == 0) } do {
	_u = _u - 1;
	_camp = _camps Select _u;
	_camp setVariable ["sideID",_sideID,true];
	_camp setVariable ["supplyValue",_startingSV,true];

	_objects = _camp nearEntities[[WFFLAG],20];
	if (count _objects != 0) then {(_objects Select 0) setFlagTexture _texture};
};

sleep 0.5;

_notifyAllSides = (_previousSide == East || _previousSide == West);

WFBE_AllCampsCaptured = [nil,'CLTFNCALLCAMPSCAPTURED',[_town,_sideID,_notifyAllSides]];
publicVariable 'WFBE_AllCampsCaptured';
if (IsClientServer) then {[nil,'CLTFNCALLCAMPSCAPTURED',[_town,_sideID,_notifyAllSides]] Spawn HandlePVF};

Format["Server_SetCampsToSide: '%1' Camps have been set to %2",_town,str _side]  call LogInform;
PROFILER_END();