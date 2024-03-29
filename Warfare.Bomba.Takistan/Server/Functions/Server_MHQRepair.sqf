#include "profiler.h"
PROFILER_BEGIN("Server_MHQRepair");

private['_hq','_HQName','_MHQ','_side','_sideText','_commanderteam','_commanderid','_position','_direction'];
_side = _this select 0;
_sideText = str _side;

_hq = (_sideText) Call GetSideHQ;
_position = getPos _hq;
_direction = getDir _hq;

_commanderTeam = (_side) Call GetCommanderTeam;
if !(isNull _commanderTeam) then {
	_commanderID = (Leader _commanderTeam) Call GetClientID;
	WFBE_SetHQStatus = [[_commanderID,_side],'CLTFNCSETHQSTATUS',false];
	publicVariable 'WFBE_SetHQStatus';
	if (IsClientServer) then {[[_commanderID,_side],'CLTFNCSETHQSTATUS',false] Spawn HandlePVF};
};

sleep 15;

_HQName = Format["WFBE_%1MHQNAME",_sideText] Call GetNamespace;
_MHQ = _HQName createVehicle _position;

Call Compile Format ["%1MHQ = _MHQ; publicVariable '%1MHQ';",_sideText];

_MHQ setDir _direction;
_MHQ setVelocity [0,0,-1];

Call Compile Format ["_MHQ AddEventHandler ['killed',{[_this select 0,_this select 1,%1,'%2'] Spawn HQKilled}];",_side,typeOf _MHQ];
	
_MHQ setVehicleInit Format["['Headquarters','ColorGreen',[1,1],'','HQUndeployed',this,0.2,false,'','',false,%1] ExecVM 'Common\Common_MarkerUpdate.sqf'",_side];
processInitCommands;
	
deleteVehicle _hq;

Call Compile Format ["%1MHQDeployed = false; publicVariable '%1MHQDeployed';",_sideText];

Format["Server_MHQRepair: The %1 MHQ was repaired.",_sideText]  call LogInform;

PROFILER_END();