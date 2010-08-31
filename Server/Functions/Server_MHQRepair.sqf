Private ["_hq","_HQName","_MHQ","_side","_sideText"];
_side = _this select 0;
_sideText = str _side;

_hq = WF_Logic getVariable Format ["%1MHQ",_sideText];
_position = getPos _hq;
_direction = getDir _hq;

_commanderTeam = (_side) Call GetCommanderTeam;
if (!isNull _commanderTeam) then {
	_commanderID = (Leader _commanderTeam) Call GetClientID;
	[_side,_commanderID,CMDSETHQSTATUS,false] Spawn CommandToClient;
};

sleep 15;

_HQName = Format["WFBE_%1MHQNAME",_sideText] Call GetNamespace;
_MHQ = _HQName createVehicle _position;

WF_Logic setVariable [Format["%1MHQ",_sideText],_MHQ,true];
WF_Logic setVariable [Format["%1MHQDeployed",_sideText],false,true];

_MHQ setDir _direction;
_MHQ setVelocity [0,0,-1];

Call Compile Format ["_MHQ AddEventHandler ['killed',{[_this select 0,_this select 1,%1,'%2'] Spawn HQKilled}];",_side,typeOf _MHQ];
	
_MHQ setVehicleInit Format["['Headquarters','ColorGreen',[1,1],'','HQUndeployed',this,0.2,false,'','',false,%1] ExecVM 'Common\Common_MarkerUpdate.sqf'",_side];
processInitCommands;
	
deleteVehicle _hq;

WF_Logic setVariable [Format ["%1MHQRepair",_sideText],false,true];