#include "profiler.h"
PROFILER_BEGIN("Server_ConstructionHQSite");

private['_deployed','_direction','_HQ','_position','_side','_sideText','_site','_varTH','_mhq','_type','_update','_areas','_near','_logic','_hqname','_grp'];
_type = _this select 0;
_side = _this select 1;
_position = _this select 2;
_direction = _this select 3;
_sideText = _side;

/* Handle the LAG. */
_varTH = format['WF_CHQInUse_%1',_sideText];
waitUntil {!(WF_Logic getVariable _varTH)};
WF_Logic setVariable [_varTH,true];

_HQ = (_sideText) Call GetSideHQ;
_deployed = (_sideText) Call GetSideHQDeployed;

if (!_deployed) then {
	_HQ setPos [1,1,1];
	
	_site = _type CreateVehicle _position;
	_site SetDir _direction;
	_site SetPos _position;
	
	Call Compile Format ["%1MHQ = _site; %1MHQDeployed = true; publicVariable '%1MHQ'; publicVariable '%1MHQDeployed';",_sideText];
	
	_site setVehicleInit Format["[this,true,%1] ExecVM 'Client\Init\Init_BaseStructure.sqf'",_side];
	processInitCommands;
	
	["Constructed",_type,_side] Spawn SideMessage;
	Call Compile Format ["_site addEventHandler ['killed',{[_this select 0,_this select 1,%1,'%2'] Spawn HQKilled}];",_side,typeOf _site];
	_site addEventHandler ["hit",{_this Spawn BuildingDamaged}];
	if (paramHandleFF) then {Call Compile Format ["_site addEventHandler ['handleDamage',{[_this select 0,_this select 2,_this select 3, %1] Call BuildingHandleDamages}]",_side]};
	
	//--- base area limits.
	if (paramBaseArea) then {
		_update = true;
		_areas = WF_Logic getVariable Format['%1Area',_sideText];
		_near = [_position,_areas] Call SortByDistance;
		if (count _near > 0) then {
			if ((_near select 0) distance _position < (('WFBE_BASEAREARANGE' Call GetNamespace) + ('WFBE_MHQBUILDINGRANGE' Call GetNamespace))) then {_update = false};
		};
		if (_update) then {
			_grp = createGroup sideLogic;
			_logic = _grp createUnit ["Logic",[0,0,0],[],0,"NONE"];
			_logic setPos _position;
			WF_Logic setVariable [Format['%1Area',_sideText],_areas + [_logic],true];
		};
	};
	
	Format["Construction_HQSite: The %1 MHQ (%2) was deployed",_sideText,_type] call LogInform;
	
	deleteVehicle _HQ;
} else {
	_position = getPos _HQ;
	_direction = getDir _HQ;
	_HQName = Format["WFBE_%1MHQNAME",_sideText] Call GetNamespace;

	_HQ SetPos [1,1,1];
	
	_MHQ = _HQName createVehicle _position;

	Call Compile Format ["%1MHQ = _MHQ; %1MHQDeployed = false; publicVariable '%1MHQ'; publicVariable '%1MHQDeployed';",_sideText];

	_MHQ setDir _direction;
	_MHQ setVelocity [0,0,-1];
	
	["Constructed",_HQName,_side] Spawn SideMessage;
	Call Compile Format ["_MHQ AddEventHandler [""killed"",{[_this select 0,_this select 1,%1,'%2'] Spawn HQKilled}];",_side,typeOf _MHQ];
	if (paramHandleFF) then {Call Compile Format ["_MHQ addEventHandler ['handleDamage',{[_this select 0,_this select 2,_this select 3, %1] Call BuildingHandleDamages}]",_side]};
	
	_MHQ setVehicleInit Format["['Headquarters','ColorGreen',[1,1],'','HQUndeployed',this,0.2,false,'','',false,%1] ExecVM 'Common\Common_MarkerUpdate.sqf';",_side];
	processInitCommands;
	
	Format["Construction_HQSite: The %1 MHQ (%2) was mobilized",_sideText,_HQName] call LogInform;
	
	deleteVehicle _HQ;
};

/* Handle the LAG. */
WF_Logic setVariable [_varTH,false];

PROFILER_END();