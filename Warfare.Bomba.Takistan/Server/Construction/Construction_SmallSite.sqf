#include "profiler.h"
PROFILER_BEGIN("Server_ConstructionSmallSite");

//*****************************************************************************************
//Description: Creates a small construction site.
//*****************************************************************************************
private['_constructed','_direction','_index','_position','_side','_site','_siteName','_time','_timeNextUpdate','_objects','_type','_starttime','_construct'];
_type = _this select 0;
_side = _this select 1;
_position = _this select 2;
_direction = _this select 3;
_index = _this select 4;

waitUntil { !isNil "initJIP" };

_time = ((Format ["WFBE_%1STRUCTURETIMES",str _side] Call GetNamespace) select _index) / 2;
if (WF_DEBUG) then { _time = _time / 10; };
	
_siteName = Format["WFBE_%1CONSTRUCTIONSITE",str _side] Call GetNamespace;

_startTime = time;
_timeNextUpdate = _startTime + _time;

_objects = [];
if (WF_A2_Arrowhead) then {_objects = [[_siteName,[0,0,-0.000230789],359.997,1,0],["Paleta2",[0.416992,-5.62012,-0.305746],0.0130822,1,0],["Land_Barrel_sand",[-5.59448,3.26929,6.29425e-005],359.997,1,0],["Paleta1",[-2.62976,-6.04736,5.53131e-005],0.0130822,1,0],["Barrel4",[6.63696,0.694336,0.000753403],359.991,1,0],["Land_Barrel_sand",[-6.73267,2.06372,6.10352e-005],359.997,1,0],["Barrel5",[7.19604,2.8855,0.00028801],0.0135841,1,0],["Barrel1",[6.08984,5.5415,0.00028801],0.0135841,1,0],["Land_Barrel_sand",[-7.13452,4.40747,6.29425e-005],359.997,1,0],["RoadBarrier_long",[0.221924,-8.58496,0.00206566],0.0130822,1,0],["Land_Barrel_sand",[-8.27271,2.80054,6.10352e-005],359.997,1,0],["Barrels",[-7.91895,-4.09668,0.00037384],0.0128253,1,0],["RoadCone",[-10.4381,-8.94336,0.000131607],0.0119093,1,0],["RoadCone",[11.1655,-8.79932,0.00034523],359.991,1,0],["RoadCone",[-10.5692,12.6655,0.000509262],359.948,1,0],["RoadCone",[11.0276,12.3904,0.000509262],359.948,1,0]]};
if (WF_A2_Vanilla || WF_A2_CombinedOps) then {_objects = [[_siteName,[0,0,-0.000230789],359.997,1,0],["Paleta2",[0.416992,-5.62012,-0.305746],0.0130822,1,0],["Land_Barrel_sand",[-5.59448,3.26929,6.29425e-005],359.997,1,0],["Paleta1",[-2.62976,-6.04736,5.53131e-005],0.0130822,1,0],["Barrel4",[6.63696,0.694336,0.000753403],359.991,1,0],["Land_Ind_BoardsPack2",[6.41797,-2.52051,0.000915527],270,1,0],["Land_Barrel_sand",[-6.73267,2.06372,6.10352e-005],359.997,1,0],["Barrel5",[7.19604,2.8855,0.00028801],0.0135841,1,0],["Barrel1",[6.08984,5.5415,0.00028801],0.0135841,1,0],["Land_Barrel_sand",[-7.13452,4.40747,6.29425e-005],359.997,1,0],["RoadBarrier_long",[0.221924,-8.58496,0.00206566],0.0130822,1,0],["Land_Barrel_sand",[-8.27271,2.80054,6.10352e-005],359.997,1,0],["Barrels",[-7.91895,-4.09668,0.00037384],0.0128253,1,0],["Land_Ind_BoardsPack1",[6.40332,-7.16162,0.000520706],0.0130822,1,0],["Land_Ind_BoardsPack1",[-6.18384,-8.09961,0.000535965],50.0093,1,0],["RoadCone",[-10.4381,-8.94336,0.000131607],0.0119093,1,0],["RoadCone",[11.1655,-8.79932,0.00034523],359.991,1,0],["RoadCone",[-10.5692,12.6655,0.000509262],359.948,1,0],["RoadCone",[11.0276,12.3904,0.000509262],359.948,1,0]]};
_construct = Compile PreprocessFile "ca\modules\dyno\data\scripts\objectMapper.sqf";
_constructed = ([_position,_direction,_objects] Call _construct);

while {_timeNextUpdate > time } do {
	sleep 1;
};
_timeNextUpdate = _startTime + _time * 2;

if (WF_A2_Arrowhead) then {_objects = [["Land_WoodenRamp",[-2.45703,-0.593262,0.357508],270,1,0],["Land_WoodenRamp",[-2.5083,1.3811,0.357508],270,1,0],[_siteName,[4.6333,0.338135,0.00393867],90,1,0],["Land_Dirthump02_EP1",[-0.587891,8.57935,0.00207901],359.967,1,0],["Land_Dirthump01_EP1",[-3.97363,-8.49219,-4.57764e-005],29.9804,1,0],["Land_WoodenRamp",[8.8335,-0.125977,0.403545],90,1,0]]};
if (WF_A2_Vanilla || WF_A2_CombinedOps) then {_objects = [["Land_WoodenRamp",[-2.45703,-0.593262,0.357508],270,1,0],["Land_WoodenRamp",[-2.5083,1.3811,0.357508],270,1,0],[_siteName,[4.6333,0.338135,0.00393867],90,1,0],["Land_Dirthump02",[-0.587891,8.57935,0.00207901],359.967,1,0],["Land_Dirthump01",[-3.97363,-8.49219,-4.57764e-005],29.9804,1,0],["Land_WoodenRamp",[8.8335,-0.125977,0.403545],90,1,0]]};
_constructed = _constructed + ([_position,_direction,_objects] Call _construct);
	
while {_timeNextUpdate > time } do {
	sleep 1;
};
	
{if (!IsNull _x) then {DeleteVehicle _x}} ForEach _constructed;

_site = _type CreateVehicle _position;
_site SetDir _direction;
_site SetPos _position;

["Constructed",_type,_side] Spawn SideMessage;

if (!IsNull _site) then {
	Call Compile Format ["%1BaseStructures = %1BaseStructures + [_site]; publicVariable '%1BaseStructures';",str _side];

	_site SetVehicleInit Format["[this,false,%1] ExecVM 'Client\Init\Init_BaseStructure.sqf'",_side];
	ProcessInitCommands;
	
	_site addEventHandler ["hit",{_this Spawn BuildingDamaged}];
	if (paramHandleFF) then {Call Compile Format ["_site addEventHandler ['handleDamage',{[_this select 0,_this select 2,_this select 3, %1] Call BuildingHandleDamages}]",_side]};
	Call Compile Format ["_site AddEventHandler ['killed',{[_this select 0,_this select 1,%1,'%2'] Spawn BuildingKilled}];",_side,_type];
	
	Format["Construction_SmallSite: A %1 %2 was constructed",str _side,_type] call LogInform;
};

//--- Base Patrols.
if ((_type == WESTBAR || _type == EASTBAR) && paramBasePatrols) then {
	[_site, _side] ExecFSM 'Server\FSM\basepatrol.fsm';
	Format["Construction_SmallSite: A %1 Base Patrol Module has been launched",str _side] call LogInform;
};

PROFILER_END();