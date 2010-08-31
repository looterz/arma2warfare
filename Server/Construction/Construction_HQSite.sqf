Private ["_deployed","_direction","_HQ","_position","_side","_site","_varTH"];
_type = _this select 0;
_side = _this select 1;
_position = _this select 2;
_direction = _this select 3;

/* Handle the LAG. */
_varTH = format['WF_CHQInUse_%1',str _side];
waitUntil {!(WF_Logic getVariable _varTH)};
WF_Logic setVariable [_varTH,true];

_HQ = WF_Logic getVariable Format ["%1MHQ",str _side];
_deployed = WF_Logic getVariable Format ["%1MHQDeployed",str _side];

if (!_deployed) then {
	_HQ setPos [1,1,1];
	
	_site = _type CreateVehicle _position;
	_site SetDir _direction;
	_site SetPos _position;
	
	WF_Logic setVariable [Format["%1MHQ",str _side],_site,true];
	WF_Logic setVariable [Format["%1MHQDeployed",str _side],true,true];
	
	_site setVehicleInit Format["[this,true,%1] ExecVM 'Client\Init\Init_BaseStructure.sqf'",_side];
	processInitCommands;
	
	["Constructed",_type,_side] Spawn SideMessage;
	Call Compile Format ["_site addEventHandler ['killed',{[_this select 0,_this select 1,%1,'%2'] Spawn HQKilled}];",_side,typeOf _site];
	_site addEventHandler ["hit",{_this Spawn BuildingDamaged}];
	if (handleFF) then {Call Compile Format ["_site addEventHandler ['handleDamage',{[_this select 0,_this select 2,_this select 3, %1] Call BuildingHandleDamages}]",_side]};
	
	//--- base area limits.
	if (baseArea) then {
		_update = true;
		_areas = WF_Logic getVariable Format['%1Area',str _side];
		_near = [_position,_areas] Call SortByDistance;
		if (count _near > 0) then {
			if ((_near select 0) distance _position < (('WFBE_BASEAREARANGE' Call GetNamespace) + ('WFBE_MHQBUILDINGRANGE' Call GetNamespace))) then {_update = false};
		};
		if (_update) then {
			_grp = createGroup sideLogic;
			_logic = _grp createUnit ["Logic",[0,0,0],[],0,"NONE"];
			_logic setPos _position;
			WF_Logic setVariable [Format['%1Area',str _side],_areas + [_logic],true];
		};
	};
	
	deleteVehicle _HQ;
} else {
	_position = getPos _HQ;
	_direction = getDir _HQ;
	_HQName = Format["WFBE_%1MHQNAME",str _side] Call GetNamespace;

	_HQ SetPos [1,1,1];
	
	_MHQ = _HQName createVehicle _position;

	WF_Logic setVariable [Format["%1MHQ",str _side],_MHQ,true];
	WF_Logic setVariable [Format["%1MHQDeployed",str _side],false,true];

	_MHQ setDir _direction;
	_MHQ setVelocity [0,0,-1];
	
	["Constructed",_HQName,_side] Spawn SideMessage;
	Call Compile Format ["_MHQ AddEventHandler [""killed"",{[_this select 0,_this select 1,%1,'%2'] Spawn HQKilled}];",_side,typeOf _MHQ];
	if (handleFF) then {Call Compile Format ["_MHQ addEventHandler ['handleDamage',{[_this select 0,_this select 2,_this select 3, %1] Call BuildingHandleDamages}]",_side]};
	
	_MHQ setVehicleInit Format["['Headquarters','ColorGreen',[1,1],'','HQUndeployed',this,0.2,false,'','',false,%1] ExecVM 'Common\Common_MarkerUpdate.sqf';",_side];
	processInitCommands;
	
	deleteVehicle _HQ;
};

/* Handle the LAG. */
WF_Logic setVariable [_varTH,false];