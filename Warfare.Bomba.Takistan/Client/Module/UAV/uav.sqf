private['_d','_uav','_add','_logic','_wpcount','_step','_radius','_dir','_lastwp','_lastwppos','_closest','_checks','_group','_cw','_spawn','_waypoints','_varname','_buildings','_sorted','_uavsetup','_driver','_gunner','_id','_logicmarta'];

_logic = UAVL;

if (!isNull playerUAV) then {if (!alive playerUAV) then {playerUAV = objNull}};
if (!isNull playerUAV) exitWith {
	if (WF_A2_Vanilla) then {
		[_logic] ExecVM "Client\Module\UAV\uav_interface.sqf";
	} else {
		[_logic] ExecVM "Client\Module\UAV\uav_interface_oa.sqf";
	};
};

//--- Logic ID
if (isnil "BIS_uavlastID") then {BIS_uav_lastID = -1};
BIS_uav_lastID = BIS_uav_lastID + 1;
_id = BIS_uav_lastID;
_varname = "";
call compile format ["BIS_uav_%1 = _logic; _logic setvehiclevarname 'BIS_uav_%1'; _varname = 'BIS_uav_%1'; publicvariable 'BIS_uav_%1'",BIS_uav_lastID];
_logic setVariable ["ID",BIS_uav_lastID];

//--- First call
if (BIS_uav_lastID == 0) then {
	//--- Execute MARTA
	if (isnil "bis_marta_mainscope") then {
		_logicMARTA = (group _logic) createunit ["MartaManager",position player,[],0,"none"];
	};
};

_buildings = (sideJoinedText) Call GetSideStructures;
_checks = [sideJoined,Format ["WFBE_%1COMMANDCENTERTYPE",sideJoinedText] Call GetNamespace,_buildings] Call GetFactories;
_closest = objNull;
if (count _checks > 0) then {
	_sorted = [player,_checks] Call SortByDistance;
	_closest = _sorted select 0;
};

if (isNull _closest) exitWith {};

_uavSetup = [Format ["WFBE_%1UAV",sideJoinedText] Call GetNamespace, getPos _closest, sideJoined, true, [], 0, "FLY" ];
_uav = _uavSetup call CreateVehi;

playerUAV = _uav;

_group = createGroup sideJoined;
_driver = [Format ["WFBE_%1SOLDIER",sideJoinedText] Call GetNamespace,_group,getPos _uav,sideJoined] Call CreateMan;
_driver MoveInDriver _uav;

//--- OPFOR Uav has no gunner slot.
if (sideJoined == west) then {
	_gunner = [Format ["WFBE_%1SOLDIER",sideJoinedText] Call GetNamespace,_group,getPos _uav,sideJoined] Call CreateMan;
	_gunner MoveInGunner _uav;
};

-12500 Call ChangePlayerFunds;

WFBE_RequestSpecial = ['SRVFNCREQUESTSPECIAL',["uav",sideJoined,_uav,clientTeam]];
publicVariable 'WFBE_RequestSpecial';
if (IsClientServer) then {['SRVFNCREQUESTSPECIAL',["uav",sideJoined,_uav,clientTeam]] Spawn HandleSPVF};

sleep 0.02;

if ((count units _uav) > 1) then {[driver _uav] join grpnull};

_radius = 1000;
_wpcount = 4;
_step = 360 / _wpcount;
_add = 0;
_cw = true;
_dir = 0;
if (isNil "_lastWP") then {
	_lastWP = objNull;
};

if (!(isNull _lastWP)) then {
	deletewaypoint _lastWP
};

//--- No need to preprocess those.
if (WF_A2_Vanilla) then {
	[_logic] ExecVM "Client\Module\UAV\uav_interface.sqf";
} else {
	[_logic] ExecVM "Client\Module\UAV\uav_interface_oa.sqf";
};
[_uav] ExecVM 'Client\Module\UAV\uav_spotter.sqf';

_spawn = [] spawn {}; //--- Empty spawn
while {alive _uav} do {
	waituntil {waypointdescription [group _uav,currentwaypoint group _uav] != ' ' || !alive _uav};
	terminate _spawn; //--- Terminate spawn from previous loop
	if (!(alive _uav)||isNull _uav) exitwith {};

	_waypoints = waypoints _uav;
	_lastWP = _waypoints select (count _waypoints - 1);
	_lastWPpos = waypointposition _lastWP;
	deletewaypoint _lastWP;
	for "_d" from 0 to (360-_step) step _step do
	{
		private['_pos','_wp'];
		_add = _d;
		if !(_cw) then {_add = -_d};
		_pos = [_lastWPpos, _radius, _dir+_add] call bis_fnc_relPos;
		_wp = (group _uav) addwaypoint [_pos,0];
		_wp setWaypointType "MOVE";
		_wp setwaypointdescription ' ';
		_wp setwaypointcompletionradius (1000/_wpcount);
	};

	_spawn = [_uav,_add,_step,_lastWPpos,_radius,_dir] spawn {
		private['_uav','_add','_step','_lastWPpos','_radius','_dir','_currentWP','_pos','_wp'];
		scriptname "UAV Route planning";
		_uav = _this select 0;
		_add = _this select 1;
		_step = _this select 2;
		_lastWPpos = _this select 3;
		_radius = _this select 4;
		_dir = _this select 5;
		_currentWP = currentwaypoint group _uav;
		while {alive _uav} do {
			waituntil {_currentWP != currentwaypoint group _uav};
			sleep .01;
			_add = _add + _step;
			if !(_cw) then {_add = -_add};
			_pos = [_lastWPpos, _radius, _dir+_add] call bis_fnc_relPos;
			_wp = (group _uav) addwaypoint [_pos,0];
			_wp setWaypointType "MOVE";
			_wp setwaypointdescription ' ';
			_wp setwaypointcompletionradius (1000/_wpcount);
			_currentWP = currentwaypoint group _uav;
		};
	};

	_wpcount = count waypoints _uav;
	waituntil {waypointdescription [group _uav,currentwaypoint group _uav] == ' ' || _wpcount != count waypoints _uav || !alive _uav};
	if (!(alive _uav)||isNull _uav) exitwith {};
};
